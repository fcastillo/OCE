package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.getDetailedVersionDelegate;
	import com.innovae.oce.application.delegate.loadVersionsDelegate;
	import com.innovae.oce.application.delegate.removeDetailedVersionDelegate;
	import com.innovae.oce.application.event.getDetailedVersionEvent;
	import com.innovae.oce.application.event.loadVersionsEvent;
	import com.innovae.oce.application.event.removeDetailedVersionEvent;
	import com.innovae.oce.domain.datamodel.Base;
	import com.innovae.oce.infraestructure.services.*;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_detailedversion;
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
	
	public class removeDetailedVersionCommand implements ICommand, IResponder
	{
		
		public var service:Webservice_oce;
		
		public function execute(event:CairngormEvent):void
		{
			trace("removeDetailedVersionCommand -> execute.");
			CursorManager.setBusyCursor(); 

			new removeDetailedVersionDelegate(this).removedetailedversion((event as removeDetailedVersionEvent).user(), (event as removeDetailedVersionEvent).version());
		}
		
		public function result(data:Object):void
		{
			trace("removeDetailedVersionCommand <- result["+data.result+"]");
			CursorManager.removeBusyCursor(); 

			//new loadVersionsEvent(loadVersionsEvent.LOAD_VERSIONS, Base.getinstance().user).dispatch();
			Base.getinstance().getVersions();
		}
		
		public function fault(info:Object) : void {
			trace("removeDetailedVersionCommand <- fault [" + info.toString()+"]");
			CursorManager.removeBusyCursor(); 

		}
	}
}