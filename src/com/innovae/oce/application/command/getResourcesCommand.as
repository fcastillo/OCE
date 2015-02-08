package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.getResourcesDelegate;
	import com.innovae.oce.application.delegate.loadVersionsDelegate;
	import com.innovae.oce.application.event.getResourcesEvent;
	import com.innovae.oce.application.event.loadVersionsEvent;
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
	
	public class getResourcesCommand implements ICommand, IResponder
	{
		
		public var service:Webservice_oce;
		public var resource_type:T_resource_type;
		
		public function execute(event:CairngormEvent):void
		{
			trace("getResourcesCommand -> execute.");
			CursorManager.setBusyCursor(); 

			resource_type = (event as getResourcesEvent).resource_type();
			new getResourcesDelegate(this).getResources((event as getResourcesEvent).user(),(event as getResourcesEvent).resource_type());
		}
		
		public function result(data:Object):void
		{
			trace("getResourcesCommand <- result["+data.result+"]");
			CursorManager.removeBusyCursor(); 

			Base.getinstance().resources = new ArrayCollection();
			var i:int = 0;
			var found:Boolean = false;
			for each (var resource_o:Object in data.result)
			{
				var resource:T_resource = new T_resource();
				resource.id = resource_o.id;
				resource.name = resource_o.name;
				resource.url = resource_o.url;
				resource.type = resource_o.type;
				resource.used = resource_o.used;
				resource.encoded = resource_o.encoded;
				trace("resource -> id["+resource.id+"] name["+resource.name+"] url["+resource.url+"] type["+resource.type+"] used["+resource.used+"]<real: "+resource_o.used+"> encoded["+resource.encoded+"]<real: "+resource_o.encoded+">");
				Base.getinstance().resources.addItem(resource);
				trace("...searching for ["+Base.getinstance().resourcesList_selectedResource.url+"] at ["+resource.url+"]");
				i++;
				if (resource.url == Base.getinstance().resourcesList_selectedResource.url) 
				{
					trace("FOUND!!!!!!!!!!!!");
					found=true;
					Base.getinstance().resourcesList_selectedResource = resource;
					Base.getinstance().resourcesList_selectedResource_item = 0 + i;
					Base.getinstance().resourcesList_selectedResource_previous_resource = resource.id;
				}
			}
			if (!found) 
			{ 
				Base.getinstance().resourcesList_selectedResource_previous_resource = -1
				Base.getinstance().resourcesList_selectedResource = new T_resource();
				Base.getinstance().resourcesList_selectedResource.id = -1;
				Base.getinstance().resourcesList_selectedResource.url = "assets/1px.png";
				Base.getinstance().resource_asignable = false;
			}
				
			Base.getinstance().resources.refresh();
			if (Base.getinstance().content_editor1) Base.getinstance().versionEdition_selectedArea_resource_selection_windows_visible = true;
			else if (Base.getinstance().content_editor3) Base.getinstance().versionEdition_selectedArea_resource_selection_windows_visible = true;
			else if (Base.getinstance().content_editor4) Base.getinstance().versionEdition_selectedArea_resource_selection_windows_visible = true;
			//trace("resource -> id["+Base.getinstance().resourcesList_selectedResource.id+"] name["+Base.getinstance().resourcesList_selectedResource.name+"] url["+Base.getinstance().resourcesList_selectedResource.url+"] type["+Base.getinstance().resourcesList_selectedResource.type+"] used["+Base.getinstance().resourcesList_selectedResource.used+"]<real: "+resource_o.used+"> encoded["+Base.getinstance().resourcesList_selectedResource.encoded+"]<real: "+resource_o.encoded+">");
			
			
			
			/*
			if (Base.getinstance().resourcesList_selectedResource.type == Base.getinstance().picture_resource_id)
			{
				Base.getinstance().pictureResources = Base.getinstance().getResources(Base.getinstance().picture_resource_id);
			}
			else if (Base.getinstance().resourcesList_selectedResource.type == Base.getinstance().video_resource_id)
			{
				Base.getinstance().videoResources = Base.getinstance().getResources(Base.getinstance().video_resource_id);
			}
			*/
			//
			//
		}
		public function fault(info:Object) : void {
			trace("getResourcesCommand <- fault [" + info.toString()+"]");
			CursorManager.removeBusyCursor(); 

		}
	}
}