package de.liersch.components.upload {

	import de.liersch.components.user.UserServiceEvent;
	import de.liersch.event.UploadEvent;

	import flash.display.BitmapData;
	import flash.events.EventDispatcher;

	import mx.rpc.Responder;

	import services.VideoService;

	import spark.components.Image;

	import valueObjects.User;
	import valueObjects.Video;

	public class UploadModel extends EventDispatcher {

		private var _user:User;
		private var _service:VideoService;

		private var _video:Video;

		public function UploadModel(service:VideoService) {
			_service=service;
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            public methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////


		public function uploadVideo(title:String, description:String, img:Image):void {
			var bitmapData:BitmapData = new BitmapData(img.width, img.height, true, 0x000000);
			bitmapData.draw(img);
			_video.title = title;
			_video.description = description;
			_video.preview = bitmapData.getPixels(bitmapData.rect);
			_service.uploadVideo(_video, new Responder(onUploadSuccess, onUploadFault));
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                         Responder Methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		private function onUploadSuccess(o:Object):void {
			dispatchEvent(new UserServiceEvent(UploadEvent.UPLOAD_SUCCESS));
		}

		private function onUploadFault(o:Object):void {
			dispatchEvent(new UserServiceEvent(UploadEvent.UPLOAD_FAILED));
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            Getter Setter                             //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		public function set video(value:Video):void {
			_video=value;
		}

	}
}
