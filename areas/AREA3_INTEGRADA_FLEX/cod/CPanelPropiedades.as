package cod
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	import com.innovae.oce.domain.datamodel.resourceReceivedEvent;
	
	public class CPanelPropiedades extends CElementoBase
	{
		private var profundidad_anterior:int = 1;
		private var panel_alinear:CAlinear;
		private var fondo_ID:String = "";
		private var aux_ID:String = "";
		
		//Dimensiones
		var anOrig:Number;
		var alL:Number;
		var anL:Number;
		var anRes:Number;
		var alRes:Number
		
		/************************GETTERS/SETTERS*************************************/
		public function getPanelAlinear():CAlinear {return panel_alinear;}
		public function getAuxID():String {return aux_ID;}		
		public function getFondoID():String {return fondo_ID;}		
		
		public function setPanelAlinear(val:CAlinear):void {panel_alinear = val;}
		public function setAuxID(val:String):void {aux_ID = val;}
		public function setFondoID(val:String):void {fondo_ID = val;}
		/****************************************************************************/
		
		public var imagen_fondo:MovieClip;
		
		///<summary>
		///Constructor; 
		///		-> Define el padre
		///		-> Define las dimensiones del área para guardar las dimensiones y posiciones
		///		   de los elementos en relativo
		///</summary>
		public function CPanelPropiedades(aita:MovieClip) 
		{
			super(aita);
			
			anL = 225; //Ancho del lienzo
			alL = 265; //Alto del lienzo
			anRes = 600; //Resolucion (ancho)
			alRes = 800; //Resolucion (alto)
		}

		///<summary>
		///Inicializa el panel de propiedades y 
		///		-> Llama a la función que carga los botones para alinear/distribuir
		///		-> Llama a las funciones que activan los event listeners
		///</summary>
		override public function load():int
		{
			this.x = getXpos();
			this.y = getYpos();
			
			cargarPanelAlinear();
			cargarListeners();
			return 0;
		}
		
		///<summary>
		///Inicializa los botones para alinear/distribuir
		///</summary>
		private function cargarPanelAlinear():void
		{
			panel_alinear = new CAlinear(getPadre());
			panel_alinear.setXpos(16);
			panel_alinear.setYpos(128);
			panel_alinear.load();
			panel_alinear.init();
			this.addChild(panel_alinear);
		}
		
		///<summary>
		///Define los event listeners para los controles de posición, tamaño, alpha...
		///</summary>
		private function cargarListeners():void
		{
			//Dimensiones, posiciones y transparencia
			t_x.addEventListener(Event.CHANGE, xChange);
			t_y.addEventListener(Event.CHANGE, yChange);
			t_ancho.addEventListener(Event.CHANGE, anchoChange);
			t_alto.addEventListener(Event.CHANGE, altoChange);
			t_transparencia.addEventListener(Event.CHANGE, alphaChange);
			
			//Relación de aspecto
			btnRelacion.buttonMode = true;
			btnRelacion.addEventListener(MouseEvent.CLICK,changeRelacionDeAspecto);
			
			//Profundidad
			control_profundidad.addEventListener(Event.CHANGE, changeProfundidad);
			
			//Duplicar elementos - Daba problemas y lo quitamos
			//btnDuplicar.addEventListener(MouseEvent.CLICK, onDuplicar);
			
			//Imagen de fondo
			btnAñadirFondo.addEventListener(MouseEvent.CLICK,añadirFondo);
			btnEliminar.addEventListener(MouseEvent.CLICK,eliminarFondo);
						
			//Botón guardar - crea el XML de la versión y lo envía a FLEX
			btnGuardar.addEventListener(MouseEvent.CLICK,onGuardarVersion);
			
			//Botón volver - vuelve a FLEX sin guardar
			btnVolver.addEventListener(MouseEvent.CLICK,onVolver);
		}
		
		///<summary>
		///Event Listener que controla la posición en el eje x del elemento mediante la caja de texto
		///</summary>
		function xChange(e:Event):void
		{
			var auxiliar:String = t_x.text;
			var valor:Number;
			
			getPadre().diferencia_x = 0;
			getPadre().diferencia_y = 0;
						
			if (auxiliar.charAt(auxiliar.length -1) != ".") valor = Number(t_x.text);
			else  valor = Number(auxiliar.substr(0,auxiliar.length-1));
			
			valor = Math.round(valor);
			t_x.text = valor.toString();
			
			if (getPadre().elemento_seleccionMultiple != null)
			{
				getPadre().diferencia_x = valor - Math.round(getPadre().elemento_seleccionMultiple.x);
				getPadre().elemento_seleccionMultiple.x = valor;
				getPadre().actualizarArrayDatos();
				getPadre().contenedorSeleccion.setXpos(getPadre().elemento_seleccionMultiple.x);
			}
			else 
			{
				if (getPadre().elemento_seleccionado != null) getPadre().elemento_seleccionado.x = valor;
			}
		}
				
		///<summary>
		///Event Listener que controla la posición en el eje y del elemento mediante la caja de texto
		///</summary>
		function yChange(e:Event):void
		{
			var auxiliar:String = t_y.text;
			var valor:Number;
			
			getPadre().diferencia_x = 0;
			getPadre().diferencia_y = 0;
						
			if (auxiliar.charAt(auxiliar.length -1) != ".") valor = Number(t_y.text);
			else  valor = Number(auxiliar.substr(0,auxiliar.length-1));
			
			valor = Math.round(valor);
			t_y.text = valor.toString();
						
			if (getPadre().elemento_seleccionMultiple != null) 
			{
				getPadre().diferencia_y = valor - Math.round(getPadre().elemento_seleccionMultiple.y);
				getPadre().elemento_seleccionMultiple.y = valor;
				getPadre().actualizarArrayDatos();
				getPadre().contenedorSeleccion.setYpos(getPadre().elemento_seleccionMultiple.y);
			}
			else 
			{
				if (getPadre().elemento_seleccionado != null) getPadre().elemento_seleccionado.y = valor;
			}
		}
		
		///<summary>
		///Event Listener que controla el ancho del elemento mediante la caja de texto
		///</summary>
		function anchoChange(e:Event):void
		{
			var valor:Number = Number(t_ancho.text);
			valor = Math.round(valor);
			if (valor < 5)
			{
				valor = 5;
			}
			
			var dif:Number = 0;
			
			if (getPadre().elemento_seleccionMultiple != null) //MULTISELECCIÓN
			{
				if (!getPadre().cambioAncho) getPadre().ancho_anterior = Math.round(getPadre().elemento_seleccionMultiple.contenedor.width);
				
				//Si hay relación de aspecto (candado = true) cambiamos también el alto
				if (getPadre().elemento_seleccionMultiple.getCandado())
				{
					if (!getPadre().cambioAlto) getPadre().alto_anterior = Math.round(getPadre().elemento_seleccionMultiple.contenedor.height);
										
					dif = valor/getPadre().elemento_seleccionMultiple.contenedor.width;
					getPadre().elemento_seleccionMultiple.contenedor.height *= dif;
					getPadre().elemento_seleccionMultiple.contenedor.height = Math.round(getPadre().elemento_seleccionMultiple.contenedor.height);
					
					getPadre().cambioAlto = true; //Para actualizar después el alto de los elementos del contenedor, en el array de datos
				}
				
				getPadre().elemento_seleccionMultiple.contenedor.width = valor;		
				getPadre().elemento_seleccionMultiple.contenedor.width = Math.round(getPadre().elemento_seleccionMultiple.contenedor.width);
				getPadre().elemento_seleccionMultiple.ajustarControladores();
				getPadre().cambioAncho = true; //Para actualizar después el ancho de los elementos del contenedor, en el array de datos
			}
			else //UN ÚNICO ELEMENTO SELECCIONADO
			{
				if (getPadre().elemento_seleccionado != null)
				{
					//Si hay relación de aspecto (candado = true) cambiamos también el alto
					if (getPadre().elemento_seleccionado.getCandado())
					{
						dif = valor/getPadre().elemento_seleccionado.datos_elemento.width;
						getPadre().elemento_seleccionado.datos_elemento.height *= dif;
					}
					getPadre().elemento_seleccionado.datos_elemento.width = valor;
					getPadre().elemento_seleccionado.ajustarBotonesAcontenido();
				}
			}
		}
		
		///<summary>
		///Event Listener que controla el alto del elemento mediante la caja de texto
		///</summary>
		function altoChange(e:Event):void
		{
			var valor:Number = Number(t_alto.text);
			valor = Math.round(valor);
			if (valor < 5)
			{
				valor = 5;
			}
			
			var dif:Number = 0;
			if (getPadre().elemento_seleccionMultiple != null)  //MULTISELECCIÓN
			{
				if (!getPadre().cambioAlto) getPadre().alto_anterior = Math.round(getPadre().elemento_seleccionMultiple.contenedor.height);
				
				//Si hay relación de aspecto (candado = true) cambiamos también el ancho
				if (getPadre().elemento_seleccionMultiple.getCandado())
				{
					if (!getPadre().cambioAncho) getPadre().ancho_anterior = Math.round(getPadre().elemento_seleccionMultiple.contenedor.width);

					dif = valor/getPadre().elemento_seleccionMultiple.contenedor.height;
					getPadre().elemento_seleccionMultiple.contenedor.width *= dif;
					getPadre().elemento_seleccionMultiple.contenedor.width = Math.round(getPadre().elemento_seleccionMultiple.contenedor.width);
					
					getPadre().cambioAncho = true; //Para actualizar después el ancho de los elementos del contenedor, en el array de datos
				}
				getPadre().elemento_seleccionMultiple.contenedor.height = valor;
				getPadre().elemento_seleccionMultiple.ajustarControladores();
				getPadre().cambioAlto = true; //Para actualizar después el alto de los elementos del contenedor, en el array de datos
			}
			else //UN ÚNICO ELEMENTO SELECCIONADO
			{
				if (getPadre().elemento_seleccionado != null)
				{
					//Si hay relación de aspecto (candado = true) cambiamos también el ancho
					if (getPadre().elemento_seleccionado.getCandado())
					{
						dif = valor/getPadre().elemento_seleccionado.datos_elemento.height;
						getPadre().elemento_seleccionado.datos_elemento.width *= dif;
					}
					getPadre().elemento_seleccionado.datos_elemento.height = valor;
					getPadre().elemento_seleccionado.ajustarBotonesAcontenido();
				}
			}
		}
		
		///<summary>
		///Event Listener que controla la transparencia del elemento mediante la caja de texto
		///</summary>
		function alphaChange(e:Event):void
		{
			var valor:Number = Number(t_transparencia.text);
			cambiarAlpha(Number(t_transparencia.text)/100);
		}
		
		///<summary>
		///Cambia el alpha del elemento seleccionado
		///- NOTA = antes cambiábamos siempre el alpha del contenedor, ahora comprobamos si tenemos contenido, para no cambiar el
		///			alpha de las imágenes auxiliares que van debajo
		///</summary>
		private function cambiarAlpha(valor:Number):void
		{
			var i:int = 0;
			if (getPadre().elemento_seleccionMultiple != null)  //MULTISELECCIÓN
			{
				//Reseteamos a alpha 1
				for (i=0; i<getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
				{
					if (getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i).name != "fondo")
					{
						MovieClip(getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i)).alpha = 1;
					}
				}
				
				//Actualizamos el valor en el array de datos
				var nuevoArray:Array = getPadre().elemento_seleccionMultiple.getArrayDatos();
				for (i = 0; i<nuevoArray.length; i++)
				{
					if (nuevoArray[i].url_datos != null) nuevoArray[i].transparencia = valor;
				}
				getPadre().elemento_seleccionMultiple.setArrayDatos(nuevoArray);
				
				//Si tenemos contenido, aplicamos el alpha
				for (i = 0; i<getPadre().listaElementosSeleccionados.length; i++)
				{
					if (getPadre().listaElementosSeleccionados[i].getUrlDatos() != null) getPadre().listaElementosSeleccionados[i].setTransparencia(valor);
				}
				
				for (i = 0; i<getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
				{
					if (getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) is MovieClip)
					{
						var mc_aux:MovieClip = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						for (var k:int = 0; k<mc_aux.numChildren; k++)
						{
							var nombre:String = mc_aux.getChildAt(k).toString();
							var pos:int = nombre.indexOf("CFondo");
							if ((pos == -1) && (nombre.indexOf("Shape") == -1))
							{
								mc_aux.alpha = valor;
							}
						}
					}
				}
			}
			else if (getPadre().elemento_seleccionado != null)  //UN ÚNICO ELEMENTO
			{
				getPadre().elemento_seleccionado.datos_elemento.alpha = valor;
				getPadre().elemento_seleccionado.setTransparencia(valor);
				if(getPadre().elemento_seleccionado.texto != null)//es tipo texto
				{
					
					trace("Actualizando texto al alpha -> "+valor);
					getPadre().elemento_seleccionado.texto.alpha = valor;
				}
			}
		}
		
		///<summary>
		///Cambia la profundidad del elemento seleccionado
		///</summary>
		private function changeProfundidad(e:Event):void 
		{
			getPadre().actualizarProfundidades_int(e.target.value);
		}
		
		///<summary>
		///Llama al padre para duplicar el elemento seleccionado - NO SE USA!!
		///</summary>
		private function onDuplicar (e:MouseEvent)
		{
			getPadre().duplicarElemento();
		}

		///<summary>
		///Llama a la librería de recursos para que el usuario elija una imagen
		///		-> Imagen = 1
		///</summary>
		private function añadirFondo(e:Event):void 
		{
			getPadre().getResourceURLFlash(1,"-1");
			getPadre().addEventListener(resourceReceivedEvent.RESOURCE_RECEIVED, loadDataFromResource);
		}

		///<summary>
		///Evento que recibe el recurso solicitado, y carga la url de la imagen
		///</summary>
		public function loadDataFromResource(e:resourceReceivedEvent):void
		{			
			trace("[Flash] loadDataFromResource");
			getPadre().removeEventListener(resourceReceivedEvent.RESOURCE_RECEIVED, loadDataFromResource);
						
			//Guardamos url y el ID
			var url:String = e.resource.url;
			
			if (url != null)
			{
				//Sacamos primero el nombre
				var fSlash: int = url.lastIndexOf("/");
				var bSlash: int = url.lastIndexOf("\\"); // reason for the double slash is just to escape the slash so it doesn't escape the quote!!!
				var slashIndex: int = fSlash > bSlash ? fSlash : bSlash;
				var imageName: String = url.substr(slashIndex + 1);
			
				getPadre().setUrlFondo(url);
				nombre_fondo.text = imageName;
				this.aux_ID = e.resource.id; //Hasta que no se cargue la imagen, guardamos el ID en una variable auxiliar
				
				//Cargamos la imagen
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleData);
				loader.load(new URLRequest(url));
			}
		}
		
		///<summary>
		///Evento que carga la imagen de fondo y la coloca
		///</summary>
		function handleData(e:Event)
		{
			//Borramos si ya existe
			for (var i:int = 0; i<getPadre().lienzo.contenedor.area_editable.numChildren; i++)
			{
				var tipo_elemento:String = getPadre().lienzo.contenedor.area_editable.getChildAt(i);
				if (tipo_elemento.indexOf("MovieClip") != -1)
				{
					getPadre().lienzo.contenedor.area_editable.removeChildAt(i);
					i=0;
				}
			}
			
			imagen_fondo = new MovieClip();
			this.fondo_ID = this.aux_ID; //Una vez que tenemos la imagen, guardamos el ID en fondo_ID
			imagen_fondo.addChild(e.currentTarget.content);
			imagen_fondo.width = getPadre().anL;
			imagen_fondo.height = getPadre().alL;
			getPadre().lienzo.contenedor.area_editable.addChild(imagen_fondo);
		}
		
		///<summary>
		///Elimina el fondo del lienzo
		///</summary>
		private function eliminarFondo(e:Event):void 
		{
			getPadre().setUrlFondo("");
			nombre_fondo.text = "";
			this.fondo_ID = "";
			this.aux_ID = "";
			
			for (var i:int = 0; i<getPadre().lienzo.contenedor.area_editable.numChildren; i++)
			{
				var tipo_elemento:String = getPadre().lienzo.contenedor.area_editable.getChildAt(i);
				if (tipo_elemento.indexOf("MovieClip") != -1)
				{
					getPadre().lienzo.contenedor.area_editable.removeChildAt(i);
					i=0;
				}
			}
		}
		
		///<summary>
		///Event Listener que controla la relación de aspecto
		///</summary>
		public function changeRelacionDeAspecto(e:MouseEvent):void 
		{
			if (getPadre().elemento_seleccionado != null)
			{
				trace("tipoooooooo _ "+getPadre().elemento_seleccionado.getTipo());
				//if(getPadre().elemento_seleccionado.getTipo() == "analog" || getPadre().elemento_seleccionado.getTipo() == "digital" || getPadre().elemento_seleccionado.getTipo() == "reloj")
				if(getPadre().elemento_seleccionado.getTipo() != "imagen" && getPadre().elemento_seleccionado.getTipo() != "rss" && getPadre().elemento_seleccionado.getTipo() != "texto")
				{
					getPadre().setCandadoPadre(true);
					getPadre().elemento_seleccionado.setCandado(true);
					btnRelacion.selected = true;
				}
				else if (getPadre().elemento_seleccionado.getCandado())
				{
					getPadre().setCandadoPadre(false);
					getPadre().elemento_seleccionado.setCandado(false);
					btnRelacion.selected = false;
				}
				else
				{
					getPadre().setCandadoPadre(true);
					getPadre().elemento_seleccionado.setCandado(true);
					btnRelacion.selected = true;
				}
			}
			
			if (getPadre().elemento_seleccionMultiple != null)
			{
				if (getPadre().elemento_seleccionMultiple.getCandado())
				{
					getPadre().setCandadoPadre(false);
					getPadre().elemento_seleccionMultiple.setCandado(false);
					btnRelacion.selected = false;
				}
				else
				{
					getPadre().setCandadoPadre(true);
					getPadre().elemento_seleccionMultiple.setCandado(true);
					btnRelacion.selected = true;
				}
			}
		}
		///<summary>
		///Actualiza los valores del panel según el elemento indicado
		///</summary>
		public function insertPropGenericas(obj:MovieClip):void 
		{
			if (obj is CContenedorElemento) //UN ÚNICO ELEMENTO SELECCIONADO
			{
				trace("cargando propiedades elemento seleccionado");
				t_ancho.text = Math.round(obj.datos_elemento.width).toString();
				t_alto.text = Math.round(obj.datos_elemento.height).toString();
				t_x.text = Math.round(obj.x).toString();
				t_y.text = Math.round(obj.y).toString();			
				t_transparencia.text = (obj.getTransparencia()*100).toString();
				
				//Si es un elemento reloj, ORONA nos ha pedido que dejemos el candado 
				//habilitado por defecto
				if(obj.getTipo() == "reloj")
				{
					btnRelacion.selected = true;
					getPadre().setCandadoPadre(true);
					obj.setCandado(true);
					btnRelacion.enabled = false;
				}
				else
				{
					btnRelacion.enabled = true;
					btnRelacion
					if (obj.getCandado())
					{
						btnRelacion.selected = true;
						
						getPadre().setCandadoPadre(true);
					}
					else
					{
						btnRelacion.selected = false;
						getPadre().setCandadoPadre(false);
					}
				}
				
				control_profundidad.value = obj.getProfundidad();
			}
			else if (obj is CContenedorSeleccionMultiple) //MULTISELECCIÓN -> mantenemos relación de ancho/alto por defecto
			{
				trace("cargando propiedades de multiseleccion");
				getPadre().setCandadoPadre(true);
				obj.setCandado(true);
				btnRelacion.selected = true;
				for(var i :int = 0;i<getPadre().listaElementosSeleccionados.length;i++)
				{
					getPadre().listaElementosSeleccionados[i].setCandado(true);
				}
				t_ancho.text = Math.round(obj.contenedor.width).toString();
				t_alto.text = Math.round(obj.contenedor.height).toString();
				t_x.text = Math.round(obj.x).toString();
				t_y.text = Math.round(obj.y).toString();			
				t_transparencia.text = (obj.contenedor.alpha*100).toString();
			}
		}
		
		///<summary>
		///Borra los datos del panel de propiedades
		///</summary>
		public function borrarPanelPropiedades():void
		{
			t_ancho.text = "";
			t_alto.text = "";
			t_x.text = "";
			t_y.text = "";
			t_transparencia.text = "";
			control_profundidad.value = 0;
			getPadre().setCandadoPadre(false);
			btnRelacion.selected = false;
		}
		
		///<summary>
		///Muestra el ancho y el alto en el panel de propiedades
		///		-> Lo usamos cuando cambiamos la dimensión de un elemento con relación de aspecto
		///</summary>
		public function mostrarEnPanelPropiedades(ancho:Number,alto:Number):void
		{
			t_ancho.text = ancho.toString();
			t_alto.text = alto.toString();
		}
		
		/*************************************VOLVER***********************************************************/
		///<summary>
		///Vuelve sin guardar
		///</summary>
		public function onVolver(e:MouseEvent)
		{
			getPadre().vaciarContenedor();
			getPadre().volverSinGuardar();
		}
		
		/******************************************************************************************************/
		
		/**************************************GUARDAR VERSIÓN***************************************************/
		///<summary>
		///Crea el xml con todos los elementos que hay en el lienzo y llama a Flex
		///</summary>
		public function onGuardarVersion(e:MouseEvent)
		{
			var listaElementos:Array = getPadre().getListaElementos();
			var array_recursos:Array = new Array();
			
			var myXML:XML = <?xml version="1.0" encoding = "UTF-8"?>;
			var presentacion:XML = <Content></Content>;
			presentacion.@alto_salida = alRes;
			presentacion.@ancho_salida = anRes;
			presentacion.@alto_original = alL;
			presentacion.@ancho_original = anL;
						
			//diapo == Area

			var diapo:XML = <AREA></AREA>;
			diapo.@tipo = "1";
			diapo.@pathfondo = getPadre().getUrlFondo();
			if (this.fondo_ID != "") 
			{
				//array_recursos.push(this.fondo_ID);
				//iñaki
				array_recursos.push(getPadre().getUrlFondo());
				diapo.@ID = this.fondo_ID;
			}
			else diapo.@ID = "";
			
			for (var i:int = 0; i< listaElementos.length; i++)
			{
				var item:CContenedorElemento = listaElementos[i];	
				
				var elemento:XML;
				elemento = new XML("<ELEMENTO/>");
				elemento.@alto = Math.round(item.datos_elemento.height)/alL;
				elemento.@ancho = Math.round(item.datos_elemento.width)/anL;
				
				//Según el tipo, vamos añadiendo atributos a la etiqueta, o modificándola
				switch(item.getTipo())
				{
					case "swf":
						elemento.@tipo = "swf";
						elemento.@ID = listaElementos[i].getID();
						array_recursos.push(listaElementos[i].getUrlDatos());
						break;
					case "imagen":
						elemento.@tipo = "imagen";
						elemento.@ID = listaElementos[i].getID();
						array_recursos.push(listaElementos[i].getUrlDatos());
						break;
					case "video":
						elemento.@tipo = "video";
						elemento.@ID = listaElementos[i].getID();
						elemento.@bucle = item.bucle;
						array_recursos.push(listaElementos[i].getUrlDatos());
						break;
					case "texto":						
						var contenido:String = unescape(item.texto.htmlText);
						var contenido1 = contenido.split("<LI").join("<P><LI");
						contenido1 = contenido1.split("/LI>").join("/LI></P>");
						contenido1 = contenido1.split('LETTERSPACING="0"').join('');
						contenido1 = contenido1.split('KERNING="0"').join('');
						elemento = new XML("<ELEMENTO>"+contenido1+"</ELEMENTO>");
						elemento.@tipo = "texto";
						elemento.@alto = item.texto.height/alL;
						elemento.@ancho = item.texto.width/anL;
						item.setUrlDatos("ninguno");
						break;
					case "anuncio":
						elemento.@tipo = "anuncio";
						item.setUrlDatos("ninguno");
						break;
					case "rss":
						elemento.@tipo = "rss";
						elemento.@estilo = item.estilo_rss;
						elemento.@tiempo_transicion = item.tiempo_trans_rss;
						elemento.@velocidad = item.velocidad_rss;
						elemento.@titulo_activo = item.tituloActivo;
						elemento.@velocidad_titulo = item.velocidad_titulo;
						elemento.@imagen_visible = item.imagenVisible;
						elemento.@color_superior = item.color_sup;
						elemento.@alpha_superior = item.alpha_superior;
						elemento.@color_inferior = item.color_inf;
						elemento.@alpha_inferior = item.alpha_inferior;
						elemento.@color_titulos = item.color_titulo;
						elemento.@color_textos = item.color_texto;
						elemento.@fuente_titulos = item.fuente_titulo;
						elemento.@fuente_textos = item.fuente_texto;
						elemento.@size_titulos = item.size_titulo;
						elemento.@size_textos = item.size_texto;
						elemento.@align_titulos = item.align_titulo;
						elemento.@align_textos = item.align_texto;
						elemento.@negrita_titulo = item.negrita_titulo;
						elemento.@negrita_texto = item.negrita_texto;
						elemento.@cursiva_titulo = item.cursiva_titulo;
						elemento.@cursiva_texto = item.cursiva_texto;
						elemento.@subrayado_titulo = item.subrayado_titulo;
						elemento.@subrayado_texto = item.subrayado_texto;
						elemento.@rss_url = item.rss_url;
						break;
					case "tiempo":
						var elemento_tiempo:CElementoTiempo = item.lector_tiempo;
						elemento.@tipo = "tiempo";
						elemento.@dia = elemento_tiempo.getDia();
						elemento.@ciudad = elemento_tiempo.getCodigoCiudad();
						elemento.@pais = elemento_tiempo.getPais();
						elemento.@estilo = elemento_tiempo.getEstilo();
						elemento.@posicion_textos = elemento_tiempo.getPosicion();
						elemento.@fecha_formato = elemento_tiempo.getFormatoFecha();
						elemento.@fecha_fuente = elemento_tiempo.getFuenteFecha();
						elemento.@fecha_color = elemento_tiempo.getColorFecha();
						elemento.@fecha_negrita = elemento_tiempo.getNegritaFecha();
						elemento.@fecha_cursiva = elemento_tiempo.getCursivaFecha();
						elemento.@fecha_subrayado = elemento_tiempo.getSubrayadoFecha();
						elemento.@temp_fuente = elemento_tiempo.getFuenteTemp();
						elemento.@temp_color = elemento_tiempo.getColorTemp();
						elemento.@temp_negrita = elemento_tiempo.getNegritaTemp();
						elemento.@temp_cursiva = elemento_tiempo.getCursivaTemp();
						elemento.@temp_subrayado = elemento_tiempo.getSubrayadoTemp();
						break;
					case "ticker":
						elemento.@tipo = "ticker";
						var texto:TextField = item.texto_ticker;
						var formato:TextFormat = texto.getTextFormat();
						elemento.@fuente = formato.font;
						elemento.@size = formato.size;
						elemento.@color = formato.color;
						elemento.@alineacion = formato.align;
						elemento.@negrita = formato.bold;
						elemento.@cursiva = formato.italic;
						elemento.@subrayado = formato.underline;
						elemento.@velocidad = item.velocidad_ticker;
						item.setUrlDatos("ticker.swf");
 						break;
					case "pasafotos":
						elemento.@tipo = "pasafotos";
						var array_imagenes:Array = item.getArrayPasafotos();
						var array_IDs_imagenes:Array = item.getArrayIDsPasafotos();
						var lista_imagenes:String = "";
						var lista_IDs:String = "";
						var j:int = 0;
						for (j = 0; j<array_imagenes.length; j++)
						{
							lista_imagenes = lista_imagenes.concat(array_imagenes[j],",");
						}
						for (j = 0; j<array_IDs_imagenes.length; j++)
						{
							array_recursos.push(array_imagenes[j]);
							lista_IDs = lista_IDs.concat(array_IDs_imagenes[j],",");
						}
						lista_imagenes = lista_imagenes.substr(0,lista_imagenes.length-1);
						lista_IDs = lista_IDs.substr(0,lista_IDs.length-1);
						
						elemento.@ID = lista_IDs;
						elemento.@url_imagenes = lista_imagenes;
						elemento.@tiempo_trans = item.getTimerPasafotos();
						elemento.@vel_trans = item.getVelocidadTransicion();
						elemento.@sentido = item.getSentidoPasafotos();
						elemento.@direccion = item.getDireccionPasafotos();
						elemento.@efecto = item.getEfectoPasafotos();
						item.setUrlDatos("pasafotos_VDAP.swf");
						break;
					case "reloj":
						elemento.@tipo = "reloj";
						var elemento_reloj:CElementoReloj_extendido = item.control_reloj;
						elemento.@tipo_reloj = elemento_reloj.getTipo();;						
						elemento.@color_agujas = elemento_reloj.getColorAgujas();
						elemento.@alpha_agujas = elemento_reloj.getAlphaAgujas();
						elemento.@color_marcas = elemento_reloj.getColorMarcas();
						elemento.@alpha_marcas = elemento_reloj.getAlphaMarcas();
						elemento.@color_sombra = elemento_reloj.getColorSombra();
						elemento.@alpha_sombra = elemento_reloj.getAlphaSombra();
						elemento.@color_fondo = elemento_reloj.getColorFondo();
						elemento.@alpha_fondo = elemento_reloj.getAlphaFondo();
						elemento.@color_marco = elemento_reloj.getColorMarco();
						elemento.@alpha_marco = elemento_reloj.getAlphaMarco();
						elemento.@color_remarco = elemento_reloj.getColorRemarco();
						elemento.@alpha_remarco = elemento_reloj.getAlphaRemarco();
						elemento.@color_numeros = elemento_reloj.getColorNumeros();
						elemento.@alpha_numeros = elemento_reloj.getAlphaNumeros();
						//digital
						elemento.@color_mes = elemento_reloj.getColorMes();
						elemento.@color_dia = elemento_reloj.getColorDia();
						elemento.@color_numDia = elemento_reloj.getColorNumDia();
						elemento.@alpha_mes = elemento_reloj.getAlphaMes();
						elemento.@alpha_dia = elemento_reloj.getAlphaDia();
						elemento.@alpha_numDia = elemento_reloj.getAlphaNumDia();						
						break;
					case "menu":
						elemento.@tipo = "menu";
						if (item.fondoMenu_ID != "") 
						{
							elemento.@ID = item.fondoMenu_ID;
							array_recursos.push(item.fondo_url);
						}
						var menu:CElementoControlMenu = item.control_menu;
						elemento.@estilo = menu.getNombreEstilo();
						elemento.@url_fondo = menu.getUrlFondo();
						elemento.@color_fondo = menu.getColorFondo();
						elemento.@hayColorFondo = menu.getHayColorFondo();
						elemento.@existe_fondo = menu.getExisteFondo();
						elemento.@cabecera_txt = menu.getTxtCabecera();
						elemento.@tituloP_txt = menu.getTxtTituloP();
						elemento.@titulo1_txt = menu.getTxtTitulo1();
						elemento.@titulo2_txt = menu.getTxtTitulo2();
						elemento.@titulo3_txt = menu.getTxtTitulo3();
						elemento.@texto1_txt = menu.getTxtTexto1();
						elemento.@texto2_txt = menu.getTxtTexto2();
						elemento.@texto3_txt = menu.getTxtTexto3();
						elemento.@pie_txt = menu.getTxtPie();
						
						elemento.@cabecera_visible = menu.getVisibleCabecera();
						elemento.@tituloP_visible = menu.getVisibleTituloP();
						elemento.@titulo1_visible = menu.getVisibleTitulo1();
						elemento.@titulo2_visible = menu.getVisibleTitulo2();
						elemento.@titulo3_visible = menu.getVisibleTitulo3();
						elemento.@texto1_visible = menu.getVisibleTexto1();
						elemento.@texto2_visible = menu.getVisibleTexto2();
						elemento.@texto3_visible = menu.getVisibleTexto3();
						elemento.@pie_visible = menu.getVisiblePie();
						
						elemento.@cabecera_color = menu.getColorCabecera();
						elemento.@tituloP_color = menu.getColorTituloP();
						elemento.@titulo1_color = menu.getColorTitulo1();
						elemento.@titulo2_color = menu.getColorTitulo2();
						elemento.@titulo3_color = menu.getColorTitulo3();
						elemento.@texto1_color = menu.getColorTexto1();
						elemento.@texto2_color = menu.getColorTexto2();
						elemento.@texto3_color = menu.getColorTexto3();
						elemento.@pie_color = menu.getColorPie();
						
						elemento.@cabecera_fuente = menu.getFuenteCabecera();
						elemento.@tituloP_fuente = menu.getFuenteTituloP();
						elemento.@titulo1_fuente = menu.getFuenteTitulo1();
						elemento.@titulo2_fuente = menu.getFuenteTitulo2();
						elemento.@titulo3_fuente = menu.getFuenteTitulo3();
						elemento.@texto1_fuente = menu.getFuenteTexto1();
						elemento.@texto2_fuente = menu.getFuenteTexto2();
						elemento.@texto3_fuente = menu.getFuenteTexto3();
						elemento.@pie_fuente = menu.getFuentePie();
						
						elemento.@cabecera_size = menu.getTamañoCabecera();
						elemento.@tituloP_size = menu.getTamañoTituloP();
						elemento.@titulo1_size = menu.getTamañoTitulo1();
						elemento.@titulo2_size = menu.getTamañoTitulo2();
						elemento.@titulo3_size = menu.getTamañoTitulo3();
						elemento.@texto1_size = menu.getTamañoTexto1();
						elemento.@texto2_size = menu.getTamañoTexto2();
						elemento.@texto3_size = menu.getTamañoTexto3();
						elemento.@pie_size = menu.getTamañoPie();
						
						elemento.@cabecera_align = menu.getAlineacionCabecera();
						elemento.@tituloP_align = menu.getAlineacionTituloP();
						elemento.@titulo1_align = menu.getAlineacionTitulo1();
						elemento.@titulo2_align = menu.getAlineacionTitulo2();
						elemento.@titulo3_align = menu.getAlineacionTitulo3();
						elemento.@texto1_align = menu.getAlineacionTexto1();
						elemento.@texto2_align = menu.getAlineacionTexto2();
						elemento.@texto3_align = menu.getAlineacionTexto3();
						elemento.@pie_align = menu.getAlineacionPie();
						
						elemento.@cabecera_negrita = menu.getNegritaCabecera();
						elemento.@tituloP_negrita = menu.getNegritaTituloP();
						elemento.@titulo1_negrita = menu.getNegritaTitulo1();
						elemento.@titulo2_negrita = menu.getNegritaTitulo2();
						elemento.@titulo3_negrita = menu.getNegritaTitulo3();
						elemento.@texto1_negrita = menu.getNegritaTexto1();
						elemento.@texto2_negrita = menu.getNegritaTexto2();
						elemento.@texto3_negrita = menu.getNegritaTexto3();
						elemento.@pie_negrita = menu.getNegritaPie();
						
						elemento.@cabecera_cursiva = menu.getCursivaCabecera();
						elemento.@tituloP_cursiva = menu.getCursivaTituloP();
						elemento.@titulo1_cursiva = menu.getCursivaTitulo1();
						elemento.@titulo2_cursiva = menu.getCursivaTitulo2();
						elemento.@titulo3_cursiva = menu.getCursivaTitulo3();
						elemento.@texto1_cursiva = menu.getCursivaTexto1();
						elemento.@texto2_cursiva = menu.getCursivaTexto2();
						elemento.@texto3_cursiva = menu.getCursivaTexto3();
						elemento.@pie_cursiva = menu.getCursivaPie();
						
						elemento.@cabecera_subrayado = menu.getSubrayadoCabecera();
						elemento.@tituloP_subrayado = menu.getSubrayadoTituloP();
						elemento.@titulo1_subrayado = menu.getSubrayadoTitulo1();
						elemento.@titulo2_subrayado = menu.getSubrayadoTitulo2();
						elemento.@titulo3_subrayado = menu.getSubrayadoTitulo3();
						elemento.@texto1_subrayado = menu.getSubrayadoTexto1();
						elemento.@texto2_subrayado = menu.getSubrayadoTexto2();
						elemento.@texto3_subrayado = menu.getSubrayadoTexto3();
						elemento.@pie_subrayado = menu.getSubrayadoPie();
						
						elemento.@cabecera_bullet = menu.getBulletsCabecera();
						elemento.@tituloP_bullet = menu.getBulletsTituloP();
						elemento.@titulo1_bullet = menu.getBulletsTitulo1();
						elemento.@titulo2_bullet = menu.getBulletsTitulo2();
						elemento.@titulo3_bullet = menu.getBulletsTitulo3();
						elemento.@texto1_bullet = menu.getBulletsTexto1();
						elemento.@texto2_bullet = menu.getBulletsTexto2();
						elemento.@texto3_bullet = menu.getBulletsTexto3();
						elemento.@pie_bullet = menu.getBulletsPie();		
						item.setUrlDatos("control_menu.swf");
						break;
					default:
						break;
				}
				
				elemento.@profundidad = item.getProfundidad();
				elemento.@transparencia = item.getTransparencia();
				elemento.@cY = item.y/alL;
				elemento.@cX = item.x/anL;
				elemento.@path = item.getUrlDatos();
				
				trace("GUARDANDO PATH -> "+item.getUrlDatos());
				if(item.getUrlDatos() != null && item.getUrlDatos() != "null")//solo lo guardamos si el path no es vacio
				{
					trace("añadiendo elemento a la diapo... "+elemento);
					diapo.appendChild(elemento);
				}
			}
			
			presentacion.appendChild(diapo);
			myXML.appendChild(presentacion)
			trace(presentacion);

			getPadre().vaciarContenedor();
			for(var i : int = 0;i<array_recursos.length;i++)
			{
				trace("array_recursos["+i+"] => "+array_recursos[i]);
			}
			getPadre().saveContentFlash(presentacion,array_recursos);
		}
		/********************************************************************************************************/
		
		public function limpiarNodos(nodo: XML):XML
		{
			if(nodo.children().length()== 0)
			{
				return null
			}
			var lista : XMLList = nodo.children();
			trace("numero de Ps: "+lista.length());
			for(var i : int=0;i<lista.length();i++)
			{
				
				trace("Numero de fonts: "+lista[i].children().length());
				for(var j : int=0;j<lista[i].children().length();j++)
				{
					if(lista[i].children()[j].children().length() == 0 && String(lista[i].children()[j].children().text()) == "")
					{
						trace("eliminar de la lista");
						delete lista[i].children()[j];
					}
				}
				
			}
			trace("-------------------------------------------------------------------------");
			trace(lista.toXMLString());
			trace("-------------------------------------------------------------------------");
			return(nodo);
		}
		
	}
	
}
