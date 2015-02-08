package  cod
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import fl.motion.Color;
	
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	
	import flash.text.*;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	import cod.*;
	import com.innovae.oce.domain.datamodel.resourceReceivedEvent;
	
	public class CContenedorElemento extends CElementoBase
	{
		//----VARIABLES
		public var estado:int = 0; //0: Editando versión en blanco
								   //1: Cargando versión existente para seguir editando
		
		//Propiedades
		public var ID:int = -1;
		private var IDRecurso : int = -1;
		private var centro_x:Number;
		private var centro_y:Number;		
		private var candado:Boolean = false;
		
		//Fondo
		public var imagen_fondo;
		
		//Variables según el tipo de elemento
		var seleccionado:int; //Texto
		public var texto:TextField;
		private var video:CElementoVideo; //Video
		public var bucle:Boolean = true;
		
		//SWF
		var raw:URLLoader;
		var swfLoader:Loader;
		
		//Ticker
		public var texto_ticker:TextField; 
		public var velocidad_ticker:Number;
		private var negrita_ticker:Boolean = false;
		private var cursiva_ticker:Boolean = false;
		private var subrayado_ticker:Boolean = false;
		private var fuente_ticker:String = "Arial";
		private var color_ticker:uint = 0x000000;
		private var alineacion_ticker:String = "Center";
		private var size_ticker:int = 30;
		
		//Elemento Tiempo
		public var lector_tiempo:CElementoTiempo;		//Controlador del elemento tiempo
		public var cambiandoDeTipo:Boolean = false;
		public var dia:String = "Hoy"; 
		public var pais:String = "España"; 
		public var cod_ciudad:String = "SPXX0087";
		public var estilo_tiempo:String = "cartoon";
		public var tipo_tiempo:String = "vertical";
		public var pos_aux:String;
		private var posicion_textos:String = "Arriba";
		private var fecha_formato:String = "dd/mm";
		private var fecha_fuente:String = "Arial";
		private var fecha_color:uint = 0x5D5D5D;
		private var fecha_negrita:Boolean = true;
		private var fecha_cursiva:Boolean = false;
		private var fecha_subrayado:Boolean = false;
		private var temp_fuente:String = "Arial";
		private var temp_color:uint = 0x5D5D5D;
		private var temp_negrita:Boolean = true;
		private var temp_cursiva:Boolean = false;
		private var temp_subrayado:Boolean = false;	
						
		//Pasafotos
		private var arrayPasafotos:Array = new Array();
		private var arrayIDsPasafotos:Array = new Array();
		private var arrayNombresPasafotos:Array = new Array();
		private var sentido:String = "Ninguno";
		private var direccion:String = "toIzda";
		private var efecto:String = "easeOutSine";
		private var tiempo_timer:int = 5000;
		private var velocidad_transicion:Number = 1;
		
		//Control especial menu
		public var control_menu:CElementoControlMenu; 			//Controlador del elemento menú
		public var nombreEstilo:String = "Ninguno";	//Estilo y fondo
		public var fondo_url:String = "";
		public var fondoMenu_ID:String = "";
		public var fondo_color:String = "0xffffff";
		public var existe_fondo:Boolean = false;
		public var hayColorFondo:Boolean = false;
		public var cabecera_txt:String = "CABECERA";	//Contenido textos
		public var tituloP_txt:String = "TÍTULO PRINCIPAL\nMENÚ DE FIN DE SEMANA";
		public var titulo1_txt:String = "Entrantes - Título 1";
		public var titulo2_txt:String = "Plato principal - Título 2";
		public var titulo3_txt:String = "Postre - Título 3";
		public var texto1_txt:String = "Plato1\nPlato 2\nPlato 3\nPlato 4\nPlato 5\nPlato 6";
		public var texto2_txt:String = "Plato1\nPlato 2\nPlato 3\nPlato 4\nPlato 5\nPlato 6";
		public var texto3_txt:String = "Plato1\nPlato 2\nPlato 3\nPlato 4\nPlato 5\nPlato 6";
		public var pie_txt:String = "PIE";
		public var cabecera_visible:Boolean = true;	//Visibilidad
		public var tituloP_visible:Boolean = true;
		public var titulo1_visible:Boolean = true;
		public var titulo2_visible:Boolean = true;
		public var titulo3_visible:Boolean = true;
		public var texto1_visible:Boolean = true;
		public var texto2_visible:Boolean = true;
		public var texto3_visible:Boolean = true;
		public var pie_visible:Boolean = true;
		public var formato_cabecera:TextFormat;		//Formatos
		public var formato_tituloP:TextFormat;
		public var formato_titulo1:TextFormat;
		public var formato_titulo2:TextFormat;
		public var formato_titulo3:TextFormat;
		public var formato_texto1:TextFormat;
		public var formato_texto2:TextFormat;
		public var formato_texto3:TextFormat;
		public var formato_pie:TextFormat;
		
		//Control reloj
		public var control_reloj:CElementoReloj_extendido; 
		public var url_reloj:String = "reloj_analog_v2.swf";
		public var tipo_reloj:String = "Analogico";	
		public var color_agujas:uint = 0x000000; 
		public var alpha_agujas:Number = 1;
		public var color_marcas:uint = 0x000000; 
		public var alpha_marcas:Number = 1;
		public var color_sombra:uint = 0xC6C6C6;
		public var alpha_sombra:Number = Number(0.28);
		public var color_fondo:uint = 0xffffff;
		public var alpha_fondo:Number = 1;
		public var color_marco:uint = 0x000000;
		public var alpha_marco:Number = 1;
		public var color_remarco:uint = 0xC6C6C6;
		public var alpha_remarco:Number = Number(0.28);
		public var color_numeros:uint = 0x000000;
		public var alpha_numeros:Number = 1;
		public var color_mes:uint = 0xCCCCCC;
		public var color_dia:uint = 0xCCCCCC;
		public var color_numDia:uint = 0x999999;
		public var alpha_mes:Number = 1;
		public var alpha_dia:Number = 1;
		public var alpha_numDia:Number = 1;
		
		//RSS
		public var rss_url:String = "http://feeds.bbci.co.uk/news/world/rss.xml";
		public var lector_rss:CElementoRSS_extendido;			//Controlador del elemento RSS
		public var elementoFondoRSS;
		public var loaderRSS:Loader;
		public var estilo_rss:String = "estilo1";
		public var tiempo_trans_rss:int = 15;
		public var velocidad_rss:int = 100;
		public var velocidad_titulo:int = 12;
		public var tituloActivo:Boolean = false;
		public var imagenVisible:Boolean = true;
		public var color_sup:uint = 0x004566;
		public var alpha_superior:Number = 1;
		public var color_inf:uint = 0x5F7D00;
		public var alpha_inferior:Number = 1;
		public var fuente_titulo:String = "Times New Roman";
		public var fuente_texto:String = "Arial";
		public var size_titulo:int = 18;
		public var size_texto:int = 12;
		public var color_titulo:uint = 0xffffff;
		public var color_texto:uint = 0xffffff;
		public var align_titulo:String = "left";
		public var align_texto:String = "left";
		public var negrita_titulo:Boolean = false;
		public var negrita_texto:Boolean = false;
		public var cursiva_titulo:Boolean = false;
		public var cursiva_texto:Boolean = false;
		public var subrayado_titulo:Boolean = false;
		public var subrayado_texto:Boolean = false;
		
		//Pestaña
		public var pestaña:CBotoneraInferior; //Botones para abrir la biblioteca de recursos o eliminar el elemento
		
		//Controladores de tamaño
		var controlador_activo:MovieClip;
		var boton_pulsado:String;
		var x_init:Number;
		var y_init:Number;
		var x0:Number;
		var y0:Number;
		
		//----FIN VARIABLES
		
		/**************************GETTERS/SETTERS*********************************/
		public function getID():int {return ID;}
		public function getIDRecurso():int {return IDRecurso;}
		public function getCentroX():Number {return centro_x;}
		public function getCentroY():Number {return centro_y;}
		public function getCandado():Boolean {return candado;}
		public function getVideo():CElementoVideo {return video;}
		public function getBucle():Boolean {return bucle;}
		public function getArrayPasafotos():Array {return arrayPasafotos;}
		public function getArrayIDsPasafotos():Array {return arrayIDsPasafotos;}
		public function getArrayNombresPasafotos():Array {return arrayNombresPasafotos;}
		public function getSentidoPasafotos():String {return sentido;}
		public function getDireccionPasafotos():String {return direccion;}
		public function getEfectoPasafotos():String {return efecto;}
		public function getTimerPasafotos():int {return tiempo_timer;}
		public function getVelocidadTransicion():int {return velocidad_transicion;}
		public function getTexto():TextField {return texto;}
		public function getTextoTicker():TextField {return texto_ticker;}
		public function getVelocidadTicker():Number {return velocidad_ticker;}
		public function getDia():String {return dia;}
		public function getCiudad():String {return cod_ciudad;}
		public function getEstiloTiempo():String {return estilo_tiempo;}
		public function getRSSUrl():String {return rss_url;}
		public function getPosicionTextos():String {return posicion_textos;}
		public function getFormatoFecha():String {return fecha_formato;}
		public function getNegritaFecha():Boolean {return fecha_negrita;}
		public function getCursivaFecha():Boolean {return fecha_cursiva;}
		public function getSubrayadoFecha():Boolean {return fecha_subrayado;}
		public function getColorFecha():uint {return fecha_color;}
		public function getFuenteFecha():String {return fecha_fuente;}
		public function getNegritaTemp():Boolean {return temp_negrita;}
		public function getCursivaTemp():Boolean {return temp_cursiva;}
		public function getSubrayadoTemp():Boolean {return temp_subrayado;}
		public function getColorTemp():uint {return temp_color;}
		public function getFuenteTemp():String {return temp_fuente;}
		public function getNegritaTicker():Boolean {return negrita_ticker;}
		public function getCursivaTicker():Boolean {return cursiva_ticker;}
		public function getSubrayadoTicker():Boolean {return subrayado_ticker;}
		public function getFuenteTicker():String {return fuente_ticker;}
		public function getColorTicker():uint {return color_ticker;}
		public function getAlineacionTicker():String {return alineacion_ticker;}
		public function getSizeTicker():int {return size_ticker;}
						
		public function setID(val:int) 
		{
			trace("Modificando la ID = "+val);
			ID = val;
		}
		public function setIDRecurso(val:int) 
		{
			trace("Modificando la ID de Recurso = "+val);
			IDRecurso = val;
		}
		public function setCentroX(val:Number) {centro_x = val;}
		public function setCentroY(val:Number) {centro_y = val;}
		public function setCandado(val:Boolean) 
		{
			if(this.getTipo() == "analog" || this.getTipo() == "digital"){candado = true;} 
			else{candado = val;}
		}
		public function setVideo(val:CElementoVideo) {video = val;}
		public function setBucle(val:Boolean) {bucle = val;}
		public function setArrayPasafotos(val:Array) {arrayPasafotos = val;}
		public function setArrayIDsPasafotos(val:Array) {arrayIDsPasafotos = val;}
		public function setArrayNombresPasafotos(val:Array) {arrayNombresPasafotos = val;}
		public function setSentidoPasafotos(val:String) {sentido = val;}
		public function setDireccionPasafotos(val:String) {direccion = val;}
		public function setEfectoPasafotos(val:String) {efecto = val;}
		public function setTimerPasafotos(val:int) {tiempo_timer = val;}
		public function setVelocidadTransicion(val:Number) {velocidad_transicion = val;}
		public function setTexto(val:TextField) {texto = val;}
		public function setTextoTicker(val:TextField) {texto_ticker = val;}
		public function setVelocidadTicker(val:Number) {velocidad_ticker = val;}
		public function setDia(val:String) {dia = val;}
		public function setCiudad(val:String) {cod_ciudad = val;}
		public function setEstiloTiempo(val:String) {estilo_tiempo = val;}
		public function setRSSUrl(val:String) {rss_url = val;}
		public function setPosicionTextos(val:String) {posicion_textos = val;}
		public function setFormatoFecha(val:String) {fecha_formato = val;}
		public function setNegritaFecha(val:Boolean) {fecha_negrita = val;}
		public function setCursivaFecha(val:Boolean) {fecha_cursiva = val;}
		public function setSubrayadoFecha(val:Boolean) {fecha_subrayado = val;  trace("cambiando fecha_subrayado a = ", val);}
		public function setColorFecha(val:uint) {fecha_color = val;}
		public function setFuenteFecha(val:String) {fecha_fuente = val;}
		public function setNegritaTemp(val:Boolean) {temp_negrita = val;}
		public function setCursivaTemp(val:Boolean) {temp_cursiva = val;}
		public function setSubrayadoTemp(val:Boolean) {temp_subrayado = val; trace("cambiando temp_subrayado a = ", val);}
		public function setColorTemp(val:uint) {temp_color = val;}
		public function setFuenteTemp(val:String) {temp_fuente = val;}
		public function setNegritaTicker(val:Boolean) {negrita_ticker = val;}
		public function setCursivaTicker(val:Boolean) {cursiva_ticker = val;}
		public function setSubrayadoTicker(val:Boolean) {subrayado_ticker = val;}
		public function setFuenteTicker(val:String) {fuente_ticker = val;}
		public function setColorTicker(val:uint) {color_ticker = val;}
		public function setAlineacionTicker(val:String) {alineacion_ticker = val;}
		public function setSizeTicker(val:int) {size_ticker = val;}
		/**************************************************************************/
		
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CContenedorElemento(aita:MovieClip) 
		{
			super(aita);
		}
		
		//<summary>
		///Inicializa el contenedor del elemento
		///</summary>
		override public function load():int
		{
			getPadre().desactivarAnterior();//si hay un elemento en escena lo desactivamos;
			//getPadre().getPanelPropiedades().insertPropGenericas(this);//actualizamos el panel de propiedades;
			//getPadre().elemento_seleccionado = this;//nuevo elemento seleccionado
			desactivarElemento();
			
			this.x = getXpos();
			this.y = getYpos();
			
			setAncho(datos_elemento.width);
			setAlto(datos_elemento.height);
			
			//Según el tipo, colocamos un fondo diferente
			if (this.getUrlDatos() == null)
			{
				switch (this.getTipo())
				{
					case "swf":
						imagen_fondo = new CFondoFlash();
						break;
					case "imagen":
						imagen_fondo = new CFondoImagen();
						break;
					case "video":
						imagen_fondo = new CFondoVideo();
						break;
					case "anuncio":
						imagen_fondo = new CFondoAnuncio();
						break;
					case "pasafotos":
						imagen_fondo = new CFondoPasafotos();
						break;
					default: 
						imagen_fondo = null;
						break;
				}
				if (imagen_fondo != null) 
				{
					this.datos_elemento.fondo.addChild(imagen_fondo);
				}
			}
			
			////Listeners
			addEventListener(MouseEvent.CLICK,onElemento);
			this.datos_elemento.addEventListener(MouseEvent.MOUSE_DOWN,startDragging);
			this.datos_elemento.addEventListener(MouseEvent.MOUSE_UP,stopDragging);
						
			this.f5.buttonMode = true;
			this.f5.addEventListener(MouseEvent.MOUSE_DOWN,onF5Down);
			this.f5.addEventListener(MouseEvent.MOUSE_UP,onF5Up);

			this.f7.buttonMode = true;
			this.f7.addEventListener(MouseEvent.MOUSE_DOWN,onF7Down);
			this.f7.addEventListener(MouseEvent.MOUSE_UP,onF7Up);

			this.f8.buttonMode = true;
			this.f8.addEventListener(MouseEvent.MOUSE_DOWN,onF8Down);
			this.f8.addEventListener(MouseEvent.MOUSE_UP,onF8Up);
			
			if(this.getTipo() == "ticker")
			{
				this.f7.removeEventListener(MouseEvent.MOUSE_DOWN,onF7Down);
				this.f7.removeEventListener(MouseEvent.MOUSE_UP,onF7Up);
				this.f8.removeEventListener(MouseEvent.MOUSE_DOWN,onF8Down);
				this.f8.removeEventListener(MouseEvent.MOUSE_UP,onF8Up);
			}
			
			return 0;
		}
		
		//<summary>
		///Define nuevas dimensiones para el elemento según el tipo
		///</summary>
		public function setDimensiones()
		{
			trace("[CContenedorElemento] - setDimensiones() -> "+getTipo());
			//Según el tipo de elemento definimos las dimensiones y la pestaña inferior
			switch (getTipo())
			{
				case "swf" :
					break;
				case "imagen" :
					break;
				case "video" :
					break;
				case "texto" :
					datos_elemento.height = 50;
					var cajaTexto:CElementoTexto = new CElementoTexto(this.datos_elemento);
					cajaTexto.setContenido("Introduzca su texto aquí");
					cajaTexto.setFuente("Arial");
					cajaTexto.setTamaño(16);
					cajaTexto.setAlineacion("left");
					cajaTexto.setColor("#336699");
					cajaTexto.setNegrita("false");
					cajaTexto.setCursiva("false");
					cajaTexto.setSubrayado("false");
					cajaTexto.setSeleccionable("true");
					cajaTexto.setWordwrap(true);
					cajaTexto.setMultilinea(true);
					cajaTexto.setTransparencia(1.0);
					cajaTexto.load();
					texto = cajaTexto.getMyTextField();
					texto.addEventListener(Event.CHANGE,cambioEnTexto);
					addChild(texto);
					setChildIndex(datos_elemento, (this.numChildren - 1));
					break;
				case "tiempo" :
					cargarTiempo(dia,cod_ciudad,estilo_tiempo);
					break;
				case "reloj" :
					cargarRelojAnalogico();				
					break;
				case "pasafotos":
					break;
				case "menu":
					datos_elemento.height = getPadre().lienzo.contenedor.area_editable.height;
					datos_elemento.width = getPadre().lienzo.contenedor.area_editable.width;
					cargarControlMenu();
					break;
				case "rss":
					cargarRSS(rss_url);
					break;
				case "anuncio":
					break;
				case "ticker" :
					trace("[CContenedorElemento] - setDimensiones() - ticker");
					datos_elemento.height = 40;
					datos_elemento.width = 206;
					var cajaTicker:CElementoTexto = new CElementoTexto(this.datos_elemento);
					cajaTicker.setContenido("Texto del ticker");
					cajaTicker.setFuente("Arial");
					cajaTicker.setAlineacion("center");
					cajaTicker.setColor("#336699");
					cajaTicker.setNegrita("false");
					cajaTicker.setCursiva("false");
					cajaTicker.setSubrayado("false");
					cajaTicker.setSeleccionable("false");
					cajaTicker.setWordwrap(false);
					cajaTicker.setMultilinea(false);
					cajaTicker.setTransparencia(1);
					cajaTicker.setTamaño(30);
					cajaTicker.load();
					
					texto_ticker = cajaTicker.getMyTextField();
					texto_ticker.addEventListener(Event.CHANGE,cambioEnTicker);
					texto_ticker.background = true;
					texto_ticker.backgroundColor = 0xCCCCCC;
					addChild(texto_ticker);
					velocidad_ticker = 5;					
					setChildIndex(datos_elemento, (this.numChildren - 1));
					break;
				default :
					break;
			}
			
			if ((getTipo() != "tiempo") && (getTipo() != "menu") && (getTipo() != "reloj"))
			{
				getPadre().getPanelPropiedadesEspecificas().descargarPanel(); 
				getPadre().getPanelPropiedadesEspecificas().setTipo(getTipo());
				getPadre().getPanelPropiedadesEspecificas().cargarPanel();
			}	
			
			if (getTipo() == "rss") getPadre().getPanelPropiedadesEspecificas().getPanelRSS().actualizarEditor();
		
			if(getPadre().elemento_seleccionado == this) insertarPestañaInferior();
			ajustarBotonesAcontenido();
		}
				
		//<summary>
		///Coloca la pestaña bajo el elemento
		///</summary>
		public function insertarPestañaInferior():void
		{
			trace("[CContenedorElemento] - insertarPestañaInferior() -> pestaña="+pestaña);
			if(pestaña != null)
			{
				if(this.contains(pestaña)) this.removeChild(pestaña);
			}
			pestaña = new CBotoneraInferior(this);
			//pestaña.setXpos(75);
			//pestaña.setYpos(154);
			trace("[CContenedorElemento] - insertarPestañaInferior() -> tipo: "+getTipo());
			if(getTipo() == "ticker" || getTipo() == "texto")
			{
				pestaña.setXpos(f7.x);
				pestaña.setYpos(f7.y);
				pestaña.setTipo(getTipo());
				pestaña.load();
				pestaña.x = f7.x - pestaña.width/2;
				pestaña.y = f7.y+5;
			}
			else
			{
				pestaña.setXpos(0);
				pestaña.setYpos(0);
				pestaña.setTipo(getTipo());
				pestaña.load();
				//pestaña.x = 75;
				//pestaña.y = 154;
				pestaña.x = 0;
				pestaña.y = 0;
			}
			
			/*var existe:Boolean = false;
			for (var i:int = 0; i< this.numChildren; i++)
			{
				if (getChildAt(i) is CBotoneraInferior) existe = true;
			}*/
			
			this.addChild(pestaña);
			this.pestaña.alpha = 1;
			this.pestaña.enabled = true;
		}	
		
import flash.display.Bitmap;
import flash.display.Loader;
import cod.CElementoVideo;

		//<summary>
		///Coloca la pestaña bajo el elemento
		///</summary>
		public function activarPestañaEnTexto(cajaTexto:TextField)
		{
			trace("[CContenedorElemento] - activarPestañaEnTexto()");
			if (getTipo() == "texto")
			{
				texto = cajaTexto;
				texto.addEventListener(Event.CHANGE,cambioEnTexto);
				addChild(texto);
			}
			else if (getTipo() == "ticker")
			{
				texto_ticker = cajaTexto;
				texto_ticker.addEventListener(Event.CHANGE,cambioEnTexto);
				texto_ticker.background = true;
				texto_ticker.backgroundColor = 0xCCCCCC;
				addChild(texto_ticker);
			}
			
			if (getPadre().getPanelPropiedadesEspecificas().getTipo() != null)
			{
				if (getPadre().getPanelPropiedadesEspecificas().getTipo() != getTipo())
				{
					getPadre().getPanelPropiedadesEspecificas().descargarPanel();
				}
			}
			getPadre().getPanelPropiedadesEspecificas().setTipo(getTipo());
			getPadre().getPanelPropiedadesEspecificas().cargarPanel();
			
			insertarPestañaInferior();
			ajustarBotonesAcontenido();
		}
				
		/*********************************************** onElemento *****************************************************/
		
		public function onElemento(e:MouseEvent)
		{
			trace("[CContenedorElemento] - onElemento() - tipo = "+getTipo());
			//trace("***********onElemento**************");
			//-----------COMPROBAMOS SI HAY MULTISELECCIÓN
				//--No
					//Borramos el array que guarda los elementos de la multiselección (arrayElementosSeleccionados)
					//Insertamos el elemento en el array por si hubiera multiselección a continuación, seleccionando otro elemento
				//--Si
					//Si el elemento ya está en la multiselección lo quitamos
					//Si no, insertamos el elemento
			//--------------------------------------------
			if ((getPadre().getKeyCode() == "16")||(getPadre().getKeyCode() == "17"))
			{
				if (!getPadre().borrarElementos) // SI TRUE, ESTAMOS SACANDO UN ELEMENTO DEL CONTENEDOR MÚLTIPLE, NO TENEMOS Q ENTRAR AKI!!
				{
					//trace("MULTISELECCIÓN SI!!!!!!!!!!!!!!!!!");
					if (getTipo() != "pasafotos")
					{
						var pos:int = getPadre().listaElementosSeleccionados.indexOf(this);
						if (pos == -1) 
						{
							getPadre().insertarElementoSeleccionado(this);
							if (getPadre().listaElementosSeleccionados.length > 1) getPadre().actualizarContenedorMultiple();
							else 
							{
								getPadre().desactivarAnterior();
								getPadre().borrarLista();
								activarElemento();
								getPadre().zMax = 0;
								getPadre().IDelemento_seleccionado = ID;
								getPadre().elemento_seleccionado = this;
								
								if (getPadre().getPanelPropiedadesEspecificas().getTipo() != this.getTipo())
								{
									trace("[CContenedorElemento] - onElemento() -> panel no es de nuestro tipo");
									getPadre().getPanelPropiedadesEspecificas().descargarPanel();
									getPadre().getPanelPropiedadesEspecificas().setTipo(this.getTipo());
									getPadre().getPanelPropiedadesEspecificas().cargarPanel();
								}
							}
						}	
					}
					else 
					{
						getPadre().desactivarAnterior();
						getPadre().borrarLista();
						activarElemento();
						getPadre().zMax = 0;
						getPadre().IDelemento_seleccionado = ID;
						getPadre().elemento_seleccionado = this;
						
						if (getPadre().getPanelPropiedadesEspecificas().getTipo() != this.getTipo())
						{
							trace("[CContenedorElemento] - onElemento() -> panel no es de nuestro tipo");
							getPadre().getPanelPropiedadesEspecificas().descargarPanel();
							getPadre().getPanelPropiedadesEspecificas().setTipo(this.getTipo());
							getPadre().getPanelPropiedadesEspecificas().cargarPanel();
						}
					}
				}
				else 
				{
					//trace("SACANDO UN ELEMENTO DE LA MULTISELECCION");
					getPadre().borrado = true;
					getPadre().seleccionarRestante(this);
				}
				if (getPadre().borrado)  getPadre().borrarElementos = false;
			}
			else
			{
			    //MULTISELECCIÓN NO
				if (getPadre().elemento_seleccionado != this) seleccionado = 0; //PARA LOS TEXTOS
				else   seleccionado++;
				
				if (getPadre().elemento_seleccionMultiple != null) getPadre().desactivarContenedorMultiseleccion();
								
				getPadre().desactivarAnterior();
				getPadre().borrarLista();
				activarElemento();
				getPadre().zMax = 0;
				getPadre().IDelemento_seleccionado = ID;
				getPadre().elemento_seleccionado = this;
				insertarPestañaInferior();
				
				
				if(getTipo() != "imagen" && getTipo() != "rss" && getTipo() != "texto" && getTipo() != "ticker")
				{
					getPadre().getPanelPropiedades().btnRelacion.selected = true;
					setCandado(true);
					getPadre().getPanelPropiedades().btnRelacion.enabled = false;
					getPadre().getPanelPropiedades().btnRelacion.alpha = 0.5;
					
				}
				else if(getTipo() == "ticker")
				{
					getPadre().getPanelPropiedades().btnRelacion.selected = false;
					setCandado(false);
					getPadre().getPanelPropiedades().btnRelacion.enabled = false;
					getPadre().getPanelPropiedades().btnRelacion.alpha = 0.5;
				}
				else
				{
					getPadre().getPanelPropiedades().btnRelacion.enabled = true;
					getPadre().getPanelPropiedades().btnRelacion.alpha = 1.0;
				}
				if (getTipo() != "pasafotos") getPadre().insertarElementoSeleccionado(this);
												
				if (seleccionado < 2)
				{
					if (getTipo() == "texto") setChildIndex(datos_elemento,numChildren-1);
					if (texto != null)
					{
						texto.type = TextFieldType.DYNAMIC;
					}
				}
				
				if (getTipo() == "ticker") setChildIndex(datos_elemento,numChildren-1);
				
				//Definimos de qué tipo tiene q ser el panel de propiedades específicas
				if ((getPadre().getPanelPropiedadesEspecificas().getTipo() != "borrado"))
				{
					if (getPadre().getPanelPropiedadesEspecificas().getTipo() == "texto")
					{
						getPadre().getPanelPropiedadesEspecificas().getPanelTexto().actualizarEditor();						
					}
					trace("borrado!");
					getPadre().getPanelPropiedadesEspecificas().descargarPanel();
					getPadre().getPanelPropiedadesEspecificas().setTipo(this.getTipo());
					getPadre().getPanelPropiedadesEspecificas().cargarPanel();
				}
				else getPadre().getPanelPropiedadesEspecificas().setTipo("");
				
			}
		}
		
		/**************************************************************************************************/
		
		/**************************************Drag&Drop del elemento*************************************/
		///<summary>
		///	Evento que controla el inicio del drag de un elemento
		///</summary>
		private function startDragging(e:MouseEvent)
		{
			if (getPadre().elemento_seleccionMultiple == null)
			{	
				activarElemento();
				var dim_w:Number = getPadre().lienzo.contenedor.area_editable.width - this.datos_elemento.width;
				var dim_h:Number = getPadre().lienzo.contenedor.area_editable.height - this.datos_elemento.height;
								
				this.startDrag(false,new Rectangle(0,0,dim_w,dim_h));
			}
		}

		///<summary>
		///	Evento que controla el fin del drag de un elemento
		///</summary>
		function stopDragging(e:MouseEvent)
		{
			if (getPadre().elemento_seleccionMultiple == null)
			{
				this.stopDrag();
				setXpos(this.x);
				setYpos(this.y);
				getPadre().getPanelPropiedades().insertPropGenericas(this);
				if (texto != null)
				{
					setChildIndex(texto,numChildren-1);
					texto.type = TextFieldType.INPUT;
				}
			}
		}
		/****************************************************************************************************/
		
		/*****************************ACTIVAR/DESACTIVAR/AJUSTAR CONTROLADORES DE TAMAÑO******************************/
		///<summary>
		///	Muestra los controladores y la pestaña inferior
		///</summary>
		public function activarElemento()
		{
			if(this.pestaña == null)
			{
				insertarPestañaInferior();
				this.pestaña.alpha = 1;
				this.pestaña.enabled = true;
			}
			else if(!this.contains(pestaña))
			{
				insertarPestañaInferior();
				this.pestaña.alpha = 1;
				this.pestaña.enabled = true;
			}
			//this.pestaña.alpha = 1;
			//this.pestaña.enabled = true;
			
			f0.alpha = 1;
			f1.alpha = 1;
			f2.alpha = 1;
			f3.alpha = 1;
			f4.alpha = 1;
			f5.alpha = 1;
			f6.alpha = 1;
			f7.alpha = 1;
			f8.alpha = 1;

			ajustarBotonesAcontenido();
		}
		
		///<summary>
		///	Esconde los controladores y la pestaña inferior
		///</summary>
		public function desactivarElemento()
		{
			if (this.pestaña != null)
			{
				if(this.contains(pestaña))
				{
					this.pestaña.alpha = 0;
					this.pestaña.enabled = false;
				}
			}
			if(this.contains(f0))
			{
				f0.alpha = 0;
				f1.alpha = 0;
				f2.alpha = 0;
				f3.alpha = 0;
				f4.alpha = 0;
				f5.alpha = 0;
				f6.alpha = 0;
				f7.alpha = 0;
				f8.alpha = 0;
			}
			
			if (this.pestaña != null) this.pestaña.alpha = 0;
		}
		
		///<summary>
		///	Coloca los controladores según las dimensiones del elemento
		///</summary>
		public function ajustarBotonesAcontenido()
		{
			setAncho(datos_elemento.width);
			setAlto(datos_elemento.height);
			centro_x = datos_elemento.width / 2;
			centro_y = datos_elemento.height / 2;
			
			f1.x = centro_x;
			f2.x = getAncho();
			f3.y = centro_y;
			f4.x = centro_x;
			f4.y = centro_y;
			f5.x = getAncho();
			f5.y = centro_y;
			f6.y = getAlto();
			f7.x = centro_x;
			f7.y = getAlto();
			f8.x = getAncho();
			f8.y = getAlto();
			
			
			if(pestaña != null)
			{
				if(getTipo() == "texto" || getTipo() == "ticker")
				{
					pestaña.x = f7.x - (pestaña.width/2);
					pestaña.y = f7.y + 5;
				}
				else
				{
					pestaña.x = f0.x;
					pestaña.y = f0.y;
				}
			}
			
			//Cambia la pestaña inferior de sitio si el elemento supera los 240 pixels de alto
			/*if (datos_elemento.height < 240)
			{
				pestaña.x = f7.x - (pestaña.width/2);
				pestaña.y = f7.y + 5;
			}
			else
			{
				pestaña.x = f0.x;
				pestaña.y = f0.y;
				setChildIndex(this.pestaña, (this.numChildren - 1));
			}*/
			
			if (estado == 0) getPadre().getPanelPropiedades().insertPropGenericas(this);
			
			if (texto != null)
			{
				texto.width = datos_elemento.width;
				texto.height = datos_elemento.height;
			}
			
			if (texto_ticker != null)
			{
				texto_ticker.width = datos_elemento.width;
				texto_ticker.height = datos_elemento.height;
			}
			
		}
		/****************************************************************************************************/
		/**************************************** ELIMINAR ***************************************************/
		///<summary>
		///	Llama a eliminar()
		///</summary>
		function eliminarElemento(e:MouseEvent)
		{
			e.stopPropagation();
			if(this == getPadre().elemento_seleccionado)
			{
				trace("[CContenedorElemento] - eliminarElemento -> estamos intentando eliminar el elemento seleccionado");
				eliminar();
				getPadre().getPanelPropiedadesEspecificas().setTipo("borrado");
			}
			else
			{
				//trace("[CContenedorElemento] - eliminarElemento -> estamos intentando eliminar un elemento NO seleccionado");
			}
			
		}
		
		///<summary>
		///	Llama al padre para que elimine el elemento
		///</summary>
		public function eliminar()
		{
			if ((this.getTipo() == "video") && (video != null)) video.unload(); 
			getPadre().eliminar(this); 
		}
		/****************************************************************************************************/
		
		/*********************************DRAG&DROP DE LOS CONTROLADORES*************************************/
		function onF5Down(e:Event)
		{
			controlador_activo = f5;
			x_init = f5.x;
			y_init = f5.y;
			x0 = f5.x;
			y0 = f5.y;
			boton_pulsado = "f5";
			
			f5.startDrag(false,new Rectangle(x_init-datos_elemento.width +5,y_init,378-this.x-5,0));			
			this.pestaña.visible = false;
			this.datos_elemento.visible = false;
			f5.addEventListener(Event.ENTER_FRAME, actualizarMedidas);
			stage.addEventListener(MouseEvent.MOUSE_UP,onF5Up);
		}

		function onF5Up(e:Event)
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP,onF5Up);
			this.datos_elemento.visible = true;
			this.pestaña.visible = true;
			f5.stopDrag();
			f5.removeEventListener(Event.ENTER_FRAME, actualizarMedidas);
			actualizarMedidasPrueba();
		}

		function onF7Down(e:Event)
		{			
			controlador_activo = f7;
			x_init = f7.x;
			y_init = f7.y;
			x0 = f7.x;
			y0 = f7.y;
			boton_pulsado = "f7";
			
			f7.startDrag(false,new Rectangle(x_init,y_init-datos_elemento.height +5,0,800-this.y-5));
			this.datos_elemento.visible = false;
			this.pestaña.visible = false;
			f7.addEventListener(Event.ENTER_FRAME, actualizarMedidas);
			stage.addEventListener(MouseEvent.MOUSE_UP,onF7Up);
			
		}

		function onF7Up(e:Event)
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP,onF7Up);
			this.datos_elemento.visible = true;
			this.pestaña.visible = true;
			f7.stopDrag();
			f7.removeEventListener(Event.ENTER_FRAME, actualizarMedidas);
			actualizarMedidasPrueba();
		}

		function onF8Down(e:Event)
		{
			controlador_activo = f8;
			x_init = f8.x;
			y_init = f8.y;
			x0 = f8.x;
			y0 = f8.y;
			boton_pulsado = "f8";
			if (candado)
			{
				f8.startDrag(false,new Rectangle(x_init-datos_elemento.width+5,y_init,378-this.x-5,0));
			}
			else
			{
				f8.startDrag(false,new Rectangle(x_init-datos_elemento.width+5,y_init-datos_elemento.height+5,378-this.x -5,800-this.y-5));

			}
			this.datos_elemento.visible = false;
			this.pestaña.visible = false;
			f8.addEventListener(Event.ENTER_FRAME, actualizarMedidas);
			stage.addEventListener(MouseEvent.MOUSE_UP,onF8Up);
		}

		function onF8Up(e:Event)
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP,onF8Up)
			this.datos_elemento.visible = true;
			this.pestaña.visible = true;
			f8.stopDrag();
			f8.removeEventListener(Event.ENTER_FRAME, actualizarMedidas);
			actualizarMedidasPrueba();
		}
		
		///<summary>
		///	Actualiza las medidas del elemento tras haber pulsado los controladores
		/// de tamaño (f0 - f8)
		///</summary>
		function actualizarMedidas(e:Event)
		{
			trace("x: "+e.currentTarget.x+" - y: "+e.currentTarget.x
				  +" - width: "+e.currentTarget.width+" - height: "+e.currentTarget.height
				  +" - d.width: "+this.datos_elemento.width+" - d.height: "+this.datos_elemento.height);
				  
			var diferencia_ancho:Number = e.currentTarget.x - x_init;
			var diferencia_alto:Number = e.currentTarget.y - y_init;
			
			
			var ratio_ancho = e.currentTarget.x/this.datos_elemento.width;
			var ratio_alto = e.currentTarget.y/this.datos_elemento.height;
			try
			{
				trace("ACTUALIZAR MEDIDAS------------------------------------------"+getTipo()+" - "+this.control_reloj.getTipo());
				///Los relojes siempre se escalan manteniendo relación de aspecto con respecto a original:
				if(this.getTipo() == "reloj")
				{ 
					if (this.control_reloj.getTipo() == "analogico")
					{
						trace("es analogico");
						ratio_ancho = e.currentTarget.x/298;
						ratio_alto = e.currentTarget.y/298;
					}
					else if (this.control_reloj.getTipo() == "digital")
					{
						trace("es digital");
						ratio_ancho = e.currentTarget.x/150;
						ratio_alto = e.currentTarget.y/52;
					}
				}
			}
			catch (error:Error) {}

			var alto_proporcional:Number;
			var ancho_proporcional:Number;
			var parar:Boolean = false;//variable que detecta si nos estamos pasando del lienzo con las proporciones (candado)
			if (candado)
			{
				switch (e.currentTarget.name)
				{
					case "f5" :
						
						alto_proporcional = this.datos_elemento.height * ratio_ancho;
						if(alto_proporcional > getPadre().alL)
						{
							parar = true; 
							alto_proporcional = getPadre().alL;
							f2.x = x_init;
							f8.x = x_init;
							f5.x = x_init;
						}
						else
						{
							f2.x = e.currentTarget.x;
							f8.x = e.currentTarget.x;
						}
						f6.y = alto_proporcional;
						f7.y = alto_proporcional;
						f8.y = alto_proporcional;
						break;
					case "f7" :
						
						ancho_proporcional = this.datos_elemento.width * ratio_alto;
						if(ancho_proporcional > getPadre().anL)
						{
							parar = true;
							ancho_proporcional = getPadre().anL;
							f6.y = y_init;
							f8.y = y_init;
							f7.y = y_init;
						}
						else
						{
							f6.y = e.currentTarget.y;
							f8.y = e.currentTarget.y;
						}
						f2.x = ancho_proporcional;
						f5.x = ancho_proporcional;
						f8.x = ancho_proporcional;
						break;
					case "f8" :
						
						alto_proporcional = this.datos_elemento.height * ratio_ancho;
						if(alto_proporcional > getPadre().alL)
						{
							parar = true;
							alto_proporcional = getPadre().alL;
							f2.x = x_init;
							f5.x = x_init;
							f8.x = x_init;
						}
						else
						{
							f2.x = e.currentTarget.x;
							f5.x = e.currentTarget.x;
						}
						f6.y = alto_proporcional;
						f7.y = alto_proporcional;
						f8.y = f7.y;
						break;
					default :
						break;
				}
				f1.x = (f2.x - f0.x)/2;
				f4.x = f1.x;
				f7.x = f1.x;
				f3.y = (f6.y - f0.y)/2;
				f4.y = f3.y;
				f5.y = f3.y;
				

				x_init = e.currentTarget.x;
				y_init = e.currentTarget.y;
			}
			else
			{
				switch (e.currentTarget.name)
				{
					case "f5" :
						f2.x = e.currentTarget.x;
						f8.x = e.currentTarget.x;
						f1.x = (f5.x - f0.x)/2;
						f4.x = f1.x;
						f7.x = f1.x;
						x_init = e.currentTarget.x;
						break;
					case "f7" :
						f6.y = e.currentTarget.y;
						f8.y = e.currentTarget.y;
						f3.y = (f7.y - f0.y)/2;
						f4.y = f3.y;
						f5.y = f3.y;
						y_init = e.currentTarget.y;
						break;
					case "f8" :
						f2.x = e.currentTarget.x;
						f5.x = e.currentTarget.x;
						f6.y = e.currentTarget.y;
						f7.y = e.currentTarget.y;
						f1.x = (f8.x - f0.x)/2;
						f4.x = f1.x;
						f7.x = f1.x;
						f3.y = (f8.y - f0.y)/2;
						f4.y = f3.y;
						f5.y = f3.y;
						x_init = e.currentTarget.x;
						y_init = e.currentTarget.y;
						break;
					default :
						break;
				}
			}
			
			if(parar)
			{
				switch (e.currentTarget.name)
				{
					case "f5" : stage.removeEventListener(MouseEvent.MOUSE_UP,onF5Up);
								this.datos_elemento.visible = true;
								this.pestaña.visible = true;
								f5.stopDrag();
								f5.removeEventListener(Event.ENTER_FRAME, actualizarMedidas);
								break;
					case "f7" : stage.removeEventListener(MouseEvent.MOUSE_UP,onF7Up);
								this.datos_elemento.visible = true;
								this.pestaña.visible = true;
								f7.stopDrag();
								f7.removeEventListener(Event.ENTER_FRAME, actualizarMedidas);
								break;
					case "f9" : stage.removeEventListener(MouseEvent.MOUSE_UP,onF8Up)
								this.datos_elemento.visible = true;
								this.pestaña.visible = true;
								f8.stopDrag();
								f8.removeEventListener(Event.ENTER_FRAME, actualizarMedidas);
								break;
				}
				actualizarMedidasPrueba();
			}
			
			getPadre().getPanelPropiedades().mostrarEnPanelPropiedades(Math.round(f8.x),Math.round(f8.y));
		}
		
		///<summary>
		///	Actualiza las medidas del elemento tras haber pulsado los controladores
		/// de tamaño (f0 - f8) - PRUEBA!!
		///</summary>
		function actualizarMedidasPrueba()
		{
			var diferencia_ancho:Number = controlador_activo.x - x0;
			var diferencia_alto:Number = controlador_activo.y - y0;
			var ratio_ancho = controlador_activo.x/this.datos_elemento.width;
			var ratio_alto = controlador_activo.y/this.datos_elemento.height;
			var alto_proporcional:Number;
			var ancho_proporcional:Number;
			if (candado)
			{
				switch (controlador_activo.name)
				{
					case "f7" :
						ancho_proporcional = this.datos_elemento.width * ratio_alto;
						datos_elemento.width =  ancho_proporcional;
						datos_elemento.height +=  diferencia_alto;
						y_init = controlador_activo.y;
						break;
					default :
						alto_proporcional = this.datos_elemento.height * ratio_ancho;
						datos_elemento.height =  alto_proporcional;
						datos_elemento.width +=  diferencia_ancho;
						break;
				}
				x_init = controlador_activo.x;
				y_init = controlador_activo.y;
			}
			else
			{
				switch (controlador_activo.name)
				{
					case "f5" :
						datos_elemento.width +=  diferencia_ancho;
						x_init = controlador_activo.x;
						break;
					case "f7" :
						datos_elemento.height +=  diferencia_alto;
						y_init = controlador_activo.y;
						break;
					case "f8" :
						datos_elemento.height +=  diferencia_alto;
						datos_elemento.width +=  diferencia_ancho;
						x_init = controlador_activo.x;
						y_init = controlador_activo.y;
						break;
					default :
						break;
				}
			}
			if (datos_elemento.width > getPadre().lienzo.contenedor.area_editable.width) datos_elemento.width = 378;
			if (datos_elemento.height > getPadre().lienzo.contenedor.area_editable.height) datos_elemento.height = 800;
			ajustarBotonesAcontenido();
			getPadre().getPanelPropiedades().insertPropGenericas(this);
			
		}
		/****************************************************************************************************/
		
		/**************************************** TIPO = TEXTO *************************************************/
		///<summary>
		///	Ajusta el tamaño del texto si fuera necesario cada vez que hay cambios
		///</summary>
		function cambioEnTexto(e:Event)
		{
			var myFormat:TextFormat;
			if (datos_elemento.height <= texto.textHeight)
			{
				myFormat = texto.getTextFormat();

				if (myFormat.size != null)
				{
					datos_elemento.height +=  myFormat.size;
					texto.height +=  myFormat.size;
				}
				else
				{
					datos_elemento.height +=  getPadre().panel_propEsp.getPanelTexto().sizeSelect.value as Number;
					texto.height +=  getPadre().panel_propEsp.getPanelTexto().sizeSelect.value as Number;
				}
				ajustarBotonesAcontenido();
			}
		}
		/****************************************************************************************************/
		
		/**************************************** TIPO = TIEMPO ************************************************/
		///<summary>
		/// Carga el elemento tiempo
		///		-> day: día a mostrar
		///		-> cod: código de la ciudad a mostrar
		///		-> estilo: estilo del control (cartoon, clásico...)
		///</summary>
		public function cargarTiempo(day:String,cod:String,estilo:String)
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleData);
			dia = day;
			cod_ciudad = cod;
			estilo_tiempo = estilo;
			var url:String;
			if (tipo_tiempo == "vertical") url = "tiempoAS3_vertical.swf";
			else if (tipo_tiempo == "horizontal") 
			{
				url = "tiempoAS3_horizontal.swf";
			}
			this.setUrlDatos(url);
			loader.load(new URLRequest(url));
		}

		///<summary>
		/// Cambian el elemento tiempo
		///		-> tipo: "Arriba" indica el formato vertical, "Derecha" el formato horizontal
		///</summary>
		public function cambiarTiempoDeTipo(tipo:String)
		{
			//Definimos cual tenemos que cargar			
			if (tipo =="Arriba") tipo_tiempo = "vertical";
			else if (tipo =="Derecha") tipo_tiempo = "horizontal";
			
			var i:int = 0;
			var nombre:String;
			
			//Guardamos el formato actual
			cod_ciudad = lector_tiempo.getCodigoCiudad();
			dia = lector_tiempo.getDia();
			estilo_tiempo = lector_tiempo.getEstilo();
			posicion_textos = lector_tiempo.getPosicion();
			
			fecha_formato = lector_tiempo.getFormatoFecha();
			fecha_negrita = lector_tiempo.getNegritaFecha();
			fecha_cursiva = lector_tiempo.getCursivaFecha();
			fecha_subrayado = lector_tiempo.getSubrayadoFecha();
			fecha_color = lector_tiempo.getColorFecha();
			fecha_fuente = lector_tiempo.getFuenteFecha();
			temp_negrita = lector_tiempo.getNegritaTemp();
			temp_cursiva = lector_tiempo.getCursivaTemp();
			temp_subrayado = lector_tiempo.getSubrayadoTemp();
			temp_color = lector_tiempo.getColorTemp();
			temp_fuente = lector_tiempo.getFuenteTemp();
						
			cambiandoDeTipo = true;
			estado = 1;
						
			//Borramos el elemento existente
			for (i = 0; i<datos_elemento.numChildren; i++)
			{
				nombre = datos_elemento.getChildAt(i).name;								
				if (nombre.indexOf("fondo") == -1)
				{
					datos_elemento.removeChildAt(i);
					i=0;
				}
			}
			
			//Vuelve a cargar el control
			cargarTiempo(dia,cod_ciudad,estilo_tiempo);
		}
		/****************************************************************************************************/
		
		/**************************************** TIPO = RELOJ ************************************************/
		///<summary>
		/// Carga el reloj analógico
		///</summary>
		public function cargarRelojAnalogico()
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleData);
			this.setUrlDatos("reloj_analog_v2.swf");
			loader.load(new URLRequest("reloj_analog_v2.swf"));
		}
		
		///<summary>
		/// Carga el reloj digital
		///</summary>
		public function cargarRelojDigital()
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleData);
			this.setUrlDatos("reloj_digital_v2.swf");
			loader.load(new URLRequest("reloj_digital_v2.swf"));
		}
		
		///<summary>
		/// Cambia el elemento reloj de tipo
		///		-> tipo: "btnAnalog" indica que hay que cargar el analógico, si no
		///		cargamos el digital
		///</summary>
		function cambiarDeReloj(tipo_reloj:String)
		{						
			//Guardamos estilo actual
			color_agujas = control_reloj.getColorAgujas();
			alpha_agujas = control_reloj.getAlphaAgujas();
			color_marcas = control_reloj.getColorMarcas();
			alpha_marcas = control_reloj.getAlphaMarcas();
			color_sombra = control_reloj.getColorSombra();
			alpha_sombra = control_reloj.getAlphaSombra();
			color_fondo = control_reloj.getColorFondo();
			alpha_fondo = control_reloj.getAlphaFondo();
			color_marco = control_reloj.getColorMarco();
			alpha_marco = control_reloj.getAlphaMarco();
			color_remarco = control_reloj.getColorRemarco();
			alpha_remarco = control_reloj.getAlphaRemarco();
			color_numeros = control_reloj.getColorNumeros();
			alpha_numeros = control_reloj.getAlphaNumeros();
					
					
			var i:int = 0;
			var nombre:String;
			var nombre2:String;
			
			if (tipo_reloj == "btnAnalog") //Tenemos que eliminar el digital
			{
				for (i = 0; i<datos_elemento.numChildren; i++)
				{
					nombre = datos_elemento.getChildAt(i).toString();
					nombre2 = datos_elemento.getChildAt(i).name.toString();
					
					if ((nombre.indexOf("CMainRelojDigital") != -1) || (nombre2.indexOf("datos_elemento") != -1))
					{
						datos_elemento.removeChildAt(i);
						i=0;
					}
				}
								
				//Cargamos el analógico
				datos_elemento.fondo.width = 290;
				datos_elemento.fondo.height = 290;
				this.setAncho(290);
				this.setAlto(290);
				cargarRelojAnalogico();
			}
			else
			{
				for (i = 0; i<datos_elemento.numChildren; i++)
				{
					nombre = datos_elemento.getChildAt(i).toString();
					nombre2 = datos_elemento.getChildAt(i).name.toString();
										
					if ((nombre.indexOf("CMainRelojAnalogico") != -1) || (nombre2.indexOf("datos_elemento") != -1))
					{
						datos_elemento.removeChildAt(i);
						i=0;
					}
				}
									
				//Cargamos el digital
				datos_elemento.fondo.width = 150;
				datos_elemento.fondo.height = 52;
				this.setAncho(93);
				this.setAlto(29);
				cargarRelojDigital();
			}
		}
		/****************************************************************************************************/
		
		/**************************************** TIPO = RSS ************************************************/
		///<summary>
		/// Carga el elemento RSS
		///</summary>
		public function cargarRSS(url:String)
		{
			//this.estilo_rss = "estilo1";
			trace("[CContenedorElemento] - cargarRSS() -> estilo:"+estilo_rss);
			cargarFondoRSS();
			
			if (getPadre().getPanelPropiedadesEspecificas().getTipo() != null)
			{
				if (getPadre().getPanelPropiedadesEspecificas().getTipo() != "rss")
				{
					getPadre().getPanelPropiedadesEspecificas().descargarPanel();
				}
			}
		}
		
		///<summary>
		/// Carga el Movieclip de fondo según el estilo seleccionado
		///</summary>
		public function cargarFondoRSS()
		{
			trace("[CContenedorElemento] - cargarFondoRSS() -> estilo:"+estilo_rss);
			if (estilo_rss == "estilo1")
			{
				this.setUrlDatos("controlRSS_estilo1Player_v2.swf");
				this.estilo_rss = "estilo1";
				elementoFondoRSS = new CFondoRSS1();
				color_sup = 0x004566;
				alpha_superior = 1;
				color_inf = 0x5F7D00;
				alpha_inferior = 1;
				fuente_titulo = "Times New Roman";
				fuente_texto = "Arial";
				size_titulo = 18;
				size_texto = 12;
				color_titulo = 0xffffff;
				color_texto = 0xffffff;
				align_titulo = "left";
				align_texto = "left";
				negrita_titulo = false;
				negrita_texto = false;
				cursiva_titulo = false;
				cursiva_texto = false;
				subrayado_titulo = false;
				subrayado_texto = false;
			}
			else if (estilo_rss == "estilo2")
			{
				this.setUrlDatos("controlRSS_estilo2Player_v2.swf");
				this.estilo_rss = "estilo2";
				elementoFondoRSS = new CFondoRSS2();
				color_sup = 0x000000;
				alpha_superior = 1;
				color_inf = 0x000000;
				alpha_inferior = 1;
				fuente_titulo = "Arial";
				fuente_texto = "Trebuchet MS";
				size_titulo = 15;
				size_texto = 10;
				color_titulo = 0xffffff;
				color_texto = 0x9BBC76;
				align_titulo = "left";
				align_texto = "left";
				negrita_titulo = false;
				negrita_texto = false;
				cursiva_titulo = false;
				cursiva_texto = false;
				subrayado_titulo = false;
				subrayado_texto = false;
			}
			else if (estilo_rss == "estilo3")
			{
				this.setUrlDatos("controlRSS_estilo3Player_v2.swf");
				this.estilo_rss = "estilo3";
				elementoFondoRSS = new CFondoRSS3();
				color_sup = 0x004566;
				alpha_superior = 1;
				fuente_titulo = "Times New Roman";
				size_titulo = 18;
				color_titulo = 0xffffff;
				align_titulo = "left";
				negrita_titulo = false;
				cursiva_titulo = false;
				subrayado_titulo = false;
				
				//Deshabilitamos algunas opciones
				getPadre().getPanelPropiedadesEspecificas().getPanelRSS().deshabilitarOpciones();
			}
			
			imagenVisible = true;
			
			//Actualizamos el panel de edición para el elemento RSS
			if (getPadre().getPanelPropiedadesEspecificas().getPanelRSS() != null) getPadre().getPanelPropiedadesEspecificas().getPanelRSS().actualizarEditor();
						
			this.datos_elemento.addChild(elementoFondoRSS);
		
			/*this.setAncho(elementoFondoRSS.width);
			this.setAlto(elementoFondoRSS.height);
			this.datos_elemento.fondo.width = elementoFondoRSS.width;
			this.datos_elemento.fondo.height = elementoFondoRSS.height;
			this.datos_elemento.width = this.getAncho();
			this.datos_elemento.height = this.getAlto();*/
			
			//Intentar que no supere los 375px de ancho!!
			var ratio_ancho:Number;
			if (estado == 0)
			{
				this.setAncho(elementoFondoRSS.width);
				this.setAlto(elementoFondoRSS.height);
				this.datos_elemento.fondo.width = elementoFondoRSS.width;
				this.datos_elemento.fondo.height = elementoFondoRSS.height;
				this.datos_elemento.width = this.getAncho();
				this.datos_elemento.height = this.getAlto();
				if (this.getAncho() > 375)
				{
					ratio_ancho = 375/this.datos_elemento.fondo.width;
					this.setAncho(375);
					this.datos_elemento.fondo.width = 375;
					this.datos_elemento.width = this.getAncho();
					this.setXpos(0);
					this.x = 0;
					
					//Cambiamos alto proporcionalmente
					this.setAlto(this.getAlto()*ratio_ancho);
					this.datos_elemento.fondo.height = this.getAlto();
				}
			}
			else
			{
				elementoFondoRSS.width = this.getAncho();
				elementoFondoRSS.height = this.getAlto();
				this.datos_elemento.fondo.width =  this.getAncho();
				this.datos_elemento.fondo.height = this.getAlto();
				this.datos_elemento.width = this.getAncho();
				this.datos_elemento.height = this.getAlto();
				
				if (this.getAncho() > 375)
				{
					ratio_ancho = 375/this.datos_elemento.fondo.width;
					this.setAncho(375);
					this.datos_elemento.fondo.width = 375;
					this.datos_elemento.width = this.getAncho();
					this.setXpos(0);
					this.x = 0;
					
					//Cambiamos alto proporcionalmente
					this.setAlto(this.getAlto()*ratio_ancho);
					this.datos_elemento.fondo.height = this.getAlto();
				}
				
			}
			if (this.pestaña != null) ajustarBotonesAcontenido();
		}
		
		///<summary>
		/// Edita el Movieclip de fondo del RSS según los parámetros definidos
		/// en el panel de edición
		///</summary>
		public function actualizarFondoRSS()
		{
			var formato_titulo:TextFormat = new TextFormat();
			formato_titulo.align = align_titulo;
			formato_titulo.bold = negrita_titulo;
			formato_titulo.color = color_titulo;
			formato_titulo.font = fuente_titulo;
			formato_titulo.size = size_titulo;
			formato_titulo.italic = cursiva_titulo;
			formato_titulo.underline = subrayado_titulo;
			elementoFondoRSS.titular_txt.setTextFormat(formato_titulo);
			
			var colorBarraSuperior:Color = new Color();
			colorBarraSuperior.setTint(color_sup,1);
			elementoFondoRSS.barra_superior.transform.colorTransform = colorBarraSuperior;
			elementoFondoRSS.barra_superior.alpha = alpha_superior;
			
			if (estilo_rss != "estilo3")
			{
				if (imagenVisible) elementoFondoRSS.imagen.visible = true;
				else  elementoFondoRSS.imagen.visible = false;

				var colorBarraInferior:Color = new Color();
				colorBarraInferior.setTint(color_inf,1);
				elementoFondoRSS.barra_inferior.transform.colorTransform = colorBarraInferior;
				elementoFondoRSS.barra_inferior.alpha = alpha_inferior;
	
				var formato_texto:TextFormat = new TextFormat();
				formato_texto.align = align_texto;
				formato_texto.bold = negrita_texto;
				formato_texto.color = color_texto;
				formato_texto.font = fuente_texto;
				formato_texto.size = size_texto;
				formato_texto.italic = cursiva_texto;
				formato_texto.underline = subrayado_texto;
				elementoFondoRSS.noticia_txt.setTextFormat(formato_texto);
			}
		}
		
		///<summary>
		/// Cambia el movieclip de fondo del RSS según el estilo seleccionado
		///</summary>
		public function cambiarEstilo(estilo:String)
		{
			//Borramos contenido
			for (var i:int = 0; i< this.datos_elemento.numChildren; i++)
			{
				var nombre_contenido:String = this.datos_elemento.getChildAt(i).name;
				if (nombre_contenido != "fondo")
				{
					this.datos_elemento.removeChildAt(i);
					i = 0;
				}
			}
			estado = 1;
			switch (estilo)
			{
				case "estilo1":
					this.setUrlDatos("controlRSS_estilo1Player_v2.swf");
					this.estilo_rss = "estilo1";
					break;
				case "estilo2":
					this.setUrlDatos("controlRSS_estilo2Player_v2.swf");
					this.estilo_rss = "estilo2";
					break;
				case "estilo3":
					this.setUrlDatos("controlRSS_estilo3Player_v2.swf");
					this.estilo_rss = "estilo3";
					break;
			}
			cargarFondoRSS();	
		}
		
		/****************************************************************************************************/
		
		/**************************************** TIPO = TICKER *************************************************/
		///<summary>
		///	Ajusta el tamaño del texto si fuera necesario cada vez que hay cambios
		///</summary>
		function cambioEnTicker(e:Event)
		{
			var myFormat:TextFormat;
			if (datos_elemento.height <= texto_ticker.textHeight)
			{
				myFormat = texto_ticker.getTextFormat();

				if (myFormat.size != null)
				{
					datos_elemento.height +=  myFormat.size;
					texto_ticker.height +=  myFormat.size;
				}
				else
				{
					datos_elemento.height +=  getPadre().editor_ticker.sizeSelect.value as Number;
					texto_ticker.height +=  getPadre().editor_ticker.sizeSelect.value as Number;
				}
				ajustarBotonesAcontenido();
			}
		}
		
		///<summary>
		///	Edita el texto del ticker según lo que hemos seleccionado en el panel
		///</summary>
		public function editarTicker(accion:String,val:* = null)
		{
			var formato:TextFormat = texto_ticker.getTextFormat();
			switch (accion)
			{
				case "tamaño": formato.size = val; break;
				case "color": formato.color = val; break;
				case "negrita": formato.bold = val; break;
				case "subrayado": formato.underline = val; break;
				case "cursiva": formato.italic = val; break;
				case "alineacion": formato.align = val; break;
				case "fuente": formato.font = val; break;
				case "velocidad": velocidad_ticker = val; break;
				default:break;
			}
			texto_ticker.setTextFormat(formato);
			texto_ticker.height = texto_ticker.textHeight;
			this.datos_elemento.height = texto_ticker.textHeight + 5;
			ajustarBotonesAcontenido();
			trace("[CContenedorElemento] - editarTicker() -> textheight="+texto_ticker.textHeight);
		}
		/****************************************************************************************************/
		
		/**************************************** TIPO = MENU *************************************************/
		///<summary>
		///	Carga el elemento Menú
		///</summary>
		public function cargarControlMenu():void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,handleData);
			loader.load(new URLRequest("control_menu.swf"));
		}
		/*****************************************************************************************************/
		
		/**************************************** CARGAR CONTENIDO ******************************************/
		
		///<summary>
		///	Conecta con la librería de recursos para cargar contenidos
		///</summary>
		function loadData(e:MouseEvent)
		{
			if(this != getPadre().elemento_seleccionado) return;
			
			//Conectamos con la librería de recursos
			trace("[CContenedorElemento] - loadData() -> URL recurso para flexx = "+this.getUrlDatos());
			switch (getTipo())
			{
				case "swf":
					getPadre().getResourceURLFlash(3,this.getUrlDatos());
					getPadre().addEventListener(resourceReceivedEvent.RESOURCE_RECEIVED, loadDataFromResource);
					break;
				case "imagen" : 
					getPadre().getResourceURLFlash(1,this.getUrlDatos());
					estado = 0;
					getPadre().addEventListener(resourceReceivedEvent.RESOURCE_RECEIVED, loadDataFromResource); 
					break;
				case "video": 
					getPadre().getResourceURLFlash(2,this.getUrlDatos());
					getPadre().addEventListener(resourceReceivedEvent.RESOURCE_RECEIVED, loadDataFromResource);
					break;
				default: var url:String = ""; break;					
			}
		}
		
		///<summary>
		///	Event listener que recibe los contenidos
		///</summary>
		public function loadDataFromResource(e:resourceReceivedEvent):void
		{
			
			var texto_prueba:TextField;
			
			getPadre().removeEventListener(resourceReceivedEvent.RESOURCE_RECEIVED, loadDataFromResource);
			var url:String = e.resource.url;
			trace("[CContenedorElemento] - loadDataFromResource() -> url : "+url);
			if (url != null && url!="")
			{
				
				if (this.getTipo() == "pasafotos")
				{
					this.getArrayPasafotos().push(url);
					this.getArrayIDsPasafotos().push(e.resource.id);
				}
				else
				{
					if(url == this.getUrlDatos())
					{
						trace("[CContenedorElemento] - loadDataFromResource() -> es el mismo recurso -> no volver a cargar!!");
						return;
					}
					this.setIDRecurso(e.resource.id);
					trace("[CContenedorElemento] - loadDataFromResource() -> numero de hijos del contenedor = "+this.datos_elemento.numChildren);
					if(this.datos_elemento.numChildren > 1)
					{
						if(getTipo() == "video")
						{
							for(var i = 0;i<this.datos_elemento.numChildren;i++)
							{
								trace("[CContenedorElemento] - loadDataFromResource() -> hijo "+i+" -> "+this.datos_elemento.getChildAt(i));
							}
							//trace("[CContenedorElemento] - loadDataFromResource() -> eliminando un hijo del contenedor -> "+this.datos_elemento.getChildAt(0));
							(this.datos_elemento.getChildAt(1) as CElementoVideo).unload();
							this.datos_elemento.removeChildAt(1);
						}
						
					}
					loadContent(getTipo(),url,texto_prueba,false);
				}
			}
			else
			{
				//añadido iñaki 16/11/2013
				trace("Nos han devuelto un path nulo a un recurso -> eliminamos el elemento!");
				if(getTipo()!="menu")//el menú puede tener fondo sin imagen asignada...
				{
					eliminar();
					getPadre().getPanelPropiedadesEspecificas().setTipo("borrado")
				}
			}
		}
				
		function randomNumber(low:Number=0, high:Number=1):Number
		{
			return Math.floor(Math.random() * (1+high-low)) + low;
		}
		
		///<summary>
		///	Función que carga un contenido en datos_elemento mediante un Loader
		///		-> tipo: tipo de elemento
		///		-> url: path del contenido (imagen, vídeo, etc.)
		///		-> cajaTexto: null si el elemento no es de tipo texto o ticker
		///		-> cargaDirecta: deprecated por el momento....ups
		///</summary>
		public function loadContent(tipo:String,url:String,cajaTexto:TextField,cargaDirecta:Boolean)
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleData);
			this.setUrlDatos(url);
						
			switch (tipo)
			{
				case "swf": 					
					//PRE-CARGA!!
					raw = new URLLoader();
					raw.dataFormat = URLLoaderDataFormat.BINARY;
					raw.addEventListener(Event.COMPLETE, preLoadComplete);
					try {raw.load(new URLRequest(url));}
					catch (error:Error)  {trace("error = ", error.message);}
					break;
				case "imagen" : 
					trace("loadContent imagen -> "+url);
					loader.load(new URLRequest(url)); break;
				case "video":
					video = new CElementoVideo(this);
					video.setBucle(true);
					video.setUrlDatos(url);
					this.setUrlDatos(url);
					var ancho:Number = video.getAncho(); 
					var alto:Number = video.getAlto();
					video.setAncho(ancho);
					video.setAlto(alto);
					video.load();
					if (this.datos_elemento.fondo.imagen_fondo != null) this.datos_elemento.fondo.removeChild(imagen_fondo);
					this.datos_elemento.addChild(video);
					
					if (getPadre().getPanelPropiedadesEspecificas().getTipo() == "video")
					{
						getPadre().getPanelPropiedadesEspecificas().getPanelVideo().checkBucle.selected = true;
						getPadre().getPanelPropiedadesEspecificas().getPanelVideo().checkMute.selected = false;
					}
					break;
				case "tiempo":
					break;
				case "rss":
					break;
				case "texto":
					texto = cajaTexto;
					texto.multiline = true;
					
					texto.addEventListener(Event.CHANGE,cambioEnTexto);
					addChild(texto);
					setChildIndex(datos_elemento, (this.numChildren - 1));
					break;
				case "ticker":
					texto_ticker = cajaTexto;
					texto.multiline = false;
					texto_ticker.addEventListener(Event.CHANGE,cambioEnTexto);
					texto_ticker.background = true;
					texto_ticker.backgroundColor = 0xCCCCCC;
					addChild(texto_ticker);
					setChildIndex(datos_elemento, (this.numChildren - 1));
				case "pasafotos":
					break;
				default:
					break;
			}
		}
		
		///<summary>
		///	Función de pre-carga para los swf que tengan vídeos; cargamos los bytes
		///</summary>
		function preLoadComplete(ev:Event):void
		{
			swfLoader = new Loader();		
			swfLoader.loadBytes(raw.data);
			swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, swfLoaded);
		}
		
		///<summary>
		///	Función que carga los bytes de los elementos swfs en datos_elemento
		///</summary>
		public function swfLoaded(e:Event):void 
		{			
			var i:int = 0;
			for (i = 0; i< this.datos_elemento.fondo.numChildren; i++)
			{
				var nombre:String = this.datos_elemento.fondo.getChildAt(i);
				if(nombre.indexOf("CFondo") != -1)
				{
					this.datos_elemento.fondo.removeChildAt(i);
					i=0;
				}
			}
			for (i = 0; i< this.datos_elemento.numChildren; i++)
			{
				var nombreRecurso:String = this.datos_elemento.getChildAt(i).name;
				if (nombreRecurso != "fondo") 
				{
					this.datos_elemento.removeChildAt(i);
					i=0;
				}
			}
			
			this.datos_elemento.addChild(swfLoader);
		
			//Si es la primera vez que insertamos un elemento
			if (estado == 0)
			{
				this.setAncho(swfLoader.width);
				this.setAlto(swfLoader.height);
				this.datos_elemento.fondo.width = swfLoader.width;
				this.datos_elemento.fondo.height = swfLoader.height;
			}
						
			this.datos_elemento.width = this.getAncho();
			this.datos_elemento.height = this.getAlto();
			ajustarBotonesAcontenido();
		}
		
		///<summary>
		///	Función que se ejecuta el cargar el contenido mediante un Loader
		///		-> Depende del tipo de elemento, instanciaremos su controlador
		///		   para poder ir editando los controles especiales
		///</summary>
		function handleData(e:Event)
		{					
			//blokear la proporción
			trace("[CContenedorElemento] - handleData()");
			getPadre().getPanelPropiedades().btnRelacion.selected = true;
			this.setCandado(true);
			if(getTipo() == "imagen" || getTipo() == "rss")
			{
				getPadre().getPanelPropiedades().btnRelacion.enabled = true;
			}
			else
			{
				getPadre().getPanelPropiedades().btnRelacion.enabled = false;
			}
			
			if(getTipo() == "imagen")
			{
				trace("es imagen - estado "+estado);
				trace("datos_elemento "+this.datos_elemento+" w : "+this.datos_elemento.width+" , h: "+this.datos_elemento.height);
				trace("this "+this+" w : "+this.getAncho()+" , h: "+this.getAlto());
				trace("loaded "+e.currentTarget.content+" w : "+e.currentTarget.content.width+" , h: "+e.currentTarget.content.height);
				/*
				var bitmap:Bitmap = e.target.content;
				trace("bitmap data w: "+bitmap.width+" h: "+bitmap.height);
				var bitmap1:Bitmap = e.currentTarget.content;
				trace("bitmap data w: "+bitmap1.width+" h: "+bitmap1.height);
				var bitmap2:Bitmap = e.currentTarget.content as Bitmap;
				trace("bitmap data w: "+bitmap2.width+" h: "+bitmap2.height);
				*/
				
				if (estado == 0)
				{
					var ratio_ancho1:Number;
					var ratio_alto1:Number;
					var alto_max:Number = this.getAlto();
					var ancho_max:Number = this.getAncho();
					var alto_real:Number = e.currentTarget.content.height;
					var ancho_real:Number = e.currentTarget.content.width;
					
					if (ancho_real > ancho_max)
					{
						ratio_ancho = ancho_max/ancho_real;
						this.setAncho(ancho_max);
						this.datos_elemento.fondo.width = ancho_max;
						//this.setXpos(0);
						//this.x = 0;
						
						//Cambiamos alto proporcionalmente
						this.setAlto(alto_real*ratio_ancho);
						this.datos_elemento.fondo.height = alto_real*ratio_ancho;
						alto_real = alto_real*ratio_ancho;
						ancho_real = ancho_max;
					}
					if (alto_real > alto_max)
					{
						ratio_alto = alto_max/alto_real;
						this.setAlto(alto_max);
						this.datos_elemento.fondo.height = alto_max;
						//this.setYpos(0);
						//this.y = 0;
						
						//Cambiamos ancho proporcionalmente
						this.setAncho(ancho_real*ratio_alto);
						this.datos_elemento.fondo.width = ancho_real*ratio_alto;
					}
				}
			}
			else if (getTipo() == "tiempo") 
			{
				trace("[CContenedorElemento] - handleData -> cargando tiempo -> w:"+e.currentTarget.content.width+", h:"+e.currentTarget.content.height);
				lector_tiempo = new CElementoTiempo(e.currentTarget.content);
				lector_tiempo.setDia(dia);
				lector_tiempo.setCodigoCiudad(cod_ciudad);
				lector_tiempo.setPais(pais);
				lector_tiempo.setEstilo(estilo_tiempo);
				lector_tiempo.editPosicion(posicion_textos);
				lector_tiempo.editFormatoFecha(fecha_formato);
				
				if (cambiandoDeTipo) //Cambiando de formato vertical a horizontal o viceversa
				{
					lector_tiempo.editNegrita(1,fecha_negrita);
					lector_tiempo.editCursiva(1,fecha_cursiva);
					lector_tiempo.editSubrayado(1,fecha_subrayado);
					lector_tiempo.editFuente(1,fecha_fuente);
					lector_tiempo.editColor(1,fecha_color.toString());
					
					lector_tiempo.editNegrita(2,temp_negrita);
					lector_tiempo.editCursiva(2,temp_cursiva);
					lector_tiempo.editSubrayado(2,temp_subrayado);
					lector_tiempo.editFuente(2,temp_fuente);
					lector_tiempo.editColor(2,temp_color.toString());
							 
					trace("[CContenedorElemento] - handleData() -> elementoTiempo -> posicion = "+posicion_textos);
					lector_tiempo.editPosicion(posicion_textos);
					lector_tiempo.editFormatoFecha(fecha_formato);
										
					//cambiandoDeTipo = false;
				}

				lector_tiempo.load();
				
				//Actualizamos o cargamos el panel de propiedades específicas
				if ((getPadre().getPanelPropiedadesEspecificas().getPanelTiempo() != null)&&(getPadre().getPanelPropiedadesEspecificas().getPanelTiempo().estilo_dia_changed)) 
				{
					trace("[CContenedorElemento] - handleData() -> tiempo ->  el panel de tiempo ya existia");
					getPadre().getPanelPropiedadesEspecificas().getPanelTiempo().actualizarTrasCambioDeEstilo();
				}
				else
				{
					trace("[CContenedorElemento] - handleData() -> tiempo ->  crear panel del tiempo");
					if (getPadre().getPanelPropiedadesEspecificas().getTipo() != null && !cambiandoDeTipo)
					{
						getPadre().getPanelPropiedadesEspecificas().descargarPanel();
						/*
						if (getPadre().getPanelPropiedadesEspecificas().getTipo() != "tiempo")
						{
							getPadre().getPanelPropiedadesEspecificas().descargarPanel();
						}
						*/
					}
					getPadre().getPanelPropiedadesEspecificas().setTipo("tiempo");
					if(estado == 0) 
					{
						getPadre().getPanelPropiedadesEspecificas().cargarPanel();
						getPadre().getPanelPropiedadesEspecificas().getPanelTiempo().codigo_ciudad = cod_ciudad;
						getPadre().getPanelPropiedadesEspecificas().getPanelTiempo().dia = dia;
						getPadre().getPanelPropiedadesEspecificas().getPanelTiempo().pais = pais
						getPadre().getPanelPropiedadesEspecificas().getPanelTiempo().estilo = estilo_tiempo;
						trace("[CContenedorElemento] - handleData() -> panel Tiempo -> posicion = "+posicion_textos);
						getPadre().getPanelPropiedadesEspecificas().getPanelTiempo().posicion = posicion_textos;
					}
					
				}
			}
			else if (getTipo() == "reloj") 
			{				
				var tipo_reloj:String = e.currentTarget.content.toString();
				control_reloj = new CElementoReloj_extendido(e.currentTarget.content);
				control_reloj.load();	
				
				if (estado == 1) //Cargando una versión para modificarla
				{
					control_reloj.editColor("numerosCP",this.color_numeros.toString());
					control_reloj.editColor("fondoCP",this.color_fondo.toString()); 
					control_reloj.editAlpha("alpha_numeros",this.alpha_numeros);
					control_reloj.editAlpha("alpha_fondo",this.alpha_fondo); 
				}
								
				if (tipo_reloj.indexOf("Analogico") != -1) 
				{
					control_reloj.setTipo("analog");
					
					if (estado == 0)
					{
						control_reloj.setColorFondo(0xffffff);
						color_fondo = 0xffffff;
						control_reloj.setAlphaFondo(1);
						alpha_fondo = 1;
						
						control_reloj.setColorNumeros(0x000000);
						color_numeros = 0x000000;
						control_reloj.setAlphaNumeros(1);
						alpha_numeros = 1;
					}
					else
					{
						control_reloj.editColor("sombraCP",this.color_sombra.toString()); 
						control_reloj.editColor("marcoCP",this.color_marco.toString());
						control_reloj.editColor("remarcoCP",this.color_remarco.toString()); 
						control_reloj.editColor("marcasCP",this.color_marcas.toString());
						control_reloj.editColor("agujasCP",this.color_agujas.toString());
						
						control_reloj.editAlpha("alpha_sombra",this.alpha_sombra); 
						control_reloj.editAlpha("alpha_marco",this.alpha_marco);
						control_reloj.editAlpha("alpha_remarco",this.alpha_remarco); 
						control_reloj.editAlpha("alpha_marcas",this.alpha_marcas);
						control_reloj.editAlpha("alpha_agujas",this.alpha_agujas);
					}
				}
				else 
				{
					control_reloj.setTipo("digital");
					
					if (estado == 0)
					{
						control_reloj.setColorFondo(0x000000);
						color_fondo = 0x000000;
						control_reloj.setAlphaFondo(1);
						alpha_fondo = 1;
						
						control_reloj.setColorNumeros(0xffffff);
						color_numeros = 0xffffff;
						control_reloj.setAlphaNumeros(1);
						alpha_numeros = 1;
					}
					else 
					{
						control_reloj.editColor("diaCP",this.color_dia.toString()); 
						control_reloj.editColor("mesCP",this.color_mes.toString()); 
						control_reloj.editColor("numDiaCP",this.color_numDia.toString()); 
						
						control_reloj.editAlpha("alpha_dia",this.alpha_dia); 
						control_reloj.editAlpha("alpha_numDia",this.alpha_numDia);
						control_reloj.editAlpha("alpha_mes",this.alpha_mes);
					}
					
				}
				
				if (estado == 0)
				{
					//Actualizamos panel de propiedades específicas
					if (getPadre().getPanelPropiedadesEspecificas().getTipo() != null)
					{
						if (getPadre().getPanelPropiedadesEspecificas().getTipo() != "reloj")
						{
							getPadre().getPanelPropiedadesEspecificas().descargarPanel();
						}
					}
					getPadre().getPanelPropiedadesEspecificas().setTipo("reloj");
					getPadre().getPanelPropiedadesEspecificas().cargarPanel();
				}
			}
			else if (getTipo() == "rss") 
			{
				lector_rss = new CElementoRSS_extendido(e.currentTarget.content);
				lector_rss.setUrlDatos(rss_url);				
				lector_rss.load();
								
				//Actualizamos panel de propiedades específicas
				if (getPadre().getPanelPropiedadesEspecificas().getTipo() != null)
				{
					if (getPadre().getPanelPropiedadesEspecificas().getTipo() != "rss")
					{
						getPadre().getPanelPropiedadesEspecificas().descargarPanel();
					}
				}
				getPadre().getPanelPropiedadesEspecificas().setTipo("rss");
				getPadre().getPanelPropiedadesEspecificas().cargarPanel();
				getPadre().getPanelPropiedadesEspecificas().getPanelRSS().url_rss = rss_url;
				getPadre().getPanelPropiedadesEspecificas().getPanelRSS().actualizarEditor();		
				getPadre().getPanelPropiedadesEspecificas().getPanelRSS().btnBold.gotoAndStop(1);
			}
			else if (getTipo() == "menu")
			{
				control_menu = new CElementoControlMenu(e.currentTarget.content);
				
				//Actualizamos panel de propiedades específicas
				if (getPadre().getPanelPropiedadesEspecificas().getTipo() != null)
				{
					if (getPadre().getPanelPropiedadesEspecificas().getTipo() != "menu")
					{
						getPadre().getPanelPropiedadesEspecificas().descargarPanel();
					}
				}
				getPadre().getPanelPropiedadesEspecificas().setTipo("menu");
				getPadre().getPanelPropiedadesEspecificas().cargarPanel();
			}

			//Recorremos el fondo de datos_elemento para borrar las imágenes de fondo gris
			var i:int = 0;
			for (i = 0; i< this.datos_elemento.fondo.numChildren; i++)
			{
				var nombre:String = this.datos_elemento.fondo.getChildAt(i);
				if(nombre.indexOf("CFondo") != -1)
				{
					this.datos_elemento.fondo.removeChildAt(i);
					i=0;
				}
			}
			//Recorremos datos_elemento para eliminar el fondo
			for (i = 0; i< this.datos_elemento.numChildren; i++)
			{
				var nombreRecurso:String = this.datos_elemento.getChildAt(i).name;
				if (nombreRecurso != "fondo") 
				{
					this.datos_elemento.removeChildAt(i);
					i=0;
				}
			}
			
			this.datos_elemento.addChild(e.currentTarget.content);
			
			/*getPadre().desactivarAnterior();
			getPadre().borrarLista();
			desactivarElemento();*/
			/*activarElemento();
			getPadre().zMax = 0;
			getPadre().IDelemento_seleccionado = ID;
			getPadre().elemento_seleccionado = this;*/
			
			//Si cargamos el contenido por primera vez, ajustamos su tamaño
			trace("[CContenedorElemento] - handleData() -> estado = "+estado);
			if (estado == 0)//estamos cargando un elemento recién creado desde panel
			{
				trace("estamos cargando un elemento recién creado desde panel");
				///activamos el elemento recién creado desde la barra de herramientas
				getPadre().desactivarAnterior();
				getPadre().borrarLista();
				activarElemento();
				getPadre().zMax = 0;
				getPadre().IDelemento_seleccionado = ID;
				getPadre().elemento_seleccionado = this;
				insertarPestañaInferior();
				if(getTipo() == "tiempo" && !cambiandoDeTipo)
				{
					var ratio_ancho:Number;
					var ratio_alto:Number;
					if (this.getAncho() > 375)
					{
						ratio_ancho = 375/this.getAncho();
						this.setAncho(375);
						this.datos_elemento.fondo.width = 375;
						this.setXpos(0);
						this.x = 0;
						
						//Cambiamos alto proporcionalmente
						this.setAlto(this.getAlto()*ratio_ancho);
						this.datos_elemento.fondo.height = this.getAlto();
					}
					if (this.getAlto() > 800)
					{
						ratio_alto = 800/this.getAlto();
						this.setAlto(800);
						this.datos_elemento.fondo.height = 800;
						this.setYpos(0);
						this.y = 0;
						
						//Cambiamos ancho proporcionalmente
						this.setAncho(this.getAncho()*ratio_alto);
						this.datos_elemento.fondo.width = this.getAncho();
					}
				}
				if (getTipo() == "imagen")
				{
					//añadido iñaki 12/04/2013
					this.setAncho(e.currentTarget.content.width);
					this.setAlto(e.currentTarget.content.height);
					this.datos_elemento.fondo.width = e.currentTarget.content.width;
					this.datos_elemento.fondo.height = e.currentTarget.content.height;
					
					if(this.getAncho() > getPadre().anL || this.getAlto() > getPadre().alL)
					{
						trace("nos salimos del lienzo");
						if(e.currentTarget.content.width > e.currentTarget.content.height)
						{
							trace("ajustando a ancho");
							var r_alto = getPadre().anL/e.currentTarget.content.width;
							trace("ajustando a ancho ancho = "+getPadre().anL+", alto = "+(e.currentTarget.content.height * r_alto));
							this.datos_elemento.width = getPadre().anL;
							this.datos_elemento.height = e.currentTarget.content.height * r_alto;
							this.setAncho(getPadre().anL);
							this.setAlto(e.currentTarget.content.height * r_alto);
							//this.x = 0;
							//this.y = 0;
						}
						else
						{
							trace("ajustando a alto");
							var r_ancho = getPadre().alL/e.currentTarget.content.height;
							this.datos_elemento.height = getPadre().alL;
							this.datos_elemento.width = e.currentTarget.content.width * r_ancho;
							this.setAncho(e.currentTarget.content.width * r_ancho);
							this.setAlto(getPadre().alL);
							//this.x = 0;
							//this.y = 0;
						}
					}
					//simular que hemos tocado en los controladores para que se haga un resize del contenido al tamaño del contenedor
					//trace("Refrescando las medidas");
					//controlador_activo = f8;
					//actualizarMedidasPrueba();
				}
				else
				{
					this.setAncho(e.currentTarget.content.width);
					this.setAlto(e.currentTarget.content.height);
					this.datos_elemento.fondo.width = e.currentTarget.content.width;
					this.datos_elemento.fondo.height = e.currentTarget.content.height;
				
				}
			}
			else if(!cambiandoDeTipo) //estado = 1 -> estamos cargando de un xml q nos han pasado
			{
				trace("estado = 1 -> estamos cargando de un xml q nos han pasado");
				this.setAncho(this.datos_elemento.fondo.width);
				this.setAlto(this.datos_elemento.fondo.height);
				e.currentTarget.content.width = this.datos_elemento.fondo.width;
				e.currentTarget.content.height = this.datos_elemento.fondo.height;
				
				
			}
			
			if(getTipo() == "tiempo")
			{
				if(cambiandoDeTipo)
				{
					trace("[CContenedorElemento] - handleData() -> cambiandodetipo");
					cambiandoDeTipo = false;
					
					trace("datos_elemento "+this.datos_elemento+" w : "+this.datos_elemento.width+" , h: "+this.datos_elemento.height);
					trace("this "+this+" w : "+this.getAncho()+" , h: "+this.getAlto());
					trace("loaded "+e.currentTarget.content+" w : "+e.currentTarget.content.width+" , h: "+e.currentTarget.content.height);
					/*this.setAncho(e.currentTarget.content.width);
					this.setAlto(e.currentTarget.content.height);
					this.datos_elemento.fondo.width = e.currentTarget.content.width;
					this.datos_elemento.fondo.height = e.currentTarget.content.height;*/
					//tomamos los valores de tamaño que tenía el tiempo antes de modificarlo y los intercambiamos (ancho<->alto)
					var aux = this.getAncho();
					this.setAncho(this.getAlto());
					this.setAlto(aux);
					
					this.datos_elemento.fondo.width = this.getAncho();
					this.datos_elemento.fondo.height = this.getAlto();
					
					e.currentTarget.content.width = this.getAncho();
					e.currentTarget.content.height = this.getAlto();
					
					this.datos_elemento.width = this.getAncho();
					this.datos_elemento.height = this.getAlto();
					
					trace("datos_elemento "+this.datos_elemento+" w : "+this.datos_elemento.width+" , h: "+this.datos_elemento.height);
					trace("this "+this+" w : "+this.getAncho()+" , h: "+this.getAlto());
					trace("loaded "+e.currentTarget.content+" w : "+e.currentTarget.content.width+" , h: "+e.currentTarget.content.height);
					
					//getPadre().desactivarAnterior();
					//getPadre().borrarLista();
					/*activarElemento();
					getPadre().zMax = 0;
					getPadre().IDelemento_seleccionado = ID;
					getPadre().elemento_seleccionado = this;*/
				}
				else
				{
					trace("datos_elemento "+this.datos_elemento+" w : "+this.datos_elemento.width+" , h: "+this.datos_elemento.height);
					trace("this "+this+" w : "+this.getAncho()+" , h: "+this.getAlto());
					trace("loaded "+e.currentTarget.content+" w : "+e.currentTarget.content.width+" , h: "+e.currentTarget.content.height);
	
					this.setAncho(this.datos_elemento.fondo.width);
					this.setAlto(this.datos_elemento.fondo.height);
					e.currentTarget.content.width = this.datos_elemento.fondo.width;
					e.currentTarget.content.height = this.datos_elemento.fondo.height;
					/*activarElemento();
					getPadre().zMax = 0;
					getPadre().IDelemento_seleccionado = ID;
					getPadre().elemento_seleccionado = this;*/
				}
			}
			else
			{
				this.datos_elemento.width = this.getAncho();
				this.datos_elemento.height = this.getAlto();
			}
			
			
			ajustarBotonesAcontenido();
		}
		/****************************************************************************************************/
		
		/************************************** CARGAR VERSIÓN EXISTENTE **************************************/
		///<summary>
		///	Función que carga un elemento texto/ticker de una versión existente
		///</summary>
		public function recargarTexto(cajaTexto:TextField)
		{
			if (getTipo() == "texto")
			{
				texto = cajaTexto;
				texto.addEventListener(Event.CHANGE,cambioEnTexto);
				setChildIndex(datos_elemento, (this.numChildren - 1));
				datos_elemento.width = texto.width;
				datos_elemento.height = texto.height;
			}
			
			if (getTipo() == "ticker")
			{
				texto_ticker = cajaTexto;
				texto_ticker.addEventListener(Event.CHANGE,cambioEnTexto);
				texto_ticker.background = true;
				texto_ticker.backgroundColor = 0xCCCCCC;
				addChild(texto_ticker);
			}
			
			//Actualizamos panel de propiedades específicas
			if (getPadre().getPanelPropiedadesEspecificas().getTipo() != null)
			{
				if (getPadre().getPanelPropiedadesEspecificas().getTipo() != getTipo())
				{
					getPadre().getPanelPropiedadesEspecificas().descargarPanel();
				}
			}
			getPadre().getPanelPropiedadesEspecificas().setTipo(getTipo());
			getPadre().getPanelPropiedadesEspecificas().cargarPanel();
			
			insertarPestañaInferior();
			ajustarBotonesAcontenido();
		}
		
		///<summary>
		///	Función que carga un elemento vídeo de una versión existente
		///</summary>
		public function recargarVideo(url:String)
		{
			video = new CElementoVideo(this);
			video.setBucle(true);
			video.setUrlDatos(url);
			this.setUrlDatos(url);
			trace("[CContenedorElemento] - recargarVideo() -> contenedor -> ancho:"+this.getAncho()+", alto:"+this.getAlto());
			video.setAncho(this.getAncho()); //Dimensiones ya editadas por el usuario, no tenemos que cargar con el tamaño por defecto del elemento
			video.setAlto(this.getAlto());
			video.videoRedimensionado(this.getAncho(),this.getAlto());
			video.load();
			if (this.datos_elemento.fondo.imagen_fondo != null) this.datos_elemento.fondo.removeChild(imagen_fondo);
			this.datos_elemento.addChild(video);
			
			//Actualizamos panel de propiedades específicas
			if (getPadre().getPanelPropiedadesEspecificas().getTipo() == "video")
			{
				getPadre().getPanelPropiedadesEspecificas().getPanelVideo().checkBucle.selected = true;
				getPadre().getPanelPropiedadesEspecificas().getPanelVideo().checkMute.selected = false;
			}
			ajustarBotonesAcontenido();
		}
		
		///<summary>
		///	Función que carga un elemento RSS de una versión existente
		///</summary>
		public function recargarFondoRSS()
		{
			//trace("***************recargarFondoRSS***************");
			if (estilo_rss == "estilo1")
			{
				this.setUrlDatos("controlRSS_estilo1Player_v2.swf");
				this.estilo_rss = "estilo1";
				elementoFondoRSS = new CFondoRSS1();
			}
			else if (estilo_rss == "estilo2")
			{
				this.setUrlDatos("controlRSS_estilo2Player_v2.swf");
				this.estilo_rss = "estilo2";
				elementoFondoRSS = new CFondoRSS2();
			}
			else if (estilo_rss == "estilo3")
			{
				this.setUrlDatos("controlRSS_estilo3Player_v2.swf");
				this.estilo_rss = "estilo3";
				elementoFondoRSS = new CFondoRSS3();
			}
			
			//Dimensiones ya editadas por el usuario, no tenemos que cargar con el tamaño por defecto del elemento
			//trace("[CContenedorElemento] - recargarFondoRSS() -> this("+this.getAncho()+"x"+this.getAlto()+")");
			//trace("[CContenedorElemento] - recargarFondoRSS() -> datos_elemento("+this.datos_elemento.width+"x"+this.datos_elemento.height+")");
			elementoFondoRSS.width = this.getAncho();
			elementoFondoRSS.height = this.getAlto();
			actualizarFondoRSS();
			
			if (getPadre().getPanelPropiedadesEspecificas().getPanelRSS() != null) getPadre().getPanelPropiedadesEspecificas().getPanelRSS().actualizarEditor();
						
			this.datos_elemento.addChild(elementoFondoRSS);
			
			//trace("[CContenedorElemento] - recargarFondoRSS() -> 2  this("+this.getAncho()+"x"+this.getAlto()+")");
			//trace("[CContenedorElemento] - recargarFondoRSS() -> 2  datos_elemento("+this.datos_elemento.width+"x"+this.datos_elemento.height+")");
			
			//Actualizamos panel de propiedades específicas
			getPadre().getPanelPropiedadesEspecificas().descargarPanel(); //NUEVO
			getPadre().getPanelPropiedadesEspecificas().setTipo(getTipo());
			getPadre().getPanelPropiedadesEspecificas().cargarPanel();
			getPadre().getPanelPropiedadesEspecificas().getPanelRSS().actualizarEditor();
		
			insertarPestañaInferior();
			ajustarBotonesAcontenido();
	
		}
		
		///<summary>
		///	Función que carga un elemento menú de una versión existente
		///</summary>
		public function recargarMenu()
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,handleControlMenu);
			loader.load(new URLRequest("control_menu.swf"));
		}
		
		///<summary>
		///	Función que recibe el contenido de control_menu.swf mediante el loader
		/// Para decidir qué fondo tiene el control menú, seguimos este orden:
		///		1- Si el usuario ha elegido un estilo, cargamos el estilo por defecto, con su fondo
		///		2- Si la variable existe_fondo es false, significa que tenemos que quitar la imagen de fondo
		///		3- Si la variable fondo_url contiene un path, significa que el usuario ha elegido una imagen de la librería de recursos como fondo
		///		4- Si hayColorFondo es true, tendremos un color en vez de una imagen
		///</summary>
		public function handleControlMenu(e:Event)
		{
			control_menu = new CElementoControlMenu(e.currentTarget.content);
			
			//Si hay estilo lo aplicamos
			if (nombreEstilo != "Ninguno") control_menu.editEstilo(nombreEstilo);
			control_menu.setNombreEstilo(nombreEstilo);
			
			//Actualizamos el valor de la variable existe_fondo
			if (!existe_fondo) 
			{
				control_menu.borrarFondo();
				control_menu.setExisteFondo(false);
			}
			else control_menu.setExisteFondo(true);
			
			//Fondo
			if (fondo_url != "")	//Imagen
			{
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, cargarFondoMenu);
				loader.load(new URLRequest(fondo_url));	
			}
			else if (hayColorFondo)
			{
				control_menu.editColorFondo(fondo_color);
			}
						
			this.datos_elemento.addChild(e.currentTarget.content);
			
			//Por último, vamos editando contenido y formato de todas las cajas de 
			//texto que forman el control especial menú
			
			//Contenido textos
			control_menu.editContenido(cabecera_txt,"txtCabecera") ;
			control_menu.editContenido(tituloP_txt,"txtTitulo") ;
			control_menu.editContenido(titulo1_txt,"txtSubtitulo1") ;
			control_menu.editContenido(titulo2_txt,"txtSubtitulo2") ;
			control_menu.editContenido(titulo3_txt,"txtSubtitulo3") ;
			control_menu.editContenido(texto1_txt,"txt1") ;
			control_menu.editContenido(texto2_txt,"txt2") ;
			control_menu.editContenido(texto3_txt,"txt3") ;
			control_menu.editContenido(pie_txt,"txtPie") ;
			
			//Visibilidad
			control_menu.editInvisible(cabecera_visible,"txtCabecera") ;
			control_menu.editInvisible(tituloP_visible,"txtTitulo") ;
			control_menu.editInvisible(titulo1_visible,"txtSubtitulo1") ;
			control_menu.editInvisible(titulo2_visible,"txtSubtitulo2") ;
			control_menu.editInvisible(titulo3_visible,"txtSubtitulo3") ;
			control_menu.editInvisible(texto1_visible,"txt1") ;
			control_menu.editInvisible(texto2_visible,"txt2") ;
			control_menu.editInvisible(texto3_visible,"txt3") ;
			control_menu.editInvisible(pie_visible,"txtPie") ;
							
			//Alineación
			control_menu.editAlineacion(formato_cabecera.align,"txtCabecera") ;
			control_menu.editAlineacion(formato_tituloP.align,"txtTitulo") ;
			control_menu.editAlineacion(formato_titulo1.align,"txtSubtitulo1") ;
			control_menu.editAlineacion(formato_titulo2.align,"txtSubtitulo2") ;
			control_menu.editAlineacion(formato_titulo3.align,"txtSubtitulo3") ;
			control_menu.editAlineacion(formato_texto1.align,"txt1") ;
			control_menu.editAlineacion(formato_texto2.align,"txt2") ;
			control_menu.editAlineacion(formato_texto3.align,"txt3") ;
			control_menu.editAlineacion(formato_pie.align,"txtPie") ;
			
			//Fuente
			control_menu.editFuente(formato_cabecera.font,"txtCabecera") ;
			control_menu.editFuente(formato_tituloP.font,"txtTitulo") ;
			control_menu.editFuente(formato_titulo1.font,"txtSubtitulo1") ;
			control_menu.editFuente(formato_titulo2.font,"txtSubtitulo2") ;
			control_menu.editFuente(formato_titulo3.font,"txtSubtitulo3") ;
			control_menu.editFuente(formato_texto1.font,"txt1") ;
			control_menu.editFuente(formato_texto2.font,"txt2") ;
			control_menu.editFuente(formato_texto3.font,"txt3") ;
			control_menu.editFuente(formato_pie.font,"txtPie") ;
			
			//Tamaño
			control_menu.editTamaño(formato_cabecera.size.toString(),"txtCabecera") ;
			control_menu.editTamaño(formato_tituloP.size.toString(),"txtTitulo") ;
			control_menu.editTamaño(formato_titulo1.size.toString(),"txtSubtitulo1") ;
			control_menu.editTamaño(formato_titulo2.size.toString(),"txtSubtitulo2") ;
			control_menu.editTamaño(formato_titulo3.size.toString(),"txtSubtitulo3") ;
			control_menu.editTamaño(formato_texto1.size.toString(),"txt1") ;
			control_menu.editTamaño(formato_texto2.size.toString(),"txt2") ;
			control_menu.editTamaño(formato_texto3.size.toString(),"txt3") ;
			control_menu.editTamaño(formato_pie.size.toString(),"txtPie") ;
			
			//Negrita
			control_menu.editNegrita(formato_cabecera.bold,"txtCabecera") ;
			control_menu.editNegrita(formato_tituloP.bold,"txtTitulo") ;
			control_menu.editNegrita(formato_titulo1.bold,"txtSubtitulo1") ;
			control_menu.editNegrita(formato_titulo2.bold,"txtSubtitulo2") ;
			control_menu.editNegrita(formato_titulo3.bold,"txtSubtitulo3") ;
			control_menu.editNegrita(formato_texto1.bold,"txt1") ;
			control_menu.editNegrita(formato_texto2.bold,"txt2") ;
			control_menu.editNegrita(formato_texto3.bold,"txt3") ;
			control_menu.editNegrita(formato_pie.bold,"txtPie") ;
			
			//Cursiva
			control_menu.editCursiva(formato_cabecera.italic,"txtCabecera") ;
			control_menu.editCursiva(formato_tituloP.italic,"txtTitulo") ;
			control_menu.editCursiva(formato_titulo1.italic,"txtSubtitulo1") ;
			control_menu.editCursiva(formato_titulo2.italic,"txtSubtitulo2") ;
			control_menu.editCursiva(formato_titulo3.italic,"txtSubtitulo3") ;
			control_menu.editCursiva(formato_texto1.italic,"txt1") ;
			control_menu.editCursiva(formato_texto2.italic,"txt2") ;
			control_menu.editCursiva(formato_texto3.italic,"txt3") ;
			control_menu.editCursiva(formato_pie.italic,"txtPie") ;
			
			//Subrayado
			control_menu.editSubrayado(formato_cabecera.underline,"txtCabecera") ;
			control_menu.editSubrayado(formato_tituloP.underline,"txtTitulo") ;
			control_menu.editSubrayado(formato_titulo1.underline,"txtSubtitulo1") ;
			control_menu.editSubrayado(formato_titulo2.underline,"txtSubtitulo2") ;
			control_menu.editSubrayado(formato_titulo3.underline,"txtSubtitulo3") ;
			control_menu.editSubrayado(formato_texto1.underline,"txt1") ;
			control_menu.editSubrayado(formato_texto2.underline,"txt2") ;
			control_menu.editSubrayado(formato_texto3.underline,"txt3") ;
			control_menu.editSubrayado(formato_pie.underline,"txtPie") ;
			
			//Viñetas
			control_menu.editViñetas(formato_cabecera.bullet,"txtCabecera") ;
			control_menu.editViñetas(formato_tituloP.bullet,"txtTitulo") ;
			control_menu.editViñetas(formato_titulo1.bullet,"txtSubtitulo1") ;
			control_menu.editViñetas(formato_titulo2.bullet,"txtSubtitulo2") ;
			control_menu.editViñetas(formato_titulo3.bullet,"txtSubtitulo3") ;
			control_menu.editViñetas(formato_texto1.bullet,"txt1") ;
			control_menu.editViñetas(formato_texto2.bullet,"txt2") ;
			control_menu.editViñetas(formato_texto3.bullet,"txt3") ;
			control_menu.editViñetas(formato_pie.bullet,"txtPie") ;
			
			//Color
			control_menu.editColor(formato_cabecera.color.toString(),"txtCabecera") ;
			control_menu.editColor(formato_tituloP.color.toString(),"txtTitulo") ;
			control_menu.editColor(formato_titulo1.color.toString(),"txtSubtitulo1") ;
			control_menu.editColor(formato_titulo2.color.toString(),"txtSubtitulo2") ;
			control_menu.editColor(formato_titulo3.color.toString(),"txtSubtitulo3") ;
			control_menu.editColor(formato_texto1.color.toString(),"txt1") ;
			control_menu.editColor(formato_texto2.color.toString(),"txt2") ;
			control_menu.editColor(formato_texto3.color.toString(),"txt3") ;
			control_menu.editColor(formato_pie.color.toString(),"txtPie") ;
			
			this.datos_elemento.width = this.getAncho();
			this.datos_elemento.height = this.getAlto();
			ajustarBotonesAcontenido();
		}
		
		///<summary>
		///	Función que recibe el contenido de fondo del control menú
		///</summary>
		public function cargarFondoMenu(e:Event)
		{
			var fondo:MovieClip = new MovieClip();
			fondo.addChild(e.currentTarget.content);
			
			if (control_menu != null) control_menu.editFondo(fondo,fondo_url) 
		}
		/****************************************************************************************************/
	}
	
}
