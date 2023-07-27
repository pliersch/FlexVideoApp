/**
 * This is a generated sub-class of _Comment.as and is intended for behavior
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

public class Comment extends _Super_Comment
{
	private static const BMP_RESOLUTION:Point=new Point(134, 158);
	private var _avatarBitmapData:BitmapData;
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
        _Super_Comment.model_internal::initRemoteClassAliasSingle(valueObjects.Comment);
        _Super_Comment.model_internal::initRemoteClassAliasAllRelated();
    }
     
    model_internal static function initRemoteClassAliasSingleChild() : void
    {
        _Super_Comment.model_internal::initRemoteClassAliasSingle(valueObjects.Comment);
    }
    
    {
        _Super_Comment.model_internal::initRemoteClassAliasSingle(valueObjects.Comment);
    }
	
	public function get avatarBitmapData():BitmapData {
		avatar.position = 0;
		_avatarBitmapData=new BitmapData(BMP_RESOLUTION.x, BMP_RESOLUTION.y);
		try {
			_avatarBitmapData.setPixels(new Rectangle(0, 0, BMP_RESOLUTION.x, BMP_RESOLUTION.y), avatar);
		} catch (error:Error) {
			trace("Comment.avatarBitmapData()");
			trace(error.message);
		}
		return _avatarBitmapData;
	}
    /** 
     * END OF DO NOT MODIFY SECTION
     *
     **/    
}

}