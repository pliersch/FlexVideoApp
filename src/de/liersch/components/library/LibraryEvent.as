package de.liersch.components.library {

	import flash.events.Event;

	import mx.collections.ArrayCollection;

	import valueObjects.Video;

	public class LibraryEvent extends Event {

		public static const UPDATE:String="update";
		public static const VIDEO_SELECTED:String="videoSelected";

		private var _videos:ArrayCollection;
		private var _video:Video;
		
		public function LibraryEvent(type:String, videos:ArrayCollection = null, 
									 video:Video = null) {
			super(type);
			_videos=videos;
			_video=video;
		}

		public function get playList():ArrayCollection {
			return _videos;
		}

		public function get video():Video {
			return _video;
		}

		public override function clone():Event {
			return new LibraryEvent(type, _videos, _video);
		}

		public override function toString():String {
			return formatToString("CatalogEvent", "videos", "video");
		}
	}
}
