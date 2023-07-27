package de.liersch.components.comment {
	
	import de.liersch.components.logger.Logger;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	
	import services.VideoService;
	
	import valueObjects.Comment;
	import valueObjects.Video;

	public class CommentModel extends EventDispatcher {
		
		private var _video:Video;
		private var _service:VideoService;
		
		
		
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                         Responder Methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		private function onCommentSucces(o:Object):void {
			_video = o.result as Video;
			Logger.instance.log("onCommentSucces", o.result);
			dispatchEvent(new CommentEvent(CommentEvent.ADD_COMMENT_SUCCESS, _video));
		}
		
		private function onCommentFault(o:Object):void {
			dispatchEvent(new CommentEvent(CommentEvent.ADD_COMMENT_FAULT));
		}
		
		private function onGetCommentSucces(o:Object):void {
			dispatchEvent(new CommentEvent(CommentEvent.GET_COMMENTS_SUCCESS, o.result as ArrayCollection));
		}
		
		private function onGetCommentFault(o:Object):void {
			dispatchEvent(new CommentEvent(CommentEvent.GET_COMMENTS_FAULT));
		}
		
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            public methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		public function loadVideo(value:Video):void {
			_video = value;
			_service.getCommentsByVideoID(_video.id, 
				new Responder(onGetCommentSucces, onGetCommentFault));
		}
		
		public function CommentModel(service:VideoService){
			_service = service;
		}
		
		public function addComment(comment:String, rate:uint):void {
			_service.commentAndRate(_video.id, comment, rate, 
				new Responder(onCommentSucces, onCommentFault));
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            Getter Setter                             //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		
		public function get video():Video
		{
			return _video;
		}
		
		public function set video(value:Video):void {
			_video = value;
		}

	}
}