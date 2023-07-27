package de.liersch.components.player.controlbar {
	
	import flash.events.Event;

	public class ControlbarEvent extends Event {
		
		public static const PLAY:String="play";
		public static const PAUSE:String="pause";
		public static const STOP:String="stop";
		public static const SEEK:String="seek";
		public static const VOLUME:String="volume";
		public static const MUTE:String="mute";
		public static const UNMUTE:String="unmute";
		public static const NORMAL_SCREEN:String="normalScreen";
		public static const FULL_SCREEN:String="fullScreen";
		public static const UPLOAD:String="upload";
		public static const FAVORITE:String="favorite";

		private var _data:*;

		public function ControlbarEvent(type:String, value:*=null) {
			super(type, false, true);
			_data=value;
		}

		public function get data():* {
			return _data;
		}

		public override function clone():Event {
			return new ControlbarEvent(type, _data);
		}

		public override function toString():String {
			return formatToString("ControlbarEvent", "data");
		}
	}
}
