package de.liersch.components.player.media
{
	import flash.events.Event;

	public class PlayerEvent extends Event
	{
		public static const READY:String = "ready";
		public static const STOPPED:String = "stopped";
		public static const PLAYING:String = "playing";
		public static const PAUSED:String = "pause";
		public static const LONG_PLAYED:String = "longPlayed";
		public static const VIDEO_COMPLETE:String = "videoComplete";

		public function PlayerEvent(type:String)
		{
			super(type,false,false);
		}

		public override function clone():Event
		{
			return new PlayerEvent(type);
		}

		public override function toString():String
		{
			return formatToString("MediaEvent");
		}
	}
}