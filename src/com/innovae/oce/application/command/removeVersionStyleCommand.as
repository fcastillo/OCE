package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.getDetailedVersionDelegate;
	import com.innovae.oce.application.delegate.loadVersionsDelegate;
	import com.innovae.oce.application.delegate.removeDetailedVersionDelegate;
	import com.innovae.oce.application.delegate.removeVersionStyleDelegate;
	import com.innovae.oce.application.event.getDetailedVersionEvent;
	import com.innovae.oce.application.event.loadVersionsEvent;
	import com.innovae.oce.application.event.removeDetailedVersionEvent;
	import com.innovae.oce.application.event.removeVersionStyleEvent;
	import com.innovae.oce.domain.T_authorization;
	import com.innovae.oce.domain.T_detailedversion;
	import com.innovae.oce.domain.T_version;
	import com.innovae.oce.domain.User;
	import com.innovae.oce.domain.datamodel.Base;
	import com.innovae.oce.infraestructure.services.*;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.managers.CursorManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.rpc.soap.WebService;
	
	public class removeVersionStyleCommand implements ICommand, IResponder
	{
		
		public var service:Webservice_oce;
		
		public function execute(event:CairngormEvent):void
		{
			trace("removeVersionStyleCommand -> execute.");
			CursorManager.setBusyCursor(); 

			new removeVersionStyleDelegate(this).removeversionstyle((event as removeVersionStyleEvent).user(), (event as removeVersionStyleEvent).version_style());
		}
		
		public function result(data:Object):void
		{
			trace("removeVersionStyleCommand <- result["+data.result+"]");
			CursorManager.removeBusyCursor(); 

			Base.getinstance().getVersionStyleTemplates();
		}
		
		public function fault(info:Object) : void {
			trace("removeVersionStyleCommand <- fault [" + info.toString()+"]");
			CursorManager.removeBusyCursor(); 

		}
	}
}