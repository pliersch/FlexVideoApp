package de.liersch.components.user {

	import de.liersch.components.logger.Logger;

	import flash.display.BitmapData;
	import flash.events.EventDispatcher;

	import mx.rpc.Responder;

	import services.VideoService;

	import valueObjects.User;

	public class UserModel extends EventDispatcher {

		private var _user:User;
		private var _service:VideoService;

		public function UserModel(service:VideoService) {
			_service = service;
		}
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            public methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		public function login(email:String, password:String):void {
			_service.login(email, password, new Responder(onLoginSuccess, onLoginFault));
		}

		public function logout():void {
			_service.logout(new Responder(onLogoutSuccess, onLogoutFault));
		}

		public function register(user:User):void {
			_service.register(user, new Responder(onRegisterSuccess, onRegisterFault));
		}

		public function unRegister():void {
			_service.unRegister(new Responder(onUnregisterSuccess, onUnregisterFault));
		}

		public function changeUserData(user:User):void {
			user.id = _user.id;
			_service.changeData(user,
				new Responder(onChangeUserDataSuccess, onChangeUserDataFault));
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                         Responder Methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		private function onLoginSuccess(o:Object):void {
			if((o.result as User) == null){
				dispatchEvent(new UserServiceEvent(UserServiceEvent.LOGIN_WRONG_PASSWORD));
			} else {
				_user = o.result as User;
				_service.userID = user.id;
				dispatchEvent(new UserServiceEvent(UserServiceEvent.LOGIN_SUCCESS));
			}
		}

		private function onLoginFault(o:Object):void {
			Logger.instance.log("UserModel", "onLoginFault");
			dispatchEvent(new UserServiceEvent(UserServiceEvent.LOGIN_FAILED));
		}

		private function onLogoutSuccess(o:Object):void {
			dispatchEvent(new UserServiceEvent(UserServiceEvent.LOGOUT_SUCCESS));
			_service.userID = null;
		}

		private function onLogoutFault(o:Object):void {
			Logger.instance.log("UserModel", "onLogoutFault");
			dispatchEvent(new UserServiceEvent(UserServiceEvent.LOGOUT_FAILED));
		}

		private function onChangeUserDataSuccess(o:Object):void {
			_user = o.result as User;
			dispatchEvent(new UserServiceEvent(UserServiceEvent.CHANGE_SUCCESS));
		}

		private function onChangeUserDataFault(o:Object):void {
			Logger.instance.log("UserModel", "onChangeUserDataFault");
			dispatchEvent(new UserServiceEvent(UserServiceEvent.CHANGE_FAILED));
		}

		private function onRegisterSuccess(o:Object):void {
			_user = o.result as User;
			_service.userID = _user.id;
			dispatchEvent(new UserServiceEvent(UserServiceEvent.REGISTER_SUCCESS));
		}

		private function onRegisterFault(o:Object):void {
			Logger.instance.log("UserModel", "onRegisterFault");
			dispatchEvent(new UserServiceEvent(UserServiceEvent.REGISTER_FAILED));
		}

		private function onUnregisterSuccess(o:Object):void {
			dispatchEvent(new UserServiceEvent(UserServiceEvent.DELETE_SUCCESS));
		}

		private function onUnregisterFault(o:Object):void {
			Logger.instance.log("UserModel", "onUnregisterFault");
			dispatchEvent(new UserServiceEvent(UserServiceEvent.DELETE_FAILED));
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            Getter Setter                             //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		public function get user():User {
			return _user;
		}

		public function set user(value:User):void {
			_user = value;
		}

	}
}
