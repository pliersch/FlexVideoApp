package services {

	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	
	import valueObjects.User;
	import valueObjects.Video;

	public class VideoService {

		private var _userID:Number;
		private var _superService:_Super_VideoService;

		public function VideoService() {
			_superService = new _Super_VideoService();
		}

		public function ping(responder:Responder):void {
			var token:AsyncToken = _superService.ping();
			token.addResponder(responder);
		}

		public function login(nickname:String, password:String, responder:Responder):void {
			var token:AsyncToken = _superService.login(nickname, password);
			token.addResponder(responder);
		}

		public function uploadVideo(video:Video, responder:Responder):void {
			var token:AsyncToken = _superService.addVideo(_userID, video);
			token.addResponder(responder);
		}

		public function logout(responder:Responder):void {
			var token:AsyncToken = _superService.logout(_userID);
			token.addResponder(responder);
		}

		public function commentAndRate(videoID:Number, comment:String, rate:uint, responder:Responder):void {
			var token:AsyncToken = _superService.addCommentAndRate(_userID, videoID, comment, rate);
			token.addResponder(responder);
		}

		public function register(user:User, responder:Responder):void {
			var token:AsyncToken = _superService.addUser(user);
			token.addResponder(responder);
		}

		public function unRegister(responder:Responder):void {
			var token:AsyncToken = _superService.deleteUserByID(_userID);
			token.addResponder(responder);
		}

		public function changeData(user:User, responder:Responder):void {
			var token:AsyncToken = _superService.changeUserData(user);
			token.addResponder(responder);
		}

		/**
		 * Playlist "News" der Plattform wird dem Responder übergeben.
		 */
		public function getNewVideos(responder:Responder):void {
			var token:AsyncToken = _superService.getAllVideos();
			token.addResponder(responder);
		}

		public function updateViewCount(videoID:Number):void {
			var token:AsyncToken = _superService.increaseViewCount(videoID);
		}

		public function getCommentsByVideoID(id:Number, responder:Responder):void {
			var token:AsyncToken = _superService.getComments(id);
			token.addResponder(responder);
		}

		public function loadUserVideos(responder:Responder):void {
			var token:AsyncToken = _superService.getUserVideos(_userID);
			token.addResponder(responder);
		}

		public function removeFromHistory(videoID:Number, responder:Responder):void {
			var token:AsyncToken = _superService.removeHistorie(_userID, videoID);
			token.addResponder(responder);
		}

		public function setToHistory(videoID:Number, responder:Responder):void {
			if (_userID) {
				var token:AsyncToken = _superService.addHistorie(_userID, videoID);
				token.addResponder(responder);
			} else {
				// responder wird nicht gebraucht und für den GarbagerCollector freigegeben 
				responder = null;
			}
		}

		public function removeFromFavorite(videoID:Number, responder:Responder):void {
			var token:AsyncToken = _superService.removeFavorite(_userID, videoID);
			token.addResponder(responder);
		}

		public function setToFavorite(videoID:Number, responder:Responder):void {
			var token:AsyncToken = _superService.setFavorite(_userID, videoID);
			token.addResponder(responder);
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            Getter Setter                             //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		public function set userID(value:Number):void {
			_userID = value;
		}
	}

}


