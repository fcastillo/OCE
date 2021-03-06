package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.getDetailedVersionDelegate;
	import com.innovae.oce.application.delegate.loadVersionsDelegate;
	import com.innovae.oce.application.event.getDetailedVersionEvent;
	import com.innovae.oce.application.event.loadVersionsEvent;
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
	
	public class getDetailedVersionCommand implements ICommand, IResponder
	{
		public var service:Webservice_oce;
		
		public function execute(event:CairngormEvent):void
		{
			trace("getDetailedVersionCommand -> execute.");
			CursorManager.setBusyCursor(); 
			new getDetailedVersionDelegate(this).getdetailedversion((event as getDetailedVersionEvent).user(), (event as getDetailedVersionEvent).version());
		}
		
		public function result(data:Object):void
		{
			trace("getDetailedVersionCommand <- result["+data.result+"]");
			CursorManager.removeBusyCursor();  
			trace(data.message.body);
			/*
			var resultLong:String = new String(data.message.body);
			trace(resultLong.indexOf("<result>"));
			trace(resultLong.indexOf("</result>"))
			trace(String("</result>").length);
			trace(int(resultLong.indexOf("</result>")+String("</result>").length));
			trace(int(resultLong.indexOf("</result>")+String("</result>").length)-resultLong.indexOf("<result>"));
			*/
			//var resultShort:String = String(data.message.body).substr(resultLong.indexOf("<result>"), int(resultLong.indexOf("</result>") + String("</result>").length - resultLong.indexOf("<result>")));
			var resultXML:XML = new XML(String(data.message.body).substr(String(data.message.body).indexOf("<result>"), int(String(data.message.body).indexOf("</result>") + String("</result>").length - String(data.message.body).indexOf("<result>"))));
			
			trace("["+resultXML.version.@id +"]["+ resultXML.version.@name+"]["+resultXML.version.@created+"]["+resultXML.version.@last_modification+"]["+resultXML.version.@type+"]");
			trace("["+resultXML.version_style.@id +"]["+ resultXML.version_style.@text_font+"]["+resultXML.version_style.@text_size+"]["+resultXML.version_style.@text_color+"]["+resultXML.version_style.@border_color+"]["+resultXML.version_style.@background_color+"]["+resultXML.version_style.@anim_speed+"]");		
			
			
			//Base.getinstance().detailedVersion = new T_detailedversion();
			var detailedversion_temp:T_detailedversion = new T_detailedversion();
			detailedversion_temp = new T_detailedversion();
			detailedversion_temp.version = new T_version();
			detailedversion_temp.version_style = new T_version_style();
			detailedversion_temp.show_floor_info = true;
			detailedversion_temp.floordirectory = new ArrayCollection();
			detailedversion_temp.up_areas = new ArrayCollection();
			detailedversion_temp.down_areas = new ArrayCollection();
			
			var version_temp:T_version 				= new T_version();
			version_temp.id 						= resultXML.version.@id;
			version_temp.name 						= resultXML.version.@name;
			version_temp.created 					= new Date(resultXML.version.@created);
			version_temp.last_modification 			= new Date(resultXML.version.@last_modification);
			version_temp.type 						= resultXML.version.@type;
			version_temp.description				= resultXML.version.@description;
			detailedversion_temp.version 			= version_temp;
			
			var verstion_style_temp:T_version_style 	= new T_version_style();
			verstion_style_temp.id 					= resultXML.version_style.@id;
			verstion_style_temp.text_font 			= resultXML.version_style.@text_font;
			verstion_style_temp.text_size 			= resultXML.version_style.@text_size;
			verstion_style_temp.text_color 			= resultXML.version_style.@text_color;
			verstion_style_temp.border_color 		= resultXML.version_style.@border_color;
			verstion_style_temp.background_color 	= resultXML.version_style.@background_color;
			verstion_style_temp.anim_speed 			= resultXML.version_style.@anim_speed;
			detailedversion_temp.version_style 		= verstion_style_temp;
			
			var directory_style_temp: T_directory_style = new T_directory_style();
			/*
			directory_style_temp.id					= (resultXML.directory_style.@id) as int;
			directory_style_temp.name				= (resultXML.directory_style.@name) as String;
			directory_style_temp.description		= (resultXML.directory_style.@description) as String;
			*/
			directory_style_temp.id					= resultXML.directory_style.@id;
			directory_style_temp.name				= resultXML.directory_style.@name;
			directory_style_temp.description		= resultXML.directory_style.@description;
			
			/*directory_style_temp.resources			= new ArrayCollection();
			
			for each (var resource:Object in resultXML.directory_style.children())
			{
				var resource_temp:T_resource		= new T_resource();
				resource_temp.id					= resource.@id;
				resource_temp.name					= resource.@name;
				resource_temp.url					= resource.@url;
				resource_temp.type					= resource.@type;
				if (resource_temp.id > 0) { directory_style_temp.resources.addItem(resource_temp); }
			}
			*/
			detailedversion_temp.directory_style 	= directory_style_temp;
			
			if (resultXML.show_floor_info == "false") {
				detailedversion_temp.show_floor_info	= false;
			}
			else
			{
				detailedversion_temp.show_floor_info	= true;
			}
			trace("show full floor info: "+detailedversion_temp.show_floor_info	+" ("+resultXML.show_floor_info+")");
			
			detailedversion_temp.floordirectory		= new ArrayCollection();
			
			for each (var floor:Object in resultXML.elements("floordirectory"))
			{
				var floor_temp:T_floor 				= new T_floor();
				floor_temp.id						= floor.@id;
				floor_temp.name						= floor.@name;
				floor_temp.position					= floor.@position;
				floor_temp.show_position			= floor.@show_position;
				floor_temp.description				= floor.@description;
				floor_temp.aditional_info			= floor.@aditional_info;
				if (floor.@show_floor_info == "false") { floor_temp.show_floor_info			= false; }
				else {floor_temp.show_floor_info			= true; }
				
				floor_temp.areas					= new ArrayCollection();
				trace("*****Floor:"+floor_temp.id+" name["+floor_temp.name+"] position["+floor_temp.position+"] show_position["+floor_temp.show_position+"] description ["+floor_temp.description+"] show_floor_info ["+floor_temp.show_floor_info+" ("+floor.@show_floor_info+")]******************");
				
				//for each (var area:Object in floor.areas.children())
				for each (var area1:Object in floor.children())
				{
					var area_temp:T_area 			= new T_area();
					area_temp.id					= area1.@id;
					area_temp.name					= area1.@name;
					area_temp.xml					= area1.@xml;
					
					//area_temp.sentido				= area.@sentido;
					//var area_type_temp:T_area_type = new T_area_type();
					//area_type_temp.id				= area.area_type.@id;
					//area_type_temp.type_name		= area.area_type.@type_name;
					//area_temp.type 				= area_type_temp;
					
					var area_type_temp:Object = area1.child("type");
					area_temp.type = new T_area_type();
					area_temp.type.id=area_type_temp.@id;
					area_temp.type.type_name=area_type_temp.@type_name;
					trace("Area:"+area1.@id+" type_area id["+area_temp.type.id+"] type_name["+area_temp.type.type_name+"]");
					
					floor_temp.areas.addItem(area_temp);
				}
				
				detailedversion_temp.floordirectory.addItem(floor_temp);
				trace("["+floor_temp.position+"] "+floor_temp.id+" - "+floor_temp.name+" > directory.length("+detailedversion_temp.floordirectory.length+")");
			}
			//////////////////////////////////////////////////////////////////////
			detailedversion_temp.up_areas = new ArrayCollection();
			for each (var area2:Object in resultXML.elements("up_areas"))
			{
				var area_temp1:T_area 			= new T_area();
				area_temp1.id					= area2.@id;
				area_temp1.name					= area2.@name;
				area_temp1.xml					= area2.@xml;
				var area_type_temp1:Object = area2.child("type");
				area_temp1.type = new T_area_type();
				area_temp1.type.id=area_type_temp1.@id;
				area_temp1.type.type_name=area_type_temp1.@type_name;
				trace("Area:"+area2.@id+" type_area id["+area_temp1.type.id+"] type_name["+area_temp1.type.type_name+"]");
				detailedversion_temp.up_areas.addItem(area_temp1);
			}
			//////////////////////////////////////////////////////////////////////
			detailedversion_temp.down_areas = new ArrayCollection();
			for each (var area3:Object in resultXML.elements("down_areas"))
			{
				var area_temp3:T_area 			= new T_area();
				area_temp3.id					= area3.@id;
				area_temp3.name					= area3.@name;
				area_temp3.xml					= area3.@xml;
				var area_type_temp3:Object = area3.child("type");
				area_temp3.type = new T_area_type();
				area_temp3.type.id=area_type_temp3.@id;
				area_temp3.type.type_name=area_type_temp3.@type_name;
				trace("Area:"+area3.@id+" type_area id["+area_temp3.type.id+"] type_name["+area_temp3.type.type_name+"]");
				detailedversion_temp.down_areas.addItem(area_temp3);
			}
			//////////////////////////////////////////////////////////////////////
			detailedversion_temp.isla_areas = new ArrayCollection;
			for each (var area:Object in resultXML.elements("isla_areas"))
			{
				var area_temp4:T_area 			= new T_area();
				area_temp4.id					= area.@id;
				area_temp4.name					= area.@name;
				area_temp4.xml					= area.@xml;
				var area_type_temp4:Object = area.child("type");
				area_temp4.type = new T_area_type();
				area_temp4.type.id=area_type_temp4.@id;
				area_temp4.type.type_name=area_type_temp4.@type_name;
				trace("Area:"+area.@id+" type_area id["+area_temp4.type.id+"] type_name["+area_temp4.type.type_name+"]");
				detailedversion_temp.isla_areas.addItem(area_temp4);
			}
			//////////////////////////////////////////////////////////////////////
			
			//Base.getinstance().detailedVersion = data.result as T_detailedversion;
			var temp:T_detailedversion = detailedversion_temp;
			Base.getinstance().detailedVersion = detailedversion_temp;
			if (Base.getinstance().detailedVersion.version.type == Base.getinstance().version_type_vdap.toString())
			{
				trace("VERSION_VDAP ["+Base.getinstance().detailedVersion.version.type+"-"+Base.getinstance().version_type_vdap.toString()+"]");
				Base.getinstance().isla_content_editor = false;
				Base.getinstance().versionEdition = true;
				Base.getinstance().showVersionEditor();
			}
			else if (Base.getinstance().detailedVersion.version.type == Base.getinstance().version_type_isla.toString())
			{
				trace("VERSION_ISLA ["+Base.getinstance().detailedVersion.version.type+"-"+Base.getinstance().version_type_isla.toString()+"]");
				Base.getinstance().versionEdition_selectedAreaContent = detailedversion_temp.isla_areas.getItemAt(0) as T_area;
				Base.getinstance().isla_content_editor = true;
				Base.getinstance().versionEdition = false;
				Base.getinstance().showIslaVersionEditor();
			}
			else
			{
				trace("VERSION_UNKNOWN ["+Base.getinstance().detailedVersion.version.type+"]");
				trace(" - VERSION_VDAP ["+Base.getinstance().version_type_vdap.toString()+"]");
				trace(" - VERSION_ISLA ["+Base.getinstance().version_type_isla.toString()+"]");
			}
		}

		public function fault(info:Object) : void {
			trace("getDetailedVersionCommand <- fault [" + info.toString()+"]");
			CursorManager.removeBusyCursor(); 
		}
	}
}