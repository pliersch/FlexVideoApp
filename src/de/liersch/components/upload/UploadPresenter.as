package de.liersch.components.upload {

	import de.liersch.components.user.UserServiceEvent;
	import de.liersch.event.UploadEvent;

	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	import mx.controls.Alert;

	import valueObjects.Video;

	[Event(name="upload", type="de.liersch.event.UploadEvent")]

	public class UploadPresenter extends EventDispatcher {

		private var _model:UploadModel;
		private var _view:UploadView;

		public function UploadPresenter(model:UploadModel, view:UploadView) {
			_model=model;
			_view=view;
			setupListener();
		}
		
		private function setupListener():void {
			_view.buttonUpload.addEventListener(MouseEvent.CLICK, onClickUpload);
			_view.buttonCancel.addEventListener(MouseEvent.CLICK, onClickCancel);
			_model.addEventListener(UploadEvent.UPLOAD_SUCCESS, onUploadSuccess);
			_model.addEventListener(UploadEvent.UPLOAD_FAILED, onUploadFailed);

		}
		
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                             Event Handler                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		private function onUploadFailed(event:UserServiceEvent):void {
			_view.errorMessage.visible = true;
		}

		private function onUploadSuccess(event:UserServiceEvent):void {
			_view.visible=false;
			clearView();
			dispatchEvent(new UploadEvent(UploadEvent.UPLOAD_SUCCESS));
		}

		private function onClickCancel(event:MouseEvent):void {
			dispatchEvent(new UploadEvent(UploadEvent.CANCEL));
			clearView();
			_view.visible=false;
		}

		private function onClickUpload(event:MouseEvent):void {
			if (canUpload()) {
				_model.uploadVideo(_view.txtTitle.text, 
					_view.txtDescription.text,
					_view.imagePreview);
			} else
				Alert.show("Bitte alle Felder ausfüllen");
		}
		
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                           private methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		private function canUpload():Boolean {
			return _view.txtTitle.text.length > 0 && 
				_view.txtDescription.text.length > 0;
		}
		
		private function clearView():void {
			_view.txtTitle.text = "";
			_view.txtDescription.text = "";
		}
		
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            public methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		

		public function showUpload(bitmapData:BitmapData, video:Video):void {
			_model.video = video;
			_view.visible = true;
			_view.imagePreview.source = bitmapData;

		}

	}
}
