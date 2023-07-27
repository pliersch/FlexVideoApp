package de.liersch.components.user.myData
{
	import flash.events.Event;
	import valueObjects.User;

	public class MyDataEvent extends Event
	{
		public static const CHANGE_USER_DATA:String = "changeUserData";

		private var _user:User;

		public function MyDataEvent(type:String, user:User)
		{
			super(type,false,false);

			this._user = user;
		}

		public function get user():User
		{
			return _user;
		}

		public override function clone():Event
		{
			return new MyDataEvent(type,user);
		}

		public override function toString():String
		{
			return formatToString("MyDataEvent","user");
		}
	}
}