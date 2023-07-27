package de.liersch.components.comment {
	import de.liersch.components.logger.Logger;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	
	import valueObjects.Video;

	public class CommentPresenter extends EventDispatcher {
		
		private var _model:CommentModel;
		private var _view:CommentView;
		private var _isLoggedIn:Boolean;

		
		
		private function setupListener():void {
			_view.lblAddComment.addEventListener(MouseEvent.CLICK, onClickAddComment);
			_view.buttonOk.addEventListener(MouseEvent.CLICK, onClickButtonOk);
			_view.buttonCancel.addEventListener(MouseEvent.CLICK, onClickButtonCancel);
			_model.addEventListener(CommentEvent.ADD_COMMENT_SUCCESS, onCommentSuccess);
			_model.addEventListener(CommentEvent.GET_COMMENTS_SUCCESS, onGetCommentsSuccess);
			_model.addEventListener(CommentEvent.ADD_COMMENT_FAULT, onFault);
			_model.addEventListener(CommentEvent.GET_COMMENTS_FAULT, onFault);
		}
		
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                             Event Handler                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
				
		private function onClickButtonOk(event:MouseEvent):void {
			if(_view.txtInput.text.length > 0){
				_model.addComment(_view.txtInput.text, _view.radioGroup.selectedValue as uint);
				_view.currentState = "AllCommentsState";
				_view.txtInput.text = "";
				_view.radioGroup.selectedValue = 3;
			} else {
				Alert.show("Bitte einen Kommentar schreiben");
			}
			
		}
		
		private function onClickButtonCancel(event:MouseEvent):void {
			_view.currentState = "AllCommentsState";
		}
		
		private function onClickAddComment(event:MouseEvent):void {
			_view.currentState = "AddCommentState";
		}
		
		private function onGetCommentsSuccess(event:CommentEvent):void {
			_view.commentsList.contentGroup.list.dataProvider = event.data as ArrayCollection;
		}

		private function onCommentSuccess(event:CommentEvent):void {
			_view.commentsList.contentGroup.list.dataProvider = (event.data as Video).comment;
			dispatchEvent(event);
		}
				
		private function onFault(event:Event):void {
			Logger.instance.log("CommentPresenter","onCommentFault");
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            public methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		public function CommentPresenter(model:CommentModel, view:CommentView) {
			_model = model;
			_view = view;
			super();
			setupListener();
		}
		
		public function setVideo(video:Video):void {
			_model.loadVideo(video);
			_view.commentsList.contentGroup.list.dataProvider = video.comment;
			if(_isLoggedIn)
				_view.lblAddComment.visible = true;
			else
				_view.lblAddComment.visible = false;
		}

		public function removeVideo():void {
			_model.video = null;
			_view.lblAddComment.visible = false;
		}
		
		public function enableComment():void {
			_isLoggedIn = true;
			if(_model.video){
				_view.lblAddComment.visible = true;
			}
		}
		
		public function disableComment():void {
			_view.lblAddComment.visible = false;
			_isLoggedIn = false;
		}
	}
}
