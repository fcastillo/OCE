package com.innovae.oce.domain.datamodel
{
	import com.innovae.oce.application.*;
	import com.innovae.oce.application.event.closeUserSessionEvent;
	import com.innovae.oce.application.event.getAreasEvent;
	import com.innovae.oce.application.event.getDetailedVersionEvent;
	import com.innovae.oce.application.event.getDirectoryStylesEvent;
	import com.innovae.oce.application.event.getIslaDetailedVersionFromAreaEvent;
	import com.innovae.oce.application.event.getResourcesEvent;
	import com.innovae.oce.application.event.getVersionStyleTemplatesEvent;
	import com.innovae.oce.application.event.getVersionXMLEvent;
	import com.innovae.oce.application.event.keepAliveUserSessionEvent;
	import com.innovae.oce.application.event.loadVersionsEvent;
	import com.innovae.oce.application.event.removeDetailedVersionEvent;
	import com.innovae.oce.application.event.removeFloorAreaContentFromServerEvent;
	import com.innovae.oce.application.event.removeVersionStyleEvent;
	import com.innovae.oce.application.event.saveContentAreaEvent;
	import com.innovae.oce.application.event.saveDetailedVersionEvent;
	import com.innovae.oce.application.event.saveVersionStyleTemplatesEvent;
	import com.innovae.oce.domain.datamodel.i18n;
	import com.innovae.services.orona.evolutio.type.*;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.events.IndexChangedEvent;
	
	public class Base extends EventDispatcher implements oceEditorProviderInterface
	{
		private static var instance:Base;
		public var version:String = "2013.11.15.00";
		private var vista:Sprite;

		public var allowIsla:Boolean = false;
		
		public var DefaultVersionStyleName:String = "default";
		
		public var version_type_vdap:int 	= 3;
		public var version_type_isla:int 	= 4;
		
		public var area1_type:int			= 1;
		public var area3_type:int			= 3;
		public var area4_type:int			= 4;
		public var area_isla_type:int		= 5;
		
		public var picture_resource_id:int 	= 1;
		public var video_resource_id:int 	= 2;
		public var swf_resource_id:int 		= 3;
		
		public var version_op_new:int = 0;
		public var version_op_new_from:int = 1;
		public var version_op_modify:int = 2;
		public var version_op_delete:int = 3;
		public var version_op_preview:int = 4;
		//
		public var version_op_new_isla:int = 5;
		public var version_op_new_isla_from:int = 6;
		public var version_op_modify_isla:int = 7;
		public var version_op_preview_isla:int = 8;
		
		
		public var area_content_new:int = 0;
		public var area_content_new_from:int = 1;
		public var area_content_modify:int = 2;
		public var area_content_set:int = 3;
		public var area_content_remove:int = 4;
		public var area_content_remove_from_server:int = 5;
		
		public var sentido_null:int = -1;
		public var sentido_down:int = 0;
		public var sentido_up: int = 1;
		
		[Bindable] public var resource_asignable:Boolean = false;
		[Bindable] public var resource_asignable_codificado:Boolean = false;
		[Bindable] public var sendingResource:Boolean = false;
		[Bindable] public var show_big_resource:Boolean = false;
		
		public var abs_url:String = "http://5.9.137.10/orona/oce/";
		public var backend_abs_url:String = "http://5.9.137.10/orona/backend/";
		
		//[Bindable] public var fuentes:ArrayCollection = new ArrayCollection([ {name:"Arial"},{name:"Arial Black"},{name:"Comic Sans"},{name:"Courier"},	{name:"Courier New"},{name:"Georgia"},{name:"Impact"},{name:"Lucida Console"},{name:"Lucida Sans"},	{name:"Microsoft Sans Serif"},	{name:"Modern"},{name:"Symbol"},{name:"Tahoma"},{name:"Times New Roman"},{name:"Trebuchet MS"},	{name:"Verdana"}]);
		[Bindable] public var fonts:ArrayCollection = new ArrayCollection([ "Arial","Arial Black","Comic Sans","Courier","Courier New","Georgia","Impact","Lucida Console","Lucida Sans","Microsoft Sans Serif","Modern","Symbol","Tahoma","Times New Roman","Trebuchet MS","Verdana"]);
		//[Bindable] public var sentidos:ArrayCollection = new ArrayCollection([ "Ascendente","Reposo","Descendente"]);
		[Bindable] public var sentidos:ArrayCollection = new ArrayCollection([ "Ascendente","Descendente"]);
		
		[Bindable] public var i18n_txt:i18n = new i18n();
		[Bindable] public var selected_lang:String = "es";
		[Bindable] public var login_button_text:String = "Identificarse";
		[Bindable] public var logged:Boolean = false;

		[Bindable] public var selected_index:int = 0;
		[Bindable] public var nextSelected_index:int = 0;
		
		[Bindable] public var user:T_authorization = new T_authorization();
		
		[Bindable] public var versiones:ArrayCollection = new ArrayCollection();
		[Bindable] public var versionesVDAP:ArrayCollection = new ArrayCollection();
		[Bindable] public var versionesISLA:ArrayCollection = new ArrayCollection();
		
		
		[Bindable] public var resources:ArrayCollection = new ArrayCollection();
		[Bindable] public var pictureResources:ArrayCollection = new ArrayCollection();
		[Bindable] public var videoResources:ArrayCollection = new ArrayCollection();
		[Bindable] public var detailedVersion:T_detailedversion = new T_detailedversion();
		[Bindable] public var detailedVersionIsNew:Boolean = true;
		[Bindable] public var directoryStyles:ArrayCollection = new ArrayCollection();
		[Bindable] public var areas:ArrayCollection = new ArrayCollection();
		[Bindable] public var versionStyleTemplates:ArrayCollection = new ArrayCollection();
		//[Bindable] public var versions
		
		[Bindable] public var versionMenu_selectedVersion:T_version;
		[Bindable] public var versionMenu_selectedVersion_index:int;
		
		[Bindable] public var versionEdition:Boolean = false;
		[Bindable] public var versionEdition_selectedFloor:T_floor = new T_floor();
		[Binbable] public var versionEdition_preselectedDirectoryStyle:T_directory_style = new T_directory_style();
		[Bindable] public var versionEdition_selectedAreaContentType:T_area_type = new T_area_type();
		[Bindable] public var versionEdition_preAsignedAreaContent:T_area = new T_area();
		[Bindable] public var versionEdition_selectedAreaContent:T_area = new T_area();
		[Bindable] public var versionEdition_selectedUp_Stop_Down:int;
		[Bindable] public var versionEdition_isEditSentido:Boolean = false;
		[Bindable] public var versionEdition_isEditSentidoLabel:String = "";
		[Bindable] public var versionEdition_selectedVersionStyle:T_version_style = new T_version_style();
		[Bindable] public var versionEdition_selectedVersionStyleChanged:Boolean = false;
		[Bindable] public var versionEdition_selectedAreaContent_Op:int;
		[Bindable] public var versionedition_selectedAreaContentType:int;
		[Bindable] public var versionEdition_isGeneralEdition:Boolean;
		
		[Bindable] public var versionEdition_piso_seleccionado_index:int = -1;
		[Bindable] public var versionEdition_piso_seleccionado:Boolean =false;
		
		[Bindable] public var versionEdition_selectedVersionStyle_text_font_selectedIndex:int = 0;
		
		//[Bindable] public var area:T_area = new T_area();
		[Bindable] public var versionEdition_selectedAreaIsNew:Boolean = true;
		
		[Bindable] public var content_editor1:Boolean = false; 
		[Bindable] public var content_editor3:Boolean = false;
		[Bindable] public var content_editor4:Boolean = false;
		[Bindable] public var content_preview:Boolean = false;
		[Bindable] public var isla_content_editor:Boolean = false;
		[Bindable] public var isla_content_preview:Boolean = false;
		
		[Bindable] public var contentArea_edition_ask_for_name:Boolean = false;
		
		[Bindable] public var versionEdition_selectedArea_resource_selection_windows_visible:Boolean = false;
		[Bindable] public var oceEditor_requested_resource_type:int;
		[Bindable] public var oceEditor_language:String = "";
		
		[Bindable] public var resourcesList_selectedResource_item:int;
		[Bindable] public var resourcesList_selectedResource_previous_resource:int = -1;
		[Bindable] public var resourcesList_selectedResource:T_resource = new T_resource();
		[Bindable] public var resourcesList_selectedResource_dimension:String = "";
		[Bindable] public var resourcesList_selectedResource_size:String = "";
		[Bindable] public var resourcesList_resource_type:T_resource_type = new T_resource_type();
		
		[Bindable] public var previewVersionXML:String = "";
		
		[Bindable] public var activityTimer:Timer;
		[Bindable] public var lastActivityTime:Date;
		[Bindable] public var lastActivityTimeOut:int = 5; //minutos
		[Bindable] public var activityTimerNotificationMaxTryout:int = 3;
		[Bindable] public var activityTimerNotificationDoneTryout:int = 0;

		
		[Bindable] public var versionEdition_hiderCanvas_visibile:Boolean = false;
		[Bindable] public var contentAreaEdition_hiderCanvas_visibile:Boolean = false;
		[Bindable] public var versionEdition_areaContentSelection_visibile:Boolean = false;
		[Bindable] public var versionEdition_floorDirectoryStyleSelection_visibile:Boolean = false;
		[Bindable] public var versionEdition_versionSaveAs_visibile:Boolean = false;
		[Bindable] public var versionEdition_configureVersionStyleTemplate_visible:Boolean = false;
		
		[Bindable] public var resourceLibraryMenuBarSelectedIndex:int = 0;
		
		public static function getinstance():Base// Static initializer
		{
			if (instance == null) instance = new Base();
			return instance;			
		}
		
		public function Base()
		{
			oceEditor_language = "aeLabelCabecera;Área de edición\r\naeTextoDefecto;Introduzca su texto aquí\r\naeTextoTickerDefecto;Texto del ticker\r\ntooltipTitSWF;Animaciones\r\ntooltipTextSWF;Archivos SWF(Shockwave Flash)\r\ntooltipTitTexto;Texto\r\ntooltipTextTexto;Editor de textos\r\ntooltipTitImg;Gráficos\r\ntooltipTextImg;Imágenes jpg, png…\r\ntooltipTitVideo;Vídeos\r\ntooltipTextVideo;Vídeos en formato flv, mov, mp4…\r\ntooltipTitMeteo;Tiempo\r\ntooltipTextMeteo;Información meteorológica\r\ntooltipTitRSS;RSS\r\ntooltipTextRSS;Conexión dinámica a RSS\r\ntooltipTitTicker;Ticker\r\ntooltipTextTicker;Texto informativo\r\ntooltipTitPasa;Pasafotos\r\ntooltipTextPasa;Pasafotos formado por imágenes\r\ntooltipTitPubli;Publicidad\r\ntooltipTextPubli;Contenido publicitario\r\ntooltipTitMenu;Menú\r\ntooltipTextMenu;Menús prediseñados \r\ntooltipTitReloj;Reloj\r\ntooltipTextReloj;Hora en formato analógico/digital\r\npgLabelCabecera;Propiedades genéricas\r\npgLabelWidth;an:\r\npgLabelHeight;al:\r\npgLabelRelacion;mantener relación\r\npgLabelAlpha;opacidad:\r\npgLabelProf;profundidad:\r\npgLabelFondo;fondo\r\npgLabelAdd;añadir\r\npgLabelElim;eliminar\r\npgButtonSave;Guardar\r\npgButtonVolver;Volver\r\npgLabelAlinear;alinear\r\npgLabelEsc;con el escenario\r\npgLabelDist;distribuir\r\npeLabelCabecera;Propiedades específicas\r\npeLabelFormatoTexto;formato del texto:\r\npeLabelBucle;reproducción en bucle\r\npeLabelMute;mute (solo en edición)\r\npeLabelDia;seleccionar día:\r\npeComboDia1;Hoy\r\npeComboDia2;Mañana\r\npeComboDia3;Pasado Mañana\r\npeComboDia4;A 3 días vista\r\npeLabelFormat;formato fecha:\r\npeComboFormat1;DD/MM/AA\r\npeComboFormat2;AA/MM/DD\r\npeComboFormat3;MM/DD/AA\r\npeLabelPos;posición textos:\r\npeComboPos1;Arriba\r\npeComboPos2;Derecha\r\npeLabelPais;seleccionar país:\r\npeComboPais1;Andorra\r\npeComboPais2;Alemania\r\npeComboPais3;Dinamarca\r\npeComboPais4;Eslovaquia\r\npeComboPais5;Eslovenia\r\npeComboPais6;España\r\npeComboPais7;Estonia\r\npeComboPais8;Finlandia\r\npeComboPais9;Francia\r\npeComboPais10;Gibraltar\r\npeComboPais11;Grecia\r\npeComboPais12;Hungría\r\npeComboPais13;Irlanda\r\npeComboPais14;Islandia\r\npeComboPais15;Italia\r\npeComboPais16;Letonia\r\npeComboPais17;Liechtenstein\r\npeComboPais18;Lituania\r\npeComboPais19;Luxemburgo\r\npeComboPais20;Macedonia\r\npeComboPais21;Malta\r\npeComboPais22;Moldavia\r\npeComboPais23;Mónaco\r\npeComboPais24;Montenegro\r\npeComboPais25;Noruega\r\npeComboPais26;Países Bajo\r\nspeComboPais27;Polonia\r\npeComboPais28;Portugal\r\npeComboPais29;Reino Unido\r\npeComboPais30;Rumania\r\npeComboPais31;San Marino\r\npeComboPais32;Serbia\r\npeComboPais33;Suecia\r\npeComboPais34;Suiza\r\npeComboPais35;Ucrania\r\npeComboPais36;Vaticano, Ciudad del\r\npeLabelCiudad;seleccionar ciudad:\r\npeLabelEdicText;edición del texto:\r\npeLabelRadioFecha;Fecha\r\npeLabelRadioTemp;Temperatura\r\npeLabelEstilo;seleccionar estilo\r\npeLabelLink;enlace a RSS\r\npeLabelEstiloRSS;estilo:\r\npeComboEstilo1;estilo1\r\npeComboEstilo2;estilo2\r\npeComboEstilo3;estilo3\r\npeLabelVisible;Imagen visible\r\npeLabelBandaSup;banda superior:\r\npeLabelBandaInf;banda inferior:\r\npeLabelVelTit;velocidad del título:\r\npeLabelVelText;velocidad del texto:\r\npeLabelInhabil;Inhabilitar\r\npeLabelTitu;Titular\r\npeLabelVelTexto;velocidad del desplazamiento\r\npeLabelContenido;contenido del pasafotos:\r\npeLabelAddImage;añadir imagen\r\npeLabelElimImage;eliminar imagen\r\npeLabelEdic;edición:\r\npeLabelTiempoTrans;tiempo entre transiciones:\r\npeLabelVel;velocidad:\r\npeLabelSentido;dirección:\r\npeComboSentido1;Ninguno\r\npeComboSentido2;Horizontal\r\npeComboSentido3;Vertical\r\npeLabelDir;sentido:\r\npeComboDir1;Hacia la izquierda\r\npeComboDir2;Hacia la derecha\r\npeComboDir3;Hacia abajo\r\npeComboDir4;Hacia arriba\r\npeLabelEfecto;efecto de la animación:\r\npeRadioEfecto1;Cortina\r\npeRadioEfecto2;Retardo\r\npeRadioEfecto3;Frenazo\r\npeRadioEfecto4;Rebote\r\npeRadioEfecto5;Ninguno\r\npeButtonPre;previsualizar\r\npeCabeceraPrevisu;Previsualizador del elemento pasafotos\r\npeButtonAcept;Aceptar\r\npeLabelPlantilla;seleccionar plantilla:\r\npeComboPlantilla1;Ninguno\r\npeComboPlantilla2;Estilo 1\r\npeComboPlantilla3;Estilo 2\r\npeComboPlantilla4;Estilo 3\r\npeComboPlantilla5;Estilo 4\r\npeComboPlantilla6;Estilo 5\r\npeComboPlantilla7;Estilo 6\r\npeLabelFondoMenu;fondo del menú\r\npeLabelColorFondo;color del fondo\r\npeLabelElimCol;eliminar color\r\npeRadioEdic1;Cabecera\r\npeRadioEdic2;Título principal\r\npeRadioEdic3;Pie\r\npeRadioEdic4;Título 1\r\npeRadioEdic5;Título 2\r\npeRadioEdic6;Título 3\r\npeRadioEdic7;Texto 1\r\npeRadioEdic8;Texto 2\r\npeRadioEdic9;Texto 3\r\npeLabelInvisible;Invisible\r\npeButtonEnviar;Enviar\r\npeLabelSelecTipo;seleccionar tipo:\r\npeRadioTipo1;Analógico\r\npeRadioTipo2;Digital\r\npeLabelAguj;agujas:\r\npeLabelNum;números:\r\npeLabelEsc;escala:\r\npeLabelMarco;marco:\r\npeLabelSombra;sombra:\r\npeLabelRemarc;remarco:\r\npeLabelFondo;fondo:\r\npeLabelDiaT;día(texto):\r\npeLabelDiaN;día(número):\r\npeLabelMes;mes\r\ndiaSem0;dom\r\ndiaSem1;lun\r\ndiaSem2;mar\r\ndiaSem3;mié\r\ndiaSem4;jue\r\ndiaSem5;vie\r\ndiaSem6;sáb\r\nmes0;enero\r\nmes1;feb\r\nmes2;mar\r\nmes3;abril\r\nmes4;mayo\r\nmes5;junio\r\nmes6;julio\r\nmes7;ago\r\nmes8;sep\r\nmes9;oct\r\nmes10;nov\r\nmes11;dic\r\n";
		}
		public function setVista(vistaExt:Sprite):void
		{
			this.vista = vistaExt;
		}
		
		public function startActivityTimer():void
		{
			var activityNotifyPeriod:int = 1;
			this.activityTimerNotificationDoneTryout = 0; 
			activityTimer = new Timer(activityNotifyPeriod*60*1000,1);
			activityTimer.addEventListener(TimerEvent.TIMER_COMPLETE, activityTimerCompleteHandler);
			activityTimer.start();
		}
		
		public function stopActivityTimer():void
		{
			if (activityTimer != null) { activityTimer.stop(); }
		}
		
		private function activityTimerCompleteHandler(e:TimerEvent):void
		{
			activityTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, activityTimerCompleteHandler);
			var now:Date = new Date();
			var millisecondDifference:int = now.valueOf() - lastActivityTime.valueOf();
			trace("^^^^^^^^^^t_i_c_k   activityTimerCompleteHandler : "+ millisecondDifference/60000 );
			if (millisecondDifference < (this.lastActivityTimeOut * 60 * 1000))
			{
				// la ultima acción ha ocurrido antes del timeout...
				new keepAliveUserSessionEvent(keepAliveUserSessionEvent.KEEP_ALIVE, this.user ).dispatch();
			}
			else
			{
				//se ha dado un timeout
				this.closeSession("activity_timeout");	
			}
		}
		
		public function checkActivityTimerTryOuts():void
		{
			if (this.activityTimerNotificationMaxTryout <= this.activityTimerNotificationDoneTryout)
			{
				this.activityTimerNotificationDoneTryout = 0;
				this.closeSession("max_tryout");
			}
			else
			{
				Base.getinstance().activityTimerNotificationDoneTryout++;
				new keepAliveUserSessionEvent(keepAliveUserSessionEvent.KEEP_ALIVE,this.user ).dispatch(); 
			}
		}
		
		public function activityHandler(event:MouseEvent):void
		{
			this.lastActivityTime = new Date();
			trace ("^^^^^^^CLICK ["+lastActivityTime.hours+":"+lastActivityTime.minutes+":"+lastActivityTime.seconds+"]^^^^^^^^^^");
		}
		
		public function closeSession(razon:String):void
		{
			this.login_button_text = "Identificarse";
			this.logged = false;
			new closeUserSessionEvent(closeUserSessionEvent.CLOSE_SESSION, this.user, razon ).dispatch();
			
			
			this.login_button_text = "Identificarse";
			this.logged = false;
			//this.user.license_id = null;
			//Alert.show(this.i18n_txt.getValue("login_incorrect_notification_text"),this.i18n_txt.getValue("login_incorrect_notification_title"), Alert.OK);
		}
		
		public function reloadWebPage(evt:CloseEvent):void
		{
			if (ExternalInterface.available)//refrescar la página para cerrar sesión
			{
				ExternalInterface.call("function startover(){document.location.reload()}");
			}
		}
		
		public function login(data:T_resul):void
		{
			if (data.result >0)
			{
				this.user.license_id = data.result;
				this.user.user_id = int(data.error_code);
				this.logged = true;
				this.login_button_text = "Cerrar sesión";
				this.startActivityTimer();
				//Base.getinstance().versionMenu_selectedVersion_index = 0;
				Base.getinstance().resources = new ArrayCollection();
				versionMenu_getSelectedVersion();
				showVersionMenu();
			}
			else
			{
				this.logged = false;
				this.user.license_id = -1;
				if (data.error_code == "0002E") { this.closeSession("login_incorrect"); }
				else if (data.error_code == "0003E") { this.closeSession("session_already_open"); }
				else if (data.error_code == "0004E") { this.closeSession("no_license_for_this_tool"); }
				else { this.closeSession("login_incorrect"); }
			}
		}
		
		//public function getResources(filtro:int):ArrayCollection
		public function getResources(filtro:int):void
		{
			trace("getResources("+filtro+")");
			this.resourcesList_resource_type = new T_resource_type();
			this.resourcesList_resource_type.id = filtro;
			new getResourcesEvent(getResourcesEvent.GET_RESOURCES,this.user, this.resourcesList_resource_type ).dispatch(); 
			/*
			var resourcesArrayCollection:ArrayCollection = new ArrayCollection();
			for each (var resource:T_resource in this.resources)
			{
				if (resource.type == filtro)
				{
					resourcesArrayCollection.addItem(resource);
				}
			}
			return resourcesArrayCollection;*/
		}
		
		public function getDirectoryStyles():void
		{
			this.directoryStyles = new ArrayCollection(); 
			new getDirectoryStylesEvent(getDirectoryStylesEvent.GET_DIRECTORYSTYLES, this.user).dispatch();
		}
		
		public function getVersionStyleTemplates():void
		{
			this.versionStyleTemplates = new ArrayCollection();
			new getVersionStyleTemplatesEvent(getVersionStyleTemplatesEvent.GET_VERSION_STYLE_TEMPLATES, this.user).dispatch();
		}
		
		public function getAreas(area_type_id:int):void
		{
			trace(">"+area_type_id);
			this.versionEdition_selectedAreaContentType = new T_area_type();
			this.versionEdition_selectedAreaContentType.id = area_type_id;
			this.versionEdition_selectedAreaContentType.type_name = "area_"+area_type_id;
			this.areas = new ArrayCollection();
			this.versionEdition_selectedAreaContent = new T_area();
			
			new getAreasEvent(getAreasEvent.GET_AREAS, this.user, this.versionEdition_selectedAreaContentType).dispatch();
		}
		
		public function getVersions():void
		{
			this.areas = new ArrayCollection();
			
			new loadVersionsEvent(loadVersionsEvent.LOAD_VERSIONS, this.user).dispatch();
		}
		
		public function MainChangeEventHandler(event:IndexChangedEvent):void
		{
			switch (event.newIndex)
			{
				case 0: 
					new loadVersionsEvent(loadVersionsEvent.LOAD_VERSIONS, this.user).dispatch();
					break;
				case 1:
					var temp_resource_type:T_resource_type = new T_resource_type();
					temp_resource_type.id = -1;
					temp_resource_type.type_name = "";
					new getResourcesEvent(getResourcesEvent.GET_RESOURCES, this.user, temp_resource_type).dispatch();
					break;
			}
		}
		
		public function versionOpFromAreaGetVersion(area:T_area):void
		{
			new getIslaDetailedVersionFromAreaEvent(getIslaDetailedVersionFromAreaEvent.GET_DETAILED_VERSION_FROM_AREA, this.user, area).dispatch(); 
		}
		
		
		public function versionOp(version_op:int, idversion:int):void
		{
			switch(version_op)
			{
				case this.version_op_new:
					this.detailedVersion = new T_detailedversion();
					this.detailedVersion.version = new T_version();
					this.detailedVersion.version_style = new T_version_style();
					this.detailedVersion.directory_style = new T_directory_style();
					this.detailedVersion.directory_style.id = 0;
					this.detailedVersion.directory_style.name = "default";
					this.detailedVersion.show_floor_info = true;
					this.detailedVersion.floordirectory = new ArrayCollection();
					this.detailedVersion.up_areas = new ArrayCollection();
					this.detailedVersion.down_areas = new ArrayCollection();
					this.detailedVersionIsNew = true;
					Base.getinstance().showVersionEditor();
					break;
				case this.version_op_new_from:
					this.detailedVersionIsNew = true;
					new getDetailedVersionEvent(getDetailedVersionEvent.GET_DETAILED_VERSION,this.user,this.obtainVersionById(idversion)).dispatch();
					break;
				case this.version_op_modify: 
					this.detailedVersionIsNew = false;
					new getDetailedVersionEvent(getDetailedVersionEvent.GET_DETAILED_VERSION,this.user,this.obtainVersionById(idversion)).dispatch();
					break;
				case this.version_op_preview:
					new getVersionXMLEvent(getVersionXMLEvent.GET_VERSION_XML,this.user,this.obtainVersionById(idversion)).dispatch();
					break;
				case this.version_op_delete:
					new removeDetailedVersionEvent(removeDetailedVersionEvent.REMOVE_DETAILED_VERSION, this.user, this.obtainVersionById(idversion)).dispatch();
					break;
				case this.version_op_new_isla:
					this.versionEdition_selectedAreaContent_Op = this.version_op_new_isla;
					this.detailedVersion = new T_detailedversion();
					this.detailedVersion.version = new T_version();
					this.detailedVersion.version.type = "4";
					this.detailedVersion.version_style = new T_version_style();
					this.detailedVersion.show_floor_info = true;
					this.detailedVersion.floordirectory = new ArrayCollection();
					this.detailedVersion.up_areas = new ArrayCollection();
					this.detailedVersion.down_areas = new ArrayCollection();
					this.detailedVersion.isla_areas = new ArrayCollection();
					this.detailedVersionIsNew = true;
					Base.getinstance().showIslaVersionEditor();
					break;
				case this.version_op_new_isla_from:
					this.versionEdition_selectedAreaContent_Op = this.version_op_new_isla_from;
					this.detailedVersionIsNew = true;
					new getDetailedVersionEvent(getDetailedVersionEvent.GET_DETAILED_VERSION,this.user,this.obtainVersionById(idversion)).dispatch();
					break;
				case this.version_op_modify_isla:
					this.versionEdition_selectedAreaContent_Op = this.version_op_modify_isla;
					this.detailedVersionIsNew = false;
					new getDetailedVersionEvent(getDetailedVersionEvent.GET_DETAILED_VERSION,this.user,this.obtainVersionById(idversion)).dispatch();
					break;
				case this.version_op_preview_isla:
					new getVersionXMLEvent(getVersionXMLEvent.GET_VERSION_XML,this.user,this.obtainVersionById(idversion)).dispatch();
					break;
			}
		}
		
		public function hideVersionEditionTitleWindows():void
		{
			Base.getinstance().versionEdition_hiderCanvas_visibile = false;
			Base.getinstance().versionEdition_areaContentSelection_visibile = false;
			Base.getinstance().versionEdition_floorDirectoryStyleSelection_visibile = false;
			Base.getinstance().versionEdition_versionSaveAs_visibile = false;
			Base.getinstance().versionEdition_configureVersionStyleTemplate_visible = false;
		}
		
		public function areaContentOp(area_content_op:int, general:Boolean):void
		{
			trace("areaContentOp -> areacontent_type["+this.versionedition_selectedAreaContentType+"]");
			this.versionEdition_selectedAreaContent_Op = area_content_op;
			//this.versionEdition_selectedAreaContent.sentido = this.versionEdition_selectedUp_Stop_Down;
			this.versionEdition_isGeneralEdition = general;
			switch(area_content_op)
			{
				case this.area_content_new:
					this.hideVersionEditionTitleWindows();
					trace("areaContentOp ["+area_content_op+"] -> new"); 
					this.versionEdition_selectedAreaContent = new T_area();
					//this.versionEdition_selectedAreaContent.xml = '<Area tipo="'+Base.getinstance().versionedition_selectedAreaContentType+'" pathfondo=""></Area>';
					this.versionEdition_selectedAreaContent.xml = "";
					this.versionEdition_selectedAreaIsNew = true;
					this.versionEdition_selectedAreaContent.type = new T_area_type();
					this.versionEdition_selectedAreaContent.type.id = Base.getinstance().versionedition_selectedAreaContentType;
					this.versionEdition_selectedAreaContent.id = -1;
					showContentAreaEditor();
					break;
				case this.area_content_new_from:
					trace("areaContentOp ["+area_content_op+"] -> new from existing");
					if (this.versionEdition_selectedAreaContent.id <= 0) 
					{ 
						Alert.show("Seleccione un contenido de área"); 
					}
					else
					{
						this.hideVersionEditionTitleWindows();
						//this.versionEdition_selectedAreaContent = this.versionEdition_selectedAreaContent;
						this.versionEdition_selectedAreaIsNew = true;
						this.versionEdition_selectedAreaContent.id = -1;
						showContentAreaEditor();
					}
					break;
				case this.area_content_modify:
					trace("areaContentOp ["+area_content_op+"] -> modify");
					if (this.versionEdition_selectedAreaContent.id <= 0) 
					{ 
						Alert.show("Seleccione un contenido de área"); 
					}
					else
					{
						this.hideVersionEditionTitleWindows();
						//this.versionEdition_selectedAreaContent = this.versionEdition_selectedAreaContent;
						this.versionEdition_selectedAreaIsNew = false;
						showContentAreaEditor();
					}
					break;
				case this.area_content_set:
					trace("areaContentOp ["+area_content_op+"] -> set");
					if (this.versionEdition_selectedAreaContent.id <= 0) 
					{ 
						Alert.show("Seleccione un contenido de área"); 
					}
					else
					{
						this.hideVersionEditionTitleWindows();
						//this.versionEdition_selectedAreaContent = this.versionEdition_selectedAreaContent;
						this.versionEdition_selectedAreaIsNew = false;
						setAreaContent_Sentido_Floor();
					}
					break;
				case this.area_content_remove:
					trace("areaContentOp ["+area_content_op+"] -> remove asigned content of type "+Base.getinstance().versionedition_selectedAreaContentType);
					if (this.versionEdition_selectedUp_Stop_Down == this.sentido_up)
					{
						this.detailedVersion.up_areas = removeAreaContent(this.detailedVersion.up_areas, Base.getinstance().versionedition_selectedAreaContentType);
					}
					else if (this.versionEdition_selectedUp_Stop_Down == this.sentido_down)
					{
						this.detailedVersion.down_areas = removeAreaContent(this.detailedVersion.down_areas, Base.getinstance().versionedition_selectedAreaContentType);
					}
					else
					{
						(this.detailedVersion.floordirectory[this.detailedVersion.floordirectory.getItemIndex(this.versionEdition_selectedFloor)] as T_floor).areas = 
							removeAreaContent(((this.detailedVersion.floordirectory[this.detailedVersion.floordirectory.getItemIndex(this.versionEdition_selectedFloor)]) as T_floor).areas, Base.getinstance().versionedition_selectedAreaContentType);
					}
					this.hideVersionEditionTitleWindows();
					break;
				case this.area_content_remove_from_server:
					trace("areaContentOp ["+area_content_op+"] -> remove from server content of type "+Base.getinstance().versionedition_selectedAreaContentType);
					removeAreaContentFromServer(this.versionEdition_selectedAreaContent);
					break;
			}
		}
		
		public function setAreaContent_Sentido_Floor():void
		{
			if (this.versionEdition_selectedUp_Stop_Down == this.sentido_up)
			{
				this.detailedVersion.up_areas = findAndReplaceAreaContent(this.detailedVersion.up_areas, this.versionEdition_selectedAreaContent);
			}
			else if (this.versionEdition_selectedUp_Stop_Down == this.sentido_down)
			{
				this.detailedVersion.down_areas = findAndReplaceAreaContent(this.detailedVersion.down_areas, this.versionEdition_selectedAreaContent);
			}
			else
			{
				(this.detailedVersion.floordirectory[this.detailedVersion.floordirectory.getItemIndex(this.versionEdition_selectedFloor)] as T_floor).areas = 
					findAndReplaceAreaContent(((this.detailedVersion.floordirectory[this.detailedVersion.floordirectory.getItemIndex(this.versionEdition_selectedFloor)]) as T_floor).areas, this.versionEdition_selectedAreaContent);
			}
		}

		public function getAsigned_AreaContent_Sentido_Floor():void
		{
			var areas:ArrayCollection = new ArrayCollection();
			if (this.versionEdition_selectedUp_Stop_Down == this.sentido_up)
			{
				areas = this.detailedVersion.up_areas;
			}
			else if (this.versionEdition_selectedUp_Stop_Down == this.sentido_down)
			{
				areas = this.detailedVersion.down_areas;
			}
			else
			{
				areas = ((this.detailedVersion.floordirectory[this.detailedVersion.floordirectory.getItemIndex(this.versionEdition_selectedFloor)]) as T_floor).areas;
			}
			
			if (areas !=null)
			{
				for (var i:int = 0; i<areas.length; i++)
				{
					if ((areas[i] as T_area).type.id == this.versionEdition_selectedAreaContentType.id)
					{
						var t_area:T_area = new T_area();
						t_area = (areas[i] as T_area);
						this.versionEdition_preAsignedAreaContent = t_area;
						this.versionEdition_selectedAreaContent = t_area;
					}
				}
			}
		}
		
		public function findAndReplaceAreaContent(areas:ArrayCollection, area:T_area):ArrayCollection
		{
			var newAreas:ArrayCollection = new ArrayCollection();
			if (areas !=null)
			{
				for (var i:int = 0; i<areas.length; i++)
				{
					if ((areas[i] as T_area).type.id != area.type.id)
					{
						newAreas.addItem(areas[i] as T_area);
					}
				}
			}
			newAreas.addItem(area);
			return newAreas;
		}
		public function removeAreaContent(areas:ArrayCollection, area_type_to_remove:int):ArrayCollection
		{
			var newAreas:ArrayCollection = new ArrayCollection();
			if (areas !=null)
			{
				for (var i:int = 0; i<areas.length; i++)
				{
					if ((areas[i] as T_area).type.id != area_type_to_remove)
					{
						newAreas.addItem(areas[i] as T_area);
					}
				}
			}
			return newAreas;
		}
		
		public function removeAreaContentFromServer(area:T_area):void
		{
			new removeFloorAreaContentFromServerEvent(removeFloorAreaContentFromServerEvent.REMOVE_AREA_FROM_SERVER, this.user, area).dispatch();
		}
		
		public function obtainVersionById(idversion:int):T_version
		{
			for each (var version:T_version in this.versiones)
			{
				if (version.id == idversion) return version;
			}
			return null;
		}
		
		public function comprobarTransicionPantalla():void
		{
			trace("actual: "+Base.getinstance().selected_index + " - next: "+this.nextSelected_index);
			if (Base.getinstance().selected_index == 3)
			{
				Alert.show("¿Desea salir de la edición de la versión? Si selecciona aceptar perderá todos los cambios.", "Alert", Alert.OK | Alert.CANCEL, this.vista, alertListener );
			}						
			else if (Base.getinstance().selected_index == 8)
			{
				Alert.show("¿Desea salir de la edición de la versión? Si selecciona aceptar perderá todos los cambios.", "Alert", Alert.OK | Alert.CANCEL, this.vista, alertListener );
			}
			else if (Base.getinstance().selected_index == 4)
			{
				Alert.show("¿Desea salir de la edición de la versión? Si selecciona aceptar perderá todos los cambios.", "Alert", Alert.OK | Alert.CANCEL, this.vista, alertListener );
			}
			else if (Base.getinstance().selected_index == 5)
			{
				Alert.show("¿Desea salir de la edición de la versión? Si selecciona aceptar perderá todos los cambios.", "Alert", Alert.OK | Alert.CANCEL, this.vista, alertListener );
			}
			else if (Base.getinstance().selected_index == 6)
			{
				Alert.show("¿Desea salir de la edición de la versión? Si selecciona aceptar perderá todos los cambios.", "Alert", Alert.OK | Alert.CANCEL, this.vista, alertListener );
			}
			else
			{
				procesarCambioPantalla();
			}
		}
		
		private function alertListener(eventObj:CloseEvent):void {
			// Check to see if the OK button was pressed.
			if (eventObj.detail==Alert.OK) {
				trace("continar con el cambio de pantalla");
				procesarCambioPantalla();
			}
			else
			{
				trace("NO CAMBIAR DE PANTALLA!!! -> seguir con la edición");
			}
		}
		
		public function procesarCambioPantalla():void
		{
			switch(String(Base.getinstance().nextSelected_index))
			{
				case "0":
					Base.getinstance().showVersionMenu();
					break;
				case "1":
					Base.getinstance().showGeneralResourceLibrary();
					break;
				case "2":
					Base.getinstance().showGeneralAreaEditor();
					break;
				case "4": break;
				case "5": break;
				case "6": break;
				case "7": break;
				case "8": break;
				default: break;
			}
		}
		
		public function preShowVersionMenu():void
		{
			this.nextSelected_index = 0;
			comprobarTransicionPantalla();
		}
		
		public function showVersionMenu():void
		{
			flash.media.SoundMixer.stopAll();
			new loadVersionsEvent(loadVersionsEvent.LOAD_VERSIONS, this.user).dispatch();
			this.selected_index = 0;
			versionMenu_selectedVersion_index = 0;
			content_editor1 = false;
			content_editor3 = false;
			content_editor4 = false;
			content_preview = false;
			isla_content_editor = false;
			versionEdition = false;
			isla_content_preview = false;
		}
		
		public function preShowGeneralResourceLibrary():void
		{
			this.nextSelected_index = 1;
			
			Base.getinstance().resourcesList_selectedResource = new T_resource();
			Base.getinstance().resourcesList_resource_type = new T_resource_type();
			Base.getinstance().resourcesList_resource_type.id = Base.getinstance().picture_resource_id;
			Base.getinstance().getResources(Base.getinstance().resourcesList_resource_type.id);
			Base.getinstance().resourceLibraryMenuBarSelectedIndex = 0;
			comprobarTransicionPantalla();
		}
		public function showGeneralResourceLibrary():void
		{
			flash.media.SoundMixer.stopAll();
			this.selected_index = 1;
			content_editor1 = false;
			content_editor3 = false;
			content_editor4 = false;
			content_preview = false;
			isla_content_editor = false;
			versionEdition = false;
			isla_content_preview = false;
			Base.getinstance().getResources(Base.getinstance().resourcesList_resource_type.id);
		}
		public function preShowGeneralAreaEditor():void
		{
			this.nextSelected_index = 2;
			comprobarTransicionPantalla();
		}
		public function showGeneralAreaEditor():void
		{
			flash.media.SoundMixer.stopAll();
			this.selected_index = 2;
			content_editor1 = false;
			content_editor3 = false;
			content_editor4 = false;
			content_preview = false;
			isla_content_editor = false;
			versionEdition = false;
			isla_content_preview = false;
		}
		/*public function preShowVersionEditor():void
		{
			this.nextSelected_index = 3;
			comprobarTransicionPantalla();
		}*/
		public function showVersionEditor():void
		{
			flash.media.SoundMixer.stopAll();
			this.versionEdition_isEditSentido = false;
			this.versionEdition_selectedFloor = null;
			this.getVersionStyleTemplates(); 
			this.selected_index = 3;
			content_editor1 = false;
			content_editor3 = false;
			content_editor4 = false;
			content_preview = false;
			isla_content_editor = false;
			versionEdition = true;
			isla_content_preview = false;
		}
		public function showVersionEditorFromAreaEditor():void
		{
			flash.media.SoundMixer.stopAll();
			this.getVersionStyleTemplates(); 
			this.selected_index = 3;
			content_editor1 = false;
			content_editor3 = false;
			content_editor4 = false;
			content_preview = false;
			isla_content_editor = false;
			versionEdition = true;
			isla_content_preview = false;
		}
		/*
		public function preShowIslaVersionEditor():void
		{
			this.nextSelected_index = 8;
			comprobarTransicionPantalla();
		}
		*/
		public function showIslaVersionEditor():void
		{
			flash.media.SoundMixer.stopAll();
			contentArea_edition_ask_for_name = false;
			content_editor1 = false;
			content_editor3 = false;
			content_editor4 = false;
			content_preview = false;
			isla_content_editor = true;
			versionEdition = false;
			this.selected_index = 8;
			isla_content_preview = false;
		}
		public function showContentAreaEditor():void
		{
			flash.media.SoundMixer.stopAll();
			trace("showContentAreaEditor: "+Base.getinstance().versionedition_selectedAreaContentType );
			if (Base.getinstance().versionedition_selectedAreaContentType == Base.getinstance().area1_type)
			{
				this.selected_index = 4;
				this.contentAreaEdition_hiderCanvas_visibile = false;
				content_editor1 = true;
				content_editor3 = false;
				content_editor4 = false;
				content_preview = false;
				isla_content_editor = false;
				isla_content_preview = false;
			}
			else if (Base.getinstance().versionedition_selectedAreaContentType == Base.getinstance().area3_type)
			{
				this.selected_index = 5;
				this.contentAreaEdition_hiderCanvas_visibile = false;
				content_editor3 = true;
				content_editor1 = false;
				content_editor4 = false;
				content_preview = false;
				isla_content_editor = false;
				isla_content_preview = false;
			}
			else if (Base.getinstance().versionedition_selectedAreaContentType == Base.getinstance().area4_type)
			{
				this.selected_index = 6;
				this.contentAreaEdition_hiderCanvas_visibile = false;
				content_editor3 = false;
				content_editor1 = false;
				content_editor4 = true;
				content_preview = false;
				isla_content_editor = false;
				isla_content_preview = false;
			}
			/*else if (Base.getinstance().versionedition_selectedAreaContentType == Base.getinstance().area_isla_type)
			{
				this.selected_index = 6;
				content_editor3 = false;
				content_editor1 = false;
				content_editor4 = false;
				content_preview = false;
				isla_content_editor = true;
				isla_content_preview = false;
			}
			*/
		}
		/*
		public function preShowVersionPreview():void
		{
			this.nextSelected_index = 7;
			comprobarTransicionPantalla();
		}
		*/
		public function showVersionPreview():void
		{
			//urko
			//new getVersionXMLEvent(getVersionXMLEvent.GET_VERSION_XML,Base.getinstance().user,Base.getinstance().detailedVersion.version).dispatch();
			flash.media.SoundMixer.stopAll();
			this.versionEdition_isEditSentido = false;
			this.versionEdition_selectedFloor = null;
			//this.getVersionStyleTemplates();//urko
			this.selected_index = 7;
			content_editor1 = false;
			content_editor3 = false;
			content_editor4 = false;
			content_preview = true;
			versionEdition = false;
			isla_content_editor = false;
			isla_content_preview = false;
			
			dispatchEvent(new BaseEvent(BaseEvent.SHOW_PREVIEW));
		}
		/*
		public function preShowIslaVersionPreview():void
		{
			this.nextSelected_index = 9;
			comprobarTransicionPantalla();
		}
		*/
		public function showIslaVersionPreview():void
		{
			//urko
			//new getVersionXMLEvent(getVersionXMLEvent.GET_VERSION_XML,Base.getinstance().user,Base.getinstance().detailedVersion.version).dispatch();
			flash.media.SoundMixer.stopAll();
			this.versionEdition_isEditSentido = false;
			this.versionEdition_selectedFloor = null;
			//this.getVersionStyleTemplates();//urko
			this.selected_index = 9;
			content_editor1 = false;
			content_editor3 = false;
			content_editor4 = false;
			content_preview = false;
			versionEdition = false;
			isla_content_editor = false;
			isla_content_preview = true;
		}
		
		//public function getResourceURL(resource_type:int = 0):void
		public function getResourceURL(resource_type:int = 0, previous_resource_url:String = "-1"):void
		{
			//var previous_resource_url_clean:String = previous_resource_url.split(Base.getinstance().backend_abs_url).join("");
			var previous_resource_url_clean:String = previous_resource_url;//.split(Base.getinstance().backend_abs_url).join("");
			trace("getResourceURL");
			trace("recibido [resource_type: "+resource_type+"][previous resource url: "+previous_resource_url_clean+"]");
			/*
			var resource:T_resource =  new T_resource();
			resource.id = 1;
			resource.name = "nombre_del_recurso";
			resource.url = "url_del_recurso";
			resource.type = 1;
			return resource;
			*/
			this.resources = new ArrayCollection();
			this.getResources(resource_type);
			this.oceEditor_requested_resource_type = resource_type;
			//if (resource_type
			if (int(previous_resource_url) < 0)
			{
				Base.getinstance().resourcesList_selectedResource_previous_resource = -1;
				Base.getinstance().resourcesList_selectedResource = new T_resource();
				Base.getinstance().resourcesList_selectedResource.id = -1;
				Base.getinstance().resourcesList_selectedResource.url = "assets/1px.png";
			}
			else
			{
				//Base.getinstance().resourcesList_selectedResource_previous_resource = previous_resource_url;
				//Base.getinstance().resourcesList_selectedResource.id = 0;
				Base.getinstance().resourcesList_selectedResource = new T_resource();
				Base.getinstance().resourcesList_selectedResource.url = previous_resource_url_clean;
			}
			//this.versionEdition_selectedArea_resource_selection_windows_visible = true;
		}
		
		public function returnWithoutSaving():void
		{
			if (Base.getinstance().isla_content_editor) 
			{ 
				showVersionMenu(); 
			}
			else if (Base.getinstance().versionEdition) 
			{
				showVersionEditorFromAreaEditor();
			}
			else if (!Base.getinstance().versionEdition_isGeneralEdition)
			{
				showVersionEditor();
			}
			else 
			{ 
				Base.getinstance().showGeneralAreaEditor(); 
			}
			this.content_editor1	 = false; 
			this.content_editor3	 = false;
			this.content_editor4	 = false;
			this.content_preview	 = false;
			this.isla_content_editor = false;
			this.isla_content_preview = false;
		}
		
		//public function saveContent(contentXML:String, resources:Array = null):void
		public function saveContent(contentXML:XML, resources:Array = null):void
		{
			trace("saveContent");
			trace("recibido ["+contentXML+"]["+resources.length+"]");
			//ver piso seleccionad y tipo de area
			//type
			//id
			//name
			//xml
			//
			Base.getinstance().contentAreaEdition_hiderCanvas_visibile = true;
			this.versionEdition_selectedAreaContent.xml = contentXML.toString();
			this.versionEdition_selectedAreaContent.resources = new ArrayCollection();
			/*
			for (var id:int = 0; id < resources.length; id++)
			{
				trace(".."+id+".."+Base.getinstance().resources.length);
				for (var id2:int = 0; id2 < Base.getinstance().resources.length; id2++)
				{
					trace(resources[id]+" ? "+Base.getinstance().resources[id2].url);
					if (Base.getinstance().resources[id2].url == resources[id])
					{
						this.versionEdition_selectedAreaContent.resources.addItem(Base.getinstance().resources[id2]);
						break;
					}
				}
			}
			*/
			
			if (resources.length > 0)
			{
				for each (var item:Object in resources)
				{
					var resource:T_resource = new T_resource();
					//resource.name = item.name;
					//resource.id = parseInt(item.toString());
					//Base.getinstance().backend_abs_url
					if (item != null)
					{
						resource.url = item.toString().split(Base.getinstance().backend_abs_url).join('');
						this.versionEdition_selectedAreaContent.resources.addItem(resource);
					}
				}
			}
			
			if (this.versionEdition_selectedAreaContent.resources.length == 1) { this.versionEdition_selectedAreaContent.resources.addItem(new T_resource()); }// Para evitar error de tipado en SOAP al intentar interpretar t_resource como array.
			
			//if (isla_content_editor)
			//{
			//	if (detailedVersionIsNew)
			//	{
			//		this.contentArea_edition_ask_for_name = true;
			//	}
			//	else
			//	{
			//		this.contentArea_edition_ask_for_name = true;
			//	}
			//}
			//else
			//{
				switch (this.versionEdition_selectedAreaContent_Op)
				{
					case this.area_content_new:
						//pedir nombre version
						this.contentArea_edition_ask_for_name = true;
						break;
					case this.area_content_new_from:
						//pedir nombre version
						this.contentArea_edition_ask_for_name = true;
						break;
					case this.area_content_modify:
						showVersionMenu();
						saveContentServer();
						break;
				}
			//}
		}
		
		public function saveContentServer():void
		{
			this.contentArea_edition_ask_for_name = false;
			new saveContentAreaEvent(saveContentAreaEvent.SAVE_CONTENT_AREA, this.user, this.versionEdition_selectedAreaContent).dispatch();
		}
		
		public function updateFloorDirectory():void
		{
			trace("updateFloorDirectory");
			var posicion_actual:int = 0;
			for (var i:int = this.detailedVersion.floordirectory.length; i!=0; i--)
			{
				(this.detailedVersion.floordirectory[i-1] as T_floor).position = posicion_actual;
				trace("pos_actual:"+posicion_actual+" "+(this.detailedVersion.floordirectory[i-1] as T_floor).name );
				posicion_actual++;
			}
			this.versionEdition_getSelectedFloorOfDirectory();
		}
		
		public function addFloor():void
		{
			// TODO Auto-generated method stub
			trace("addFloor");
			var newFloor:T_floor = new T_floor();
			newFloor.areas = new ArrayCollection();
			newFloor.name = "nuevo piso";
			this.detailedVersion.floordirectory.addItem(newFloor);
			this.versionEdition_isEditSentido = false;
			this.versionEdition_selectedUp_Stop_Down = Base.getinstance().sentido_null;
			this.versionEdition_selectedFloor = newFloor;
			updateFloorDirectory();
		}
		
		public function removeFloor():void
		{
			// TODO Auto-generated method stub
			trace("removeFloor");
			//var selectedFloors:Object = floorDirectory.selectedItems;
			//if (selectedFloors != null)
			//{
				var actualFloorDirectory:ArrayCollection = this.detailedVersion.floordirectory;
				var newFloorDirectory:ArrayCollection = new ArrayCollection();
				for each (var floor:T_floor in actualFloorDirectory)
				{
					//if (floor != selectedFloors[0]) { newFloorDirectory.addItem(floor); }
					if (floor != this.versionEdition_selectedFloor) { newFloorDirectory.addItem(floor); }
					else {trace("floor deleted"); }
				}
				this.detailedVersion.floordirectory = newFloorDirectory;
			//}
			updateFloorDirectory();
		}
		
		/*public function modifySelectedFloorShowFloorInfo(value:Boolean):void
		{
			this.versionEdition_selectedFloor.show_floor_info = String(value);
		}*/
		
		public function updateSelectedFloor():void
		{
			var existe_otro_piso_con_mismo_show_position:Boolean = false;
			var posicion_piso_repetido : int = -1;
			for (var i:int =0; i < this.detailedVersion.floordirectory.length; i++)
			{
				if ((this.detailedVersion.floordirectory.getItemAt(i) as T_floor).show_position == this.versionEdition_selectedFloor.show_position) 
				{ 
					if ((this.detailedVersion.floordirectory.getItemAt(i) as T_floor).position != this.versionEdition_selectedFloor.position)
					{
						existe_otro_piso_con_mismo_show_position = true;	
						posicion_piso_repetido = i;
						break;
					}
					
				}
			}
			
			if (existe_otro_piso_con_mismo_show_position)
			{
				
				////  añadido por iñaki 12-04-2013
				
				//eliminar el elemento actual de la lista de pisos (solo si estamos estamos añadiendo)
				/*trace("Eliminando elemento de la posicion : "+ String(this.versionEdition_piso_seleccionado_index));
				this.detailedVersion.floordirectory.removeItemAt(this.versionEdition_piso_seleccionado_index);
				//vaciar los datos del panel de edición de piso
				this.versionEdition_piso_seleccionado = false;*/
				
				//en vez de eliminarlo mejor guardarlo con showposition vacía?
				if(posicion_piso_repetido != this.versionEdition_piso_seleccionado_index && this.versionEdition_selectedFloor.show_position != "")//estamos añadiendo un segundo piso con el mismo showposition
				{
					Alert.show(this.i18n_txt.getValue("exists_floor_with_same_show_position_text"),this.i18n_txt.getValue("exists_floor_with_same_show_position_title"), Alert.OK);
					this.versionEdition_selectedFloor.show_position = "";	
				}
				
			}
			else
			{
				for (var j:int =0; j < this.detailedVersion.floordirectory.length; j++)
				{
					if ((this.detailedVersion.floordirectory.getItemAt(j) as T_floor).position == this.versionEdition_selectedFloor.position) 
					{ 
						trace("Selected Floor values updated.");this.detailedVersion.floordirectory.setItemAt(this.versionEdition_selectedFloor, j); 
					}
				}
			}
		}
		
		public function selectedDirectoryStyle():void
		{
			this.detailedVersion.directory_style = this.versionEdition_preselectedDirectoryStyle;
			this.versionEdition_preselectedDirectoryStyle = new T_directory_style();
			trace("selectedDirectoryStyle: "+this.detailedVersion.directory_style.id + " - "+this.detailedVersion.directory_style.name);
		}
		
		public function saveVersionStyle():void
		{
			var asdf:T_version_style = this.versionEdition_selectedVersionStyle;
			new saveVersionStyleTemplatesEvent(saveVersionStyleTemplatesEvent.SAVE_VERSION_STYLE_TEMPLATES, this.user, this.versionEdition_selectedVersionStyle).dispatch();
		}
		
		public function deleteVersionStyle():void
		{
			new removeVersionStyleEvent(removeVersionStyleEvent.REMOVE_VERSION_STYLE, this.user, this.versionEdition_selectedVersionStyle).dispatch();
		}
		
		public function setVersionStyle():void
		{
			Base.getinstance().detailedVersion.version_style = Base.getinstance().versionEdition_selectedVersionStyle;
		}
		
		public function saveDetailedVersion():void
		{
			new saveDetailedVersionEvent(saveDetailedVersionEvent.SAVE_DETAILED_VERSION, this.user, this.detailedVersion, this.detailedVersionIsNew).dispatch();
		}

		public function editWay(sentido:int):void
		{
			if (sentido == this.sentido_up)
			{
				this.versionEdition_isEditSentidoLabel = "Editando sentido ascendente.";
			}
			else if (sentido == this.sentido_down)
			{
				this.versionEdition_isEditSentidoLabel = "Editando sentido descendiente.";
			}
			this.versionEdition_isEditSentido = true;
			this.versionEdition_selectedUp_Stop_Down = sentido;
		}
		
		public function versionEdition_getSelectedFloorOfDirectory():void
		{
			var posicion_actual:int = -1;
			Base.getinstance().versionEdition_piso_seleccionado= false;
			for (var i:int = 0; i<Base.getinstance().detailedVersion.floordirectory.length; i++)
			{
				if ((Base.getinstance().detailedVersion.floordirectory[i] as T_floor) == Base.getinstance().versionEdition_selectedFloor)
				{
					posicion_actual = i;
					Base.getinstance().versionEdition_piso_seleccionado = true;
				}
			}
			Base.getinstance().versionEdition_piso_seleccionado_index = posicion_actual;
			trace("piso seleccionado["+Base.getinstance().versionEdition_piso_seleccionado+"]: "+Base.getinstance().versionEdition_piso_seleccionado_index);
		}
		
		public function versionMenu_getSelectedVersion():void
		{
			var posicion_actual:int = -1;
			Base.getinstance().versionEdition_piso_seleccionado= false;
			if (Base.getinstance().versionMenu_selectedVersion != null)
			{
				for (var i:int = 0; i<Base.getinstance().versionesVDAP.length; i++)
				{
					trace(i+" - "+(Base.getinstance().versionesVDAP[i] as T_version).id + " - "+(Base.getinstance().versionesVDAP[i] as T_version).name);
					if ((Base.getinstance().versionesVDAP[i] as T_version).id == Base.getinstance().versionMenu_selectedVersion.id)
					{
						//trace(i+" - "+(Base.getinstance().versiones[i] as T_version).id + " - "+(Base.getinstance().versiones[i] as T_version).name);
						posicion_actual = 0+i;
						break;
	
					}
				}
			}
			trace("selected index: "+Base.getinstance().versionMenu_selectedVersion_index+" - posicion actual: "+posicion_actual);
			Base.getinstance().versionMenu_selectedVersion_index = posicion_actual;
		}
		
		public function checkVersionNameNoDuplicated(name:String):Boolean
		{
			for each (var version:T_version in this.versiones)
			{
				if (version.name == name) return false;
			}
			return true;
		}
		
		public function checkContentAreaEditionNameNoDuplicated(name:String):Boolean
		{
			for each (var area:T_area in this.areas)
			{
				if (area.name == name) return false;
			}
			return true;
		}
		
		public function bloquearInteraccionEnviandoRecurso():void
		{
			this.sendingResource=true;
			stopActivityTimer();
		}
		
		public function desbloquearInteraccion():void
		{
			this.sendingResource=false;
			startActivityTimer();
		}
		
		
	}
}