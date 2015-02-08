package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.getResourcesDelegate;
	import com.innovae.oce.application.delegate.getVersionStyleTemplatesDelegate;
	import com.innovae.oce.application.delegate.loadVersionsDelegate;
	import com.innovae.oce.application.delegate.saveVersionStyleTemplatesDelegate;
	import com.innovae.oce.application.event.getDirectoryStylesEvent;
	import com.innovae.oce.application.event.getVersionStyleTemplatesEvent;
	import com.innovae.oce.application.event.saveVersionStyleTemplatesEvent;
	import com.innovae.oce.domain.datamodel.Base;
	import com.innovae.oce.infraestructure.services.*;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_directory_style;
	import com.innovae.services.orona.evolutio.type.T_resource;
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
	
	public class saveVersionStyleTemplatesCommand implements ICommand, IResponder
	{
		
		public var service:Webservice_oce;
		
		public function execute(event:CairngormEvent):void
		{
			trace("saveVersionStyleTemplatesCommand -> execute.");
			CursorManager.setBusyCursor(); 

			new saveVersionStyleTemplatesDelegate(this).saveVersionStyleTemplates((event as saveVersionStyleTemplatesEvent).user(),(event as saveVersionStyleTemplatesEvent).version_style());
		}
		
		public function result(data:Object):void
		{
			trace("saveVersionStyleTemplatesCommand <- result["+data.result+"]");
			CursorManager.removeBusyCursor(); 

			trace(data.message.body);
			var resultXML:XML = new XML(String(data.message.body).substr(String(data.message.body).indexOf("<getVersionStylesResponse>"), int(String(data.message.body).indexOf("</getVersionStylesResponse>") + String("</getVersionStylesResponse>").length - String(data.message.body).indexOf("<getVersionStylesResponse>"))));
			Base.getinstance().versionStyleTemplates = new ArrayCollection();
			/*
			for each (var version_style_o:XML in resultXML.elements("version_style"))
			{
				trace("*"+version_style_o.@id+" ... "+version_style_o.@name);
				var version_style:T_version_style = new T_version_style();
				version_style.id = version_style_o.@id;
				version_style.name = version_style_o.@name;
				version_style.text_font = version_style_o.@text_font;
				version_style.text_size = version_style_o.@text_size;
				version_style.text_color = version_style_o.@text_color;
				version_style.border_color = version_style_o.@border_color;
				version_style.background_color = version_style_o.@background_color;
				version_style.anim_speed = version_style_o.@anim_speed;
				
				Base.getinstance().versionStyleTemplates.addItem(version_style);
			}
			*/
			Base.getinstance().getVersionStyleTemplates();
		}
		public function fault(info:Object) : void {
			trace("saveVersionStyleTemplatesCommand <- fault [" + info.toString()+"]");
			CursorManager.removeBusyCursor(); 
			trace(info.message.faultDetail);
			trace(info.message.faultString);
			trace(info.token.message.body);
			
		}
	}
}