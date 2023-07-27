/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - Video.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.EventDispatcher;
import flash.utils.ByteArray;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;
import valueObjects.Comment;
import valueObjects.Date;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_Video extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("de.liersch.persistence.Video") == null)
            {
                flash.net.registerClassAlias("de.liersch.persistence.Video", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("de.liersch.persistence.Video", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
        valueObjects.Date.initRemoteClassAliasSingleChild();
        valueObjects.Comment.initRemoteClassAliasSingleChild();
    }

    model_internal var _dminternal_model : _VideoEntityMetadata;
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
    private var _internal_title : String;
    private var _internal_duration : int;
    private var _internal_releaseDate : valueObjects.Date;
    private var _internal_preview : ByteArray;
    private var _internal_description : String;
    private var _internal_views : int;
    private var _internal_fileName : String;
    private var _internal_rating : int;
    private var _internal_comment : ArrayCollection;
    model_internal var _internal_comment_leaf:valueObjects.Comment;
    private var _internal_lenght : int;
    private var _internal_ownerNickName : String;
    private var _internal_sumRate : Number;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_Video()
    {
        _model = new _VideoEntityMetadata(this);

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
    public function get title() : String
    {
        return _internal_title;
    }

    [Bindable(event="propertyChange")]
    public function get duration() : int
    {
        return _internal_duration;
    }

    [Bindable(event="propertyChange")]
    public function get releaseDate() : valueObjects.Date
    {
        return _internal_releaseDate;
    }

    [Bindable(event="propertyChange")]
    public function get preview() : ByteArray
    {
        return _internal_preview;
    }

    [Bindable(event="propertyChange")]
    public function get description() : String
    {
        return _internal_description;
    }

    [Bindable(event="propertyChange")]
    public function get views() : int
    {
        return _internal_views;
    }

    [Bindable(event="propertyChange")]
    public function get fileName() : String
    {
        return _internal_fileName;
    }

    [Bindable(event="propertyChange")]
    public function get rating() : int
    {
        return _internal_rating;
    }

    [Bindable(event="propertyChange")]
    public function get comment() : ArrayCollection
    {
        return _internal_comment;
    }

    [Bindable(event="propertyChange")]
    public function get lenght() : int
    {
        return _internal_lenght;
    }

    [Bindable(event="propertyChange")]
    public function get ownerNickName() : String
    {
        return _internal_ownerNickName;
    }

    [Bindable(event="propertyChange")]
    public function get sumRate() : Number
    {
        return _internal_sumRate;
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

    public function set title(value:String) : void
    {
        var oldValue:String = _internal_title;
        if (oldValue !== value)
        {
            _internal_title = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "title", oldValue, _internal_title));
        }
    }

    public function set duration(value:int) : void
    {
        var oldValue:int = _internal_duration;
        if (oldValue !== value)
        {
            _internal_duration = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "duration", oldValue, _internal_duration));
        }
    }

    public function set releaseDate(value:valueObjects.Date) : void
    {
        var oldValue:valueObjects.Date = _internal_releaseDate;
        if (oldValue !== value)
        {
            _internal_releaseDate = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "releaseDate", oldValue, _internal_releaseDate));
        }
    }

    public function set preview(value:ByteArray) : void
    {
        var oldValue:ByteArray = _internal_preview;
        if (oldValue !== value)
        {
            _internal_preview = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "preview", oldValue, _internal_preview));
        }
    }

    public function set description(value:String) : void
    {
        var oldValue:String = _internal_description;
        if (oldValue !== value)
        {
            _internal_description = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "description", oldValue, _internal_description));
        }
    }

    public function set views(value:int) : void
    {
        var oldValue:int = _internal_views;
        if (oldValue !== value)
        {
            _internal_views = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "views", oldValue, _internal_views));
        }
    }

    public function set fileName(value:String) : void
    {
        var oldValue:String = _internal_fileName;
        if (oldValue !== value)
        {
            _internal_fileName = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "fileName", oldValue, _internal_fileName));
        }
    }

    public function set rating(value:int) : void
    {
        var oldValue:int = _internal_rating;
        if (oldValue !== value)
        {
            _internal_rating = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "rating", oldValue, _internal_rating));
        }
    }

    public function set comment(value:*) : void
    {
        var oldValue:ArrayCollection = _internal_comment;
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_comment = value;
            }
            else if (value is Array)
            {
                _internal_comment = new ArrayCollection(value);
            }
            else if (value == null)
            {
                _internal_comment = null;
            }
            else
            {
                throw new Error("value of comment must be a collection");
            }
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "comment", oldValue, _internal_comment));
        }
    }

    public function set lenght(value:int) : void
    {
        var oldValue:int = _internal_lenght;
        if (oldValue !== value)
        {
            _internal_lenght = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "lenght", oldValue, _internal_lenght));
        }
    }

    public function set ownerNickName(value:String) : void
    {
        var oldValue:String = _internal_ownerNickName;
        if (oldValue !== value)
        {
            _internal_ownerNickName = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "ownerNickName", oldValue, _internal_ownerNickName));
        }
    }

    public function set sumRate(value:Number) : void
    {
        var oldValue:Number = _internal_sumRate;
        if (oldValue !== value)
        {
            _internal_sumRate = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sumRate", oldValue, _internal_sumRate));
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
    public function get _model() : _VideoEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _VideoEntityMetadata) : void
    {
        var oldValue : _VideoEntityMetadata = model_internal::_dminternal_model;
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
