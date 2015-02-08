/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - T_detailedversion.as.
 */

package com.innovae.services.orona.evolutio.type
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import com.innovae.services.orona.evolutio.type.T_area;
import com.innovae.services.orona.evolutio.type.T_directory_style;
import com.innovae.services.orona.evolutio.type.T_floor;
import com.innovae.services.orona.evolutio.type.T_version;
import com.innovae.services.orona.evolutio.type.T_version_style;
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
public class _Super_T_detailedversion extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
        com.innovae.services.orona.evolutio.type.T_version.initRemoteClassAliasSingleChild();
        com.innovae.services.orona.evolutio.type.T_version_style.initRemoteClassAliasSingleChild();
        com.innovae.services.orona.evolutio.type.T_directory_style.initRemoteClassAliasSingleChild();
        com.innovae.services.orona.evolutio.type.T_floor.initRemoteClassAliasSingleChild();
        com.innovae.services.orona.evolutio.type.T_area.initRemoteClassAliasSingleChild();
        com.innovae.services.orona.evolutio.type.T_area_type.initRemoteClassAliasSingleChild();
    }

    model_internal var _dminternal_model : _T_detailedversionEntityMetadata;
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
    private var _internal_version : com.innovae.services.orona.evolutio.type.T_version;
    private var _internal_version_style : com.innovae.services.orona.evolutio.type.T_version_style;
    private var _internal_directory_style : com.innovae.services.orona.evolutio.type.T_directory_style;
    private var _internal_show_floor_info : Boolean;
    private var _internal_floordirectory : ArrayCollection;
    model_internal var _internal_floordirectory_leaf:com.innovae.services.orona.evolutio.type.T_floor;
    private var _internal_up_areas : ArrayCollection;
    model_internal var _internal_up_areas_leaf:com.innovae.services.orona.evolutio.type.T_area;
    private var _internal_down_areas : ArrayCollection;
    model_internal var _internal_down_areas_leaf:com.innovae.services.orona.evolutio.type.T_area;
    private var _internal_isla_areas : ArrayCollection;
    model_internal var _internal_isla_areas_leaf:com.innovae.services.orona.evolutio.type.T_area;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_T_detailedversion()
    {
        _model = new _T_detailedversionEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get version() : com.innovae.services.orona.evolutio.type.T_version
    {
        return _internal_version;
    }

    [Bindable(event="propertyChange")]
    public function get version_style() : com.innovae.services.orona.evolutio.type.T_version_style
    {
        return _internal_version_style;
    }

    [Bindable(event="propertyChange")]
    public function get directory_style() : com.innovae.services.orona.evolutio.type.T_directory_style
    {
        return _internal_directory_style;
    }

    [Bindable(event="propertyChange")]
    public function get show_floor_info() : Boolean
    {
        return _internal_show_floor_info;
    }

    [Bindable(event="propertyChange")]
    public function get floordirectory() : ArrayCollection
    {
        return _internal_floordirectory;
    }

    [Bindable(event="propertyChange")]
    public function get up_areas() : ArrayCollection
    {
        return _internal_up_areas;
    }

    [Bindable(event="propertyChange")]
    public function get down_areas() : ArrayCollection
    {
        return _internal_down_areas;
    }

    [Bindable(event="propertyChange")]
    public function get isla_areas() : ArrayCollection
    {
        return _internal_isla_areas;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set version(value:com.innovae.services.orona.evolutio.type.T_version) : void
    {
        var oldValue:com.innovae.services.orona.evolutio.type.T_version = _internal_version;
        if (oldValue !== value)
        {
            _internal_version = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "version", oldValue, _internal_version));
        }
    }

    public function set version_style(value:com.innovae.services.orona.evolutio.type.T_version_style) : void
    {
        var oldValue:com.innovae.services.orona.evolutio.type.T_version_style = _internal_version_style;
        if (oldValue !== value)
        {
            _internal_version_style = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "version_style", oldValue, _internal_version_style));
        }
    }

    public function set directory_style(value:com.innovae.services.orona.evolutio.type.T_directory_style) : void
    {
        var oldValue:com.innovae.services.orona.evolutio.type.T_directory_style = _internal_directory_style;
        if (oldValue !== value)
        {
            _internal_directory_style = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "directory_style", oldValue, _internal_directory_style));
        }
    }

    public function set show_floor_info(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_show_floor_info;
        if (oldValue !== value)
        {
            _internal_show_floor_info = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "show_floor_info", oldValue, _internal_show_floor_info));
        }
    }

    public function set floordirectory(value:*) : void
    {
        var oldValue:ArrayCollection = _internal_floordirectory;
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_floordirectory = value;
            }
            else if (value is Array)
            {
                _internal_floordirectory = new ArrayCollection(value);
            }
            else if (value == null)
            {
                _internal_floordirectory = null;
            }
            else
            {
                throw new Error("value of floordirectory must be a collection");
            }
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "floordirectory", oldValue, _internal_floordirectory));
        }
    }

    public function set up_areas(value:*) : void
    {
        var oldValue:ArrayCollection = _internal_up_areas;
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_up_areas = value;
            }
            else if (value is Array)
            {
                _internal_up_areas = new ArrayCollection(value);
            }
            else if (value == null)
            {
                _internal_up_areas = null;
            }
            else
            {
                throw new Error("value of up_areas must be a collection");
            }
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "up_areas", oldValue, _internal_up_areas));
        }
    }

    public function set down_areas(value:*) : void
    {
        var oldValue:ArrayCollection = _internal_down_areas;
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_down_areas = value;
            }
            else if (value is Array)
            {
                _internal_down_areas = new ArrayCollection(value);
            }
            else if (value == null)
            {
                _internal_down_areas = null;
            }
            else
            {
                throw new Error("value of down_areas must be a collection");
            }
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "down_areas", oldValue, _internal_down_areas));
        }
    }

    public function set isla_areas(value:*) : void
    {
        var oldValue:ArrayCollection = _internal_isla_areas;
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_isla_areas = value;
            }
            else if (value is Array)
            {
                _internal_isla_areas = new ArrayCollection(value);
            }
            else if (value == null)
            {
                _internal_isla_areas = null;
            }
            else
            {
                throw new Error("value of isla_areas must be a collection");
            }
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "isla_areas", oldValue, _internal_isla_areas));
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
    public function get _model() : _T_detailedversionEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _T_detailedversionEntityMetadata) : void
    {
        var oldValue : _T_detailedversionEntityMetadata = model_internal::_dminternal_model;
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
