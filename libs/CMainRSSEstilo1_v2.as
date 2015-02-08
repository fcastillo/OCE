package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.errors.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.display.FrameLabel;
	import flash.utils.Timer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.DisplayObject;
	import fl.motion.Color;
	import flash.geom.ColorTransform;
	import flash.text.TextFormat;
	import flash.text.TextField;
	
	import caurina.transitions.Tweener;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	
	public class CMainRSSEstilo1_v2 extends MovieClip 
	{
		//URLs para pruebas
		var rssurl:String = "http://rss.cnn.com/rss/edition.rss";
		var otra_url:String = "http://feeds.bbci.co.uk/news/world/rss.xml?edition=uk";
		var eitb : String = "http://www.eitb.com/es/rss/eltiempo/";
		var yOtra:String ="http://feeds.bbci.co.uk/news/world/rss.xml";
		var standard1:String = "http://cyber.law.harvard.edu/rss/examples/rss2sample.xml";
		var standard2:String = "http://rss.cnn.com/rss/edition.rss";
		var horoscopo:String = "http://www.horoscopofree.com/es/misc/partnership/Horoscopo.xml";
		
		//Variables para cargar y parsear el XML
		var url_php:String = "http://5.9.137.10/orona/backend/api/xmlrpc/RSS_Cargar.php";
		var xmlLoader:URLLoader = new URLLoader();
		var rssxml:XML = new XML();
		var listaItems:XMLList = new XMLList();
		var loader:Loader;
		
		//Arrays para guardar los datos
		var listaTitulos:Array = new Array();
		var listaTextos:Array = new Array();
		var listaImagenes:Array = new Array();
		
		//Control
		var elemento_rss;
		var cont:int = 0;
		var max_cont:int = 0;
		
		//Timer para transiciones
		var tiempo:uint = 20000;
		var repeticiones:int = 2;
		var reloj:Timer;
		var delay:Timer;
		var tiempo_delay:uint = 3000;
		
		//Scroll del texto
		var contador:int = 0;
		var lag:int = 100;
		var scroll_activo:Boolean = false;
		var textoActivo:Boolean = false;
		var maxLength:int = 326;
		var maxLineas:int = 0;
		var filas_bajadas:int = 0;
		var filas_subidas:int = 0;
		var toX0:Object = {x:15, alpha:1, time:1, transition:"easeOutSine"};
		var myTweenX:Tween;
		
		//Cargar imagen
		var imagen_visible:Boolean = false;
		var imagenCargada:Boolean = false;
		
		//Movimiento titulo
		var segundos_titulo:int = 12;
		var moverTitulo:Boolean = false;
		
		//Formato
		var color_barraSup:Color = new Color();
		//color_barraSup.setTint(0x004566,1);
		var color_sup:uint = 0x004566;
		var alpha_superior:Number = 1;
		var color_barraInf:Color = new Color();
		//color_barraInf.setTint(0x5F7D00,1);
		var color_inf:uint = 0x5F7D00;
		var alpha_inferior:Number = 1;
		var fuente_titulo:String = "Times New Roman";
		var fuente_texto:String = "Arial";
		var size_titulo:int = 18;
		var size_texto:int = 12;
		var color_titulo:uint = 0xffffff;
		var color_texto:uint = 0xffffff;
		var align_titulo:String = "left";
		var align_texto:String = "left";
		var negrita_titulo:Boolean = true;
		var negrita_texto:Boolean = false;
		var cursiva_titulo:Boolean = false;
		var cursiva_texto:Boolean = false;
		var subrayado_titulo:Boolean = false;
		var subrayado_texto:Boolean = false;
		
		var tipoRSS:String = "estilo1";
		var cambiarEstilo:Boolean = false;
		
		var textField_titulo:TextField;
		var textField_noticia:TextField;
		var formato_titulo:TextFormat;
		var formato_noticia:TextFormat;
		var tituloCreado:Boolean = false;
		var noticiaCreada:Boolean = false;
		var fondosActualizados:Boolean = false;
		
		//iñaki
		var mascara : MovieClip;
		var altReal:Number = -1;
		
		//actualización timer refresco
		var last_update:Date;
		var update_timer: Timer;
		var update_cycle: Number = 60*60*1000; //1 hora.
		//var update_cycle: Number = 30000;
		
		var rss_url:String;
		
		public function CMainRSSEstilo1_v2() 
		{
			//last_update = new Date();
			// Inicializamos variables
			color_barraSup.setTint(0x004566,1);
			color_barraInf.setTint(0x5F7D00,1);
			
			textField_titulo = new TextField();
			textField_titulo.text = "";
			formato_titulo = new TextFormat();
			formato_titulo.color = 0x000000;
			formato_titulo.size = 20;
			textField_titulo.setTextFormat(formato_titulo);				
			textField_titulo.multiline = false;
			textField_titulo.wordWrap = false;
			textField_titulo.width = 467;
			//textField_titulo.height = 467;
			fondo.addChild(textField_titulo);
					
			//Carga(horoscopo);
			//Carga(yOtra);
			//Carga(eitb);
			//setMovimientoTitulo(true);
			//this.scaleX = 0.5;
			
			//stage.addEventListener(MouseEvent.MOUSE_DOWN, clickEnStage);
		}
		
		public function alturaRealEnLienzo(alt:Number):void
		{
			trace("[SWF RSS Estilo 1] - alturaRealEnLienzo("+alt+")");
			altReal = alt;
		}
		function clickEnStage(e:MouseEvent)
		{
			descargarElementos();
		}
		//---------Función loadXML---------//
		//-- Edita el control según los atributos leídos en el dpe
		//-- Variables de entrada:
			//--datos: nodo xml del dpe
		//--------------------------------------//
		public function loadXML(datos:XML)
		{		
			//textField_titulo.text = "PRUEBA RSS - ENTRANDO EN loadXML";
			//ESTILO
			var estilo:String = datos.@estilo;
			
			//TIEMPO TRANSICIONES
			var tiempo_transicion:int = datos.@tiempo_transicion;
			setTiempoEntreTransiciones(tiempo_transicion);
			
			//VELOCIDAD TRANSICIONES
			var velocidad:int = datos.@velocidad;
			setVelocidadTexto(velocidad);
						
			//TITULO ACTIVO - VELOCIDAD TITULO
			var titulo_activo:Boolean;
			var velocidad_titulo:int = datos.@velocidad_titulo;
			datos.@titulo_activo == "true" ? titulo_activo = true : titulo_activo = false;
			//setMovimientoTitulo(true);
			setMovimientoTitulo(titulo_activo);
			if (titulo_activo) setVelocidadTitulo(velocidad_titulo);
			
			//COLORES Y ALPHA DE FONDO
			var color_superior:String = datos.@color_superior;
			var alpha_superior:Number = Number(datos.@alpha_superior);
			var color_inferior:String = datos.@color_inferior;
			var alpha_inferior:Number = Number(datos.@alpha_inferior);
			
			editColorBarras("superior",uint(color_superior),alpha_superior);
			editColorBarras("inferior",uint(color_inferior),alpha_inferior);
												
			//FORMATO TITULO
			align_titulo = datos.@align_titulos;
			color_titulo = datos.@color_titulos;
			fuente_titulo = datos.@fuente_titulos;
			size_titulo = datos.@size_titulos;
			//size_titulo = 50;
			datos.@negrita_titulo == "true" ? negrita_titulo = true : negrita_titulo = false;
			datos.@cursiva_titulo == "true" ? cursiva_titulo = true : cursiva_titulo = false;
			datos.@subrayado_titulo == "true" ? subrayado_titulo = true : subrayado_titulo = false;
			
			//FORMATO TEXTO
			align_texto = datos.@align_textos;
			color_texto = datos.@color_textos;
			fuente_texto = datos.@fuente_textos;
			size_texto = datos.@size_textos;
			datos.@negrita_texto == "true" ? negrita_texto = true : negrita_texto = false;
			datos.@cursiva_texto == "true" ? cursiva_texto = true : cursiva_texto = false;
			datos.@subrayado_texto == "true" ? subrayado_texto = true : subrayado_texto = false;
						
			//IMAGEN VISIBLE
			var imagen_visible:Boolean;
			datos.@imagen_visible == "true" ? imagen_visible = true : imagen_visible = false;
			if (estilo == "estilo3") setImagenVisible(false);
			else setImagenVisible(imagen_visible);
			
			//CARGAMOS RSS
			rss_url = datos.@rss_url;
			Carga(rss_url);
		}
		
		//-- Función Carga
		//	 Inicializa el reloj y llama a cargarXML()
		//--
		public function Carga(path)
		{	
			trace("***************Carga = "+path);
			
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
				var myFont = new Arial();
				//formato_titulo.font = fuente_titulo;
				formato_titulo.font = myFont.fontName;
				formato_titulo.italic = cursiva_titulo;
				formato_titulo.size = size_titulo;
				//formato_titulo.size = 40;
				formato_titulo.underline = subrayado_titulo;
				
				formato_noticia = new TextFormat();
				formato_noticia.align = align_texto;
				formato_noticia.bold = negrita_texto;
				formato_noticia.color = color_texto;
				formato_noticia.font = fuente_texto;
				formato_noticia.italic = cursiva_texto;
				formato_noticia.size = size_texto;
				formato_noticia.underline = subrayado_texto;
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
			xmlLoader.addEventListener(ErrorEvent.ERROR, errorHandler);
			xmlLoader.load(new URLRequest(path));	*/
			
			//trace("******************cargarXML*******************");
			//trace("url_php = ", url_php);
			
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
		public function ioErrorHandler(event:IOErrorEvent):void 
		{  
			trace("io error RSS = ", event);
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
		public function parseXML(e:Event):void 
		{
			trace("*********************parseXML*********************");
			reiniciarVariables()
			this.unload();
			//trace("xml recibido = "+e.target.data);
			XML.ignoreWhitespace = true; 
			try
			{
				rssxml = new XML(e.target.data);
				//trace("rssxml = "+rssxml);
				//trace("rssxml = ", rssxml.toXMLString());
				if (rssxml.toXMLString() != "")
				{
					
					if(fondo.contains(textField_titulo))
					{
						trace("Lo contiene!!("+textField_titulo+")");
						//fondo.removeChild(textField_titulo);
						trace("KKKK");
					}
					
					listaItems = rssxml.channel.item;
			
					//PARA LEER LAS IMÁGENES CON EL ESPACIO DE NOMBRES CORRESPONDIENTE
					var spacioDeNombres:String = rssxml.toString(); //Volcamos todo el rss como string
					var pos1:int = spacioDeNombres.indexOf("xmlns");
					var pos2:int = spacioDeNombres.indexOf("<channel>");
					spacioDeNombres = spacioDeNombres.substr(pos1+6,pos2-pos1-10);
					var uri:String = spacioDeNombres;
					pos1 = spacioDeNombres.indexOf("=");
					spacioDeNombres = spacioDeNombres.substr(0,pos1);
					uri = uri.substr(pos1+2,uri.length-pos1-2);
					pos2 = uri.indexOf('"');
					uri = uri.substr(0,pos2);
					
					//spacioDeNombres => tipo de extensión, la más común es "media"
					//uri => URI del espacio de nombres, ej. "http://search.yahoo.com/mrss/" 
						
					if(spacioDeNombres == "media") cargarRSSMediaExtendido(uri);
					else guardarDatos();
					
					
					last_update = new Date();
					trace("last_update -> UPDATED!!!! -> "+last_update);
					checkVisibility();
				}
				
			}
			catch(e:Error)
			{	
				trace("Error al parsear = ",e);
			}
		}
		
		//-- Función cargarRSSMediaExtendido
		//	 Parsea el xml y guarda los datos en arrays
		//		- titulos: listaTitulos
		//		- contenidos: listaTextos
		//		- imágenes: listaImagenes (NOTA! en el rss tienen que venir en <media:thumbnail> o <media:content>
		//--
		public function cargarRSSMediaExtendido(uri:String)
		{
			trace("cargarRSSMediaExtendido");
			var mediaNamespace:Namespace = new Namespace("media", uri);
			var qualifiedName:QName = new QName(mediaNamespace, "thumbnail");
			
			var listaContenidos:XMLList = rssxml.descendants(qualifiedName);
			
			if (listaContenidos.length() == 0)
			{
				qualifiedName = new QName(mediaNamespace, "content");
				listaContenidos = rssxml.descendants(qualifiedName);
			}
			
			if (listaContenidos.length() > 0)
			{
				var cont_aux:int = 0;
				for each (var element:XML in listaContenidos)
				{
					var item:XML = element.parent();
					var titulo = item.title;
					var noticia = item.description;
					var imagen = element.@url;
					
					//Sacamos cualquier posible imagen de la descripcion
					var pos1:int = noticia.toString().indexOf("<a href");
					var pos2:int = noticia.toString().indexOf("/a>");
					if (pos1 != -1)
					{
						var noticia1:String = noticia.toString().substr(0,pos1);
						var noticia2:String = noticia.toString().substr(pos2+3,noticia.toString().length);
						noticia = noticia1.concat(noticia2);
					}
									
					//Volcamos a los arrays
					if (titulo != listaTitulos[cont_aux-1])
					{
						listaTitulos.push(titulo);
						listaTextos.push(noticia);
						listaImagenes.push(imagen);
						cont_aux++;
					}		
				}  
				
				max_cont = listaTitulos.length;
										
				//Cargamos la primera noticia
				initRSS();
			}
			else guardarDatos();
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
				var noticia = listaItems[i].description;
								
				//Volcamos a los arrays
				listaTitulos.push(titulo);
				listaTextos.push(noticia);
			}
						
			max_cont = listaTitulos.length;
			initRSS();
		}
		
		//-- Función initRSS
		//	 Crea un elemento de tipo CElementoRSS y lo saca en pantalla
		//--
		public function initRSS()
		{
			trace("********initRSS**********");
			if (cont >= max_cont) cont = 0;
			
			elemento_rss = new CElementoRSS();
			elemento_rss.x = 0;
			elemento_rss.y = 0;
			elemento_rss.addEventListener(Event.ENTER_FRAME,frameListener);
			imagenCargada = false;
			textoActivo = false;	
			
			elemento_rss.barra_superior.transform.colorTransform = color_barraSup;
			elemento_rss.barra_superior.alpha = alpha_superior;
			elemento_rss.barra_inferior.transform.colorTransform = color_barraInf;
			elemento_rss.barra_inferior.alpha = alpha_inferior;
			
			if ((listaImagenes.length < 1) || (!imagen_visible))
			{
				//trace("ocultando imagen");
				elemento_rss.imagen.visible = false;
			}
							
			fondo.addChild(elemento_rss);	
		}
		
		//-- Función frameListener
		//	 Event Listener que controla los elementos de CElementoRSS según el frame en el que estemos
		//--
		public function frameListener (e:Event)
		{
			//trace("framelistener estilo1 : "+e.target.currentLabel);
			
			switch(e.target.currentLabel)
			{
				case "textos":			
					if (!tituloCreado)
					{
						tituloCreado = true;
						textField_titulo = new TextField();
						textField_titulo.htmlText = listaTitulos[cont].toString();
						trace("titulo = "+listaTitulos[cont].toString());
						textField_titulo.setTextFormat(formato_titulo);				
						//textField_titulo.background = true;
						//textField_titulo.backgroundColor = 0x000000;
						
						textField_titulo.multiline = false;
						textField_titulo.wordWrap = false;
					
						//textField_titulo.width = 467;
						//trace("SCALEEEEEE "+elemento_rss.scaleX);
						textField_titulo.width = 1000;
						//textField_titulo.width = (textField_titulo.textWidth + 20)*(467/elemento_rss.contenedor_superior.width);
						//trace("SCALEEEEEE "+textField_titulo.width +" - "+textField_titulo.textWidth);
						//textField_titulo.height = 2*textField_titulo.textHeight;
						
						//trace("textField_titulo.textWidth = ", textField_titulo.textWidth);
//						trace("textField_titulo.width = ", textField_titulo.width);
//						trace("------------------------------");
														
						//if (textField_titulo.textHeight < 20) textField_titulo.y = 6;
						//else 
						textField_titulo.y = 6;
														
						if (align_titulo == "left") textField_titulo.x = 14;
						else textField_titulo.x = 0;
										
						elemento_rss.contenedor_superior.addChild(textField_titulo);
						
						
					}					
					if(textField_titulo != null)
					{
						//trace("textHeigth="+textField_titulo.textHeight+" size="+formato_titulo.size+" heighttextfield="+textField_titulo.height+" contenedor="+elemento_rss.contenedor_superior.height); 
						formato_titulo.size = Object(18);
						//trace("ajustando tamaño texto = "+formato_titulo.size);
						textField_titulo.defaultTextFormat = formato_titulo;
						textField_titulo.setTextFormat(formato_titulo);
					}
					if (!noticiaCreada)
					{
						//trace("creando noticia");
						noticiaCreada = true;
						textField_noticia = new TextField();
						textField_noticia.htmlText = listaTextos[cont].toString();
						textField_noticia.setTextFormat(formato_noticia);
						textField_noticia.x = 14;
						textField_noticia.y = 7;
						textField_noticia.width = 328;
						textField_noticia.height = 35;
						textField_noticia.multiline = true;
						textField_noticia.wordWrap = true;
						elemento_rss.contenedor_inferior.addChild(textField_noticia);
						
						if(elemento_rss.imagen.contenedor.numChildren>1)
						{
							//trace("resize del textfield");
							//textField_noticia.width = 230;
						}
					}
								
		
					if ((listaImagenes.length < 1) || (!imagen_visible))
					{
						textField_noticia.width = 436;
						maxLength = 436;
					}			
					break;
				case "imagen":
					loader = new Loader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,recibiendoImagen);
					//trace("imagen_visible="+imagen_visible+", imagenCargada="+imagenCargada+", listaImagenes.length="+listaImagenes.length+", listaImagenes[cont]="+listaImagenes[cont]);
					if (imagen_visible)
					//if (true)
					{
						if (!imagenCargada)
						{
							if (listaImagenes.length > 0)
							{
								if (listaImagenes[cont] != null) 
								{
									imagenCargada = true;
									var urlRequest:URLRequest = new URLRequest(listaImagenes[cont].toString());
									loader.load(urlRequest);
									textField_noticia.width = 340;
									if(mascara != null)
									{
										if(!fondo.contains(mascara))
										{
											mascara = new CMascara();
											mascara.x = 0;mascara.y = 0;
											mascara.width = 345;
											//fondo.addChild(mascara);
										
											//textField_noticia.mask = mascara;
											//textField_titulo.mask = mascara;
											//elemento_rss.contenedor_superior.setMask(mascara);
											//elemento_rss.contenedor_superior.width = 345
											//elemento_rss.fondo.mask = mascara
										}
									}
									else
									{
										mascara = new CMascara();
										mascara.x = 0;mascara.y = 0;
										mascara.width = 345;
										//fondo.addChild(mascara);
									
										//textField_noticia.mask = mascara;
										//textField_titulo.mask = mascara;
										//elemento_rss.contenedor_superior.mask = mascara;
										//elemento_rss.fondo.mask = mascara
										//elemento_rss.contenedor_superior.width = 345
									}
								}
								else  elemento_rss.imagen.visible = false;
							}
							else elemento_rss.imagen.visible = false;
						}
					}		
					else elemento_rss.imagen.visible = false;
					break;
				case "fin":
					cont++;		
					elemento_rss.removeEventListener(Event.ENTER_FRAME,frameListener);
					reloj.addEventListener(TimerEvent.TIMER, timer_completed);
					reloj.start();
					//trace("moverTitulo = "+moverTitulo);
					if (moverTitulo)
					//if (true)
					{
						if (!textoActivo)
						//if (true)
						{
							delay.addEventListener(TimerEvent.TIMER, delay_completed);
							delay.start();
							//textoActivo = true;
							//TweenLite.to(textField_titulo,segundos_titulo, {x:-textField_titulo.width, onComplete:reiniciarMovimiento, delay:3});
							//myTweenX = new Tween(textField_titulo, "x", Strong.easeOut, textField_titulo.x, -textField_titulo.textWidth-20,segundos_titulo, true);
							//myTweenX.addEventListener(TweenEvent.MOTION_FINISH, reiniciarMovimiento);
						}			
					}
							
					//Scroll
					if (textField_noticia.numLines.toString() > "2") 
					{
						textField_noticia.height = textField_noticia.textHeight + 10;
						maxLineas = 2*Math.round(textField_noticia.height/30);
						controlScrollAutomatico(true);
					}
								
					break;
			}
			//trace("*******");
		}
		
		//-- Función recibiendoImagen
		//	 Event Listener que carga la imagen
		//--
		public function recibiendoImagen(e:Event)
		{		
			trace("[SWF RSS Estilo 1] - recibiendoImagen()");
			var loaderInfo:LoaderInfo = e.target as LoaderInfo;
			if(loaderInfo.contentType == "image/jpeg" || loaderInfo.contentType == "image/png" || loaderInfo.contentType == "image/gif")
			{
				var dispObj:DisplayObject = loaderInfo.content;
				var ratio = elemento_rss.imagen.width / dispObj.width;
				dispObj.width = elemento_rss.imagen.width;
				dispObj.height = dispObj.height * ratio;
				
				//dispObj.height = elemento_rss.imagen.height;
				if(altReal != -1)//el rss está estirado en el lienzo -> contrarrestar este estirado en la imagen
				{
					dispObj.height = dispObj.height * (84 / altReal);
					if(dispObj.height > elemento_rss.imagen.height) dispObj.height = elemento_rss.imagen.height;
				}
				//centrarlo en vertical
				dispObj.y = elemento_rss.imagen.height/2 - dispObj.height/2;
				elemento_rss.imagen.addChild(dispObj);
				elemento_rss.imagen.visible = true;		
				elemento_rss.setChildIndex(elemento_rss.imagen,elemento_rss.numChildren-1);
			}
			else
			{
				trace("RSS tipo 1 - formato no admitido "+ loaderInfo.contentType)
			}
		}
		
		//-- Función reiniciarMovimiento
		//	 Función que reinicia el movimiento del título
		//--
		public function reiniciarMovimiento(e:TweenEvent)
		{
			//trace("****************reiniciarMovimiento***************");
			if (align_titulo == "left") textField_titulo.x = 14;
			else textField_titulo.x = 0;
			
			delay.start();
			//TweenLite.to(textField_titulo, segundos_titulo, {x:-textField_titulo.width, onComplete:reiniciarMovimiento,delay:3});
			
			//textField_titulo.x = 200;
			//myTweenX = new Tween(textField_titulo, "x", Strong.easeOut, textField_titulo.x, -textField_titulo.textWidth-20, segundos_titulo, true);
			//myTweenX.addEventListener(TweenEvent.MOTION_FINISH, reiniciarMovimiento);
		}
		
		//-- Función timer_completed
		//	 Función que elimina el elemento existente y carga uno nuevo
		//--
		public function timer_completed(e:TimerEvent)
		{
			//trace("*******************timer_completed***********");
			removeEventListener(Event.ENTER_FRAME,moverRSSDown);
			removeEventListener(Event.ENTER_FRAME,moverRSSUp);
			
			//if (align_titulo == "left") textField_titulo.x = 14;
			//else textField_titulo.x = 0;
			
			scroll_activo = false;
			noticiaCreada = false;
			tituloCreado = false;
			if (myTweenX != null) myTweenX.stop();
			fondosActualizados = false;
			contador = 0;
			filas_bajadas = 0;
			fondo.removeChild(elemento_rss);
			reloj.stop();
			initRSS();
		}
		
		public function delay_completed(e:TimerEvent)
		{
			trace("delay_completed");
			delay.stop();
			textoActivo = true;
			myTweenX = new Tween(textField_titulo, "x", None.easeOut, textField_titulo.x, -textField_titulo.textWidth-20,segundos_titulo, true);
			myTweenX.addEventListener(TweenEvent.MOTION_FINISH, reiniciarMovimiento);
		}
		
		public function controlScrollAutomatico(op)
		{
			//trace("--------------controlScrollAutomatico");
			addEventListener(Event.ENTER_FRAME,moverRSSDown);
		}
		
		//-- Función moverRSSDown
		//	 Función que llama a moverFilas()
		//--
		public function moverRSSDown(e:Event)
		{
			//trace("moverRSSDown");
			contador++;
			if (contador == lag)
			{
				moverFilas();
			}
		}
		
		//-- Función moverRSSUp
		//	 Función que mueve el texto, bajando la caja de texto hasta su posición inicial
		//--
		public function moverRSSUp(e:Event)
		{
			//trace("moverRSSUp");
			contador++;
			if (contador == lag)
			{
				TweenLite.to(textField_noticia, 1, {y:7});
				
				contador = 0;
				addEventListener(Event.ENTER_FRAME,moverRSSDown);
				removeEventListener(Event.ENTER_FRAME,moverRSSUp);
			}
		}
		
		//-- Función moverFilas
		//	 Función que mueve el texto, subiendo la caja de texto para leer las filas que queden por debajo
		//--
		public function moverFilas()
		{
			//trace("moverFilas");
			filas_bajadas += 2; 
			TweenLite.to(textField_noticia, 2, {y:(textField_noticia.y-30), onComplete:comprobacion});
		}
		
		//-- Función comprobacion
		//	 Función que comprueba si hay que seguir moviendo el texto
		//--
		public function comprobacion()
		{
			if (filas_bajadas+2 >= maxLineas)
			{
				//trace("activamos scrollUp");
				removeEventListener(Event.ENTER_FRAME,moverRSSDown);
				filas_bajadas = 0;
				addEventListener(Event.ENTER_FRAME,moverRSSUp);
			}
			contador = 0;
		}
		
		public function descargarElementos()
		{
			trace("[RSS ESTILO 1]descargarElementos ");
			if(hasEventListener(Event.ENTER_FRAME)){removeEventListener(Event.ENTER_FRAME,moverRSSDown);}
			
			if (reloj != null)
			{
				if(reloj.hasEventListener(TimerEvent.TIMER)){reloj.removeEventListener(TimerEvent.TIMER, timer_completed);}
				reloj.stop();
				reloj = null;
			}
			if (delay != null  )
			{
				if(delay.hasEventListener(TimerEvent.TIMER)){delay.removeEventListener(TimerEvent.TIMER, delay_completed);}
				delay.stop();
				delay = null;
			}
			if (elemento_rss != null) 
			{
				//loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,recibiendoImagen_estilo2);
				if(elemento_rss.hasEventListener(Event.ENTER_FRAME)){elemento_rss.removeEventListener(Event.ENTER_FRAME,frameListener);}
				//fondo.removeChild(elemento_rss);
				if(fondo.contains(elemento_rss)){fondo.removeChild(elemento_rss);}
			}
			if(myTweenX != null) 
			{
				myTweenX.stop();
				myTweenX.removeEventListener(TweenEvent.MOTION_FINISH, reiniciarMovimiento);
			}
		}
		
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
		
		//-- Función setImagenVisible
		//	 Función que permite que la imagen sea visible o no
		//--
		public function setImagenVisible(op:Boolean)
		{
			imagen_visible = op;
		}
		
		//-- Función getImagenVisible
		//	 Función que devuelve la visibilidad de la imagen
		//--
		public function getImagenVisible():Boolean
		{
			return imagen_visible;
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
					color_barraInf = new Color();
					color_barraInf.setTint(valor_color,1);
					alpha_inferior = valor_alpha;
					color_inf = valor_color;
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
				case "2": fuente_texto = valor; break;
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
				case "2": size_texto = valor; break;
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
				case "2": color_texto = valor; break;
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
				case "2": align_texto = valor; break;
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
				case "2": negrita_texto = valor;  break;
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
				case "2": cursiva_texto = valor; break;
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
				case "2": subrayado_texto = valor; break;
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
			
			if (textField_noticia != null) 
			{
				textField_noticia.setTextFormat(formato_noticia);
			}
			//trace("formato noticia ok");
		}
		
		public function unload()
		{
			if (elemento_rss != null) elemento_rss.removeEventListener(Event.ENTER_FRAME,frameListener);
			if (reloj != null) reloj.removeEventListener(TimerEvent.TIMER, timer_completed);reloj.stop();
			if (delay != null) delay.removeEventListener(TimerEvent.TIMER, delay_completed);delay.stop();
			if (loader != null) loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,recibiendoImagen);
			if(elemento_rss != null)
			{
				if(fondo != null) if(fondo.contains(elemento_rss)) fondo.removeChild(elemento_rss);	
			}
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
			noticiaCreada = false;
			listaTitulos = new Array();
			listaTextos = new Array();
			listaImagenes = new Array();
			rssxml = new XML();
			listaItems = new XMLList();
			
		}
	}
	
}
