package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.getAreasDelegate;
	import com.innovae.oce.application.delegate.removeFloorAreaContentFromServerDelegate;
	import com.innovae.oce.application.event.getAreasEvent;
	import com.innovae.oce.application.event.removeFloorAreaContentFromServerEvent;
	import com.innovae.oce.domain.datamodel.Base;
	import com.innovae.oce.infraestructure.services.*;
	import com.innovae.services.orona.evolutio.type.T_area;
	import com.innovae.services.orona.evolutio.type.T_area_type;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_directory_style;
	import com.innovae.services.orona.evolutio.type.T_resource;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.managers.CursorManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.rpc.soap.WebService;
	
	public class removeFloorAreaContentFromServerCommand implements ICommand, IResponder
	{
		
		public var service:Webservice_oce;
		public var area: T_area;
		
		public function execute(event:CairngormEvent):void
		{
			trace("removeFloorAreaContentFromServerCommand -> execute.");
			CursorManager.setBusyCursor(); 
			this.area = (event as removeFloorAreaContentFromServerEvent).area();
			new removeFloorAreaContentFromServerDelegate(this).removeArea((event as removeFloorAreaContentFromServerEvent).user(),(event as removeFloorAreaContentFromServerEvent).area());
		}
		
		public function result(data:Object):void
		{
			trace("removeFloorAreaContentFromServerCommand <- result["+data.result+"]");
			CursorManager.removeBusyCursor(); 
			if ( (data.result.result <0) && (data.result.error_code == "002XE") )
			{
				Alert.show(data.result.error_message);
			}
			Base.getinstance().getAreas(Base.getinstance().versionedition_selectedAreaContentType); 
		}
		public function fault(info:Object) : void {
			trace("removeFloorAreaContentFromServerCommand <- fault [" + info.toString()+"]");
			CursorManager.removeBusyCursor(); 
			
			Base.getinstance().getAreas(Base.getinstance().versionedition_selectedAreaContentType); 
		}
	}
}