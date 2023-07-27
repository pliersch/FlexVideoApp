package de.liersch.components.user {

	import flash.events.Event;

	import valueObjects.User;

	public class UserEvent extends Event {
		public static const CONNECTED:String = "connected";
		public static const DISCONNECTED:String = "disconnected";
		public static const FAVORITE:String = "favorite";

		public function UserEvent(type:String) {
			super(type,false,false);

		}

		override public function clone():Event {
			return new UserEvent(type);
		}

		override public function toString():String {
			return formatToString("UserEvent");
		}
	}
}
