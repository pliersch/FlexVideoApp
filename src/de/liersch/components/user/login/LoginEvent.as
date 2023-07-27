package de.liersch.components.user.login {

	import flash.events.Event;

	public class LoginEvent extends Event {
		public static const LOGIN:String = "login";
		public static const LOGOUT:String = "logout";

		private var _email:String;
		private var _password:String;

		public function LoginEvent(type:String, email:String = "", password:String = "") {
			super(type,false,false);

			_email = email;
			_password = password;
		}

		public function get email():String {
			return _email;
		}

		public function get password():String {
			return _password;
		}

		public override function clone():Event {
			return new LoginEvent(type,email,password);
		}

		public override function toString():String {
			return formatToString("LoginEvent","email","password");
		}
	}
}
