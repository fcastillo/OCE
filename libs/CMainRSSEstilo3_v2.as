package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.errors.IOError;
	import flash.events.ErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.display.FrameLabel;
	import flash.display.LoaderInfo;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Loader;
	import flash.display.DisplayObject;
	import fl.motion.Color;
	import flash.geom.ColorTransform;
	import flash.text.TextFormat;
	
	import caurina.transitions.Tweener;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.text.TextField;
	
	public class CMainRSSEstilo3_v2 extends MovieClip 
	{
		//URLs para pruebas
		var rssurl:String = "http://rss.cnn.com/rss/edition.rss";
		var otra_url:String = "http://feeds.bbci.co.uk/news/world/rss.xml?edition=uk";
		var yOtra:String ="http://feeds.bbci.co.uk/news/world/rss.xml";
		var standard1:String = "http://cyber.law.harvard.edu/rss/examples/rss2sample.xml";
		var standard2:String = "http://rss.cnn.com/rss/edition.rss";
		var horoscopo:String = "http://www.horoscopofree.com/es/misc/partnership/Horoscopo.xml";
		
		//Variables para cargar y parsear el XML
		var url_php:String = "http://5.9.137.10/orona/backend/api/xmlrpc/RSS_Cargar.php";
		var xmlLoader:URLLoader = new URLLoader();
		var rssxml:XML = new XML();
		var listaItems:XMLList = new XMLList();
		
		//Arrays para guardar los datos
		var listaTitulos:Array = new Array();
		
		//Control
		var elemento_rss;
		var cont:int = 0;
		var max_cont:int = 0;
		
		//Timer para transiciones
		var tiempo:uint = 15000;
		var repeticiones:int = 2;
		var reloj:Timer;
		var delay:Timer;
		var tiempo_delay:uint = 3000;
		
		//Scroll del texto
		var contador:int = 0;
		var lag:int = 100;
		var segundos_titulo:int = 12;
		var scroll_activo:Boolean = false;
		var textoActivo:Boolean = false;
		var moverTitulo:Boolean = false;
		
		var maxLength:int = 326;
		var maxLineas:int = 0;
		var filas_bajadas:int = 0;
		var filas_subidas:int = 0;
		var toX0:Object = {x:15, alpha:1, time:1, transition:"easeOutSine"};
		var myTweenX:Tween;
		
		//Cargar imagen
		var imagenCargada:Boolean = false;
		
		//Formato
		var color_barraSup:Color = new Color();
		var color_sup:uint = 0x004566;
		var alpha_superior:Number = 1;
		var fuente_titulo:String = "Times New Roman";
		var size_titulo:int = 18;
		var color_titulo:uint = 0xffffff;
		var align_titulo:String = "center";
		var negrita_titulo:Boolean = true;
		var cursiva_titulo:Boolean = false;
		var subrayado_titulo:Boolean = false;
		
		var tipoRSS:String = "estilo3";
		
		var textField_titulo:TextField;
		var formato_titulo:TextFormat;
		var tituloCreado:Boolean = false;
		var fondosActualizados:Boolean = false;
		var altReal:Number = -1;
		
		//actualización timer refresco
		var last_update:Date;
		var update_timer: Timer;
		var update_cycle: Number = 60*60*1000; //1 hora.
		//var update_cycle: Number = 30000;
		
		var rss_url:String;
		
		public function CMainRSSEstilo3_v2() 
		{
			color_barraSup.setTint(0x004566,1);
			
			//Carga(horoscopo);
			//Carga(standard2);
			//Carga(yOtra);
			//setMovimientoTitulo(true);
		}
		public function alturaRealEnLienzo(alt:Number):void
		{
			trace("[SWF RSS Estilo 3] - alturaRealEnLienzo("+alt+")");
			altReal = alt;
		}
		//---------Función loadXML---------//
		//-- Edita el control según los atributos leídos en el dpe
		//-- Variables de entrada:
			//--datos: nodo xml del dpe
		//--------------------------------------//
		public function loadXML(datos:XML)
		{		
			//ESTILO
			var estilo:String = datos.@estilo;
			
			//TIEMPO TRANSICIONES
			var tiempo_transicion:int = datos.@tiempo_transicion;
			setTiempoEntreTransiciones(tiempo_transicion);
			
			//VELOCIDAD TRANSICIONES
			var velocidad:int = datos.@velocidad;
			//setVelocidadTexto(velocidad);
						
			//TITULO ACTIVO - VELOCIDAD TITULO
			var titulo_activo:Boolean;
			var velocidad_titulo:int = datos.@velocidad_titulo;
			datos.@titulo_activo == "true" ? titulo_activo = true : titulo_activo = false;
			setMovimientoTitulo(titulo_activo);
			if (titulo_activo) setVelocidadTitulo(velocidad_titulo);
			
			//COLORES Y ALPHA DE FONDO
			var color_superior:String = datos.@color_superior;
			var alpha_superior:Number = Number(datos.@alpha_superior);
						
			editColorBarras("superior",uint(color_superior),alpha_superior);
															
			//FORMATO TITULO
			align_titulo = datos.@align_titulos;
			color_titulo = datos.@color_titulos;
			fuente_titulo = datos.@fuente_titulos;
			size_titulo = datos.@size_titulos;
			datos.@negrita_titulo == "true" ? negrita_titulo = true : negrita_titulo = false;
			datos.@cursiva_titulo == "true" ? cursiva_titulo = true : cursiva_titulo = false;
			datos.@subrayado_titulo == "true" ? subrayado_titulo = true : subrayado_titulo = false;
			
			//CARGAMOS RSS
			var rss_url:String = datos.@rss_url;
			Carga(rss_url);
		}
		
		//-- Función Carga
		//	 Inicializa el reloj y llama a cargarXML()
		//--
		public function Carga(path)
		{	
			//trace("***************Carga*************");
			reloj = new Timer(tiempo,0);
			reloj.addEventListener(TimerEvent.TIMER, timer_completed);
			delay = new Timer(tiempo_delay,0);
			rssurl = path;
			rss_url = path;
			crearFormatos();
			cargarXML(rssurl);
		}
		
		//-- Función crearFormatos
		//	 Crea los formatos para el titulo y el texto
		//--
		public function crearFormatos()
		{
			try
			{
				formato_titulo = new TextFormat();
				formato_titulo.align = align_titulo;
				formato_titulo.bold = negrita_titulo;
				formato_titulo.color = color_titulo;
				formato_titulo.font = fuente_titulo;
				formato_titulo.italic = cursiva_titulo;
				formato_titulo.size = size_titulo;
				formato_titulo.underline = subrayado_titulo;
			}
			catch (e:Error)
			{
				trace("Error al crear el formato de título = ", e.message);
			}
		}
		
		
		//-- Función cargarXML
		//	 Carga el rss que le hemos pasado
		//--
		public function cargarXML(path)
		{		
			/*xmlLoader.addEventListener(Event.COMPLETE, parseXML);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			xmlLoader.load(new URLRequest(path));	*/
			
			//reiniciarVariables();
			this.unload();
			
			//Carga llamando a un php que nos devuelva el xml
			var variables:URLVariables = new URLVariables();
			variables.url = path;
			
            var request:URLRequest = new URLRequest(url_php);
			request.method = URLRequestMethod.POST;
            request.data = variables;
			
			xmlLoader.addEventListener(Event.COMPLETE, parseXML);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			xmlLoader.addEventListener(ErrorEvent.ERROR, errorHandler);
			xmlLoader.load(request);
		}
		
		//-- Función ioErrorHandler
		//	 Muestra un mensaje de error si no se ha podido cargar la URL
		//--
		function ioErrorHandler(event:IOErrorEvent):void 
		{  
			trace("RSS estilo 3 - URL not found");	
			
			checkVisibility()
		}
		
		//-- Función errorHandler
		//	 Muestra un mensaje de error si no se ha podido cargar la URL
		//--
		public function errorHandler(event:ErrorEvent):void 
		{  
			trace("error RSS = ", event);
			checkVisibility()
		}
		
		//-- Función parseXML
		//	 Comprueba si el RSS tiene imágenes, para llamar a la función que lo parsee
		//		- con imágenes: cargarRSSMediaExtendido(uri)
		//		- sin imágenes: guardarDatos()
		//--
		function parseXML(e:Event):void 
		{
			XML.ignoreWhitespace = true; 
			try
			{
				rssxml = new XML(e.target.data);	
				if (rssxml.toXMLString() != "")
				{
					listaItems = rssxml.channel.item;
					guardarDatos();
				}
				last_update = new Date();
				trace("last_update -> UPDATED!!!! -> "+last_update);
				checkVisibility();
			}
			catch(e:Error)
			{	
				trace("Error al parsear = ",e);
			}
			
			
		}
		
		//-- Función guardarDatos
		//	 Guarda los datos de los RSS que no contienen imágenes
		//--
		public function guardarDatos()
		{
			//trace("************guardarDatos**********");
			for (var i:int = 0; i < listaItems.length(); i++)
			{
				var titulo = listaItems[i].title;
										
				//Volcamos a los arrays
				listaTitulos.push(titulo);
			}
						
			max_cont = listaTitulos.length;
			initRSS();
		}
		
		//-- Función initRSS
		//	 Crea un elemento de tipo CElementoRSS y lo saca en pantalla
		//--
		public function initRSS()
		{
			//trace("********initRSS**********");
			if (cont >= max_cont) cont = 0;
			
			elemento_rss = new CElementoRSS();
			elemento_rss.x = 0;
			elemento_rss.y = 0;
			elemento_rss.addEventListener(Event.ENTER_FRAME,frameListener);
			textoActivo = false;	
			
			elemento_rss.barra_superior.transform.colorTransform = color_barraSup;
			elemento_rss.barra_superior.alpha = alpha_superior;
							
			fondo.addChild(elemento_rss);
		}
		
		//-- Función frameListener
		//	 Event Listener que controla los elementos de CElementoRSS según el frame en el que estemos
		//--
		function frameListener (e:Event)
		{
			//trace(e.target.currentLabel);
			switch(e.target.currentLabel)
			{
				case "textos":
					if (!tituloCreado)
					{
						tituloCreado = true;
						textField_titulo = new TextField();
						textField_titulo.multiline = true;
						textField_titulo.wordWrap = true;
						textField_titulo.htmlText = listaTitulos[cont].toString();
						textField_titulo.setTextFormat(formato_titulo);				
						
						//textField_titulo.width = textField_titulo.textWidth + 5;
						
						textField_titulo.width = 1000;
						
						textField_titulo.height = 2*textField_titulo.textHeight;
										
						if (int(textField_titulo.numLines)> 1)
						{
							textField_titulo.y = 6;
						}
						else 
						{
							if (formato_titulo.size < 20) textField_titulo.y = 13;
							else if (formato_titulo.size < 24) textField_titulo.y = 12;
							else if (formato_titulo.size < 30) textField_titulo.y = 10;
							else if (formato_titulo.size > 30) textField_titulo.y = 6;
							
							//trace("textField_titulo.y = ", textField_titulo.y);
							
							//if (textField_titulo.textHeight < 20) textField_titulo.y = 14;
							//else textField_titulo.y = 12;
						}
										
						if (align_titulo == "left") textField_titulo.x = 14;
						else textField_titulo.x = 0;
		
						elemento_rss.contenedor_superior.addChild(textField_titulo);
					}					
					break;
				case "fin":
					cont++;		
					elemento_rss.removeEventListener(Event.ENTER_FRAME,frameListener);
					reloj.addEventListener(TimerEvent.TIMER, timer_completed);
					reloj.start();
					
					if (moverTitulo)
					{
						if (!textoActivo)
						{
							delay.addEventListener(TimerEvent.TIMER, delay_completed);
							delay.start();
							//textoActivo = true;
							//TweenLite.to(textField_titulo,segundos_titulo, {x:-textField_titulo.width, onComplete:reiniciarMovimiento, delay:3});
							//myTweenX = new Tween(textField_titulo, "x", Strong.easeOut, textField_titulo.x, -textField_titulo.textWidth-20,segundos_titulo, true);
							//myTweenX.addEventListener(TweenEvent.MOTION_FINISH, reiniciarMovimiento);
						}			
					}
								
					break;
			}
		}
		
		//-- Función reiniciarMovimiento
		//	 Función que reinicia el movimiento del título
		//--
		public function reiniciarMovimiento(e:TweenEvent)
		{
			//trace("****************reiniciarMovimiento***************");
			//elemento_rss.titulo.x = textField_titulo.width - 30;
			if (align_titulo == "left") textField_titulo.x = 14;
			else textField_titulo.x = 0;
			
			delay.start();
			
			//TweenLite.to(textField_titulo, segundos_titulo, {x:-textField_titulo.width, onComplete:reiniciarMovimiento,delay:3});
			//textField_titulo.x = textField_titulo.textWidth;
			//myTweenX = new Tween(textField_titulo, "x", Strong.easeOut, textField_titulo.x, -textField_titulo.width, segundos_titulo, true);
			//myTweenX.addEventListener(TweenEvent.MOTION_FINISH, reiniciarMovimiento);
		}
		
		//-- Función timer_completed
		//	 Función que elimina el elemento existente y carga uno nuevo
		//--
		function timer_completed(e:TimerEvent)
		{
			//trace("*******************timer_completed***********");	
			//if (align_titulo == "left") textField_titulo.x = 14;
			//else textField_titulo.x = 0;
			
			tituloCreado = false;
			if (myTweenX != null) myTweenX.stop();
			fondosActualizados = false;
			contador = 0;
			fondo.removeChild(elemento_rss);
			reloj.stop();
			initRSS();
		}
		
		function delay_completed(e:TimerEvent)
		{
			delay.stop();
			textoActivo = true;
			myTweenX = new Tween(textField_titulo, "x", None.easeOut, textField_titulo.x, -textField_titulo.width,segundos_titulo, true);
			myTweenX.addEventListener(TweenEvent.MOTION_FINISH, reiniciarMovimiento);
		}
		
		public function descargarElementos()
		{
			if (reloj != null)
			{
				reloj.removeEventListener(TimerEvent.TIMER, timer_completed);
				reloj.stop();
				reloj = null;
			}
			if (elemento_rss != null) 
			{
				elemento_rss.removeEventListener(Event.ENTER_FRAME,frameListener);
				fondo.removeChild(elemento_rss);
			}
		}
		
		/*************************************** TIMER ************************************************/
		//-- Función setTiempoEntreTransiciones
		//	 Función que cambia los parámetros del timer para modificar el tiempo entre transiciones
		//--
		public function setTiempoEntreTransiciones(valor:int)
		{
			tiempo = valor*1000;
			if (reloj != null)
			{
				reloj.stop();
				reloj = new Timer(tiempo,0);
				reloj.addEventListener(TimerEvent.TIMER, timer_completed);
				reloj.start();
			}
		}
		
		//-- Función getTiempoEntreTransiciones
		//	 Función devuelve el tiempo entre transiciones
		//--
		public function getTiempoEntreTransiciones():int
		{
			return (Math.round(tiempo/1000));
		}
		
		//-- Función setVelocidadTexto
		//	 Función que cambia la velocidad de scroll en el texto
		//--
		public function setVelocidadTexto(valor:int)
		{
			lag = valor;
		}
		
		//-- Función getVelocidadTexto
		//	 Función que devuelve la velocidad de scroll en el texto
		//--
		public function getVelocidadTexto():int
		{
			return lag;
		}
		
		
		//-- Función setVelocidadTitulo
		//	 Función que cambia la velocidad de scroll en el titulo
		//--
		public function setVelocidadTitulo(valor:int)
		{
			segundos_titulo = valor;
		}
		
		//-- Función getVelocidadTitulo
		//	 Función que devuelve la velocidad de scroll en el titulo
		//--
		public function getVelocidadTitulo():int
		{
			return segundos_titulo;
		}
		
		//-- Función activarMovimientoTitulo
		//	 Función que activa el movimiento del titulo
		//--
		public function setMovimientoTitulo(op:Boolean)
		{
			moverTitulo = op;
		}
		
		//-- Función getVelocidadTitulo
		//	 Función que devuelve la velocidad de scroll en el titulo
		//--
		public function getMovimientoTitulo():Boolean
		{
			return moverTitulo;
		}
		
		public function setImagenVisible(op:Boolean){}
		public function getImagenVisible():Boolean {return false;}
		/**********************************************************************************************/
		
		/*************************************URL DEL PHP***********************************************/
		
		//-- Función setPhpUrl
		//	 Función que cambia la url del php al que pasamos la url del rss
		//--
		public function setPhpUrl(valor:String)
		{
			url_php = valor;
		}
		
		//-- Función getPhpUrl
		//	 Función que devuelve la url del php al que pasamos la url del rss
		//--
		public function getPhpUrl():String
		{
			return url_php;
		}
		
		/**********************************************************************************************/
				
		/************************************ FORMATO *************************************************/
		//-- Función editColorBarras
		//	 Función que cambia los colores de fondo
		//--
		public function editColorBarras(op:String,valor_color:uint,valor_alpha:Number)
		{
			//trace("*************cambiarColorBarra*************");
			switch(op)
			{
				case "superior":
					color_barraSup = new Color();
					color_barraSup.setTint(valor_color,1);
					color_sup = valor_color;
					alpha_superior = valor_alpha;
					break;
				case "inferior":
					break;
			}
		}
		
		//-- Función editFuenteTextos
		//	 Función que cambia la fuente de los textos
		//--
		public function editFuenteTextos(op:String,valor:String)
		{
			//trace("*************RSS.SWF - editFuenteTextos*******************");
			var formato:TextFormat;
			switch(op)
			{
				case "1": fuente_titulo = valor; break;
			}
		}
		
		//-- Función editSizeTextos
		//	 Función que cambia el tamaño de los textos
		//--
		public function editSizeTextos(op:String,valor:int)
		{
			var formato:TextFormat;
			switch(op)
			{
				case "1": size_titulo = valor; break;
			}
		}
		
		//-- Función editColorTextos
		//	 Función que cambia el color de los textos
		//--
		public function editColorTextos(op:String,valor:uint)
		{
			var formato:TextFormat;
			switch(op)
			{
				case "1": color_titulo = valor; break;
			}
		}
		
		//-- Función editAlignTextos
		//	 Función que cambia la alineación de los textos
		//--
		public function editAlignTextos(op:String,valor:String)
		{
			var formato:TextFormat;
			switch(op)
			{
				case "1": align_titulo = valor; break;
			}
		}
		
		//-- Función editNegritaTextos
		//	 Función que cambia la negrita de los textos
		//--
		public function editNegritaTextos(op:String,valor:Boolean)
		{	
			var formato:TextFormat;
			switch(op)
			{
				case "1": negrita_titulo = valor; break;
			}
		}
		
		//-- Función editCursivaTextos
		//	 Función que cambia la cursiva de los textos
		//--
		public function editCursivaTextos(op:String,valor:Boolean)
		{
			switch(op)
			{
				case "1": cursiva_titulo = valor; break;
			}
		}
		
		//-- Función editSubrayadoTextos
		//	 Función que cambia el subrayado de los textos
		//--
		public function editSubrayadoTextos(op:String,valor:Boolean)
		{
			switch(op)
			{
				case "1": subrayado_titulo = valor; break;
			}
		}
		
		//-- Función actualizarFormato
		//	 Función que actualiza el formato tras cada animación
		//--
		public function actualizarFormato()
		{
			//trace("**************actualizarFormato******************");
			//Formato textos
			textField_titulo.setTextFormat(formato_titulo);
				
			//trace("formato titulo ok");
		}
		
		public function unload()
		{
			if (elemento_rss != null) elemento_rss.removeEventListener(Event.ENTER_FRAME,frameListener);
			if (reloj != null) reloj.removeEventListener(TimerEvent.TIMER, timer_completed);reloj.stop();
			if (delay != null) delay.removeEventListener(TimerEvent.TIMER, delay_completed);delay.stop();
			if(elemento_rss != null) fondo.removeChild(elemento_rss);	
		}
		function checkVisibility()
		{
			var threeDays:Number = 3*24*60*60*1000;
			if(last_update == null)
			{
				this.visible = false;
				return;
			}
			var last_update_milliseconds:Number = last_update.getTime();
			var now:Date = new Date();
			var now_milliseconds:Number = now.getTime();
			var difference_milliseconds:Number = Math.abs( now_milliseconds - last_update_milliseconds);
			trace("checkVisibility() "+last_update+" -> "+Math.round(difference_milliseconds/threeDays));
			if (Math.round(difference_milliseconds/threeDays) > 0)
			{
				trace("OCULTAR");
				this.visible = false;
			}
			else
			{
				trace("MOSTRAR");
				this.visible = true;
			}
			
			restartTimerControl();
		}
		function reloadControlFromTimer(e:TimerEvent){
			trace("[CMainRSSEstilo1_v2] - reloadControlFromTimer()");
			update_timer.stop();
			update_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,reloadControlFromTimer);
			trace("^^^^^^^^^^^^^^^  REFRESCANDO INFORMACION ^^^^^^^^^^^^^^^^^^^^^^^^^^");
			trace(rss_url);
			cargarXML(rss_url);
		}
		
		function restartTimerControl()
		{
			trace("[CMainRSSEstilo1_v2] - restartTimerControl()");
			removeTimer();
			update_timer = new Timer(update_cycle,0);
			update_timer.addEventListener(TimerEvent.TIMER, reloadControlFromTimer);
			update_timer.start();
		}
		
		function removeTimer()
		{
			trace("[CMainRSSEstilo1_v2] - removeTimer()");
			if (update_timer != null)
			{
				trace("removeTimer");
				update_timer.stop();
				update_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,reloadControlFromTimer);
			}
		}
		
		function reiniciarVariables()
		{
			cont = 0;
			tituloCreado = false;
			//noticiaCreada = false;
			listaTitulos = new Array();
			//listaTextos = new Array();
			//listaImagenes = new Array();
			rssxml = new XML();
			listaItems = new XMLList();
			
		}
	}
	
}
