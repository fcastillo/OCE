/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - T_version_style.as.
 */

package com.innovae.services.orona.evolutio.type
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_T_version_style extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
    }

    model_internal var _dminternal_model : _T_version_styleEntityMetadata;
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
    private var _internal_id : int;
    private var _internal_name : String;
    private var _internal_text_font : String;
    private var _internal_text_size : int;
    private var _internal_text_color : String;
    private var _internal_border_color : String;
    private var _internal_background_color : String;
    private var _internal_anim_speed : int;
    private var _internal_floor_per_page : int;
    private var _internal_dir_text_color : String;
    private var _internal_dir_up_color : String;
    private var _internal_dir_down_color : String;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_T_version_style()
    {
        _model = new _T_version_styleEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get id() : int
    {
        return _internal_id;
    }

    [Bindable(event="propertyChange")]
    public function get name() : String
    {
        return _internal_name;
    }

    [Bindable(event="propertyChange")]
    public function get text_font() : String
    {
        return _internal_text_font;
    }

    [Bindable(event="propertyChange")]
    public function get text_size() : int
    {
        return _internal_text_size;
    }

    [Bindable(event="propertyChange")]
    public function get text_color() : String
    {
        return _internal_text_color;
    }

    [Bindable(event="propertyChange")]
    public function get border_color() : String
    {
        return _internal_border_color;
    }

    [Bindable(event="propertyChange")]
    public function get background_color() : String
    {
        return _internal_background_color;
    }

    [Bindable(event="propertyChange")]
    public function get anim_speed() : int
    {
        return _internal_anim_speed;
    }

    [Bindable(event="propertyChange")]
    public function get floor_per_page() : int
    {
        return _internal_floor_per_page;
    }

    [Bindable(event="propertyChange")]
    public function get dir_text_color() : String
    {
        return _internal_dir_text_color;
    }

    [Bindable(event="propertyChange")]
    public function get dir_up_color() : String
    {
        return _internal_dir_up_color;
    }

    [Bindable(event="propertyChange")]
    public function get dir_down_color() : String
    {
        return _internal_dir_down_color;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set id(value:int) : void
    {
        var oldValue:int = _internal_id;
        if (oldValue !== value)
        {
            _internal_id = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "id", oldValue, _internal_id));
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

    public function set text_font(value:String) : void
    {
        var oldValue:String = _internal_text_font;
        if (oldValue !== value)
        {
            _internal_text_font = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "text_font", oldValue, _internal_text_font));
        }
    }

    public function set text_size(value:int) : void
    {
        var oldValue:int = _internal_text_size;
        if (oldValue !== value)
        {
            _internal_text_size = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "text_size", oldValue, _internal_text_size));
        }
    }

    public function set text_color(value:String) : void
    {
        var oldValue:String = _internal_text_color;
        if (oldValue !== value)
        {
            _internal_text_color = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "text_color", oldValue, _internal_text_color));
        }
    }

    public function set border_color(value:String) : void
    {
        var oldValue:String = _internal_border_color;
        if (oldValue !== value)
        {
            _internal_border_color = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "border_color", oldValue, _internal_border_color));
        }
    }

    public function set background_color(value:String) : void
    {
        var oldValue:String = _internal_background_color;
        if (oldValue !== value)
        {
            _internal_background_color = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "background_color", oldValue, _internal_background_color));
        }
    }

    public function set anim_speed(value:int) : void
    {
        var oldValue:int = _internal_anim_speed;
        if (oldValue !== value)
        {
            _internal_anim_speed = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "anim_speed", oldValue, _internal_anim_speed));
        }
    }

    public function set floor_per_page(value:int) : void
    {
        var oldValue:int = _internal_floor_per_page;
        if (oldValue !== value)
        {
            _internal_floor_per_page = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "floor_per_page", oldValue, _internal_floor_per_page));
        }
    }

    public function set dir_text_color(value:String) : void
    {
        var oldValue:String = _internal_dir_text_color;
        if (oldValue !== value)
        {
            _internal_dir_text_color = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "dir_text_color", oldValue, _internal_dir_text_color));
        }
    }

    public function set dir_up_color(value:String) : void
    {
        var oldValue:String = _internal_dir_up_color;
        if (oldValue !== value)
        {
            _internal_dir_up_color = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "dir_up_color", oldValue, _internal_dir_up_color));
        }
    }

    public function set dir_down_color(value:String) : void
    {
        var oldValue:String = _internal_dir_down_color;
        if (oldValue !== value)
        {
            _internal_dir_down_color = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "dir_down_color", oldValue, _internal_dir_down_color));
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
    public function get _model() : _T_version_styleEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _T_version_styleEntityMetadata) : void
    {
        var oldValue : _T_version_styleEntityMetadata = model_internal::_dminternal_model;
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
