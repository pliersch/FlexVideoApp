package de.liersch.components.user {

	import de.liersch.components.user.login.LoginEvent;
	import de.liersch.components.user.login.LoginViewMediator;
	import de.liersch.components.user.login.RegisterEvent;
	import de.liersch.components.user.myData.MyDataEvent;
	import de.liersch.components.user.myData.MyDataViewMediator;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class UserPresenter extends EventDispatcher {

		private var _login:LoginViewMediator;
		private var _myData:MyDataViewMediator;
		private var _model:UserModel;

		public function UserPresenter(userModel:UserModel,
			loginViewMediator:LoginViewMediator,
			myDataViewMediator:MyDataViewMediator) {
			_model = userModel;
			_login = loginViewMediator;
			_myData = myDataViewMediator;
			super();
			setupListener();
		}

		private function setupListener():void {
			_model.addEventListener(UserServiceEvent.LOGIN_SUCCESS, onConnect);
			_model.addEventListener(UserServiceEvent.LOGIN_FAILED, onLoginFailed);
			_model.addEventListener(UserServiceEvent.LOGIN_WRONG_PASSWORD, onLoginWrongPassword );
			_model.addEventListener(UserServiceEvent.LOGOUT_SUCCESS, onDisconnect);
			_model.addEventListener(UserServiceEvent.LOGOUT_FAILED, dispatchEvent);
			_model.addEventListener(UserServiceEvent.CHANGE_SUCCESS, onChangeSuccess);
			_model.addEventListener(UserServiceEvent.CHANGE_FAILED, onChangeFailed);
			_model.addEventListener(UserServiceEvent.REGISTER_SUCCESS, onConnect);
			_model.addEventListener(UserServiceEvent.REGISTER_FAILED, onRegisterFailed);

			_login.addEventListener(LoginEvent.LOGIN, onLogin);
			_login.addEventListener(LoginEvent.LOGOUT, onLogout);
			_login.addEventListener(RegisterEvent.REGISTER, onRegister);

			_myData.addEventListener(MyDataEvent.CHANGE_USER_DATA, onChangeUserData);

		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                             Event Handler                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		private function onChangeUserData(event:MyDataEvent):void {
			_model.changeUserData(event.user);
		}

		private function onUnregister(event:RegisterEvent):void {

		}

		private function onRegister(event:RegisterEvent):void {
			_model.register(event.user);
		}

		private function onChangeSuccess(event:UserServiceEvent):void {
			_myData.setUser(_model.user);
		}

		private function onChangeFailed(event:UserServiceEvent):void {

		}

		private function onLogout(event:LoginEvent):void {
			_model.logout();
		}

		private function onLogin(event:LoginEvent):void {
			_model.login(event.email, event.password);
		}
		
		private function onLoginWrongPassword(event:UserServiceEvent):void {
			_login.showWrongPasswort();
		}


		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            public methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////


		public function logout():void {
			_model.logout();
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                         Responder Methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		// login & change
		private function onConnect(event:UserServiceEvent):void {
			_login.handleSuccess();
			_myData.setUser(_model.user);
			dispatchEvent(new UserEvent(UserEvent.CONNECTED));
		}
		
		protected function onDisconnect(event:Event):void {
			dispatchEvent(new UserEvent(UserEvent.DISCONNECTED));
		}

		private function onLoginFailed(event:UserServiceEvent):void {
			_login.showLoginFailed();
		}

		private function onLogoutFailed(event:UserServiceEvent):void {

		}

		private function onRegisterFailed(event:UserServiceEvent):void {
			_login.showRegisterFailed();
		}

		private function name(evt:MyDataEvent):void {
			_model.changeUserData(evt.user);
		}
	}
}
