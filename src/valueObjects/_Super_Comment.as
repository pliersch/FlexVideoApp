/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - Comment.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.EventDispatcher;
import flash.utils.ByteArray;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;
import valueObjects.Date;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_Comment extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("de.liersch.persistence.Comment") == null)
            {
                flash.net.registerClassAlias("de.liersch.persistence.Comment", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("de.liersch.persistence.Comment", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
        valueObjects.Date.initRemoteClassAliasSingleChild();
    }

    model_internal var _dminternal_model : _CommentEntityMetadata;
    model_internal var _changedObjects:mx.collections.ArrayCollection = new ArrayCollection();

    public function getChangedObjects() : Array
    {
        _changedObjects.addItemAt(this,0);
        return _changedObjects.source;
    }

    public function clearChangedObjects() : void
    {
        _changedObjects.removeAll();
    }

    /**
     * properties
     */
    private var _internal_message : String;
    private var _internal_id : Number;
    private var _internal_userID : Number;
    private var _internal_rate : int;
    private var _internal_userName : String;
    private var _internal_avatar : ByteArray;
    private var _internal_date : valueObjects.Date;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_Comment()
    {
        _model = new _CommentEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get message() : String
    {
        return _internal_message;
    }

    [Bindable(event="propertyChange")]
    public function get id() : Number
    {
        return _internal_id;
    }

    [Bindable(event="propertyChange")]
    public function get userID() : Number
    {
        return _internal_userID;
    }

    [Bindable(event="propertyChange")]
    public function get rate() : int
    {
        return _internal_rate;
    }

    [Bindable(event="propertyChange")]
    public function get userName() : String
    {
        return _internal_userName;
    }

    [Bindable(event="propertyChange")]
    public function get avatar() : ByteArray
    {
        return _internal_avatar;
    }

    [Bindable(event="propertyChange")]
    public function get date() : valueObjects.Date
    {
        return _internal_date;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set message(value:String) : void
    {
        var oldValue:String = _internal_message;
        if (oldValue !== value)
        {
            _internal_message = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "message", oldValue, _internal_message));
        }
    }

    public function set id(value:Number) : void
    {
        var oldValue:Number = _internal_id;
        if (oldValue !== value)
        {
            _internal_id = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "id", oldValue, _internal_id));
        }
    }

    public function set userID(value:Number) : void
    {
        var oldValue:Number = _internal_userID;
        if (oldValue !== value)
        {
            _internal_userID = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "userID", oldValue, _internal_userID));
        }
    }

    public function set rate(value:int) : void
    {
        var oldValue:int = _internal_rate;
        if (oldValue !== value)
        {
            _internal_rate = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "rate", oldValue, _internal_rate));
        }
    }

    public function set userName(value:String) : void
    {
        var oldValue:String = _internal_userName;
        if (oldValue !== value)
        {
            _internal_userName = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "userName", oldValue, _internal_userName));
        }
    }

    public function set avatar(value:ByteArray) : void
    {
        var oldValue:ByteArray = _internal_avatar;
        if (oldValue !== value)
        {
            _internal_avatar = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "avatar", oldValue, _internal_avatar));
        }
    }

    public function set date(value:valueObjects.Date) : void
    {
        var oldValue:valueObjects.Date = _internal_date;
        if (oldValue !== value)
        {
            _internal_date = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "date", oldValue, _internal_date));
        }
    }

    /**
     * Data/source property setter listeners
     *
     * Each data property whose value affects other properties or the validity of the entity
     * needs to invalidate all previously calculated artifacts. These include:
     *  - any derived properties or constraints that reference the given data property.
     *  - any availability guards (variant expressions) that reference the given data property.
     *  - any style validations, message tokens or guards that reference the given data property.
     *  - the validity of the property (and the containing entity) if the given data property has a length restriction.
     *  - the validity of the property (and the containing entity) if the given data property is required.
     */


    /**
     * valid related derived properties
     */
    model_internal var _isValid : Boolean;
    model_internal var _invalidConstraints:Array = new Array();
    model_internal var _validationFailureMessages:Array = new Array();

    /**
     * derived property calculators
     */

    /**
     * isValid calculator
     */
    model_internal function calculateIsValid():Boolean
    {
        var violatedConsts:Array = new Array();
        var validationFailureMessages:Array = new Array();

        var propertyValidity:Boolean = true;

        model_internal::_cacheInitialized_isValid = true;
        model_internal::invalidConstraints_der = violatedConsts;
        model_internal::validationFailureMessages_der = validationFailureMessages;
        return violatedConsts.length == 0 && propertyValidity;
    }

    /**
     * derived property setters
     */

    model_internal function set isValid_der(value:Boolean) : void
    {
        var oldValue:Boolean = model_internal::_isValid;
        if (oldValue !== value)
        {
            model_internal::_isValid = value;
            _model.model_internal::fireChangeEvent("isValid", oldValue, model_internal::_isValid);
        }
    }

    /**
     * derived property getters
     */

    [Transient]
    [Bindable(event="propertyChange")]
    public function get _model() : _CommentEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _CommentEntityMetadata) : void
    {
        var oldValue : _CommentEntityMetadata = model_internal::_dminternal_model;
        if (oldValue !== value)
        {
            model_internal::_dminternal_model = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_model", oldValue, model_internal::_dminternal_model));
        }
    }

    /**
     * methods
     */


    /**
     *  services
     */
    private var _managingService:com.adobe.fiber.services.IFiberManagingService;

    public function set managingService(managingService:com.adobe.fiber.services.IFiberManagingService):void
    {
        _managingService = managingService;
    }

    model_internal function set invalidConstraints_der(value:Array) : void
    {
        var oldValue:Array = model_internal::_invalidConstraints;
        // avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_invalidConstraints = value;
            _model.model_internal::fireChangeEvent("invalidConstraints", oldValue, model_internal::_invalidConstraints);
        }
    }

    model_internal function set validationFailureMessages_der(value:Array) : void
    {
        var oldValue:Array = model_internal::_validationFailureMessages;
        // avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_validationFailureMessages = value;
            _model.model_internal::fireChangeEvent("validationFailureMessages", oldValue, model_internal::_validationFailureMessages);
        }
    }


}

}
