package de.liersch.components.library {

	import de.liersch.skin.list.LibraryListSkin;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	import mx.collections.ArrayCollection;

	import spark.events.IndexChangeEvent;

	import valueObjects.Video;

	[Event( name = "videoSelected", type = "de.liersch.components.library.LibraryEvent" )]
	public class LibraryPersenter extends EventDispatcher {

		private var _model:LibraryModel;
		private var _view:LibraryView;

		public function LibraryPersenter( model:LibraryModel, view:LibraryView ) {
			super();
			_model = model;
			_view = view;
			setupListener();
		}

		private function setupListener():void {
			_view.contentList.addEventListener( IndexChangeEvent.CHANGE, onSelectVideo );
			_view.buttonBarPortal.addEventListener( IndexChangeEvent.CHANGE, onSelectCategoryPortal );
			_view.buttonBarMyChannel.addEventListener( IndexChangeEvent.CHANGE, onSelectCategoryMyChannel );
			_model.addEventListener( LibraryEvent.UPDATE, onUpdate );
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                             Event Handler                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////	


		private function onSelectVideo( event:IndexChangeEvent ):void {
			var video:Video = _model.getVideo( event.newIndex );
			dispatchEvent( new LibraryEvent( LibraryEvent.VIDEO_SELECTED, null, video ));
		}

		private function onUpdate( event:LibraryEvent ):void {
			updateView();
		}

		private function onSelectCategoryPortal( event:IndexChangeEvent ):void {
			switch ( event.newIndex ) {
				case 0: _model.setNews(); break;
				case 1:_model.setBest(); break;
				case 2:_model.setMost(); break;
			}
			updateView();
		}

		private function onSelectCategoryMyChannel( event:IndexChangeEvent ):void {
			switch ( event.newIndex ) {
				case 0: _model.setUploads(); break;
				case 1: _model.setFavorites(); break;
				case 2: _model.setHistory(); break;
			}
			updateView();
		}
		
		private function updateView():void {
			_view.contentList.dataProvider = _model.currentVideos;
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            public methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		public function loadVideos():void {
			_model.loadVideos();
		}

		public function showUserVideos():void {
			_view.buttonBarPortal.visible = false;
			_view.buttonBarMyChannel.visible = true;
			_model.loadUserVideos();
			updateView();
		}

		public function showPortalVideos():void {
			_view.buttonBarPortal.visible = true;
			_view.buttonBarMyChannel.visible = false;
			_model.setAllVideos();
			updateView();
		}

		/**
		 *Fügt ein Video zu den Favoriten hinzu.
		 * @param videoID ID des Videos. Falls keine ID übergeben wird,
		 * wird das aktuelle Video gesetzt.
		 */
		public function setFavorite( videoID:Number = -1 ):void {
			_model.setFavorite( videoID );

		}

		/**
		 * Erhöht die Anzahl der Aufrufe eines Videos.
		 */
		public function updateViewCountAndHistory():void {
			_model.updateViewCountAndHistory();
		}
		
		public function updateVideo(video:Video):void {
			_model.updateVideo(video);
		}

	}
}
