package de.liersch.components.player.media {
	
	import flash.events.Event;
	import flash.geom.Point;

	public class PlayerInfoEvent extends Event {
		
		public static const METADATA:String="metadata";

		private var _duration:uint;

		public function PlayerInfoEvent(type:String, duration:uint) {
			super(type, false, false);
			_duration=duration;
		}

		public function get duration():uint {
			return _duration;
		}

		public override function clone():Event {
			return new PlayerInfoEvent(type, _duration);
		}

		public override function toString():String {
			return formatToString("MediaInfoEvent", "duration");
		}

	}
}
