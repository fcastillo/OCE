package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.getDetailedVersionDelegate;
	import com.innovae.oce.application.delegate.getVersionXMLDelegate;
	import com.innovae.oce.application.delegate.loadVersionsDelegate;
	import com.innovae.oce.application.event.getDetailedVersionEvent;
	import com.innovae.oce.application.event.getVersionXMLEvent;
	import com.innovae.oce.application.event.loadVersionsEvent;
	import com.innovae.oce.domain.datamodel.Base;
	import com.innovae.oce.infraestructure.services.*;
	import com.innovae.services.orona.evolutio.type.T_area;
	import com.innovae.services.orona.evolutio.type.T_area_type;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_detailedversion;
	import com.innovae.services.orona.evolutio.type.T_directory_style;
	import com.innovae.services.orona.evolutio.type.T_floor;
	import com.innovae.services.orona.evolutio.type.T_resource;
	import com.innovae.services.orona.evolutio.type.T_resource_type;
	import com.innovae.services.orona.evolutio.type.T_resul;
	import com.innovae.services.orona.evolutio.type.T_version;
	import com.innovae.services.orona.evolutio.type.T_version_style;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.managers.CursorManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.rpc.soap.WebService;
	
	public class getVersionXMLCommand implements ICommand, IResponder
	{
		public var service:Webservice_oce;
		
		public function execute(event:CairngormEvent):void
		{
			trace("getVersionXMLCommand -> execute.");
			CursorManager.setBusyCursor(); 

			new getVersionXMLDelegate(this).getversionxml((event as getVersionXMLEvent).user(), (event as getVersionXMLEvent).version());
		}
		
		public function result(data:Object):void
		{
			trace("getVersionXMLCommand <- result["+data.result+"]");
			CursorManager.removeBusyCursor(); 

			trace(data.message.body);
			trace("VersionXMLCommand <- result["+data.result+"]");
			var result:T_resul = data.result as T_resul;
			trace("error_message: "+result.error_message);
			Base.getinstance().previewVersionXML = result.error_message;
			if (result.error_code == "3")
			{
				Base.getinstance().showVersionPreview();
			}
			else if (result.error_code == "4")
			{
				Base.getinstance().showIslaVersionPreview();
			}
		}

		public function fault(info:Object) : void {
			trace("getVersionXMLCommand <- fault [" + info.toString()+"]");
			CursorManager.removeBusyCursor(); 

		}
	}
}