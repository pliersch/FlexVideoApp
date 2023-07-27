package de.liersch.components.comment
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.Comment;
	import valueObjects.Video;

	public class CommentEvent extends Event
	{
		public static const ADD_COMMENT_SUCCESS:String = "adCommentSuccess";
		public static const ADD_COMMENT_FAULT:String = "adCommentFault";

		public static const GET_COMMENTS_SUCCESS:String = "getCommentsSuccess";
		public static const GET_COMMENTS_FAULT:String = "getCommentsFault";

		private var _data:Object;

		public function CommentEvent(type:String, data:Object=null)
		{
			super(type,false,false);
			
			_data = data;
		}
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            public methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		public function get data():Object
		{
			return _data;
		}

		public override function clone():Event
		{
			return new CommentEvent(type,_data);
		}

		public override function toString():String
		{
			return formatToString("CommentEvent","data");
		}
	}
}