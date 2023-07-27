package de.liersch.components.user.login
{
	import flash.events.Event;
	
	import valueObjects.User;

	public class RegisterEvent extends Event
	{
		public static const REGISTER:String = "register";
		public static const UNREGISTER:String = "unregister";

		private var _user:User;

		public function RegisterEvent(type:String, user:User)
		{
			super(type,false,false);

			_user = user;
		}

		public function get user():User
		{
			return _user;
		}

		public override function clone():Event
		{
			return new RegisterEvent(type,user);
		}

		public override function toString():String
		{
			return formatToString("RegisterEvent","user");
		}
	}
}