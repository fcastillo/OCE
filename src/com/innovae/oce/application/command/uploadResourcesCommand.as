package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.getResourcesDelegate;
	import com.innovae.oce.application.delegate.loadVersionsDelegate;
	import com.innovae.oce.application.delegate.uploadResourcesDelegate;
	import com.innovae.oce.application.event.getResourcesEvent;
	import com.innovae.oce.application.event.loadVersionsEvent;
	import com.innovae.oce.application.event.uploadResourcesEvent;
	import com.innovae.oce.domain.datamodel.Base;
	import com.innovae.oce.infraestructure.services.*;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_resource;
	import com.innovae.services.orona.evolutio.type.T_resource_type;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.managers.CursorManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.rpc.soap.WebService;
	
	public class uploadResourcesCommand implements ICommand, IResponder
	{
		
		public var service:Webservice_oce;
		
		public function execute(event:CairngormEvent):void
		{
			trace("uploadResourcesCommand -> execute.");
			CursorManager.setBusyCursor(); 
			Base.getinstance().bloquearInteraccionEnviandoRecurso();
			new uploadResourcesDelegate(this).uploadResources((event as uploadResourcesEvent).user(),(event as uploadResourcesEvent).file(), (event as uploadResourcesEvent).filename(), (event as uploadResourcesEvent).resource_type());
		}
		
		public function result(data:Object):void
		{
			trace("uploadResourcesCommand <- result["+data.result+"]");
			CursorManager.removeBusyCursor(); 
			try
			{
				if (data.result.error_code == "-1")
				{
					Alert.show(data.result.error_message);
				}
			}
			catch (error:Error) {}
			Base.getinstance().desbloquearInteraccion();
			Base.getinstance().getResources(Base.getinstance().resourcesList_resource_type.id);
		}
		
		public function fault(info:Object) : void 
		{
			trace("uploadResourcesCommand <- fault [" + info.toString()+"]");
			CursorManager.removeBusyCursor(); 
			//Alert.show(info.toString());
			//Base.getinstance().desbloquearInteraccion();
			Base.getinstance().getResources(Base.getinstance().resourcesList_resource_type.id);
		}
	}
}