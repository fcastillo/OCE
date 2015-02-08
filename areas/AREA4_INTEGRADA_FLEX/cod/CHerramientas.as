package cod
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class CHerramientas extends CElementoBase
	{
		private var myTooltip:CTooltip;
		
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CHerramientas(aita:MovieClip) 
		{
			super(aita);
		}

		///<summary>
		///Inicializa el panel de herramientas y llama a cargarListeners()
		///</summary>
		override public function load():int
		{
			this.x = getXpos();
			this.y = getYpos();
			
			cargarListeners();
			return 0;
		}
		
		///<summary>
		///Define los event listeners para los botones
		///</summary>
		private function cargarListeners()
		{
			texto.addEventListener(MouseEvent.CLICK, onClick);
			imagen.addEventListener(MouseEvent.CLICK, onClick);
			video.addEventListener(MouseEvent.CLICK, onClick);
			swf.addEventListener(MouseEvent.CLICK, onClick);
			tiempo.addEventListener(MouseEvent.CLICK, onClick);
			rss.addEventListener(MouseEvent.CLICK, onClick);
			ticker.addEventListener(MouseEvent.CLICK, onClick);
			pasafotos.addEventListener(MouseEvent.CLICK, onClick);
			anuncio.addEventListener(MouseEvent.CLICK, onClick);
			menu.addEventListener(MouseEvent.CLICK, onClick);
			reloj.addEventListener(MouseEvent.CLICK, onClick);
			
			//-----------------------------TOOLTIP-----------------------------//
			texto.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver );
			imagen.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver );
			video.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver );
			swf.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver );
			tiempo.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver );
			rss.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver );
			ticker.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver );
			pasafotos.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver );
			anuncio.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver );
			menu.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver );
			reloj.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver );
			
			texto.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut );
			imagen.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut );
			video.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut );
			swf.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut );
			tiempo.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut );
			rss.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut );
			ticker.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut );
			pasafotos.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut );
			anuncio.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut );
			menu.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut );
			reloj.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut );
			
			myTooltip = new CTooltip(this);
			myTooltip.load();
			myTooltip.setTooltipAlign("right");
			myTooltip.setAutoSize(true);
			//-------------------------------------------------------------------//
		}
		
		///<summary>
		///Llama al padre para insertar un elemento en el lienzo del tipo definido por 
		///el botón pulsado
		///</summary>
		function onClick (e:MouseEvent)
		{
			//Márgenes para centrar el elemento
			var margen_izda = Math.round((getPadre().lienzo.width - 200)/2);
			var margen_arriba = Math.round((getPadre().lienzo.contenedor.height - 150)/2);
			
			//Guardamos en el padre el tipo de elemento seleccionado
			getPadre().setTipoElemento(e.currentTarget.name);
			if(e.currentTarget.name != "ticker")
			{
				getPadre().getPanelPropiedades().btnRelacion.selected = false;
				getPadre().getPanelPropiedades().btnRelacion.alpha = 0.5;
				getPadre().getPanelPropiedades().btnRelacion.enabled = false;
			}
			else if( e.currentTarget.name != "imagen" && e.currentTarget.name != "rss" && e.currentTarget.name != "texto" )
			{
				trace("DESHABILITAR CHECKBOX!");
				getPadre().getPanelPropiedades().btnRelacion.alpha = 0.5;
				getPadre().getPanelPropiedades().btnRelacion.enabled = false;
			}
			else
			{
				trace("HABILITAR CHECKBOX!");
				getPadre().getPanelPropiedades().btnRelacion.alpha = 1.0;
				getPadre().getPanelPropiedades().btnRelacion.enabled = true;
			}
			
			//Desactivamos los elementos que pudieran estar seleccionados
			getPadre().desactivarAnterior();
			getPadre().desactivarContenedorMultiseleccion();
			
			//Si insertamos un elemento de tipo pasafotos o menú lo colocamos en (0,0)
			if ((e.currentTarget.name == "pasafotos") || (e.currentTarget.name == "menu")) 
			{
				getPadre().insertarElemento(0,0);
			}
			else getPadre().insertarElemento(margen_izda,margen_arriba);
		}
		
		/******************************************Tooltip******************************************/
		///<summary>
		///Muestra el tooltip
		///</summary>
		private function onMouseOver( e:MouseEvent ):void 
		{
			switch(e.currentTarget.name)
			{
				case "swf": myTooltip.getTip().show( swf, "Animaciones","Archivos SWF(Shockwave Flash)"); break;
				case "texto": myTooltip.getTip().show( texto, "Texto","Editor de textos"); break;
				case "imagen": myTooltip.getTip().show( imagen, "Gráficos","Imágenes jpg,png..."); break;
				case "video": myTooltip.getTip().show( video, "Vídeos","Vídeos en formato flv,mov,mp4..."); break;
				case "tiempo": myTooltip.getTip().show( tiempo, "Tiempo","Información meteorológica"); break;
				case "rss": myTooltip.getTip().show( rss, "RSS","Conexión dinámica a RSS"); break;
				case "ticker": myTooltip.getTip().show( ticker, "Ticker","Texto informativo"); break;
				case "pasafotos": myTooltip.getTip().show( pasafotos, "Pasafotos","Pasafotos formado por imágenes"); break;
				case "anuncio": myTooltip.getTip().show( anuncio, "Publicidad","Contenido publicitario"); break;
				case "menu": myTooltip.getTip().show( menu, "Menú","Menús pre-diseñados"); break;
				case "reloj": myTooltip.getTip().show( reloj, "Reloj","Hora en formato analógico/digital"); break;
				default:break;
			}
		}
		
		///<summary>
		///Elimina el tooltip
		///</summary>
		private function onMouseOut (e:MouseEvent)
		{
			if (myTooltip.getTip() != null) myTooltip.getTip().hide();
		}
		/******************************************************************************************************/

	}
	
}
