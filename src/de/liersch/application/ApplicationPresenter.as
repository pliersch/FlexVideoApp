package de.liersch.application {

	import de.liersch.components.logger.Logger;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.display.NativeWindowDisplayState;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import flash.events.NativeDragEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.ui.Mouse;
	import flash.utils.Timer;

	import mx.controls.Alert;

	import spark.components.Image;
	import spark.components.WindowedApplication;

	import valueObjects.Video;

	public class ApplicationPresenter {

		private var _application : VideoClientDesktop;
		private var _resizer:Image;
		private var _headView:ApplicationHeadView;
		private var _timer:Timer;
		private var _isFullScreen:Boolean=false;
		private var _applicationNegotiator:ApplicationNegotiator;
		private var _lastState:String;

		public function ApplicationPresenter(windowedApplication:WindowedApplication,
			applicationHeadView:ApplicationHeadView,
			resizer:Image) {

			addApplication(windowedApplication);
			addStatusBar(resizer);
			addApplicationHeadView(applicationHeadView);
			_lastState = _application.currentState;
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                                 Setup                                //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////	

		private function addApplication(windowedApplication:WindowedApplication):void {
			_application = windowedApplication as VideoClientDesktop;
			_application.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER,onDragIn);
			_application.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP,onDrop);
		}

		private function addStatusBar(applicationStatusBar:Image):void {
			_resizer = applicationStatusBar;
			_resizer.addEventListener(MouseEvent.MOUSE_DOWN, onStatusBarMouseDown);
		}

		private function addApplicationHeadView(applicationHeadView:ApplicationHeadView):void {
			_headView = applicationHeadView;
			_headView.buttonLogout.visible = false;
			_headView.buttonHome.visible = false;
			_headView.buttonMyChannel.visible = false;
			setupListener();
		}

		private function setupListener():void {
			// Logger "easteregg"
			_headView.background.doubleClickEnabled = true;
			_headView.background.addEventListener(MouseEvent.MOUSE_DOWN, header_mouseDownHandler);
			_headView.background.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
			_headView.buttonHome.addEventListener(MouseEvent.CLICK, onClickButtonHome);
			_headView.buttonMyChannel.addEventListener(MouseEvent.CLICK, onClickButtonMyChannel);
			_headView.buttonLogin.addEventListener(MouseEvent.CLICK, onClickButtonLogin);
			_headView.buttonLogout.addEventListener(MouseEvent.CLICK, onClickButtonLogout);
			_headView.buttonClose.addEventListener(MouseEvent.CLICK, onClickButtonClose);
			_headView.buttonMaximize.addEventListener(MouseEvent.CLICK, onClickMaximizeButton);
			_headView.buttonMinimize.addEventListener(MouseEvent.CLICK, onClickMinimizeButton);
			_headView.buttonFullScreen.addEventListener(MouseEvent.CLICK, onClickButtonFullScreen);
		}

		private function onDoubleClick(event:MouseEvent):void {
			Logger.instance.show();
		}

		private function playLocalVideo(file:File):void {
			var video:Video = new Video();
			video.fileName = file.name;
			video.localPath = file.nativePath;
			_applicationNegotiator.playLocalMedia(video);
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                             Event Handler                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		private function onDragIn(event:NativeDragEvent):void {
			NativeDragManager.acceptDragDrop(_application);
		}

		private function onDrop(event:NativeDragEvent):void {
			var dropfiles:Array = event.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			for each (var file:File in dropfiles) {
				switch (file.extension.toLowerCase()) {
					case "f4v":
					case "flv":
					case "mp4":
					case "mov":
					case "mp3":
						playLocalVideo(file);
						break;
					default:
						Alert.show("Nur flv, f4v, mp3, mp4 und mov Formate werden unterstützt");
				}
			}
		}

		private function onClickButtonLogin(event:MouseEvent):void {
			_application.loginView.visible = true;
		}

		private function onClickButtonLogout(event:MouseEvent):void {
			_applicationNegotiator.logout();
		}

		private function onClickButtonMyChannel(event:MouseEvent):void {
			_application.currentState="MyChannelState";
			_applicationNegotiator.handleMyChannelState();
			showWindowComponents();
		}

		private function onClickButtonHome(event:MouseEvent):void {
			_application.currentState = "HomeState";
			_applicationNegotiator.handleHomeState();
			showWindowComponents();
		}

		private function onClickButtonClose(event:MouseEvent):void {
			_application.exit();
		}

		private function onClickMaximizeButton(event:MouseEvent):void {
			if (_application.nativeWindow.displayState == NativeWindowDisplayState.MAXIMIZED) {
				_application.restore();
			} else {
				_application.maximize();
			}
		}

		private function onClickMinimizeButton(event:MouseEvent):void {
			_application.minimize();
		}

		private function header_mouseDownHandler(event:MouseEvent):void {
			_application.nativeWindow.startMove();
		}

		private function onClickButtonFullScreen(event:MouseEvent):void {
			_isFullScreen=!_isFullScreen;
			if (_isFullScreen) {
				_application.stage.displayState=StageDisplayState.FULL_SCREEN_INTERACTIVE;
			} else {
				_application.stage.displayState=StageDisplayState.NORMAL;
			}
		}

		private function onStatusBarMouseDown(event:MouseEvent):void {
			_application.nativeWindow.startResize();
		}

		private function onMouseMove(event:MouseEvent):void {
			_timer.reset();
			_timer.start();
			_headView.visible = true;
			_resizer.visible = true;
			_applicationNegotiator.handleUserInteraction(true);
			Mouse.show();
		}
		
		private function startTimer():void {
			_timer=new Timer(5000,1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			_application.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}

		private function onTimerComplete(event:TimerEvent):void {
			_timer.stop();
			_headView.visible = false;
			_resizer.visible = false;
			_applicationNegotiator.handleUserInteraction(false);
			Mouse.hide();
		}

		private function killTimer():void {
			_application.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			_timer.stop();
			_timer = null;
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            public methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////


		public function connected():void {
			_headView.buttonLogin.visible = false;
			_headView.buttonLogout.visible = true;
			_headView.buttonHome.visible = true;
			_headView.buttonMyChannel.visible = true;
			_application.currentState = "MyChannelState";
			_applicationNegotiator.handleMyChannelState();
		}

		public function handleLogout():void {
			_headView.buttonLogin.visible = true;
			_headView.buttonLogout.visible = false;
			_headView.buttonHome.visible = false;
			_headView.buttonMyChannel.visible = false;
		}

		public function setFullScreen():void {
			_application.currentState = "FullScreenState";
			startTimer();
		}

		public function setNormalScreen():void {
			setToLastState();
		}

		public function setHomeState():void {
			_application.currentState = "HomeState";
			_lastState = "HomeState";
		}

		/**
		 * Wird aufgerufen, wenn das Video endet. War es im Vollbild
		 * wird der zuvor letzte View State gesetzt.
		 */
		public function setToLastState():void {
			if (_application.currentState == "FullScreenState"){
				killTimer();
				_application.currentState = _lastState;				
			}
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                           private methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		private function showWindowComponents():void {
			_applicationNegotiator.handleUserInteraction(true);
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            Getter Setter                             //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		public function set applicationNegotiator(value:ApplicationNegotiator):void {
			_applicationNegotiator = value;
		}

	}
}
