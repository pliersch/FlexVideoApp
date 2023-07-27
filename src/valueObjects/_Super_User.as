/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - User.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.EventDispatcher;
import flash.utils.ByteArray;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;
import valueObjects.PlayList;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_User extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("de.liersch.persistence.User") == null)
            {
                flash.net.registerClassAlias("de.liersch.persistence.User", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("de.liersch.persistence.User", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
        valueObjects.PlayList.initRemoteClassAliasSingleChild();
        valueObjects.Video.initRemoteClassAliasSingleChild();
        valueObjects.Date.initRemoteClassAliasSingleChild();
        valueObjects.Comment.initRemoteClassAliasSingleChild();
    }

    model_internal var _dminternal_model : _UserEntityMetadata;
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
    private var _internal_id : Number;
    private var _internal_email : String;
    private var _internal_nickName : String;
    private var _internal_name : String;
    private var _internal_isLoggedIn : Boolean;
    private var _internal_avatarBytes : ByteArray;
    private var _internal_givenName : String;
    private var _internal_password : String;
    private var _internal_playList : ArrayCollection;
    model_internal var _internal_playList_leaf:valueObjects.PlayList;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_User()
    {
        _model = new _UserEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get id() : Number
    {
        return _internal_id;
    }

    [Bindable(event="propertyChange")]
    public function get email() : String
    {
        return _internal_email;
    }

    [Bindable(event="propertyChange")]
    public function get nickName() : String
    {
        return _internal_nickName;
    }

    [Bindable(event="propertyChange")]
    public function get name() : String
    {
        return _internal_name;
    }

    [Bindable(event="propertyChange")]
    public function get isLoggedIn() : Boolean
    {
        return _internal_isLoggedIn;
    }

    [Bindable(event="propertyChange")]
    public function get avatarBytes() : ByteArray
    {
        return _internal_avatarBytes;
    }

    [Bindable(event="propertyChange")]
    public function get givenName() : String
    {
        return _internal_givenName;
    }

    [Bindable(event="propertyChange")]
    public function get password() : String
    {
        return _internal_password;
    }

    [Bindable(event="propertyChange")]
    public function get playList() : ArrayCollection
    {
        return _internal_playList;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set id(value:Number) : void
    {
        var oldValue:Number = _internal_id;
        if (oldValue !== value)
        {
            _internal_id = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "id", oldValue, _internal_id));
        }
    }

    public function set email(value:String) : void
    {
        var oldValue:String = _internal_email;
        if (oldValue !== value)
        {
            _internal_email = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "email", oldValue, _internal_email));
        }
    }

    public function set nickName(value:String) : void
    {
        var oldValue:String = _internal_nickName;
        if (oldValue !== value)
        {
            _internal_nickName = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "nickName", oldValue, _internal_nickName));
        }
    }

    public function set name(value:String) : void
    {
        var oldValue:String = _internal_name;
        if (oldValue !== value)
        {
            _internal_name = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "name", oldValue, _internal_name));
        }
    }

    public function set isLoggedIn(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_isLoggedIn;
        if (oldValue !== value)
        {
            _internal_isLoggedIn = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "isLoggedIn", oldValue, _internal_isLoggedIn));
        }
    }

    public function set avatarBytes(value:ByteArray) : void
    {
        var oldValue:ByteArray = _internal_avatarBytes;
        if (oldValue !== value)
        {
            _internal_avatarBytes = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "avatarBytes", oldValue, _internal_avatarBytes));
        }
    }

    public function set givenName(value:String) : void
    {
        var oldValue:String = _internal_givenName;
        if (oldValue !== value)
        {
            _internal_givenName = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "givenName", oldValue, _internal_givenName));
        }
    }

    public function set password(value:String) : void
    {
        var oldValue:String = _internal_password;
        if (oldValue !== value)
        {
            _internal_password = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "password", oldValue, _internal_password));
        }
    }

    public function set playList(value:*) : void
    {
        var oldValue:ArrayCollection = _internal_playList;
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_playList = value;
            }
            else if (value is Array)
            {
                _internal_playList = new ArrayCollection(value);
            }
            else if (value == null)
            {
                _internal_playList = null;
            }
            else
            {
                throw new Error("value of playList must be a collection");
            }
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "playList", oldValue, _internal_playList));
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
    public function get _model() : _UserEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _UserEntityMetadata) : void
    {
        var oldValue : _UserEntityMetadata = model_internal::_dminternal_model;
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
