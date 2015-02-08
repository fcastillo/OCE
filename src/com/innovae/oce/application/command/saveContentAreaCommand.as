package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.getDetailedVersionDelegate;
	import com.innovae.oce.application.delegate.loadVersionsDelegate;
	import com.innovae.oce.application.delegate.saveContentAreaDelegate;
	import com.innovae.oce.application.event.getDetailedVersionEvent;
	import com.innovae.oce.application.event.loadVersionsEvent;
	import com.innovae.oce.application.event.saveContentAreaEvent;
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
	import com.innovae.services.orona.evolutio.type.T_resul;
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
	
	public class saveContentAreaCommand implements ICommand, IResponder
	{
		public var service:Webservice_oce;
		
		public function execute(event:CairngormEvent):void
		{
			trace("saveContentAreaCommand -> execute.");
			CursorManager.setBusyCursor(); 

			new saveContentAreaDelegate(this).saveContentArea((event as saveContentAreaEvent).user(), (event as saveContentAreaEvent).area());
		}
		
		public function result(data:Object):void
		{
			trace("saveContentAreaCommand <- result["+data.result+"]");
			CursorManager.removeBusyCursor(); 

			trace(data.message.body);

			//var resultShort:String = String(data.message.body).substr(resultLong.indexOf("<result>"), int(resultLong.indexOf("</result>") + String("</result>").length - resultLong.indexOf("<result>")));
			var resultXML:XML = new XML(String(data.message.body).substr(String(data.message.body).indexOf("<result>"), int(String(data.message.body).indexOf("</result>") + String("</result>").length - String(data.message.body).indexOf("<result>"))));
			
			trace("["+resultXML.version.@id +"]["+ resultXML.version.@name+"]["+resultXML.version.@created+"]["+resultXML.version.@last_modification+"]["+resultXML.version.@type+"]");
			trace("["+resultXML.version_style.@id +"]["+ resultXML.version_style.@text_font+"]["+resultXML.version_style.@text_size+"]["+resultXML.version_style.@text_color+"]["+resultXML.version_style.@border_color+"]["+resultXML.version_style.@background_color+"]["+resultXML.version_style.@anim_speed+"]");		
			
			Base.getinstance().versionEdition_selectedAreaContent.id = (data.result as T_resul).result;
			Base.getinstance().setAreaContent_Sentido_Floor();
			if (Base.getinstance().versionEdition_isGeneralEdition)
			{
				Base.getinstance().areas = new ArrayCollection();
				Base.getinstance().versionEdition_preAsignedAreaContent = new T_area();
				Base.getinstance().versionEdition_selectedAreaContent	= new T_area();
				Base.getinstance().getAreas(Base.getinstance().versionedition_selectedAreaContentType);
				Base.getinstance().showGeneralAreaEditor();	
			}
			else
			{
				Base.getinstance().showVersionEditorFromAreaEditor();
			}
		}

		public function fault(info:Object) : void {
			trace("saveContentAreaCommand <- fault [" + info.toString()+"]");
			CursorManager.removeBusyCursor(); 

		}
	}
}