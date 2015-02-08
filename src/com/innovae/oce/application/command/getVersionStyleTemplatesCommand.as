package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.getResourcesDelegate;
	import com.innovae.oce.application.delegate.getVersionStyleTemplatesDelegate;
	import com.innovae.oce.application.delegate.loadVersionsDelegate;
	import com.innovae.oce.application.event.getDirectoryStylesEvent;
	import com.innovae.oce.application.event.getVersionStyleTemplatesEvent;
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
	
	public class getVersionStyleTemplatesCommand implements ICommand, IResponder
	{
		
		public var service:Webservice_oce;
		
		public function execute(event:CairngormEvent):void
		{
			trace("getVersionStyleTemplatesCommand -> execute.");
			CursorManager.setBusyCursor(); 

			new getVersionStyleTemplatesDelegate(this).getVersionStyleTemplates((event as getVersionStyleTemplatesEvent).user());
		}
		
		public function result(data:Object):void
		{
			trace("getVersionStyleTemplatesCommand <- result["+data.result+"]");
			CursorManager.removeBusyCursor(); 

			trace(data.message.body);
			var resultXML:XML = new XML(String(data.message.body).substr(String(data.message.body).indexOf("<getVersionStylesResponse>"), int(String(data.message.body).indexOf("</getVersionStylesResponse>") + String("</getVersionStylesResponse>").length - String(data.message.body).indexOf("<getVersionStylesResponse>"))));
			Base.getinstance().versionStyleTemplates = new ArrayCollection();
			var i:int = 0;
			for each (var version_style_o:XML in resultXML.elements("version_style"))
			{
				//trace("*"+version_style_o.@id+" ... "+version_style_o.@name);
				var version_style:T_version_style = new T_version_style();
				version_style.id = version_style_o.@id;
				version_style.name = version_style_o.@name;
				version_style.text_font = version_style_o.@text_font;
				version_style.text_size = version_style_o.@text_size;
				version_style.text_color = version_style_o.@text_color;
				version_style.border_color = version_style_o.@border_color;
				version_style.background_color = version_style_o.@background_color;
				version_style.anim_speed = version_style_o.@anim_speed;
				version_style.floor_per_page = version_style_o.@floor_per_page;
				version_style.dir_up_color = version_style_o.@dir_up_color;
				version_style.dir_down_color = version_style_o.@dir_down_color;
				version_style.dir_text_color = version_style_o.@dir_text_color;
				//trace("*"+version_style.id+" ... "+version_style.name+" ["+version_style.text_font + "] "+" ["+version_style.text_size + "] "+" ["+version_style.text_color + "] "+" ["+version_style.border_color + "] "+" ["+version_style.background_color+ "] "+" ["+version_style.anim_speed + "] "+" ["+version_style.floor_per_page+ "]"+" ["+version_style.dir_up_color+ "] "+" ["+version_style.dir_down_color + "] "+" ["+version_style.dir_text_color+ "]");
				Base.getinstance().versionStyleTemplates.addItem(version_style);
				if (version_style.id == Base.getinstance().detailedVersion.version_style.id)
				{
					Base.getinstance().detailedVersion.version_style = version_style;
					//Base.getinstance().versionEdition_selectedVersionStyle = version_style;

					Base.getinstance().versionEdition_selectedVersionStyle = new T_version_style();
					Base.getinstance().versionEdition_selectedVersionStyle.id					 = version_style.id;
					Base.getinstance().versionEdition_selectedVersionStyle.name					 = version_style.name;
					Base.getinstance().versionEdition_selectedVersionStyle.text_font			 = version_style.text_font;
					Base.getinstance().versionEdition_selectedVersionStyle.text_size			 = version_style.text_size;
					Base.getinstance().versionEdition_selectedVersionStyle.text_color			 = version_style.text_color;
					Base.getinstance().versionEdition_selectedVersionStyle.border_color			 = version_style.border_color;
					Base.getinstance().versionEdition_selectedVersionStyle.background_color		 = version_style.background_color;
					Base.getinstance().versionEdition_selectedVersionStyle.anim_speed			 = version_style.anim_speed;
					Base.getinstance().versionEdition_selectedVersionStyle.floor_per_page 		 = version_style.floor_per_page;
					Base.getinstance().versionEdition_selectedVersionStyle.dir_down_color 		 = version_style.dir_down_color;
					Base.getinstance().versionEdition_selectedVersionStyle.dir_up_color 		 = version_style.dir_up_color;
					Base.getinstance().versionEdition_selectedVersionStyle.dir_text_color 		 = version_style.dir_text_color;
					Base.getinstance().versionEdition_selectedVersionStyleChanged				 = false;
					trace("*"+version_style.id+" ... "+version_style.name+" ["+version_style.text_font + "] "+" ["+version_style.text_size + "] "+" ["+version_style.text_color + "] "+" ["+version_style.border_color + "] "+" ["+version_style.background_color+ "] "+" ["+version_style.anim_speed + "] "+" ["+version_style.floor_per_page+ "]"+" ["+version_style.dir_up_color+ "] "+" ["+version_style.dir_down_color + "] "+" ["+version_style.dir_text_color+ "]");
				}
				i++;
			}

			try { Base.getinstance().versionEdition_selectedVersionStyle.name = Base.getinstance().detailedVersion.version_style.name;} catch (e:Error) { trace("ERROR: "+e.message); }
			
			Base.getinstance().versionStyleTemplates.refresh();
			/*
			Base.getinstance().versionEdition_hiderCanvas_visibile = true;
			Base.getinstance().versionEdition_areaContentSelection_visibile = false;
			Base.getinstance().versionEdition_floorDirectoryStyleSelection_visibile = false;
			Base.getinstance().versionEdition_versionSaveAs_visibile = false;
			Base.getinstance().versionEdition_configureVersionStyleTemplate_visible = true;
			*/
			
		}
		public function fault(info:Object) : void {
			trace("getDirectoryStylesCommand <- fault [" + info.toString()+"]");
			CursorManager.removeBusyCursor(); 

		}
	}
}