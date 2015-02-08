/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this service wrapper you may modify the generated sub-class of this class - Webservice_oce.as.
 */
package com.innovae.oce.infraestructure.services
{
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.services.wrapper.WebServiceWrapper;
import com.adobe.serializers.utility.TypeUtility;
import com.innovae.services.orona.evolutio.type.T_area;
import com.innovae.services.orona.evolutio.type.T_area_type;
import com.innovae.services.orona.evolutio.type.T_authorization;
import com.innovae.services.orona.evolutio.type.T_detailedversion;
import com.innovae.services.orona.evolutio.type.T_resource;
import com.innovae.services.orona.evolutio.type.T_resource_type;
import com.innovae.services.orona.evolutio.type.T_resul;
import com.innovae.services.orona.evolutio.type.T_version;
import com.innovae.services.orona.evolutio.type.T_version_style;
import flash.utils.ByteArray;
import mx.collections.ArrayCollection;
import mx.rpc.AbstractOperation;
import mx.rpc.AsyncToken;
import mx.rpc.soap.mxml.Operation;
import mx.rpc.soap.mxml.WebService;
import mx.rpc.xml.SchemaTypeRegistry;

[ExcludeClass]
internal class _Super_Webservice_oce extends com.adobe.fiber.services.wrapper.WebServiceWrapper
{
    
    // Constructor
    public function _Super_Webservice_oce()
    {
        // initialize service control
        _serviceControl = new mx.rpc.soap.mxml.WebService();
        mx.rpc.xml.SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://5.9.137.10/orona/backend/api/", "l_version_style"), ArrayCollection);
        mx.rpc.xml.SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://5.9.137.10/orona/backend/api/", "l_version"), ArrayCollection);
        mx.rpc.xml.SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://5.9.137.10/orona/backend/api/", "l_directory_style"), ArrayCollection);
        mx.rpc.xml.SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://5.9.137.10/orona/backend/api/", "t_detailed_icp"), ArrayCollection);
        mx.rpc.xml.SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://5.9.137.10/orona/backend/api/", "l_resources"), ArrayCollection);
        mx.rpc.xml.SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://5.9.137.10/orona/backend/api/", "l_area"), ArrayCollection);
        var operations:Object = new Object();
        var operation:mx.rpc.soap.mxml.Operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "getDetailedVersion");
         operation.resultType = com.innovae.services.orona.evolutio.type.T_detailedversion;
        operations["getDetailedVersion"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "getVersiones");
         operation.resultElementType = Object;
        operations["getVersiones"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "deleteResource");
         operation.resultType = com.innovae.services.orona.evolutio.type.T_resul;
        operations["deleteResource"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "removeFloorAreaContent");
         operation.resultType = com.innovae.services.orona.evolutio.type.T_resul;
        operations["removeFloorAreaContent"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "keepAliveUserSession");
         operation.resultType = com.innovae.services.orona.evolutio.type.T_resul;
        operations["keepAliveUserSession"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "uploadResource");
         operation.resultType = com.innovae.services.orona.evolutio.type.T_resul;
        operations["uploadResource"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "saveContentArea");
         operation.resultType = com.innovae.services.orona.evolutio.type.T_resul;
        operations["saveContentArea"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "getDirectoryStyles");
         operation.resultElementType = Object;
        operations["getDirectoryStyles"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "removeDetailedVersion");
         operation.resultType = com.innovae.services.orona.evolutio.type.T_resul;
        operations["removeDetailedVersion"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "login");
         operation.resultType = com.innovae.services.orona.evolutio.type.T_resul;
        operations["login"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "closeUserSession");
         operation.resultType = com.innovae.services.orona.evolutio.type.T_resul;
        operations["closeUserSession"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "getIslaDetailedVersionFromArea");
         operation.resultType = com.innovae.services.orona.evolutio.type.T_detailedversion;
        operations["getIslaDetailedVersionFromArea"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "saveVersionStyle");
         operation.resultType = com.innovae.services.orona.evolutio.type.T_resul;
        operations["saveVersionStyle"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "removeVersionStyle");
         operation.resultType = com.innovae.services.orona.evolutio.type.T_resul;
        operations["removeVersionStyle"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "getVersionStyles");
         operation.resultElementType = Object;
        operations["getVersionStyles"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "getVersionXML");
         operation.resultType = com.innovae.services.orona.evolutio.type.T_resul;
        operations["getVersionXML"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "getFloorAreaContents");
         operation.resultElementType = Object;
        operations["getFloorAreaContents"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "saveDetailedVersion");
         operation.resultType = com.innovae.services.orona.evolutio.type.T_resul;
        operations["saveDetailedVersion"] = operation;

        operation = new mx.rpc.soap.mxml.Operation(null, "getResources");
         operation.resultElementType = Object;
        operations["getResources"] = operation;

        _serviceControl.operations = operations;
        try
        {
            _serviceControl.convertResultHandler = com.adobe.serializers.utility.TypeUtility.convertResultHandler;
        }
        catch (e: Error)
        { /* Flex 3.4 and earlier does not support the convertResultHandler functionality. */ }


        preInitializeService();
        model_internal::initialize();
    }
    
    //init initialization routine here, child class to override
    protected function preInitializeService():void
    {


        _serviceControl.service = "oce";
        _serviceControl.port = "oce";
        wsdl = "http://5.9.137.10/orona/backend/api/orona.evolutio.wsdl";
        model_internal::loadWSDLIfNecessary();
    }
    

    /**
      * This method is a generated wrapper used to call the 'getDetailedVersion' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function getDetailedVersion(auth:com.innovae.services.orona.evolutio.type.T_authorization, version:com.innovae.services.orona.evolutio.type.T_version) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getDetailedVersion");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(auth,version) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'getVersiones' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function getVersiones(auth:com.innovae.services.orona.evolutio.type.T_authorization) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getVersiones");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(auth) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'deleteResource' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function deleteResource(auth:com.innovae.services.orona.evolutio.type.T_authorization, resourc:com.innovae.services.orona.evolutio.type.T_resource) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("deleteResource");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(auth,resourc) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'removeFloorAreaContent' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function removeFloorAreaContent(auth:com.innovae.services.orona.evolutio.type.T_authorization, area_content:com.innovae.services.orona.evolutio.type.T_area) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("removeFloorAreaContent");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(auth,area_content) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'keepAliveUserSession' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function keepAliveUserSession(auth:com.innovae.services.orona.evolutio.type.T_authorization) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("keepAliveUserSession");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(auth) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'uploadResource' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function uploadResource(auth:com.innovae.services.orona.evolutio.type.T_authorization, file:ByteArray, filename:String, type:com.innovae.services.orona.evolutio.type.T_resource_type) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("uploadResource");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(auth,file,filename,type) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'saveContentArea' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function saveContentArea(auth:com.innovae.services.orona.evolutio.type.T_authorization, area_content:com.innovae.services.orona.evolutio.type.T_area) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("saveContentArea");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(auth,area_content) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'getDirectoryStyles' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function getDirectoryStyles(auth:com.innovae.services.orona.evolutio.type.T_authorization) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getDirectoryStyles");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(auth) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'removeDetailedVersion' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function removeDetailedVersion(auth:com.innovae.services.orona.evolutio.type.T_authorization, version:com.innovae.services.orona.evolutio.type.T_version) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("removeDetailedVersion");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(auth,version) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'login' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function login(username:String, password:String, tool:String) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("login");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(username,password,tool) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'closeUserSession' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function closeUserSession(auth:com.innovae.services.orona.evolutio.type.T_authorization) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("closeUserSession");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(auth) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'getIslaDetailedVersionFromArea' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function getIslaDetailedVersionFromArea(auth:com.innovae.services.orona.evolutio.type.T_authorization, area:com.innovae.services.orona.evolutio.type.T_area) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getIslaDetailedVersionFromArea");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(auth,area) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'saveVersionStyle' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function saveVersionStyle(authorization:com.innovae.services.orona.evolutio.type.T_authorization, ver_style:com.innovae.services.orona.evolutio.type.T_version_style) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("saveVersionStyle");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(authorization,ver_style) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'removeVersionStyle' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function removeVersionStyle(authorization:com.innovae.services.orona.evolutio.type.T_authorization, ver_style:com.innovae.services.orona.evolutio.type.T_version_style) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("removeVersionStyle");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(authorization,ver_style) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'getVersionStyles' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function getVersionStyles(auth:com.innovae.services.orona.evolutio.type.T_authorization) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getVersionStyles");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(auth) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'getVersionXML' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function getVersionXML(auth:com.innovae.services.orona.evolutio.type.T_authorization, version:com.innovae.services.orona.evolutio.type.T_version) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getVersionXML");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(auth,version) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'getFloorAreaContents' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function getFloorAreaContents(auth:com.innovae.services.orona.evolutio.type.T_authorization, type:com.innovae.services.orona.evolutio.type.T_area_type) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getFloorAreaContents");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(auth,type) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'saveDetailedVersion' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function saveDetailedVersion(auth:com.innovae.services.orona.evolutio.type.T_authorization, version:com.innovae.services.orona.evolutio.type.T_detailedversion, new_version:Boolean) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("saveDetailedVersion");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(auth,version,new_version) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'getResources' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function getResources(auth:com.innovae.services.orona.evolutio.type.T_authorization, resourc_type:com.innovae.services.orona.evolutio.type.T_resource_type) : mx.rpc.AsyncToken
    {
        model_internal::loadWSDLIfNecessary();
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getResources");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(auth,resourc_type) ;
        return _internal_token;
    }
     
}

}
