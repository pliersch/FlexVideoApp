package de.liersch.components.player.media {
	
	import de.liersch.components.player.PlayerView;
	
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.net.NetStream;
	
	import mx.events.ResizeEvent;
	
	import org.osmf.elements.VideoElement;
	import org.osmf.events.LoadEvent;
	import org.osmf.events.MediaErrorEvent;
	import org.osmf.events.MediaPlayerCapabilityChangeEvent;
	import org.osmf.events.MediaPlayerStateChangeEvent;
	import org.osmf.events.TimeEvent;
	import org.osmf.media.MediaElement;
	import org.osmf.media.MediaFactory;
	import org.osmf.media.MediaPlayer;
	import org.osmf.media.MediaPlayerSprite;
	import org.osmf.media.URLResource;
	import org.osmf.net.DynamicStreamingResource;
	import org.osmf.net.NetLoader;
	import org.osmf.net.NetStreamCodes;
	import org.osmf.traits.LoadState;
	import org.osmf.traits.MediaTraitType;

	[Event(name="mediaPlayerStateChange", type="org.osmf.events.MediaPlayerStateChangeEvent")]
	[Event(name="canPlayChange", type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
	[Event(name="metadata", type="de.liersch.components.player.media.PlayerInfoEvent")]
	
	public class PlayerModel extends EventDispatcher {

		
		private var _currentMin:uint;
		private var _currentSec:uint;

		private var _resource:DynamicStreamingResource;
		private var _netstream:NetStream;
		
		private var _mediaPlayer:MediaPlayer;

		private var _netLoader:NetLoader;

		private var _mediaElement:MediaElement;
		
		private var _currentVolume:Number;
		
		private var _playTime:uint;

		private var _view:PlayerView;
		
		private var _sprite:MediaPlayerSprite;
		private var _isMute:Boolean;
		
		public function PlayerModel(view:PlayerView) {
			_view = view;
			initPlayer();
			setupListener();
		}
		
		private function initPlayer():void {
			_sprite=new MediaPlayerSprite();
			_mediaPlayer = _sprite.mediaPlayer;
			_sprite.width=_view.mediaHolder.width;
			_sprite.height=_view.mediaHolder.height;
			_view.mediaHolder.addChild(_sprite);
			_view.addEventListener(ResizeEvent.RESIZE, onResizeView);
			_currentVolume = 0.5;
			
		}
		
		private function setupListener():void {
			_mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.CAN_PLAY_CHANGE, onCanPlayChange);
			_mediaPlayer.addEventListener(MediaPlayerStateChangeEvent.MEDIA_PLAYER_STATE_CHANGE,onMediaPlayerStateChange);
			_mediaPlayer.addEventListener(TimeEvent.CURRENT_TIME_CHANGE, onCurrentTimeChanged);
			_mediaPlayer.addEventListener(TimeEvent.COMPLETE, onTimeComplete);
		}
		
		private function setupPlayer(url:String):void {			
			_mediaElement = _sprite.mediaFactory.createMediaElement(new URLResource(url));
			if(_mediaElement is VideoElement)
				(_mediaElement as VideoElement).smoothing = true;
			_mediaPlayer.media = _mediaElement;
			_mediaPlayer.volume = _isMute ? 0 : _currentVolume;
			_playTime = 0;
		}
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                             Event Handler                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		private function onMediaPlayerStateChange(event:MediaPlayerStateChangeEvent):void {
			dispatchEvent(event);
		}
		
		private function onTimeComplete(event:TimeEvent):void {
			dispatchEvent(event);
		}
		
		private function onCanPlayChange(event:MediaPlayerCapabilityChangeEvent):void {
			if (event.enabled) {
				_mediaElement.getTrait(MediaTraitType.LOAD).
					addEventListener(LoadEvent.LOAD_STATE_CHANGE, onLoadStateChange);
				_view.errorLabel.visible = false;
			}
		}
		
		private function onLoadStateChange(event:LoadEvent):void {
			if (event.loadState == LoadState.READY) {
				if(_mediaElement is VideoElement){
					(_mediaElement as VideoElement).client.addHandler(NetStreamCodes.ON_META_DATA, onMetaData);					
				}
				_mediaElement.addEventListener(MediaErrorEvent.MEDIA_ERROR, onMediaError);
			}
		}
		
		private function onMediaError(event:MediaErrorEvent):void {
			_view.errorLabel.visible = true;
		}
		
		private function onMetaData(info:Object):void {
			dispatchEvent(new PlayerInfoEvent(PlayerInfoEvent.METADATA, info.duration));
		}

		private function onCurrentTimeChanged(event:TimeEvent):void {
			dispatchEvent(event);
		}
		
		private function onResizeView(event:ResizeEvent):void {
			_sprite.width = _view.width;
			_sprite.height = _view.height;
			_sprite.x = 0;
			_sprite.y = 0;
		}
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            public methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		public function seekTo(seconds:uint):void {
			if (_mediaPlayer.canSeekTo(seconds)) {
				_mediaPlayer.seek(seconds);
			}
		}

		public function play():void {
			if(_mediaPlayer.canPlay){
				_mediaPlayer.play();
				if(_mediaElement is VideoElement)
					(_mediaElement as VideoElement).smoothing = true;
			}
		}

		public function pause():void {
			if(_mediaPlayer.canPause)
				_mediaPlayer.pause();
		}
		
		public function load(url:String):void {
			setupPlayer(url);
		}
		
		public function setVolume(volume:Number):void {
			_currentVolume = volume;
			_mediaPlayer.volume = volume;
		}
		
		public function mute(isMute:Boolean):void {
			_isMute = isMute;
			if(isMute)
				_mediaPlayer.volume = 0;
			else
				_mediaPlayer.volume = _currentVolume;
		}
		
		public function capture():BitmapData {
			var bitmapData:BitmapData = new BitmapData(_sprite.width, _sprite.height, true, 0x000000);
			bitmapData.draw(_sprite);
			return bitmapData;
		}
	}
}