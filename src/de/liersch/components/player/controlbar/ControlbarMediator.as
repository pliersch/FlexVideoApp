package de.liersch.components.player.controlbar {

	import de.liersch.util.Times;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	import org.osmf.events.MediaPlayerStateChangeEvent;

	public class ControlbarMediator extends EventDispatcher {

		private var _view:ControlbarView;

		private static const PLAY:String="play";
		private static const PAUSE:String="pause";
		private var _state:String;

		private var _duration:uint;
		private var _completeTimeAsString:String;
		private var _userIsLoggedIn:Boolean;

		public function ControlbarMediator(view:ControlbarView) {
			_view=view;
			super();
			_state=PAUSE;
			addListener();
		}

		public function setDuration(duration:uint):void {
			_duration=duration;
			_completeTimeAsString=Times.secToTime(duration);
		}

		private function addListener():void {
			_view.progressBar.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownProgressBar);
			_view.buttonMute.addEventListener(MouseEvent.CLICK, onClickMuteButton);
			_view.buttonUnMute.addEventListener(MouseEvent.CLICK, onClickUnMuteButton);
			_view.buttonPlay.addEventListener(MouseEvent.CLICK, onClickPlayButton);
			_view.buttonPause.addEventListener(MouseEvent.CLICK, onClickPauseButton);
			_view.sliderVolume.addEventListener(Event.CHANGE, onChangeVolumeSlider);
			_view.buttonMaximize.addEventListener(MouseEvent.CLICK, onClickMaximize);
			_view.buttonMinimize.addEventListener(MouseEvent.CLICK, onClickMinimize);
			_view.buttonUpload.addEventListener(MouseEvent.CLICK, onClickUploadButton);
			_view.buttonFavorite.addEventListener(MouseEvent.CLICK, onClickFavoriteButton);
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                             Event Handler                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////


		private function onClickFavoriteButton(event:MouseEvent):void {
			_view.buttonFavorite.visible = false;
			dispatchEvent(new ControlbarEvent(ControlbarEvent.FAVORITE));
		}

		private function onClickMinimize(event:MouseEvent):void {
			_view.buttonMaximize.visible=true;
			_view.buttonMinimize.visible=false;
			dispatchEvent(new ControlbarEvent(ControlbarEvent.NORMAL_SCREEN));
		}

		private function onClickMaximize(event:MouseEvent):void {
			_view.buttonMaximize.visible=false;
			_view.buttonMinimize.visible=true;
			dispatchEvent(new ControlbarEvent(ControlbarEvent.FULL_SCREEN));
		}

		private function onClickUnMuteButton(event:MouseEvent):void {
			_view.buttonUnMute.visible=false;
			_view.buttonMute.visible=true;
			dispatchEvent(new ControlbarEvent(ControlbarEvent.UNMUTE));
		}

		private function onClickMuteButton(event:MouseEvent):void {
			_view.buttonUnMute.visible=true;
			_view.buttonMute.visible=false;
			dispatchEvent(new ControlbarEvent(ControlbarEvent.MUTE));
		}

		private function onChangeVolumeSlider(event:Event):void {
			_view.buttonUnMute.visible=false;
			_view.buttonMute.visible=true;
			dispatchEvent(new ControlbarEvent(ControlbarEvent.VOLUME, event.target.value));
		}

		private function onClickPauseButton(event:MouseEvent):void {
			dispatchEvent(new ControlbarEvent(ControlbarEvent.PAUSE));
		}

		private function onClickPlayButton(event:MouseEvent):void {
			dispatchEvent(new ControlbarEvent(ControlbarEvent.PLAY));
		}

		private function onClickUploadButton(event:MouseEvent):void {
			hideUploadButton();
			dispatchEvent(new ControlbarEvent(ControlbarEvent.UPLOAD));
		}

		private function onMouseDownProgressBar(event:MouseEvent):void {
			if (_duration) {
				var position:uint=event.localX * _duration / _view.progressBar.width;
				dispatchEvent(new ControlbarEvent(ControlbarEvent.SEEK, position));
			}
		}
		
		private function hideUploadButton():void {
			_view.buttonUpload.visible=false;
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            public methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		public function enableUploadAndFavorite():void {
			_userIsLoggedIn = true;
		}
		
		public function disableUploadAndFavorite():void {
			_userIsLoggedIn = false;
			_view.buttonUpload.visible = false;
			_view.buttonFavorite.visible = false;
		}

		public function showUpload():void {
			_view.buttonFavorite.visible = false;
			if (_userIsLoggedIn)
				_view.buttonUpload.visible=true;
		}
		
		public function hideUpload():void {
			_view.buttonUpload.visible=false;
		}
		
		public function hideFavorite():void {
			_view.buttonFavorite.visible = false;
		}
		
		public function showFavorite():void {
			if (_userIsLoggedIn)
				_view.buttonFavorite.visible=true;
		}

		public function changePlayState(playerState:String):void {
			_state=playerState;
			if (_state == PLAY) {
				_view.buttonPlay.visible=false;
				_view.buttonPause.visible=true;
			} else {
				_view.buttonPlay.visible=true;
				_view.buttonPause.visible=false;
			}
		}

		public function updateTime(time:uint):void {
			_view.progressBar.setProgress(time, _duration);
			_view.timeLabel.text=Times.secToTime(time) + " | " + _completeTimeAsString;
		}

		public function show():void {
			_view.visible=true;
		}

		public function hide():void {
			_view.visible=false;
		}

		public function reset():void {
			_view.buttonPlay.visible=true;
			_view.buttonPause.visible=false;
		}
		
	}
}
