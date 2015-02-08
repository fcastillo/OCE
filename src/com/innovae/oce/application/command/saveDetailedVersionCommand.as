package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.getDetailedVersionDelegate;
	import com.innovae.oce.application.delegate.loadVersionsDelegate;
	import com.innovae.oce.application.delegate.saveDetailedVersionDelegate;
	import com.innovae.oce.application.event.getDetailedVersionEvent;
	import com.innovae.oce.application.event.loadVersionsEvent;
	import com.innovae.oce.application.event.saveDetailedVersionEvent;
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
	
	public class saveDetailedVersionCommand implements ICommand, IResponder
	{
		public var service:Webservice_oce;
		
		public function execute(event:CairngormEvent):void
		{
			trace("saveDetailedVersionCommand -> execute.");
			CursorManager.setBusyCursor(); 

			new saveDetailedVersionDelegate(this).saveDetailedVersion((event as saveDetailedVersionEvent).user(), (event as saveDetailedVersionEvent).version(), (event as saveDetailedVersionEvent).newVersion());
		}
		
		public function result(data:Object):void
		{
			trace("saveDetailedVersionCommand <- result["+data.result+"]");
			CursorManager.removeBusyCursor(); 

			trace(data.message.body);
			
			var resultXML:XML = new XML(String(data.message.body).substr(String(data.message.body).indexOf("<result>"), int(String(data.message.body).indexOf("</result>") + String("</result>").length - String(data.message.body).indexOf("<result>"))));
			
			trace("["+resultXML.version.@id +"]["+ resultXML.version.@name+"]["+resultXML.version.@created+"]["+resultXML.version.@last_modification+"]["+resultXML.version.@type+"]");
			trace("["+resultXML.version_style.@id +"]["+ resultXML.version_style.@text_font+"]["+resultXML.version_style.@text_size+"]["+resultXML.version_style.@text_color+"]["+resultXML.version_style.@border_color+"]["+resultXML.version_style.@background_color+"]["+resultXML.version_style.@anim_speed+"]");		
			
			Base.getinstance().showVersionMenu();
		}

		public function fault(info:Object) : void {
			trace("saveDetailedVersionCommand <- fault [" + info.toString()+"]");
			CursorManager.removeBusyCursor(); 
			Base.getinstance().showVersionMenu();

		}
	}
}