package de.liersch.components.user {

	import flash.events.Event;

	import valueObjects.User;

	public class UserServiceEvent extends Event {

		public static const REGISTER_SUCCESS:String = "registerSuccess";
		public static const REGISTER_FAILED:String = "registerFailed";

		public static const DELETE_SUCCESS:String = "deleteSuccess";
		public static const DELETE_FAILED:String = "deleteFailed";

		public static const CHANGE_USER_DATA:String = "changeUserData";
		public static const CHANGE_SUCCESS:String = "changeSuccess";
		public static const CHANGE_FAILED:String = "changeFailed";

		public static const LOGIN_FAILED:String = "loginFailed";
		public static const LOGIN_SUCCESS:String = "loginSuccess";
		public static const LOGIN_WRONG_PASSWORD:String = "loginWrongPassword";

		public static const LOGOUT_SUCCESS:String = "logoutSuccess";
		public static const LOGOUT_FAILED:String = "logoutFailed";

		public function UserServiceEvent(type:String) {
			super(type,false,false);
		}


		public override function clone():Event {
			return new UserServiceEvent(type);
		}

		public override function toString():String {
			return formatToString("UserServiceEvent");
		}
	}
}
