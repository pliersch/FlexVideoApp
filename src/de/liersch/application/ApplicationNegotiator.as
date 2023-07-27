package de.liersch.application {

	import de.liersch.components.comment.CommentEvent;
	import de.liersch.components.comment.CommentPresenter;
	import de.liersch.components.library.LibraryEvent;
	import de.liersch.components.library.LibraryPersenter;
	import de.liersch.components.player.PlayerPresenter;
	import de.liersch.components.player.controlbar.ControlbarEvent;
	import de.liersch.components.player.media.PlayerEvent;
	import de.liersch.components.upload.UploadPresenter;
	import de.liersch.components.user.UserEvent;
	import de.liersch.components.user.UserPresenter;
	import de.liersch.event.UploadEvent;
	
	import flash.events.Event;
	
	import valueObjects.Video;

	public class ApplicationNegotiator {

		private var _user:UserPresenter;
		private var _player:PlayerPresenter;
		private var _upload:UploadPresenter;
		private var _library:LibraryPersenter;
		private var _comment:CommentPresenter;
		private var _applicationPresenter:ApplicationPresenter;

		public function ApplicationNegotiator() {

		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                                 Setup                                //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		public function createUser(userPresenter:UserPresenter):void {
			_user = userPresenter;
			_user.addEventListener(UserEvent.CONNECTED, onUserConnected);
			_user.addEventListener(UserEvent.DISCONNECTED, onUserDisconnected);
		}

		public function createPlayer(player:PlayerPresenter):void {
			_player = player;
			_player.addEventListener(ControlbarEvent.NORMAL_SCREEN, onNormalScreen);
			_player.addEventListener(ControlbarEvent.FULL_SCREEN, onFullScreen);
			_player.addEventListener(UploadEvent.DO_UPLOAD, onUploadSelected);
			_player.addEventListener(UserEvent.FAVORITE, onFavorite);
			_player.addEventListener(PlayerEvent.LONG_PLAYED, onLongPlayed);
			_player.addEventListener(PlayerEvent.VIDEO_COMPLETE, onVideoComplete);
		}

		public function createLibrary(libraryPersenter:LibraryPersenter):void {
			_library = libraryPersenter;
			_library.addEventListener(LibraryEvent.VIDEO_SELECTED, onVideoSelected);
			_library.loadVideos();
		}

		public function createComment(comment:CommentPresenter):void {
			_comment = comment;
			_comment.addEventListener(CommentEvent.ADD_COMMENT_SUCCESS, onAddCommentSuccess);
		}

		private function onAddCommentSuccess(event:CommentEvent):void {
			_library.updateVideo(event.data as Video);
		}

		public function createUpload(uploadPresenter:UploadPresenter):void {
			_upload = uploadPresenter;
			_upload.addEventListener(UploadEvent.UPLOAD_SUCCESS, onUploadSuccess);
			_upload.addEventListener(UploadEvent.CANCEL, onCancelUpload);
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                           Event Handler                              //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		private function onVideoComplete(event:PlayerEvent):void {
			// ist das Video im FullScreen muss der vorherige State gesetzt werden
			_applicationPresenter.setToLastState();
		}
		
		private function onLongPlayed(event:PlayerEvent):void {
			_library.updateViewCountAndHistory();
		}

		private function onFavorite(event:UserEvent):void {
			_library.setFavorite();
		}

		private function onUploadSuccess(event:Event):void {
			_library.loadVideos();
		}

		private function onUserDisconnected(event:UserEvent):void {
			_applicationPresenter.setHomeState();
			_player.disableUploadAndFavorite();
			_comment.disableComment();
			_applicationPresenter.handleLogout();
			_library.showPortalVideos();
		}

		private function onUserConnected(event:UserEvent):void {
			_applicationPresenter.connected();
			_comment.enableComment();
			_player.enableUploadAndFavorite();
		}

		private function onVideoSelected(event:LibraryEvent):void {
			_player.setMedia(event.video);
			_comment.setVideo(event.video);
		}

		private function onCancelUpload(event:UploadEvent):void {
			_player.showUpload();
		}

		private function onNormalScreen(event:ControlbarEvent):void {
			_applicationPresenter.setNormalScreen();
		}

		private function onFullScreen(event:Event):void {
			_applicationPresenter.setFullScreen();
		}

		private function onUploadSelected(event:UploadEvent):void {
			// TODO warum
			if (_upload) {
				_upload.showUpload(event.bitmapData, event.video);
			}
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                          public methods                              //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		public function playLocalMedia(detail:Video):void {
			_player.setLocalMedia(detail);
			_comment.removeVideo();
		}

		public function handleUserInteraction(value:Boolean):void {
			_player.setControlBarVisibility(value);
		}

		public function logout():void {
			_user.logout();
		}

		public function handleHomeState():void {
			_library.showPortalVideos();
		}

		public function handleMyChannelState():void {
			_library.showUserVideos();
			// TODO
			//				if (_myData)
			//			_myData.setUser(_user.user);
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            Getter Setter                             //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		public function set windowPresenter(value:ApplicationPresenter):void {
			_applicationPresenter = value;
		}

	}
}
