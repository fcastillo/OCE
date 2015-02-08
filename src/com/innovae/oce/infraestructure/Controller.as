package com.innovae.oce.infraestructure
{
    import com.adobe.cairngorm.control.FrontController;
    import com.innovae.oce.application.command.*;
    import com.innovae.oce.application.event.*;

    public class Controller extends FrontController
    {
        // toda las acciones de la aplicación se gestionan desde esta clase
        public function Controller()
        {
			addCommand( loginEvent.LOGIN, 														loginCommand );
			addCommand( loadVersionsEvent.LOAD_VERSIONS, 										loadVersionsCommand );
			addCommand( getResourcesEvent.GET_RESOURCES, 										getResourcesCommand );
			addCommand( uploadResourcesEvent.UPLOAD_RESOURCE, 									uploadResourcesCommand );
			addCommand( getDetailedVersionEvent.GET_DETAILED_VERSION, 							getDetailedVersionCommand );
			addCommand( getDirectoryStylesEvent.GET_DIRECTORYSTYLES,				 			getDirectoryStylesCommand );
			addCommand( getAreasEvent.GET_AREAS,												getAreasCommand );
			addCommand( getVersionStyleTemplatesEvent.GET_VERSION_STYLE_TEMPLATES,				getVersionStyleTemplatesCommand );
			addCommand( saveVersionStyleTemplatesEvent.SAVE_VERSION_STYLE_TEMPLATES,			saveVersionStyleTemplatesCommand );
			addCommand( saveDetailedVersionEvent.SAVE_DETAILED_VERSION,							saveDetailedVersionCommand );
			addCommand( removeVersionStyleEvent.REMOVE_VERSION_STYLE,							saveVersionStyleTemplatesCommand );
			addCommand( removeDetailedVersionEvent.REMOVE_DETAILED_VERSION,						removeDetailedVersionCommand );
			addCommand( saveContentAreaEvent.SAVE_CONTENT_AREA,									saveContentAreaCommand );
			addCommand( deleteResourceEvent.REMOVE_RESOURCE,									deleteResourceCommand );
			addCommand( getVersionXMLEvent.GET_VERSION_XML, 									getVersionXMLCommand );
			addCommand( keepAliveUserSessionEvent.KEEP_ALIVE,									keepAliveUserSessionCommand );
			addCommand( closeUserSessionEvent.CLOSE_SESSION,									closeUserSessionCommand );
			addCommand( getIslaDetailedVersionFromAreaEvent.GET_DETAILED_VERSION_FROM_AREA, 	getIslaDetailedVersionFromAreaCommand );
			addCommand( removeFloorAreaContentFromServerEvent.REMOVE_AREA_FROM_SERVER,			removeFloorAreaContentFromServerCommand );
        }
    }
}
