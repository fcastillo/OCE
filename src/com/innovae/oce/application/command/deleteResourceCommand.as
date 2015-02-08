package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.deleteResourceDelegate;
	import com.innovae.oce.application.delegate.getDetailedVersionDelegate;
	import com.innovae.oce.application.delegate.loadVersionsDelegate;
	import com.innovae.oce.application.event.deleteResourceEvent;
	import com.innovae.oce.application.event.getDetailedVersionEvent;
	import com.innovae.oce.application.event.loadVersionsEvent;
	import com.innovae.oce.application.event.removeDetailedVersionEvent;
	import com.innovae.oce.domain.datamodel.Base;
	import com.innovae.oce.infraestructure.services.*;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_detailedversion;
	import com.innovae.services.orona.evolutio.type.T_resource;
	import com.innovae.services.orona.evolutio.type.T_version;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.managers.CursorManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.rpc.soap.WebService;
	
	public class deleteResourceCommand implements ICommand, IResponder
	{
		
		public var service:Webservice_oce;
		
		public function execute(event:CairngormEvent):void
		{
			trace("deleteResourceCommand -> execute.");
			CursorManager.setBusyCursor();
			new deleteResourceDelegate(this).deleteresource((event as deleteResourceEvent).user(), (event as deleteResourceEvent).resource());
		}
		
		public function result(data:Object):void
		{
			trace("deleteResourceCommand <- result["+data.result+"]");
			CursorManager.removeBusyCursor(); 
			Base.getinstance().resourcesList_selectedResource = new T_resource();
			Base.getinstance().getResources(Base.getinstance().resourcesList_resource_type.id);
		}
		
		public function fault(info:Object) : void {
			trace("deleteResourceCommand <- fault [" + info.toString()+"]");
			CursorManager.removeBusyCursor(); 
		}
	}
}