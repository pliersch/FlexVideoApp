package de.liersch.components.player {

	import de.liersch.components.player.controlbar.ControlbarEvent;
	import de.liersch.components.player.controlbar.ControlbarMediator;
	import de.liersch.components.player.media.PlayerEvent;
	import de.liersch.components.player.media.PlayerInfoEvent;
	import de.liersch.components.player.media.PlayerModel;
	import de.liersch.event.UploadEvent;
	import de.liersch.components.user.UserEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	import org.osmf.events.MediaPlayerStateChangeEvent;
	import org.osmf.events.TimeEvent;
	import org.osmf.media.MediaPlayerState;

	import valueObjects.Video;

	[Event( name = "fullScreen", type = "flash.events.Event" )]
	[Event( name = "normalScreen", type = "flash.events.Event" )]

	public class PlayerPresenter extends EventDispatcher {

		private var _controlbar:ControlbarMediator;
		private var _model:PlayerModel;
		private var _video:Video;
		private var _playTime:int;
		private var _isLocal:Boolean;

		public function PlayerPresenter(controlbarPresenter:ControlbarMediator, mediaPresenter:PlayerModel) {
			_controlbar = controlbarPresenter;
			_model = mediaPresenter;
			setup();
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                                 Setup                                //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		private function setup():void {
			setupControlbarListener();
			setupMediaListener();
		}

		private function setupControlbarListener():void {
			_controlbar.addEventListener( ControlbarEvent.PLAY, onPlay );
			_controlbar.addEventListener( ControlbarEvent.PAUSE, onPause );
			_controlbar.addEventListener( ControlbarEvent.MUTE, onMute );
			_controlbar.addEventListener( ControlbarEvent.UNMUTE, onUnMute );
			_controlbar.addEventListener( ControlbarEvent.VOLUME, onVolume );
			_controlbar.addEventListener( ControlbarEvent.SEEK, onSeek );
			_controlbar.addEventListener( ControlbarEvent.FULL_SCREEN, dispatchEvent );
			_controlbar.addEventListener( ControlbarEvent.NORMAL_SCREEN, dispatchEvent );
			_controlbar.addEventListener( ControlbarEvent.UPLOAD, onUpload );
			_controlbar.addEventListener( ControlbarEvent.FAVORITE, onFavorite );
		}

		private function setupMediaListener():void {
			_model.addEventListener( PlayerEvent.READY, onMediaReady );
			_model.addEventListener( TimeEvent.COMPLETE, onComplete );
			_model.addEventListener( MediaPlayerStateChangeEvent.MEDIA_PLAYER_STATE_CHANGE, onMediaPlayerStateChange );
			_model.addEventListener( TimeEvent.CURRENT_TIME_CHANGE, onCurrentTimeChange );
			_model.addEventListener( PlayerInfoEvent.METADATA, onMetadata );
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                             Event Handler                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		private function onFavorite(event:ControlbarEvent):void {
			dispatchEvent( new UserEvent( UserEvent.FAVORITE ));
		}

		private function onUpload(event:ControlbarEvent):void {
			_model.pause();
			dispatchEvent( new UploadEvent( UploadEvent.DO_UPLOAD, _model.capture(), _video ));
		}

		private function onComplete(event:TimeEvent):void {
			dispatchEvent(new PlayerEvent(PlayerEvent.VIDEO_COMPLETE));
			_controlbar.reset();
		}

		private function onMediaPlayerStateChange(event:MediaPlayerStateChangeEvent):void {
			if (event.state == MediaPlayerState.PAUSED)
				_controlbar.changePlayState( "pause" );
			else if (event.state == MediaPlayerState.PLAYING)
				_controlbar.changePlayState( "play" );
		}

		private function onMetadata(event:PlayerInfoEvent):void {
			_video.duration = event.duration;
			_controlbar.setDuration( event.duration );
		}

		private function onCurrentTimeChange(event:TimeEvent):void {
			// Circa 10sek Spielzeit und kein Video von HD
			if (_playTime++ == 40 && !_isLocal) {
				dispatchEvent( new PlayerEvent( PlayerEvent.LONG_PLAYED ));
			}
			_controlbar.updateTime( event.time );
		}

		private function onMediaReady(event:PlayerEvent):void {
			_controlbar.changePlayState( "play" );
		}

		private function onSeek(event:ControlbarEvent):void {
			_model.seekTo( event.data as uint );
		}

		private function onVolume(event:ControlbarEvent):void {
			_model.setVolume( event.data as Number );
			if (event.data as Number == 0)
				_model.mute( true );
		}

		private function onMute(event:ControlbarEvent):void {
			_model.mute( true );
		}

		private function onUnMute(event:ControlbarEvent):void {
			_model.mute( false );
		}

		private function onPause(event:ControlbarEvent):void {
			_model.pause();
		}

		private function onPlay(event:ControlbarEvent):void {
			_model.play();
		}

		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            public methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		public function setLocalMedia(video:Video):void {
			_isLocal = true;
			_video = video;
			_model.load( _video.localPath );
			showUpload();
		}

		public function setMedia(video:Video):void {
			_video = video;
			_isLocal = false;
			_playTime = 0;
			_model.load( _video.fileName );
			_controlbar.hideUpload();
			if(!_video.isFavorite)
				_controlbar.showFavorite();
			else
				_controlbar.hideFavorite();
		}

		public function setControlBarVisibility(value:Boolean):void {
			if (value)
				_controlbar.show();
			else
				_controlbar.hide();
		}

		public function enableUploadAndFavorite():void {
			_controlbar.enableUploadAndFavorite();
		}
		
		public function disableUploadAndFavorite():void {
			_controlbar.disableUploadAndFavorite();
		}

		public function showUpload():void {
			_controlbar.showUpload();
		}


		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            Getter Setter                             //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////

		public function get video():Video {
			return _video;
		}



	}
}
