package de.liersch.components.library {


	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	
	import services.VideoService;
	
	import valueObjects.PlayList;
	import valueObjects.Video;

	[Event( name = "portalNews", type = "de.liersch.components.library.LibraryEvent" )]

	public class LibraryModel extends EventDispatcher {

		private var _currentVideos:ArrayCollection;
		private var _allVideos:ArrayCollection;

		private var _selectedVideo:Video;
		private var _service:VideoService;

		private var _myUploads:PlayList;
		private var _myFavorites:PlayList;
		private var _myHistory:PlayList;

		private var _currentVideo:Video;
		
		
		public function LibraryModel( service:VideoService ) {
			_service = service;
		}
		
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            public methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		public function setAllVideos():void {
			_currentVideos = _allVideos;
		}

		public function getVideo( index:int ):Video {
			_currentVideo = _currentVideos.getItemAt( index ) as Video;
			if ( _myFavorites )
				_currentVideo.isFavorite = isInFavorites(_currentVideo.id); 
			return _currentVideo;
		}
		
		public function provideVideoByID( value:uint ):void {
			_selectedVideo = _currentVideos.getItemAt( value ) as Video;
		}

		public function setNews():void {
			var news:Array = _currentVideos.toArray();
			news.sort( sortOnID );
			_currentVideos.source = news;
		}

		public function setBest():void {
			var best:Array = _currentVideos.toArray();
			best.sort( sortOnRate );
			_currentVideos.source = best;
		}

		public function setMost():void {
			var news:Array = _currentVideos.toArray();
			news.sort( sortOnViews );
			_currentVideos.source = news;
		}

		public function setUploads():void {
			_currentVideos = _myUploads.video;
		}

		public function setFavorites():void {
			_currentVideos = _myFavorites.video;
		}

		public function setHistory():void {
			_currentVideos = _myHistory.video;
		}

		public function updateVideo(video:Video):void {
			for each (var v:Video in _allVideos) {
				if (v.id == video.id) {
					v.rating = video.rating;
					break;
				}
			}
		}
		
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                           Service Methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		public function loadVideos():void {
			_service.getNewVideos( new Responder( onGetNewsSucces, onGetNewsFault ));
		}

		public function loadUserVideos():void {
			_service.loadUserVideos( new Responder( onGetUserVideosSucces, onGetUserVideosFault ));
		}

		public function setFavorite( videoID:Number ):void {
			if ( videoID == -1 )
				videoID = _currentVideo.id;
			_service.setToFavorite( videoID, new Responder( onSetFavoriteSucces, onSetFavoriteFault ));
		}

		public function removeFavorite( videoID:Number ):void {
			if ( videoID == -1 )
				videoID = _currentVideo.id;
			_service.removeFromFavorite(videoID, new Responder( onRemoveFavoriteSucces, onRemoveFavoriteFault ));
		}

		public function updateViewCountAndHistory():void {
			_service.updateViewCount( _currentVideo.id );
			if ( !isInFavorites(_currentVideo.id)) {
				_service.setToHistory( _currentVideo.id, new Responder( onSetToHistorySucces, onSetToHistoryFault ));
			}
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                         Responder Methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		private function onGetNewsSucces( o:Object ):void {
			var playList:PlayList = new PlayList();
			playList.video = o.result as ArrayCollection;
			_allVideos = playList.video;
			_currentVideos = _allVideos;
			dispatchEvent( new LibraryEvent( LibraryEvent.UPDATE ));
		}

		private function onGetNewsFault( o:Object ):void {
			dispatchEvent( new Event( "noServiceAvailable" ));
		}

		private function onGetUserVideosFault( o:Object ):void {
			dispatchEvent( new Event( "noServiceAvailable" ));
		}

		private function onGetUserVideosSucces( o:Object ):void {
			_myUploads = ( o.result as ArrayCollection ).getItemAt( 0 ) as PlayList;
			_myFavorites = ( o.result as ArrayCollection ).getItemAt( 1 ) as PlayList;
			_myHistory = ( o.result as ArrayCollection ).getItemAt( 2 ) as PlayList;
			_currentVideos = _myUploads.video;
			dispatchEvent( new LibraryEvent( LibraryEvent.UPDATE ));
		}

		private function onSetFavoriteSucces( o:Object ):void {
			_myFavorites.video.addItem( o.result as Video );
		}

		private function onSetFavoriteFault( o:Object ):void {
			trace( "CatalogModel.onSetFavoriteFault(o)" );
		}

		private function onRemoveFavoriteSucces( o:Object ):void {
			var index:int = _myFavorites.video.getItemIndex( o.result as Video );
			if ( index > -1 )
				_myFavorites.video.removeItemAt( index );
		}

		private function onRemoveFavoriteFault( o:Object ):void {
			// not implement
		}

		private function onSetToHistorySucces( o:Object ):void {
			_myHistory.video.addItem( o.result as Video );
		}

		private function onSetToHistoryFault( o:Object ):void {

		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            Getter Setter                             //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		public function get list():ArrayCollection {
			return _currentVideos;
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                                 Helper                               //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		private function sortOnID( a:Video, b:Video ):Number {
			var aId:Number = a.id;
			var bId:Number = b.id;
			if ( aId > bId ) {
				return -1;
			} else if ( aId < bId ) {
				return 1;
			} else {
				return 0;
			}
		}

		private function sortOnViews( a:Video, b:Video ):Number {
			var aViews:int = a.views;
			var bViews:int = b.views;
			if ( aViews > bViews ) {
				return -1;
			} else if ( aViews < bViews ) {
				return 1;
			} else {
				return 0;
			}
		}

		private function sortOnRate( a:Video, b:Video ):Number {
			var aRating:int = a.rating;
			var bRating:int = b.rating;
			if ( aRating > bRating ) {
				return -1;
			} else if ( aRating < bRating ) {
				return 1;
			} else {
				return 0;
			}
		}
		
		private function isInFavorites(videoID:Number):Boolean {
			if(!_myFavorites)
				return false;
			for each (var video:Video in _myFavorites.video) {
				if(video.id == videoID)
					return true;
			}
			return false;
		}
		
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            Getter Setter                             //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		public function get currentVideos():ArrayCollection {
			return _currentVideos;
		}

	}
}
