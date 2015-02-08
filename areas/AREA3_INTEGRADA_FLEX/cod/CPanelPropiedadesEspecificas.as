package cod
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import fl.controls.ScrollBar;
	import fl.events.ScrollEvent;
	
	import com.greensock.*;
	import fl.motion.easing.*;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	
	public class CPanelPropiedadesEspecificas extends CElementoBase
	{
		//VARIABLES
		
		//Paneles
		private var panel_texto:CTextEditor;
		private var panel_video:CPanelVideo;
		private var panel_ticker:CTickerEditor;
		private var panel_tiempo:CPanelTiempo_extendido;
		private var panel_rss:CRSSEditor_extendido;
		private var panel_pasafotos:CPanelPasafotos;
		private var panel_menu:CControlMenuEditor;
		private var panel_reloj:CPanelReloj_extendido;
		
		//Variables scroll		
		var sb:ScrollBar;
		var mcMask:MovieMaskMC;
		
		//*****************************GETTERS/SETTERS************************************/
		public function getPanelTexto():CTextEditor {return panel_texto;}
		public function getPanelVideo():CPanelVideo {return panel_video;}
		public function getPanelTicker():CTickerEditor {return panel_ticker;}
		public function getPanelTiempo():CPanelTiempo_extendido {return panel_tiempo;}
		public function getPanelRSS():CRSSEditor_extendido {return panel_rss;}
		public function getPanelPasafotos():CPanelPasafotos {return panel_pasafotos;}
		public function getPanelMenu():CControlMenuEditor {return panel_menu;}
		public function getPanelReloj():CPanelReloj_extendido {return panel_reloj;}
		
		public function setPanelTexto(val:CTextEditor):void {panel_texto = val;}
		public function setPanelVideo(val:CPanelVideo):void {panel_video = val;}
		public function setPanelTicker(val:CTickerEditor):void {panel_ticker = val;}
		public function setPanelTiempo(val:CPanelTiempo_extendido):void {panel_tiempo = val;}
		public function setPanelRSS(val:CRSSEditor_extendido):void {panel_rss = val;}
		public function setPanelPasafotos(val:CPanelPasafotos):void {panel_pasafotos = val;}
		public function setPanelMenu(val:CControlMenuEditor):void {panel_menu = val;}
		public function setPanelReloj(val:CPanelReloj_extendido):void {panel_reloj = val;}
		//********************************************************************************/
		
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CPanelPropiedadesEspecificas(aita:MovieClip) 
		{
			super(aita);
		}
		
		///<summary>
		///Inicializa el panel de propiedades
		///</summary>
		override public function load():int
		{
			this.x = getXpos();
			this.y = getYpos();
						
			return 0;
		}

		///<summary>
		///Carga el panel correspondiente al elemento activo en el lienzo
		///</summary>
		public function cargarPanel():void
		{
			switch (this.getTipo())
			{
				case "texto":
					cargarPanelTexto();
					break;
				case "imagen":
					break;
				case "video":
					cargarPanelVideo();
					break;
				case "swf":
					break;
				case "tiempo":
					cargarPanelTiempo();
					break;
				case "rss":
					cargarPanelRSS();
					break;
				case "ticker":
					cargarPanelTicker();
					break;
				case "pasafotos":
					cargarPanelPasafotos();
					break;
				case "anuncio":
					break;
				case "menu":
					cargarPanelMenu();
					break;
				case "reloj":
					cargarPanelReloj();
					break;
			}
		}
		
		///<summary>
		///Descarga el panel que esté en escena en ese momento
		///</summary>
		public function descargarPanel():void
		{
			switch (this.getTipo())
			{
				case "texto":
					descargarPanelTexto();
					break;
				case "imagen":
					break;
				case "video":
					descargarPanelVideo();
					break;
				case "swf":
					break;
				case "tiempo":
					descargarPanelTiempo();
					break;
				case "rss":
					descargarPanelRSS();
					break;
				case "ticker":
					descargarPanelTicker();
					break;
				case "pasafotos":
					descargarPanelPasafotos();
					break;
				case "anuncio":
					break;
				case "menu":
					descargarPanelMenu();
					break;
				case "reloj":
					descargarPanelReloj();
					break;
			}
			descargarHijos(); //Revisamos si se ha quedado algún panel, y lo eliminamos
		}
		
		///<summary>
		///Carga el panel del elemento texto
		///</summary>
		function cargarPanelTexto():void
		{
			panel_texto = new CTextEditor(this);
			panel_texto.x = 0;
			panel_texto.y = 0;
			panel_texto.visible = true;
			panel_texto.init();
			contenedor.addChild(panel_texto);
			
			//Le pasamos al panel que edita el texto la instancia a la caja de texto - setMainText
			if ((getPadre().elemento_seleccionado != null) && (getPadre().elemento_seleccionado.texto != null))
			{
				panel_texto.setMainText(getPadre().elemento_seleccionado.texto);
			}
			
			//Actualiza el panel con las características del texto
			panel_texto.actualizarEditor();
		}
		
		///<summary>
		///Descarga el panel del elemento texto
		///</summary>
		function descargarPanelTexto():void
		{
			if (panel_texto != null)
			{
				contenedor.removeChild(panel_texto);
				panel_texto == null;
				this.setTipo("");
			}
		}
		
		///<summary>
		///Carga el panel del elemento video
		///</summary>
		function cargarPanelVideo():void
		{
			panel_video = new CPanelVideo(this);
			panel_video.x = 0;
			panel_video.y = 0;
			panel_video.visible = true;
			panel_video.load();
			contenedor.addChild(panel_video);
			
			//Actualizamos el estado de los botones
			if ((getPadre().elemento_seleccionado != null) && (getPadre().elemento_seleccionado.getVideo() != null))
			{
				if (getPadre().elemento_seleccionado.getVideo().getVideoPlaying())
				{
					panel_video.btnPlay.gotoAndStop(2);
					panel_video.btnPause.gotoAndStop(1);
				}
				else
				{
					panel_video.btnPlay.gotoAndStop(1);
					panel_video.btnPause.gotoAndStop(2);
				}
				
				if (getPadre().elemento_seleccionado.getVideo().getVideoMuted()) panel_video.checkMute.selected = true;
				else panel_video.checkMute.selected = false;
				
				if (getPadre().elemento_seleccionado.getVideo().getBucle())  panel_video.checkBucle.selected = true;
				else  panel_video.checkBucle.selected = false;
			}
		}
		
		///<summary>
		///Descarga el panel del elemento video
		///</summary>
		function descargarPanelVideo():void
		{
			if (panel_video != null)
			{
				contenedor.removeChild(panel_video);
				panel_video == null;
				this.setTipo("");
			}
		}
		
		///<summary>
		///Carga el panel del elemento ticker
		///</summary>
		function cargarPanelTicker():void
		{
			//TextEditor
			panel_ticker = new CTickerEditor(this);
			panel_ticker.x = 0;
			panel_ticker.y = 0;
			panel_ticker.visible = true;
			panel_ticker.load();
			contenedor.addChild(panel_ticker);
			
			//Le pasamos al panel que edita el texto del ticker la instancia a la caja de texto - setTextoTicker
			if ((getPadre().elemento_seleccionado != null) && (getPadre().elemento_seleccionado.texto_ticker != null))
			{
				panel_ticker.setTextoTicker(getPadre().elemento_seleccionado.texto_ticker);
				panel_ticker.actualizarEditor();
			}
		}
		
		///<summary>
		///Descarga el panel del elemento ticker
		///</summary>
		function descargarPanelTicker():void
		{
			if (panel_ticker != null)
			{
				contenedor.removeChild(panel_ticker);
				panel_ticker == null;
				this.setTipo("");
			}
		}
		
		///<summary>
		///Carga el panel del elemento tiempo
		///</summary>
		function cargarPanelTiempo():void
		{
			panel_tiempo = new CPanelTiempo_extendido(this);
			panel_tiempo.x = 0;
			panel_tiempo.y = 0;
			panel_tiempo.visible = true;
			panel_tiempo.load();
			contenedor.addChild(panel_tiempo);
			if ((getPadre().elemento_seleccionado != null) && (getPadre().elemento_seleccionado.lector_tiempo != null))
			{
				panel_tiempo.actualizarEditor();
			}
		}
		
		///<summary>
		///Descarga el panel del elemento tiempo
		///</summary>
		function descargarPanelTiempo():void
		{
			if (panel_tiempo != null)
			{
				if(contenedor.contains(panel_tiempo)) contenedor.removeChild(panel_tiempo);
				panel_tiempo == null;
				this.setTipo("");
			}
		}
		
		///<summary>
		///Carga el panel del elemento rss
		///</summary>
		function cargarPanelRSS():void
		{
			panel_rss = new CRSSEditor_extendido(this);
			panel_rss.x = 0;
			panel_rss.y = 0;
			panel_rss.visible = true;
			panel_rss.load();
			contenedor.addChild(panel_rss);
			
			if (getPadre().elemento_seleccionado != null)
			{
				panel_rss.actualizarEditor();
			}
		}
		
		///<summary>
		///Descarga el panel del elemento rss
		///</summary>
		function descargarPanelRSS():void
		{
			if (panel_rss != null)
			{
				contenedor.removeChild(panel_rss);
				panel_rss == null;
				this.setTipo("");
			}
		}
		
		///<summary>
		///Carga el panel del elemento pasafotos
		///</summary>
		function cargarPanelPasafotos():void
		{
			panel_pasafotos = new CPanelPasafotos(this);
			panel_pasafotos.x = 0;
			panel_pasafotos.y = 0;
			panel_pasafotos.visible = true;
			panel_pasafotos.load();
			contenedor.addChild(panel_pasafotos);
			
			if (getPadre().elemento_seleccionado != null)
			{
				panel_pasafotos.llenarComboImagenes(); //Cargamos el combo con los nombres de las fotos
				panel_pasafotos.mostrarValores(); //Actualizamos el panel de edición del pasafotos
			}
		}
		
		///<summary>
		///Descarga el panel del elemento pasafotos
		///</summary>
		function descargarPanelPasafotos():void
		{
			if (panel_pasafotos != null)
			{
				contenedor.removeChild(panel_pasafotos);
				panel_pasafotos == null;
				this.setTipo("");
			}
		}
		
		///<summary>
		///Carga el panel del elemento menú
		///</summary>
		function cargarPanelMenu():void
		{
			panel_menu = new CControlMenuEditor(this);
			panel_menu.x = 0;
			panel_menu.y = -1;
			panel_menu.visible = true;
			panel_menu.load();

			contenedor.fondo.addChild(panel_menu);
						
			activarScroll(); //Es el único panel que necesita scroll
						
			if ((getPadre().elemento_seleccionado != null) && (getPadre().elemento_seleccionado.control_menu != null))
			{
				panel_menu.actualizarEditor();
			}
			
		}
		
		///<summary>
		///Descarga el panel del elemento menú
		///</summary>
		function descargarPanelMenu():void
		{
			if (panel_menu != null)
			{
				contenedor.fondo.removeChild(panel_menu);
				desactivarScroll();
				panel_menu == null;
				this.setTipo("");
			}
		}
		
		///<summary>
		///Carga el panel del elemento reloj
		///</summary>
		function cargarPanelReloj():void
		{
			panel_reloj = new CPanelReloj_extendido(this);
			panel_reloj.x = 0;
			panel_reloj.y = -1;
			panel_reloj.visible = true;
			panel_reloj.load();

			contenedor.addChild(panel_reloj);
			
			if ((getPadre().elemento_seleccionado != null) && (getPadre().elemento_seleccionado.control_reloj != null))
			{
				panel_reloj.actualizarPanel();
			}
		}
		
		///<summary>
		///Descarga el panel del elemento reloj
		///</summary>
		function descargarPanelReloj():void
		{
			if (panel_reloj != null)
			{
				contenedor.removeChild(panel_reloj);
				panel_reloj == null;
				this.setTipo("");
			}
		}
		
		///<summary>
		///Descarga cualquier panel 
		///		-> Hay ocasiones en las que se quedan 2 paneles, uno encima de otro, y no mantenemos
		///		   la referencia al panel que se ha quedado por debajo. Con esta función eliminamos todo.
		///</summary>
		function descargarHijos():void
		{
			for (var i:int = 0; i<contenedor.numChildren; i++)
			{
				if(contenedor.getChildAt(i).name != "fondo")
				{
					contenedor.removeChildAt(i);
					i=0;
				}
			}
		}
		
		/********************************** SCROLL ************************************/
		///<summary>
		///Función que inserta un scroll para poder ver la totalidad del panel de edición del elemento menú
		///</summary>
		public function activarScroll()
		{			
			mcMask = new MovieMaskMC();
			mcMask.x = 0;
			mcMask.y = 24,45;
									
			sb = new ScrollBar();
			sb.x = 472;
			sb.y = 25;
			sb.height = mcMask.height;
			sb.enabled = true;
			sb.setScrollProperties(mcMask.height, 0, (panel_menu.height-mcMask.height + 40));
			sb.addEventListener(ScrollEvent.SCROLL, scrollPanel);

			addChild(sb);
		}
		
		///<summary>
		///Event listener que coloca el panel según el scroll
		///</summary>
		function scrollPanel(e:ScrollEvent):void
		{
			panel_menu.y = -e.position;
		}
		
		///<summary>
		///Función que elimina el scroll
		///</summary>
		public function desactivarScroll()
		{
			sb.removeEventListener(ScrollEvent.SCROLL, scrollPanel);
			removeChild(sb);
		}
		/**************************************************************************/
	}
	
}
