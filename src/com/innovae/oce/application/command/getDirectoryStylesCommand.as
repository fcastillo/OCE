package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.getDirectoryStylesDelegate;
	import com.innovae.oce.application.delegate.getResourcesDelegate;
	import com.innovae.oce.application.delegate.loadVersionsDelegate;
	import com.innovae.oce.application.event.getDirectoryStylesEvent;
	import com.innovae.oce.domain.datamodel.Base;
	import com.innovae.oce.infraestructure.services.*;
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
	
	public class getDirectoryStylesCommand implements ICommand, IResponder
	{
		
		public var service:Webservice_oce;
		
		public function execute(event:CairngormEvent):void
		{
			trace("getDirectoryStylesCommand -> execute.");
			CursorManager.setBusyCursor(); 
			new getDirectoryStylesDelegate(this).getDirectoryStyles((event as getDirectoryStylesEvent).user());
		}
		
		public function result(data:Object):void
		{
			trace("getDirectoryStylesCommand <- result["+data.result+"]");
			CursorManager.removeBusyCursor(); 
			trace(data.message.body);
			var resultXML:XML = new XML(String(data.message.body).substr(String(data.message.body).indexOf("<getDirectoryStylesResponse>"), int(String(data.message.body).indexOf("</getDirectoryStylesResponse>") + String("</getDirectoryStylesResponse>").length - String(data.message.body).indexOf("<getDirectoryStylesResponse>"))));
			Base.getinstance().directoryStyles = new ArrayCollection();
			
			for each (var directory_style_o:XML in resultXML.elements("directory_style"))
			{
				trace("*"+directory_style_o.@id+" ... "+directory_style_o.@name);
				var directory_style:T_directory_style = new T_directory_style();
				directory_style.id = directory_style_o.@id;
				directory_style.name = directory_style_o.@name;
				directory_style.description = directory_style_o.@description;
				/*directory_style.resources = new ArrayCollection();
				for each (var resource_o:XML in directory_style_o.elements("resource"))
				{
					var resource:T_resource = new T_resource();
					resource.id = resource_o.@id;
					resource.name = resource_o.@name;
					resource.url = resource_o.@url;
					resource.type = resource_o.@type;
					directory_style.resources.addItem(resource);
				}
				*/
				Base.getinstance().directoryStyles.addItem(directory_style);
			}

			/*
			for each (var directory_style_o:Object in data.result)
			{
				var directory_style:T_directory_style = new T_directory_style();
				directory_style.id = directory_style_o.id;
				directory_style.name = directory_style_o.name;
				directory_style.description = directory_style_o.description;
				directory_style.resources = new ArrayCollection();
				for each (var resource_o:Object in directory_style_o.resources)
				{
					var resource:T_resource = new T_resource();
					resource.id = resource_o.id;
					resource.name = resource_o.name;
					resource.url = resource_o.url;
					resource.type = resource_o.type;
					directory_style.resources.addItem(resource);
				}
				Base.getinstance().directoryStyles.addItem(resource);
			}
			*/
			Base.getinstance().directoryStyles.refresh();
		}
		public function fault(info:Object) : void {
			trace("getDirectoryStylesCommand <- fault [" + info.toString()+"]");
			CursorManager.removeBusyCursor(); 
		}
	}
}