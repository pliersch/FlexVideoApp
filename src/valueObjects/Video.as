/**
 * This is a generated sub-class of _Video.as and is intended for behavior
 * customization.  This class is only generated when there is no file already present
 * at its target location.  Thus custom behavior that you add here will survive regeneration
 * of the super-class. 
 *
 * NOTE: Do not manually modify the RemoteClass mapping unless
 * your server representation of this class has changed and you've 
 * updated your ActionScriptGeneration,RemoteClass annotation on the
 * corresponding entity 
 **/ 
 
package valueObjects
{

import com.adobe.fiber.core.model_internal;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

public class Video extends _Super_Video
{
	private static const BMP_RESOLUTION:Point=new Point(220, 150);
	private var _previewBitmapData:BitmapData;
	private var _isFavorite:Boolean;
	private var _localPath:String;
//	private var _rating:uint;
    /** 
     * DO NOT MODIFY THIS STATIC INITIALIZER - IT IS NECESSARY
     * FOR PROPERLY SETTING UP THE REMOTE CLASS ALIAS FOR THIS CLASS
     *
     **/
     
    /**
     * Calling this static function will initialize RemoteClass aliases
     * for this value object as well as all of the value objects corresponding
     * to entities associated to this value object's entity.  
     */     
    public static function _initRemoteClassAlias() : void
    {
        _Super_Video.model_internal::initRemoteClassAliasSingle(valueObjects.Video);
        _Super_Video.model_internal::initRemoteClassAliasAllRelated();
    }
     
    model_internal static function initRemoteClassAliasSingleChild() : void
    {
        _Super_Video.model_internal::initRemoteClassAliasSingle(valueObjects.Video);
    }
    
    {
        _Super_Video.model_internal::initRemoteClassAliasSingle(valueObjects.Video);
    }
    /** 
     * END OF DO NOT MODIFY SECTION
     *
     **/   
	public function get previewBitmapData():BitmapData {
		preview.position = 0;
		_previewBitmapData=new BitmapData(BMP_RESOLUTION.x, BMP_RESOLUTION.y);
		try {
			_previewBitmapData.setPixels(new Rectangle(0, 0, BMP_RESOLUTION.x, BMP_RESOLUTION.y), preview);
		} catch (error:Error) {
			trace("Video.previewBitmapData()");
			trace(error.message);
		}
		return _previewBitmapData;
	}
	
//	[Bindable(event="propertyChange")]
//	public function get rating():uint {
//		_rating = sumRate / comment.length;
//		return _rating;
//	}
//	[Bindable(event="propertyChange")]
//	public function set rating(value:uint):void{
//		_rating = value;
//	}
	
	public function get isFavorite():Boolean{
		return _isFavorite;
	}

	public function set isFavorite(value:Boolean):void {
		_isFavorite = value;
	}

	public function get localPath():String
	{
		return _localPath;
	}

	public function set localPath(value:String):void
	{
		_localPath = value;
	}
	
	

}

}