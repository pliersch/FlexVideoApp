package de.liersch.event {

	import flash.display.BitmapData;
	import flash.events.Event;

	import valueObjects.Video;

	public class UploadEvent extends Event {

		public static const UPLOAD:String="upload";
		public static const DO_UPLOAD:String="DoUpload";
		public static const UPLOAD_SUCCESS:String="uploadSuccess";
		public static const UPLOAD_FAILED:String="uploadFailed";
		public static const CANCEL:String="cancel";


		public var video:Video;
		public var bitmapData:BitmapData;

		// TODO warum null ?
		public function UploadEvent(type:String, bitmap:BitmapData = null, video:Video = null) {
			this.video=video;
			this.bitmapData=bitmap;
			super(type);
		}

		public override function clone():Event {
			return new UploadEvent(type, bitmapData, video);
		}

		public override function toString():String {
			return formatToString("UploadEvent", "bitmapData", "video");
		}
	}
}
