package de.liersch.components.user.login {

	import de.liersch.components.logger.Logger;
	import de.liersch.components.user.UserEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	import mx.controls.Alert;
	
	import valueObjects.User;

	[Event(name="dataReceived", type="de.liersch.components.user.UserEvent")]
	[Event(name="login", type="de.liersch.components.user.login.LoginEvent")]
	[Event(name="register", type="de.liersch.components.user.login.RegisterEvent")]

	public class LoginViewMediator extends EventDispatcher {

		private var _view:LoginView;
		private var _mode:Object;
		private var _fileRef:FileReference;

		private var _loader:Loader;

		public function LoginViewMediator(view:LoginView) {
			_view = view;
			_view.currentState="Login"
			_view.textinputLoginEmail.setFocus();
			_fileRef = new FileReference();
			setupListener();
		}

		private function setupListener():void {

			// Login-State
			_view.buttonLoginOk.addEventListener(MouseEvent.CLICK, onClickButtonLoginOk);
			_view.buttonLoginCancel.addEventListener(MouseEvent.CLICK, onClickButtonCancel);
			_view.buttonLoginRegister.addEventListener(MouseEvent.CLICK, onClickButtonLoginRegister);
			// Rgister-State
			_view.buttonRegisterOk.addEventListener(MouseEvent.CLICK, onClickButtonRegisterOk);
			_view.buttonRegisterCancel.addEventListener(MouseEvent.CLICK, onClickButtonCancel);
			_view.buttonRegisterLogin.addEventListener(MouseEvent.CLICK, onClickButtonRegisterLogin);
			_view.buttonImg.addEventListener(MouseEvent.CLICK, onButtonClick);
		}
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                           private methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		private function onClickButtonRegisterLogin(event:MouseEvent):void {
			_view.currentState = "Login";
		}

		private function onClickButtonLoginRegister(event:MouseEvent):void {
			_view.currentState = "Register";
		}

		private function onClickButtonCancel(event:MouseEvent):void {
			clearView();
			_view.visible = false;
		}

		private function onClickButtonRegisterOk(event:MouseEvent):void {
			if (canRegister()) {
				var bitmapData:BitmapData = new BitmapData(_view.avatar.width, _view.avatar.height);
				bitmapData.draw(_view.avatar);
				var user:User = createUser();
				user.avatarBytes = bitmapData.getPixels(bitmapData.rect);
				dispatchEvent(new RegisterEvent(RegisterEvent.REGISTER, user));
			} else {
				Alert.show("Du musst alle Felder ausfüllen");
			}
		}

		private function canLogin():Boolean {
			return _view.textinputLoginEmail.text.length > 0
				&& _view.textinputLoginPassword.text.length > 0
		}

		private function createUser():User {
			var user:User = new User();
			user.email = _view.textinputRegisterEmail.text;
			user.name = _view.textinputRegisterName.text;
			user.givenName = _view.textinputRegisterGivenName.text;
			user.nickName = _view.textinputRegisterNickName.text;
			user.password = _view.textinputRegisterPassword.text;
			return user;
		}

		// TODO: validate
		private function canRegister():Boolean {
			return _view.textinputRegisterEmail.text.length > 0
				&& _view.textinputRegisterName.text.length > 0
				&& _view.textinputRegisterGivenName.text.length > 0
				&& _view.textinputRegisterNickName.text.length > 0
				&& _view.textinputRegisterPassword.text.length > 0
				&& _view.textinputRegisterPasswordRepeat.text == 
				_view.textinputRegisterPassword.text;
		}

		private function clearView():void {
			_view.textinputRegisterEmail.text = "";
			_view.textinputRegisterName.text = "";
			_view.textinputRegisterGivenName.text = "";
			_view.textinputRegisterNickName.text = "";
			_view.textinputRegisterPassword.text = "";
			_view.textinputRegisterPasswordRepeat.text = "";
			_view.textinputLoginEmail.text = "";
			_view.textinputLoginPassword.text = "";
			_view.avatar.source = null;
		}
		
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                             Event Handler                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		
		private function onClickButtonLoginOk(event:MouseEvent):void {
			if (canLogin()) {
				dispatchEvent(new LoginEvent(LoginEvent.LOGIN, 
					_view.textinputLoginEmail.text,
					_view.textinputLoginPassword.text));
			}
		}

		private function onButtonClick(e:MouseEvent):void {
			_fileRef.browse([new FileFilter("Images", "*.jpg;*.gif;*.png")]);
			_fileRef.addEventListener(Event.SELECT, onFileSelected);
		}

		private function onFileSelected(e:Event):void {
			_fileRef.addEventListener(Event.COMPLETE, onFileLoaded);
			_fileRef.load();
		}

		private function onFileLoaded(e:Event):void {
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			_loader.loadBytes(e.target.data);
		}

		private function onComplete(event:Event):void {
			var image:Bitmap = Bitmap(_loader.content);
			image.smoothing = true;
			_view.avatar.source = image.bitmapData;
		}
		
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            public methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		public function handleSuccess():void {
			clearView();
			_view.currentState = "Login";
			_view.visible = false;
		}

		public function showLoginFailed():void {
			_view.currentState = "LoginFailed";
			Logger.instance.log("LoginViewMediator", "handleLoginFailed");
		}

		public function showRegisterFailed():void {
			_view.currentState = "RegisterFailed";
		}

		public function showWrongPasswort():void {
			_view.currentState = "WrongPassword";
			
		}
	}
}
