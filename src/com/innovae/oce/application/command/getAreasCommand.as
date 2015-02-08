package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.getAreasDelegate;
	import com.innovae.oce.application.event.getAreasEvent;
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
	
	public class getAreasCommand implements ICommand, IResponder
	{
		
		public var service:Webservice_oce;
		public var area_type: T_area_type;
		
		public function execute(event:CairngormEvent):void
		{
			trace("getAreasCommand -> execute.");
			CursorManager.setBusyCursor(); 
			this.area_type = (event as getAreasEvent).area_type();
			new getAreasDelegate(this).getAreas((event as getAreasEvent).user(),(event as getAreasEvent).area_type());
		}
		
		public function result(data:Object):void
		{
			trace("getAreasCommand <- result["+data.result+"]");
			CursorManager.removeBusyCursor(); 
			trace(data.message.body);
			var resultXML:XML = new XML(String(data.message.body).substr(String(data.message.body).indexOf("<getFloorAreaContentsResponse>"), int(String(data.message.body).indexOf("</getFloorAreaContentsResponse>") + String("</getFloorAreaContentsResponse>").length - String(data.message.body).indexOf("<getFloorAreaContentsResponse>"))));
			Base.getinstance().directoryStyles = new ArrayCollection();
			
			for each (var area_o:XML in resultXML.elements("area"))
			{
				trace("*"+area_o.@id+" ... "+area_o.@name+" ... "+area_o.@description);
				var area:T_area = new T_area();
				area.id 	= area_o.@id;
				area.name	= area_o.@name;
				area.xml	= area_o.@xml
				area.description = area_o.@description;
				area.type 	= this.area_type;  
				Base.getinstance().areas.addItem(area);
			}
			Base.getinstance().areas.refresh();
			Base.getinstance().getAsigned_AreaContent_Sentido_Floor();
		}
		public function fault(info:Object) : void {
			trace("getAreasCommand <- fault [" + info.toString()+"]");
			CursorManager.removeBusyCursor(); 
		}
	}
}