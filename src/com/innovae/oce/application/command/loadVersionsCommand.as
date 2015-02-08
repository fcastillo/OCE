package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.loadVersionsDelegate;
	import com.innovae.oce.application.event.loadVersionsEvent;
	import com.innovae.oce.domain.datamodel.Base;
	import com.innovae.oce.infraestructure.services.*;
	import com.innovae.services.orona.evolutio.type.T_authorization;
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
	
	public class loadVersionsCommand implements ICommand, IResponder
	{
		
		public var service:Webservice_oce;
		
		public function execute(event:CairngormEvent):void
		{
			trace("loadVersionsCommand -> execute.");
			CursorManager.setBusyCursor(); 

			new loadVersionsDelegate(this).loadversions((event as loadVersionsEvent).user());
		}
		
		public function result(data:Object):void
		{
			trace("loadVersionsCommand <- result["+data.result+"]");
			CursorManager.removeBusyCursor(); 

			Base.getinstance().versiones = new ArrayCollection();
			Base.getinstance().versionesVDAP = new ArrayCollection();
			Base.getinstance().versionesISLA = new ArrayCollection();
			Base.getinstance().areas = new ArrayCollection();
			
			for each (var version_o:Object in data.result)
			{
				var version:T_version = new T_version();
				version.id = version_o.id;
				version.name = version_o.name;
				version.created = version_o.created;
				version.last_modification = version_o.last_modification;
				version.type = version_o.type;
				version.description = version_o.description;
				Base.getinstance().versiones.addItem(version);
				if (version.type == "5" ) { Base.getinstance().areas.addItem(version); }
				if (version.type == "3" ) { Base.getinstance().versionesVDAP.addItem(version);}
				if (version.type == "4" ) { Base.getinstance().versionesISLA.addItem(version);}
			}
			Base.getinstance().versionMenu_getSelectedVersion();
			//Base.getinstance().versiones.refresh();
			
		}
		public function fault(info:Object) : void {
			trace("loadVersionsCommand <- fault [" + info.toString()+"]");
			CursorManager.removeBusyCursor(); 

		}
	}
}