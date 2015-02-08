package com.innovae.oce.domain.datamodel 
{	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Loader;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.text.*;	
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.events.EventDispatcher;
	
	import cod.*;
	import flash.external.ExternalInterface;
	import com.innovae.oce.domain.datamodel.oceEditorInterface;
	import com.innovae.oce.domain.datamodel.resourceReceivedEvent;
	import com.innovae.oce.domain.datamodel.oceEditorProviderInterface;
		
	public class CMainOCE_areav0 extends MovieClip implements oceEditorInterface
	{		
		//*****************************VARIABLES************************************/
		//Interface
		public var _resourceLibrary:Object;
		
		//Stage + paneles
		private var panel_herramientas:CHerramientas;
		private var panel_propiedades:CPanelPropiedades;
		private var panel_propEsp:CPanelPropiedadesEspecificas;
		private var candado_padre:Boolean = false;
		
		//Panel de propiedades
		public var cambioAncho:Boolean = false;
		public var cambioAlto:Boolean = false;
		public var ancho_anterior:Number;
		public var alto_anterior:Number;
		
		//Variables para el lienzo
		var desactivarOnAreaEditable:Boolean = false;
		
		//Elementos en el área
		private var listaElementos:Array;
		public var elementoBorrado:int = -1;
		private var urlFondo:String = "";
		
		//Elemento
		private var tipo_elemento:String;
		public var elemento_seleccionado:CContenedorElemento; //Guarda la instancia del elemento seleccionado
		public var IDelemento_seleccionado:int;
		
		//Profundidades
		public var zMax:Number = 0;
		
		//Eventos teclado
		private var keyCode:String = "";
		
		//Multiseleccion
		public var permitirSeleccion:Boolean = false;
		public var borrado:Boolean = true;
		public var borrarElementos:Boolean = false;
		public var elemento_seleccionMultiple:CContenedorSeleccionMultiple;
		public var listaElementosSeleccionados:Array;
		public var contenedorSeleccion:CContenedorSeleccionMultiple;
		public var arrayDatos:Array;
		public var arrayContenido:Array;
		public var mc:MovieClip;
		public var contenedorEliminado:Boolean = true;
		public var elemento_a_borrar:CContenedorElemento;
		
		//Multiselección - auxiliares de posicionamiento
		public var xmin:Number = 1000;
		public var ymin:Number = 1000;
		public var xmax:Number = -10;
		public var ymax:Number = -10;
		public var xtotal:Number = -10;
		public var ytotal:Number = -10;
		public var totalWidth:Number = 0;
		public var totalHeight:Number = 0;
		public var diferencia_x:Number = 0;
		public var diferencia_y:Number = 0;
		public var dif_x:Number = 0;
		public var dif_y:Number = 0;
		
		//Multiselección con ratón
		var pizarra:Shape;
		var anchoMS:Number;
		var altoMS:Number;
		var initX:Number; //Posición en x donde empieza el cuadrado
		var initY:Number; //Posición en y donde empieza el cuadrado
		
		
		//Cargar versión existente
		public var alL:Number;
		public var anL:Number;
		var anRes:Number;
		var alRes:Number
		var elementos:XMLList;
		
		//**************************FIN VARIABLES**********************************/
		
		//*****************************GETTERS/SETTERS************************************/
		public function getPanelHerramientas():CHerramientas {return panel_herramientas;}
		public function getPanelPropiedades():CPanelPropiedades {return panel_propiedades;}
		public function getPanelPropiedadesEspecificas():CPanelPropiedadesEspecificas {return panel_propEsp;}
		public function getCandadoPadre():Boolean {return candado_padre;}
		public function getListaElementos():Array {return listaElementos;}
		public function getTipoElemento():String {return tipo_elemento;}
		public function getKeyCode():String {return keyCode;}
		public function getUrlFondo():String {return urlFondo;}
		
		public function setPanelHerramientas(val:CHerramientas):void {panel_herramientas = val;}
		public function setPanelPropiedades(val:CPanelPropiedades):void {panel_propiedades = val;}
		public function setPanelPropiedadesEspecificas(val:CPanelPropiedadesEspecificas):void {panel_propEsp = val;}
		public function setCandadoPadre(val:Boolean):void {candado_padre = val;}
		public function setListaElementos(val:Array):void {listaElementos = val;}
		public function setTipoElemento(val:String):void {tipo_elemento = val;}
		public function setKeyCode(val:String):void {keyCode = val;}
		public function setUrlFondo(val:String):void {urlFondo = val;}
		//********************************************************************************/
		
		///<summary>
		///Constructor; carga los paneles en el stage
		///</summary>
		public function CMainOCE_areav0() 
		{
			//Variables lienzo
			anL = 225; //Ancho del lienzo
			alL = 170; //Alto del lienzo
			anRes = 600; //Resolucion (ancho)
			alRes = 800; //Resolucion (alto)
			
			//Inicializamos variables
			listaElementos = new Array();
			
			//Cargamos paneles
			cargarPanelHerramientas();
			cargarPanelPropiedades();
			cargarPanelPropiedadesEspecíficas();
			
			//Cargamos listeners
			cargarListeners();
			
			//CARGAR ELEMENTOS DE VERSIÓN EXISTENTE -> CUANDO SE INTEGRE LA INTERFAZ HABRÁ QUE QUITAR ESTO!!
			//loadXML_provisional();
		}
		
		//******************************Elementos stage****************************************//
		
		///<summary>
		///Carga el panel de herramientas
		///</summary>
		private function cargarPanelHerramientas():void
		{
			panel_herramientas = new CHerramientas(this);
			panel_herramientas.setXpos(424);
			panel_herramientas.setYpos(25);
			panel_herramientas.load();
			addChild(panel_herramientas);
		}
		
		///<summary>
		///Carga el panel de propiedades genéricas
		///</summary>
		private function cargarPanelPropiedades():void
		{
			panel_propiedades = new CPanelPropiedades(this);
			panel_propiedades.setXpos(424);
			panel_propiedades.setYpos(78);
			panel_propiedades.load();
			this.addChild(panel_propiedades);
		}
		
		///<summary>
		///Carga el panel de propiedades específicas
		///</summary>
		private function cargarPanelPropiedadesEspecíficas():void
		{
			panel_propEsp = new CPanelPropiedadesEspecificas(this);
			panel_propEsp.setXpos(424);
			panel_propEsp.setYpos(330);
			panel_propEsp.load();
			this.addChild(panel_propEsp);
		}
		
		//******************************fin Elementos stage**************************************//
		
		///<summary>
		///Carga los event listeners para el lienzo y el teclado
		///</summary>
		function cargarListeners():void
		{		
				//---------------------------------TECLADO----------------------------------//
			trace("[oceEditor]cargarListeners - keyDownListener");
			addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			trace("[oceEditor]cargarListeners - keyUpListener");
			addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
			//--------------------------------------------------------------------------------//
			
			//------------------------------AREA DE EDICIÓN----------------------------------//
			trace("[oceEditor]cargarListeners - mouseDownListener");
			lienzo.contenedor.area_editable.addEventListener(MouseEvent.MOUSE_DOWN, startRect);
			trace("[oceEditor]cargarListeners - mouseClickListener");
			lienzo.contenedor.area_editable.addEventListener(MouseEvent.CLICK, onAreaEditable);
			//--------------------------------------------------------------------------------//
		}
		
		//******************************Eventos teclado**************************************//
		///<summary>
		///Controla si están pulsadas las teclas Ctrl y Mayus para la multiselección, o las flechas para mover objetos
		///</summary>
		function keyDownHandler( e:KeyboardEvent ):void
		{
			//trace("[oceEditor]keyDownHandler ("+e.keyCode+")");
			if ((e.keyCode == 16) || (e.keyCode == 17))
			{
				permitirSeleccion = true;
				keyCode = e.keyCode.toString();
				if (borrado)  
				{
					borrarElementos = false;
				}
				else borrarElementos = true;
			}
			//HEMOS COMENTADO LOS EVETOS PARA LAS FLECHAS PORQUE INTERFIERE CON 
			//EL CONTENEDOR EN FLEX
			//switch(e.keyCode)
//			{
//				case 16: break;
//				case 17: break;
//				case 37: moverObjeto("left"); break;
//				case 38: moverObjeto("up"); break;
//				case 39: moverObjeto("right"); break;
//				case 40: moverObjeto("down"); break;
//			}
		}
		
		///<summary>
		///Controla si se ha dejado de pulsar alguna tecla
		///</summary>
		public function keyUpHandler( e:KeyboardEvent ):void
		{
			if ((e.keyCode == 16) || (e.keyCode == 17)) 
			{
				permitirSeleccion = false;
			}
			keyCode = "";
		}
		
		///<summary>
		///Mueve el elemento seleccionado mediante el teclado - DESACTIVADO POR EL MOMENTO!
		///</summary>
		public function moverObjeto(direccion:String)
		{
			if (elemento_seleccionado != null)
			{
				switch (direccion)
				{
					case "left": 
						if ((elemento_seleccionado.x - 1) > 0) elemento_seleccionado.x --; 
						break;
					case "up": 
						if ((elemento_seleccionado.y - 1) > 0) elemento_seleccionado.y --; 
						break;
					case "right": 
						if ((elemento_seleccionado.x + 1 + elemento_seleccionado.datos_elemento.width) < lienzo.contenedor.area_editable.width) elemento_seleccionado.x ++; 
						break;
					case "down": 
						if ((elemento_seleccionado.y + 1 + elemento_seleccionado.datos_elemento.height) < lienzo.contenedor.area_editable.height) elemento_seleccionado.y ++; 
						break;
				}
				elemento_seleccionado.setXpos(elemento_seleccionado.x);
				elemento_seleccionado.setYpos(elemento_seleccionado.y);
				panel_propiedades.insertPropGenericas(elemento_seleccionado);
			}
			else if (elemento_seleccionMultiple != null)
			{
				diferencia_y = 0;
				diferencia_x = 0;
				switch (direccion)
				{
					case "left": 
						if ((elemento_seleccionMultiple.x - 1) > 0)
						{
							elemento_seleccionMultiple.x --; 
							diferencia_x = -1;
						} 
						break;
					case "up": 
						if ((elemento_seleccionMultiple.y - 1) > 0)
						{
							elemento_seleccionMultiple.y --; 
							diferencia_y = -1;
						} 
						break; 
					case "right": 
						if ((elemento_seleccionMultiple.x + 1 + elemento_seleccionMultiple.contenedor.width) < lienzo.contenedor.area_editable.width)
						{
							elemento_seleccionMultiple.x ++;  
							diferencia_x = 1; 
						}
						break;
					case "down": 
						if ((elemento_seleccionMultiple.y + 1 + elemento_seleccionMultiple.contenedor.height) < lienzo.contenedor.area_editable.height)
						{
							elemento_seleccionMultiple.y ++;  
							diferencia_y = 1; 
						}
						break;
						
				}
				
				elemento_seleccionMultiple.setXpos(elemento_seleccionMultiple.x);
				elemento_seleccionMultiple.setYpos(elemento_seleccionMultiple.y);
				panel_propiedades.insertPropGenericas(elemento_seleccionMultiple);
				actualizarArrayDatos();
			}			
		}
		/*****************************fin eventos teclado************************************************/
		
		/***********************************Multiselección con el ratón*****************************************/
		///<summary>
		///Crea el cuadrado que se irá pintando a medida q se mueve el ratón
		///</summary>
		function startRect(e:MouseEvent)
		{
			//Para evitar que el texto se quede seleccionado
			if ((elemento_seleccionado!= null)&&(elemento_seleccionado.texto != null))
			{
				elemento_seleccionado.texto.setSelection(elemento_seleccionado.texto.text.length,elemento_seleccionado.texto.text.length);
				elemento_seleccionado.texto.type = TextFieldType.DYNAMIC;
			}
			
			//Desactivamos el elemento activo en el lienzo
			desactivarAnterior();
			
			//Guardamos las coordenadas en x e y desde las que se empieza a pintar el cuadrado
			this.initX = mouseX;
			this.initY = mouseY;
			
			//Cuadrado azul que pintamos en el lienzo
			pizarra = new Shape(); 
			pizarra.graphics.lineStyle(2, 0x0000FF); //Grosor y color
			addChild(pizarra);
			this.addEventListener(Event.ENTER_FRAME, pintandoCuadrado);
			stage.addEventListener(MouseEvent.MOUSE_UP,endRect);
		}
		
		///<summary>
		///Pinta el cuadrado siguiendo el movimiento del ratón
		///</summary>
		function pintandoCuadrado (e:Event)
		{
			pizarra.graphics.clear(); //Borramos lo pintado hasta ahora para actualizar el cuadro
			var posXmouse:Number = mouseX;
			var posYmouse:Number = mouseY;
			if (posXmouse <= lienzo.x) posXmouse = lienzo.x;
			if (posXmouse >= lienzo.x + lienzo.width) posXmouse = lienzo.x + lienzo.width;
			if (posYmouse <= lienzo.y) posYmouse =  lienzo.y;
			if (posYmouse >= lienzo.y + lienzo.contenedor.height) posYmouse = lienzo.y + lienzo.contenedor.height;
			pizarra.graphics.lineStyle(2, 0x0000FF); 
			pizarra.graphics.moveTo(initX, initY);
			pizarra.graphics.lineTo(posXmouse, initY);
			pizarra.graphics.lineTo(posXmouse, posYmouse);
			pizarra.graphics.lineTo(initX, posYmouse);
			pizarra.graphics.lineTo(initX, initY);
		}
		
		///<summary>
		///Dejamos de pintar el cuadrado y llama activarMultiseleccion() con las dimensiones y posicion del cuadrado
		///</summary>
		function endRect(e:MouseEvent)
		{
			//Eliminamos el cuadrado de la multiselección
			this.removeEventListener(Event.ENTER_FRAME, pintandoCuadrado);
			pizarra.graphics.clear();		
					
			var contenedorTocado:Boolean = false;
			var elementoTocado:Boolean = false;
						
			//Guardamos coordenadas en x e y del ratón
			var pos_mouseX:Number = e.currentTarget.mouseX - lienzo.x;
			var pos_mouseY:Number = e.currentTarget.mouseY - lienzo.y;
			
			//Comprobamos si el cuadrado terminaba en algún elemento del lienzo
			//Si es así, ponemos elementoTocado a true
			for (var i:int = 0; i< listaElementos.length; i++)
			{
				var elem_posX:Number = listaElementos[i].x;
				var elem_posY:Number = listaElementos[i].y;
				if ((pos_mouseX >= elem_posX) && (pos_mouseX <= (elem_posX + listaElementos[i].width)) && (pos_mouseX >= elem_posY) && (pos_mouseY <= (elem_posY + listaElementos[i].height))) elementoTocado = true;
			}
			
			//Comprobamos si el cuadrado terminaba fuera del lienzo
			//Si es así, ponemos contenedorTocado a true
			if ((mouseX >= 24) && (mouseX <= 402)) contenedorTocado = true;
			if ((mouseY >= 70) && (mouseY <= 870) )contenedorTocado = true;
			
			if ((keyCode != "16")&&(keyCode != "17"))
			{
				if (pizarra != null)
				{
					this.removeEventListener(Event.ENTER_FRAME, pintandoCuadrado);
					pizarra.graphics.clear();				
					
					if ((elemento_seleccionado == null) && (elemento_seleccionMultiple == null))
					{
						//Ancho y alto del cuadrado
						anchoMS = mouseX - initX;
						altoMS = mouseY - initY;
						
						if (elemento_seleccionMultiple != null)
						{
							if  (!elemento_seleccionMultiple.isDragging) activarMultiseleccion(anchoMS,altoMS,contenedorTocado,elementoTocado);
						}
						else activarMultiseleccion(anchoMS,altoMS,contenedorTocado,elementoTocado);
					}
					pizarra == null;
					stage.removeEventListener(MouseEvent.MOUSE_UP,endRect);
				}
			}
		}
		
		///<summary>
		///Activa la multiselección; tiene en cuenta si se ha levantado el ratón en el contenedor o en un elemento
		///</summary>
		function activarMultiseleccion(anchoMS,altoMS,contenedorTocado:Boolean,elementoTocado:Boolean)
		{
			var xmin:Number = initX - lienzo.x;
			var xmax:Number = initX + anchoMS - lienzo.x;
			var ymin:Number = initY - lienzo.y;
			var ymax:Number = initY + altoMS - lienzo.y;
			
			var aux:Number;
			if (xmin > xmax) 
			{
				aux = xmin;
				xmin = xmax;
				xmax = aux;
			}
			if (ymin > ymax)
			{
				aux = ymin;
				ymin = ymax;
				ymax = aux;
			}
						
			var item:CContenedorElemento;
						
			if (elemento_seleccionMultiple != null) desactivarElementos();
			borrarLista();
			
			var i:int = 0;
			var hayUnReloj : Boolean = false;
			if (listaElementos.length > 0)
			{
				for (i = 0; i< listaElementos.length; i++)
				{
					if(listaElementos[i].getTipo() == "reloj" || listaElementos[i].getTipo() == "analog" || listaElementos[i].getTipo() == "digital")//detectamos si hay un reloj en la selección múltiple
					{
						hayUnReloj = true;
						trace("HAY UN RELOJ!!");
					}
					item = listaElementos[i];
					var item_width:Number = item.datos_elemento.width;
					var item_height:Number = item.datos_elemento.height;
					var x1:Number = item.x + item_width;
					var y1:Number = item.y + item_height;
															
					//Función que comprueba si el elemento está dentro del cuadrado pintado
					comprobarSiEstaDentro(item,xmin,xmax,ymin,ymax,x1,y1);
				}
				
				if (listaElementosSeleccionados.length > 1) actualizarContenedorMultiple();			
				else if (listaElementosSeleccionados.length == 1)
				{
					elemento_seleccionado = listaElementosSeleccionados[0];
					elemento_seleccionado.activarElemento();
				}
								
				//NOTA! Cuando se termina de ejecutar endRect también se ejecuta onAreaEditable, ya que se hace click en el area
				//de edición. Esto supone un problema, ya que esta función desactiva todo lo que esté en escena. Mediante el 
				//parámetro desactivarOnAreaEditable podemos controlarlo
				if (contenedorTocado) 
				{
					if (elemento_seleccionMultiple != null) desactivarOnAreaEditable = true;
					else desactivarOnAreaEditable = false;
				}
				else desactivarOnAreaEditable = false;
				if (elementoTocado) desactivarOnAreaEditable = false;
				this.getPanelPropiedades().btnRelacion.alpha = 0.5;
				this.getPanelPropiedades().btnRelacion.selected = true;
				this.getPanelPropiedades().btnRelacion.enabled = false;
				this.setCandadoPadre(true);
				if(elemento_seleccionMultiple != null)
				{
					this.elemento_seleccionMultiple.setCandado(true);
				}
				////si hay un reloj mantenemos la relación de aspecto
				if(hayUnReloj)//si en la selección múltiple hay un reloj mantener las proporciones siempre 
				{
					trace("Hay un reloj!!");
					this.getPanelPropiedades().btnRelacion.alpha = 0.5;
					this.getPanelPropiedades().btnRelacion.selected = true;
					this.getPanelPropiedades().btnRelacion.enabled = false;
					this.setCandadoPadre(true);
					trace("elemento_seleccionMultiple = "+elemento_seleccionMultiple+" - elemento_seleccionado = "+elemento_seleccionado);
					if(elemento_seleccionMultiple != null)
					{
						trace("setcandado true en seleccion multiple");
						this.elemento_seleccionMultiple.setCandado(true);
					}
					else if(elemento_seleccionado != null)
					{
						trace("setcandado true en seleccion única");
						this.elemento_seleccionado.setCandado(true);
					}
					
				}
				else
				{
					this.getPanelPropiedades().btnRelacion.enabled = true;
					this.getPanelPropiedades().btnRelacion.alpha = 1.0;
				}
			}
		}
		
		///<summary>
		///Comprueba si el elemento que le pasamos está dentro del cuadrado dibujado, y si es así
		///lo introduce en el contenedor múltiple
		///</summary>
		public function comprobarSiEstaDentro(item:CContenedorElemento,xmin:Number,xmax:Number,ymin:Number,ymax:Number,x1:Number,y1:Number)
		{
			if ((item.x > xmin) && (item.x < xmax))
			{
				if ((item.y > ymin) && (item.y < ymax))
				{
					meterItemEnContenedor(item);
				}
				else if ((y1 > ymin) && (y1 < ymax))
				{
					meterItemEnContenedor(item);
				}
			}
			else if ((x1 > xmin) && (x1 < xmax))
			{
				if ((item.y > ymin) && (item.y < ymax))
				{
					meterItemEnContenedor(item);
				}
				else if ((y1 > ymin) && (y1 < ymax))
				{
					meterItemEnContenedor(item);
				}
			}
		}
		
		///<summary>
		///Función que introduce el elemento en el contenedor múltiple
		///</summary>
		public function meterItemEnContenedor(item:CContenedorElemento)
		{
			if (elemento_seleccionMultiple == null) item.activarElemento();
			var pos:int = listaElementosSeleccionados.indexOf(this);
			if (pos == -1)  insertarElementoSeleccionado(item);
		}
		/************************************fin multiselección con ratón**************************************/
		
		/******************************Insertar/Eliminar/Desactivar elementos*********************************************/
		///<summary>
		///Inserta un contenedor para el elemento del tipo previamente seleccionado
		///</summary>
		public function insertarElemento(xpos:Number, ypos:Number)
		{
			//trace("***************insertarElemento***********");
			var cuadro:CContenedorElemento = new CContenedorElemento(this);
			cuadro.setTipo(tipo_elemento);
			cuadro.setXpos(xpos);
			cuadro.setYpos(ypos);
			cuadro.setTransparencia(1);
			if(tipo_elemento == "ticker") cuadro.setCandado(false);
			else cuadro.setCandado(true);
			cuadro.load();
			this.elemento_seleccionado = cuadro;
			cuadro.activarElemento();
			cuadro.setDimensiones();
			lienzo.contenedor.addChild(cuadro);
			cuadro.setID(lienzo.contenedor.getChildIndex(cuadro));
			cuadro.setProfundidad(lienzo.contenedor.getChildIndex(cuadro));
			panel_propiedades.insertPropGenericas(cuadro);
			listaElementos.push(cuadro);
		}
		
		///<summary>
		///Desactiva el elemento clickado anteriormente
		///</summary>
		public function desactivarAnterior()
		{
			if (elemento_seleccionado != null)
			{				
				elemento_seleccionado.desactivarElemento();
				elemento_seleccionado = null;
			}
		}
		
		///<summary>
		///Desactiva el contenedor múltiple si existe
		///</summary>
		public function desactivarContenedorMultiseleccion()
		{
			if (!contenedorEliminado)
			{
				//Comprobamos si hemos cambiado las dimensiones del contenedor múltiple
				comprobarCambiosEnDimensiones();
				elemento_seleccionMultiple.stopDrag();
				
				//Guardamos las coordenadas en x e y para poder actualizar las posiciones de los elementos
				var xinit:Number = elemento_seleccionMultiple.x;
				var yinit:Number = elemento_seleccionMultiple.y;
				
				arrayContenido = elemento_seleccionMultiple.getArrayDatos();
				elemento_seleccionMultiple.desactivarElemento();
				elemento_seleccionMultiple.eliminar();
				elemento_seleccionMultiple = null;
				
				//Volvemos a pintar los elementos en el lienzo, en la nueva posición
				//y con su nuevo tamaño
				deshacerSeleccionMultiple(xinit,yinit);
				
				diferencia_x = 0; //Reseteamos valores offset del movimiento del contenedor múltiple
				diferencia_y = 0;
				
				borrado = true;
				panel_propiedades.borrarPanelPropiedades();
				borrarLista();
			}
		}
		///<summary>
		///Elimina un elemento
		///</summary>
		public function eliminar (obj:MovieClip)
		{
			var posicion:int = listaElementos.indexOf(obj);
			if (posicion != -1) 
			{
				elementoBorrado = obj.getID();
				listaElementos.splice(posicion,1);
				obj.parent.removeChild(obj);
				panel_propEsp.descargarPanel();
				panel_propiedades.borrarPanelPropiedades();
				elemento_seleccionado = null;
				actualizarDatos();
			}
		}
		
		///<summary>
		///Duplica un elemento - DE MOMENTO NO SE ESTÁ UTILIZANDO PORQUE ALGUNOS ELEMENTOS
		//DABAN MUCHOS PROBLEMAS A LA HORA DE DUPLICARLOS! SI HACE FALTA UTILIZAR ESTA FUNCIÓN ESTÁ INCOMPLETA!!
		///</summary>
		public function duplicarElemento()
		{
			if (elemento_seleccionado != null)
			{
				var copia:CContenedorElemento = new CContenedorElemento(this);
				copia.x = elemento_seleccionado.x + 10;
				copia.y = elemento_seleccionado.y + 10;
				copia.setXpos(copia.x);
				copia.setYpos(copia.y);
				copia.setAncho(elemento_seleccionado.datos_elemento.width);
				copia.setAlto(elemento_seleccionado.datos_elemento.height);
				copia.setCandado(elemento_seleccionado.getCandado());
				copia.setID(elemento_seleccionado.getID());
				copia.setProfundidad(listaElementos.length);
				copia.setTexto(elemento_seleccionado.getTexto());
				copia.setTextoTicker(elemento_seleccionado.getTextoTicker());
				copia.setVelocidadTicker(elemento_seleccionado.getVelocidadTicker());
				copia.setTipo(elemento_seleccionado.getTipo());
				copia.setTransparencia(elemento_seleccionado.getTransparencia());
				copia.setUrlDatos(elemento_seleccionado.getUrlDatos());
				copia.setVideo(elemento_seleccionado.getVideo());				
				copia.setDia(elemento_seleccionado.getDia());
				copia.setCiudad(elemento_seleccionado.getCiudad());
				copia.setEstiloTiempo(elemento_seleccionado.getEstiloTiempo());
				copia.setRSSUrl(elemento_seleccionado.getRSSUrl());
				copia.setBucle(elemento_seleccionado.getBucle());
				copia.control_reloj = elemento_seleccionado.control_reloj;
				copia.setArrayPasafotos(elemento_seleccionado.getArrayPasafotos());
				copia.setSentidoPasafotos(elemento_seleccionado.getSentidoPasafotos());
				copia.setDireccionPasafotos(elemento_seleccionado.getDireccionPasafotos());
				copia.setEfectoPasafotos(elemento_seleccionado.getEfectoPasafotos());
				copia.setTimerPasafotos(elemento_seleccionado.getTimerPasafotos());
				copia.setVelocidadTransicion(elemento_seleccionado.getVelocidadTransicion());
				copia.control_reloj = elemento_seleccionado.control_reloj;
				copia.tipo_reloj = elemento_seleccionado.tipo_reloj;
				copia.color_agujas = elemento_seleccionado.color_agujas
				copia.alpha_agujas = elemento_seleccionado.alpha_agujas
				copia.color_marcas = elemento_seleccionado.color_marcas
				copia.alpha_marcas = elemento_seleccionado.alpha_marcas
				copia.color_sombra = elemento_seleccionado.color_sombra
				copia.alpha_sombra = elemento_seleccionado.alpha_sombra
				copia.color_fondo = elemento_seleccionado.color_fondo
				copia.alpha_fondo = elemento_seleccionado.alpha_fondo
				copia.color_marco = elemento_seleccionado.color_marco
				copia.alpha_marco = elemento_seleccionado.alpha_marco
				copia.color_remarco = elemento_seleccionado.color_remarco
				copia.alpha_remarco = elemento_seleccionado.alpha_remarco
				copia.color_numeros = elemento_seleccionado.color_numeros
				copia.alpha_numeros = elemento_seleccionado.alpha_numeros
										
				var cajaTexto:TextField = new TextField();
				if (elemento_seleccionado.getTipo() == "texto")
				{
					cajaTexto.htmlText = elemento_seleccionado.getTexto().htmlText;
					cajaTexto.width = elemento_seleccionado.getTexto().textWidth;
					cajaTexto.height = elemento_seleccionado.getTexto().textHeight;
					cajaTexto.wordWrap = true;
					cajaTexto.setTextFormat(elemento_seleccionado.getTexto().getTextFormat());
					copia.setTexto(cajaTexto); 
				}
				else if (elemento_seleccionado.getTipo() == "ticker")
				{
					cajaTexto.text = elemento_seleccionado.getTextoTicker().text;
					cajaTexto.setTextFormat(elemento_seleccionado.getTextoTicker().getTextFormat());
					cajaTexto.width = copia.datos_elemento.width;
				}
				else if (elemento_seleccionado.getTipo() == "rss")
				{
					copia.cargarRSS(copia.getRSSUrl());
				}
				else if (elemento_seleccionado.getTipo() == "tiempo")
				{
					copia.cargarTiempo(copia.getDia(),copia.getCiudad(),copia.getEstiloTiempo());
				}
				else if (elemento_seleccionado.getTipo() == "reloj")
				{					
					if (copia.control_reloj.getTipo() == "analog") copia.cargarRelojAnalogico();
					else copia.cargarRelojDigital();
				}
				else if (elemento_seleccionado.getTipo() == "menu")
				{
					
				}
				else if (elemento_seleccionado.getTipo() == "pasafotos")
				{
					
				}
				else if (elemento_seleccionado.getUrlDatos() != null) copia.loadContent(elemento_seleccionado.getTipo(),elemento_seleccionado.getUrlDatos(),cajaTexto,false);
								
				
				//copia.datos_elemento.width = elemento_seleccionado.datos_elemento.width;
				//copia.datos_elemento.height = elemento_seleccionado.datos_elemento.height;
				
				copia.datos_elemento.alpha = copia.getTransparencia();
				
				copia.load();
				
				copia.datos_elemento.width = copia.getAncho();
				copia.datos_elemento.height = copia.getAlto();
				
				if ((copia.getTipo() == "swf") || (copia.getTipo() == "imagen") || (copia.getTipo() == "video") || (copia.getTipo() == "anuncio")) copia.setDimensiones();
				
				if ((copia.getTipo() == "tiempo") || (copia.getTipo() == "pasafotos") || (copia.getTipo() == "menu") || (copia.getTipo() == "rss")  || (copia.getTipo() == "reloj"))
				{
					copia.insertarPestañaInferior();
					copia.ajustarBotonesAcontenido();
				}
								
				lienzo.contenedor.addChild(copia);
				listaElementos.push(copia);
				
				panel_propEsp.descargarPanel();
				panel_propEsp.setTipo(copia.getTipo());
				panel_propEsp.cargarPanel();
			}
		}
		/********************************************************************************************************/
		
		/******************************************** onAreaEditable ********************************************/
		
		///<summary>
		///Función que controla los clicks sobre el lienzo - Si es necesario desactiva los elementos seleccionados
		///</summary>
		function onAreaEditable(e:MouseEvent)
		{
			//trace("**********onAreaEditable");
			if (!desactivarOnAreaEditable) //no está desactivada la función; si es true, significa que estamos con multiselección
			{
				desactivarElementos();
				panel_propEsp.descargarPanel();
			}
			else desactivarOnAreaEditable = false;
			//trace("*********FIN onAreaEditable");
		}
		
		///<summary>
		///Función que desactiva los elementos seleccionados
		///</summary>
		function desactivarElementos()
		{
			//trace("**********desactivarElementos************");			
			if ((!contenedorEliminado) && (elemento_seleccionMultiple != null))
			{
				comprobarCambiosEnDimensiones();
				elemento_seleccionMultiple.stopDrag();
				var xinit:Number = elemento_seleccionMultiple.x;
				var yinit:Number = elemento_seleccionMultiple.y;
				
				arrayContenido = elemento_seleccionMultiple.getArrayDatos();
				elemento_seleccionMultiple.desactivarElemento();
				elemento_seleccionMultiple.eliminar();
				elemento_seleccionMultiple = null;
				deshacerSeleccionMultiple(xinit,yinit);
			}
			
			contenedorEliminado = true;
			desactivarAnterior();
			
			diferencia_x = 0; //Reseteamos valores offset del movimiento del contenedor múltiple
			diferencia_y = 0;
			zMax = 0;
			
			borrado = true;
			
			panel_propiedades.borrarPanelPropiedades();
			panel_propEsp.descargarPanel();
			borrarLista();
		}
		
		///<summary>
		///Función que vacía el lienzo para que no se queden elementos tras guardar la versión en FLEX!!
		///</summary>
		public function vaciarContenedor()
		{
			for (var i:int = 0; i<lienzo.contenedor.numChildren; i++)
			{
				if (lienzo.contenedor.getChildAt(i) is CContenedorElemento)
				{
					var objeto:CContenedorElemento = lienzo.contenedor.getChildAt(i) as CContenedorElemento;
					if (objeto.getTipo() == "video" && objeto.getVideo() != null)//NO es un video vacio
					{
						trace("Es un video");
						objeto.getVideo().unload();
					}
					
					lienzo.contenedor.removeChildAt(i);
					i=0;
				}
			}
			
			listaElementos.splice(0,listaElementos.length);
			panel_propEsp.descargarPanel();
		}
		
		///<summary>
		///Función que deshace la multiselección, creando de nuevo los elementos en el lienzo
		///</summary>
		function deshacerSeleccionMultiple(x_init:Number,y_init:Number)
		{
			//trace("****************deshacerSeleccionMultiple************************");
			var anchoContenido:Number;
			var altoContenido:Number;
			
			var i:int = 0;
			var k:int = 0;
			
			for (i = 0; i< arrayContenido.length-1; i++)
			{
				for (k = i+1; k< arrayContenido.length; k++)
				{
					if (arrayContenido[k].zpos < arrayContenido[i].zpos)
					{
						var auxiliar:CDatosElemento = arrayContenido[i];
						arrayContenido[i] = arrayContenido[k];
						arrayContenido[k] = auxiliar;
					}
				}
			}
						
			for (i = 0; i<arrayContenido.length; i++)
			{
				anchoContenido = Math.round(arrayContenido[i].ancho);
				altoContenido = Math.round(arrayContenido[i].alto);
								
				
				arrayContenido[i].contenido.width = anchoContenido;
				arrayContenido[i].contenido.height = altoContenido;
																
				var cuadro:CContenedorElemento = new CContenedorElemento(this);
				cuadro.setTipo(arrayContenido[i].tipo);
				//iñaki
				cuadro.setXpos(arrayContenido[i].contenido.x + x_init); 
				cuadro.setYpos(arrayContenido[i].contenido.y + y_init);
				cuadro.x = arrayContenido[i].contenido.x + x_init;
				cuadro.y = arrayContenido[i].contenido.y + y_init;
				trace("[Main] - deshacerSeleccionMultiple() -> "+i+" - "+cuadro.x+", "+cuadro.y);
				//cuadro.setXpos(arrayContenido[i].x + x_init); 
				//cuadro.setYpos(arrayContenido[i].y + y_init);
				arrayContenido[i].contenido.x = 0;
				arrayContenido[i].contenido.y = 0;
				cuadro.setUrlDatos(arrayContenido[i].url_datos);
				cuadro.lector_tiempo = arrayContenido[i].lector_tiempo;
				cuadro.control_menu = arrayContenido[i].control_menu;
				cuadro.control_reloj = arrayContenido[i].control_reloj;				
				cuadro.lector_rss = arrayContenido[i].lector_rss;
				
				if ( cuadro.lector_tiempo != null)
				{
					cuadro.dia = cuadro.lector_tiempo.getDia();
					cuadro.cod_ciudad = cuadro.lector_tiempo.getCodigoCiudad();
					cuadro.estilo_tiempo = cuadro.lector_tiempo.getEstilo();
					cuadro.pais = cuadro.lector_tiempo.getPais();
				}
				
				if ( cuadro.control_reloj != null)
				{					
					cuadro.color_agujas = cuadro.control_reloj.getColorAgujas();
					cuadro.alpha_agujas = cuadro.control_reloj.getAlphaAgujas();
					cuadro.color_marcas = cuadro.control_reloj.getColorMarcas();
					cuadro.alpha_marcas = cuadro.control_reloj.getAlphaMarcas();
					cuadro.color_sombra = cuadro.control_reloj.getColorSombra();
					cuadro.alpha_sombra = cuadro.control_reloj.getAlphaSombra();
					cuadro.color_fondo = cuadro.control_reloj.getColorFondo();
					cuadro.alpha_fondo = cuadro.control_reloj.getAlphaFondo();
					cuadro.color_marco = cuadro.control_reloj.getColorMarco();
					cuadro.alpha_marco = cuadro.control_reloj.getAlphaMarco();
					cuadro.color_remarco = cuadro.control_reloj.getColorRemarco();
					cuadro.alpha_remarco = cuadro.control_reloj.getAlphaRemarco();
					cuadro.color_numeros = cuadro.control_reloj.getColorNumeros();
					cuadro.alpha_numeros = cuadro.control_reloj.getAlphaNumeros();
					
					cuadro.color_mes = cuadro.control_reloj.getColorNumeros();
					cuadro.color_dia = cuadro.control_reloj.getColorNumeros();
					cuadro.color_numDia = cuadro.control_reloj.getColorNumeros();
					cuadro.alpha_mes = cuadro.control_reloj.getAlphaNumeros();
					cuadro.alpha_dia = cuadro.control_reloj.getAlphaNumeros();
					cuadro.alpha_numDia = cuadro.control_reloj.getAlphaNumeros();
				}
				
				cuadro.datos_elemento.fondo.width = anchoContenido;
				cuadro.datos_elemento.fondo.height = altoContenido;	
				
				var aux:MovieClip;
				var texto_aux:TextField;
				var j:int = 0;
				if ((arrayContenido[i].tipo == "texto") || (arrayContenido[i].tipo == "ticker"))
				{
					aux = arrayContenido[i].contenido;
					for (j = 0; j<aux.numChildren; j++)
					{
						if (aux.getChildAt(j) is TextField)  
						{
							texto_aux = aux.getChildAt(j) as TextField;
							cuadro.activarPestañaEnTexto(texto_aux);
						}
					}
				}
				else if (arrayContenido[i].tipo == "video") 
				{
					cuadro.setVideo(arrayContenido[i].contenido);
					cuadro.getVideo().setTransparencia(arrayContenido[i].alpha);
					cuadro.datos_elemento.addChild(arrayContenido[i].contenido);
				}
				else if (arrayContenido[i].tipo == "menu") 
				{
					cuadro.datos_elemento.addChild(arrayContenido[i].contenido);
				}
				else if (arrayContenido[i].tipo == "pasafotos")  
				{
					cuadro.datos_elemento.addChild(arrayContenido[i].contenido);
					cuadro.setUrlDatos("kk");
					
					cuadro.setArrayPasafotos(arrayContenido[i].array_pasafotos);
					cuadro.setSentidoPasafotos(arrayContenido[i].sentido) ;
					cuadro.setDireccionPasafotos(arrayContenido[i].direccion); 
					cuadro.setEfectoPasafotos(arrayContenido[i].efecto);
					cuadro.setTimerPasafotos(int(arrayContenido[i].tiempo));
					cuadro.setVelocidadTransicion(Number(arrayContenido[i].velocidad));
				}
				else 
				{
					if (arrayContenido[i].url_datos != null) cuadro.datos_elemento.addChild(arrayContenido[i].contenido);					
				}
				
				if (arrayContenido[i].tipo == "rss")  
				{
					cuadro.datos_elemento.width = anchoContenido;
					cuadro.datos_elemento.height = altoContenido;	
				}
				
				cuadro.datos_elemento.alpha = arrayContenido[i].transparencia;
				cuadro.setTransparencia(arrayContenido[i].transparencia);
				
				cuadro.load();
				
				//Según el elemento, llamamos solo a setDimensiones, o insertamos también la botonera inferior
				if ((arrayContenido[i].tipo == "swf") || (arrayContenido[i].tipo == "imagen") || (arrayContenido[i].tipo == "video") || (arrayContenido[i].tipo == "anuncio")) cuadro.setDimensiones();
				
				if ((arrayContenido[i].tipo == "tiempo") || (arrayContenido[i].tipo == "pasafotos") || (arrayContenido[i].tipo == "menu") || (arrayContenido[i].tipo == "rss")  || (arrayContenido[i].tipo == "reloj"))
				{
					cuadro.insertarPestañaInferior();
					cuadro.ajustarBotonesAcontenido();
				}
				
				lienzo.contenedor.addChild(cuadro);
				cuadro.setID(lienzo.contenedor.getChildIndex(cuadro));
				cuadro.setProfundidad(listaElementos.length);
				cuadro.desactivarElemento();
				listaElementos.push(cuadro);
			}
			actualizarDatos();
		}
		/*******************************************************************************************************************/
		
		/********************************************* MULTISELECCIÓN ***************************************************/
		
		///<summary>
		///Borra el array que mantiene los elementos seleccionados para la multiselección
		///</summary>
		public function borrarLista()
		{
			listaElementosSeleccionados = new Array();
		}
		
		///<summary>
		///Función que inserta elementos en el array multiselección
		///</summary>
		public function insertarElementoSeleccionado(objeto:CContenedorElemento)
		{
			if (elemento_seleccionMultiple == null) listaElementosSeleccionados.push(objeto);
			else
			{
				dif_x = elemento_seleccionMultiple.x - xmin;
				dif_y = elemento_seleccionMultiple.y - ymin;
				
				for (var i:int = 0; i<listaElementosSeleccionados.length; i++)
				{
					listaElementosSeleccionados[i].x += dif_x;
					listaElementosSeleccionados[i].y += dif_y;
				}
				listaElementosSeleccionados.push(objeto);
			}
		}
		
		///<summary>
		///Función que actualiza las posiciones en x e y de los elementos de la multiselección
		///</summary>
		public function actualizarArrayDatos()
		{
			for (var i:int = 0; i< arrayDatos.length; i++)
			{
				arrayDatos[i].xpos += diferencia_x;
				arrayDatos[i].ypos += diferencia_y;
			}
		}
		
		///<summary>
		///Función que localiza el elemento que hay que sacar de la multiselección
		///</summary>
		public function encontrarElemento(mousex:Number,mousey:Number)
		{
			var x1:Number;
			var x2:Number;
			var y1:Number;
			var y2:Number;
			var pos:int = -1;
			var i:int = 0;
				
			for (i=0; i<listaElementosSeleccionados.length; i++)
			{
				if ((diferencia_x == 0)&&(diferencia_y == 0))
				{
					x1 = listaElementosSeleccionados[i].x;
					x2 = listaElementosSeleccionados[i].x + listaElementosSeleccionados[i].datos_elemento.width;
					y1 = listaElementosSeleccionados[i].y;
					y2 = listaElementosSeleccionados[i].y + listaElementosSeleccionados[i].datos_elemento.height;
				}
				else
				{
					x1 = listaElementosSeleccionados[i].x + diferencia_x;
					x2 = listaElementosSeleccionados[i].x + diferencia_x + listaElementosSeleccionados[i].datos_elemento.width;
					y1 = listaElementosSeleccionados[i].y + diferencia_y;
					y2 = listaElementosSeleccionados[i].y + diferencia_y + listaElementosSeleccionados[i].datos_elemento.height;
				}
				
				if ((mousex>x1)&&(mousex<x2)&&(mousey>y1)&&(mousey<y2)) 
				{
					elemento_a_borrar = listaElementosSeleccionados[i];
					pos = i;
				}
			}
			for (i=0; i<listaElementosSeleccionados.length; i++)
			{
				if (i!=pos)
				{
					listaElementosSeleccionados[i].x += diferencia_x;
					listaElementosSeleccionados[i].y += diferencia_y;
				}
			}
			return pos;
		}
		
		///<summary>
		///Función que activa el elemento correspondiente cuando se desactiva una multiselección tras haber sacado un elemento
		///</summary>
		public function seleccionarRestante (item:CContenedorElemento)
		{
			for (var i:int = 0; i<lienzo.contenedor.numChildren ; i++)
			{
				if (lienzo.contenedor.getChildAt(i) is CContenedorElemento)
				{
					var elem:CContenedorElemento = lienzo.contenedor.getChildAt(i) as CContenedorElemento;
					if (elem != item)
					{
						elemento_seleccionado = elem;
						elemento_seleccionado.activarElemento();
					}
				}
			}
		}
		
		///<summary>
		///Función que actualiza el contenedor múltiple; lo crea, o añade elementos
		///</summary>
		public function actualizarContenedorMultiple()
		{
			//trace("******************actualizarContenedorMultiple***************");	
			var i:int;
			var k:int;
			calcularDimensionesSeleccionMultiple();
			if (contenedorEliminado) //CREAMOS UN NUEVO CONTENEDOR MÚLTIPLE
			{
				for (i = 0; i< listaElementosSeleccionados.length-1; i++)
				{
					for (k = i+1; k< listaElementosSeleccionados.length; k++)
					{
						if (listaElementosSeleccionados[k].getProfundidad() > listaElementosSeleccionados[i].getProfundidad())
						{
							var aux:CContenedorElemento = listaElementosSeleccionados[i];
							listaElementosSeleccionados[i] = listaElementosSeleccionados[k];
							listaElementosSeleccionados[k] = aux;
						}
					}
				}
				
				contenedorSeleccion = new CContenedorSeleccionMultiple(this);
				initContenedorMultiple();

				arrayDatos = new Array();			
				
				for (i = 0; i< listaElementosSeleccionados.length; i++)
				{
					elemento2SeleccionMultiple(i);
				}
				
				contenedorSeleccion.setArrayDatos(arrayDatos);
				contenedorSeleccion.width = totalWidth+10;
				contenedorSeleccion.height = totalHeight+10;	
				lienzo.contenedor.addChild(contenedorSeleccion);
				contenedorEliminado = false;
				elemento_seleccionado = null;
			}
			else 
			{
				//trace("AÑADIMOS UN ELEMENTO");
				var offset_x:Number = contenedorSeleccion.getXpos();
				var offset_y:Number = contenedorSeleccion.getYpos();
				
				initContenedorMultiple();
				actualizarContenedorSeleccion(xmin,ymin,offset_x,offset_y);				
				elemento2SeleccionMultiple(arrayDatos.length);
								
				contenedorSeleccion.setArrayDatos(arrayDatos);
				contenedorSeleccion.width = totalWidth+10;
				contenedorSeleccion.height = totalHeight+10;	
			}
			contenedorSeleccion.actualizarPanelPropiedades();
			comprobarProfundidades();
		}
		
		///<summary>
		///Función que calcula las dimensiones del contenedor múltiple
		///</summary>
		function calcularDimensionesSeleccionMultiple()
		{
			var i:int = 0;
			xmin = 1000;
			ymin = 1000;
			xtotal = -10;
			ytotal = -10;
			totalWidth = 0;
			totalHeight = 0;
			//trace("*****************calcularDimensionesSeleccionMultiple**********");
			for (i = 0; i< listaElementosSeleccionados.length; i++)
			{
				
				var x_pos:Number = listaElementosSeleccionados[i].x;
				var y_pos:Number = listaElementosSeleccionados[i].y;
				
				var width_elem:Number;
				var height_elem:Number;
				
				if ((listaElementosSeleccionados[i].datos_elemento.width == 0) && (listaElementosSeleccionados[i].datos_elemento.height == 0))
				{
					width_elem = listaElementosSeleccionados[i].getAncho();
					height_elem = listaElementosSeleccionados[i].getAlto();
				}
				else
				{
					width_elem = listaElementosSeleccionados[i].datos_elemento.width;
					height_elem = listaElementosSeleccionados[i].datos_elemento.height;
				}
				
				if (x_pos < xmin) xmin = x_pos;
				if (y_pos < ymin) ymin = y_pos;
				if ((x_pos + width_elem) > xtotal) xtotal = (x_pos + width_elem);
				if ((y_pos + height_elem) > ytotal) ytotal = (y_pos + height_elem);
			}
			
			totalWidth = xtotal - xmin;
			totalHeight = ytotal - ymin;
		}
		
		///<summary>
		///Inicializa el contenedor múltiple
		///</summary>
		function initContenedorMultiple()
		{
			contenedorSeleccion.setXpos(xmin);
			contenedorSeleccion.setYpos(ymin);
			contenedorSeleccion.setAncho(totalWidth);
			contenedorSeleccion.setAlto(totalHeight);
			contenedorSeleccion.load();
		}
		
		///<summary>
		///Introduce el contenido del elemento en la posición "pos" en el contenedor multiselección
		///</summary>
		function elemento2SeleccionMultiple(pos:int)
		{
			//trace("*************elemento2SeleccionMultiple**************");
			var item:MovieClip;
			var aux:CContenedorElemento;
			var contenido_texto:TextField;
			var i:int = 0;
									
			if ((listaElementosSeleccionados[pos].getTipo() == "texto") || (listaElementosSeleccionados[pos].getTipo() == "ticker"))
			{
				aux = listaElementosSeleccionados[pos];
				for (i = 0; i< aux.numChildren; i++)
				{
					if ( aux.getChildAt(i) is TextField)
					{
						contenido_texto = aux.getChildAt(i) as TextField;
						item = new MovieClip();
						contenido_texto.type = TextFieldType.DYNAMIC;
						item.addChild(contenido_texto);
						item.name = "datos_elemento";
					}
				}
			}
			else if (listaElementosSeleccionados[pos].getTipo() == "video")
			{
				aux = listaElementosSeleccionados[pos];
				var aux_width:Number = aux.datos_elemento.width;
				var aux_height:Number = aux.datos_elemento.height;
				var videoMC:CElementoVideo = new CElementoVideo(this);
				videoMC.setAlto(aux_height);
				videoMC.setAncho(aux_width);
				videoMC.setTransparencia(aux.datos_elemento.alpha);
				videoMC.setUrlDatos("chicago.f4v");
				videoMC.load();
				item = new MovieClip();
				item = videoMC;
				item.name = "datos_elemento";
			}
			else if (listaElementosSeleccionados[pos].getTipo() == "pasafotos")
			{
				item = listaElementosSeleccionados[pos].datos_elemento;
			}
			else if (listaElementosSeleccionados[pos].getTipo() == "menu")
			{
				 item = listaElementosSeleccionados[pos].datos_elemento;
			}
			else 
			{
				if (listaElementosSeleccionados[pos].getUrlDatos() != null) item = listaElementosSeleccionados[pos].datos_elemento;
				else item = listaElementosSeleccionados[pos].datos_elemento.fondo;
				
			}		
									
			item.x = listaElementosSeleccionados[pos].x - contenedorSeleccion.getXpos();
			item.y = listaElementosSeleccionados[pos].y - contenedorSeleccion.getYpos();
			
			item.width = listaElementosSeleccionados[pos].getAncho();
			item.height = listaElementosSeleccionados[pos].getAlto();
		
			var elemento:CDatosElemento = new CDatosElemento(listaElementosSeleccionados[pos].getTipo(),listaElementosSeleccionados[pos].x,listaElementosSeleccionados[pos].y,listaElementosSeleccionados[pos].getProfundidad(),item.width,item.height,listaElementosSeleccionados[pos].alpha,item,listaElementosSeleccionados[pos].getUrlDatos(),listaElementosSeleccionados[pos].lector_tiempo,listaElementosSeleccionados[pos].control_menu,listaElementosSeleccionados[pos].lector_rss,listaElementosSeleccionados[pos].getArrayPasafotos(),listaElementosSeleccionados[pos].getDireccionPasafotos(),listaElementosSeleccionados[pos].getSentidoPasafotos(),listaElementosSeleccionados[pos].getEfectoPasafotos(),int(listaElementosSeleccionados[pos].getTimerPasafotos()),listaElementosSeleccionados[pos].getVelocidadTransicion(),listaElementosSeleccionados[pos].control_reloj);
						
			elemento.xpos = listaElementosSeleccionados[pos].x;
			elemento.ypos = listaElementosSeleccionados[pos].y;		
			arrayDatos.push(elemento);
			
			contenedorSeleccion.contenedor.addChild(item);

			if (zMax != 0)
			{
				if (listaElementosSeleccionados[pos].getProfundidad() > zMax)  contenedorSeleccion.contenedor.setChildIndex(item,contenedorSeleccion.contenedor.numChildren -1);
				else contenedorSeleccion.contenedor.setChildIndex(item,0);
			}
			else contenedorSeleccion.contenedor.setChildIndex(item,0); 
												
			listaElementosSeleccionados[pos].eliminar();
		}
		
		
		///<summary>
		///Actualiza las posiciones en x e y de los elementos de la multiselección
		/// y de los controladores de tamaño (f0 a f8)
		///</summary>
		function actualizarContenedorSeleccion(xmin:Number,ymin:Number,offset_x:Number,offset_y:Number)
		{
			//trace ("**************actualizarMC*************");
			var child:MovieClip;
			var i:int;
			
			if (xmin < offset_x)
			{
				for (i=0; i<contenedorSeleccion.contenedor.numChildren; i++)
				{
					child = contenedorSeleccion.contenedor.getChildAt(i) as MovieClip;
					child.x += offset_x - xmin;
				}
				contenedorSeleccion.f0.x = 0;
				contenedorSeleccion.f3.x = 0;
				contenedorSeleccion.f6.x = 0;
				contenedorSeleccion.f1.x = totalWidth/2;
				contenedorSeleccion.f4.x = totalWidth/2;
				contenedorSeleccion.f7.x = totalWidth/2;
				contenedorSeleccion.f2.x = totalWidth;
				contenedorSeleccion.f5.x = totalWidth;
				contenedorSeleccion.f8.x = totalWidth;
			}
						
			if (ymin < offset_y)
			{
				for (i=0; i<contenedorSeleccion.contenedor.numChildren; i++)
				{
					child = contenedorSeleccion.contenedor.getChildAt(i) as MovieClip;
					child.y += offset_y - ymin;
				}
				contenedorSeleccion.f0.y = 0;
				contenedorSeleccion.f1.y = 0;
				contenedorSeleccion.f2.y = 0;
				contenedorSeleccion.f3.y = totalHeight/2;
				contenedorSeleccion.f4.y = totalHeight/2;
				contenedorSeleccion.f5.y = totalHeight/2;
				contenedorSeleccion.f6.y = totalHeight;
				contenedorSeleccion.f7.y = totalHeight;
				contenedorSeleccion.f8.y = totalHeight;
			}
		}
		
		///<summary>
		///Actualiza el contenedor múltiple si se han cambiado sus dimensiones desde el panel de propiedades
		///</summary>
		public function comprobarCambiosEnDimensiones()
		{
			var i:int = 0;
			var nuevoArray:Array;
			var indice:int;
			var ancho_actual:Number;
			var alto_actual:Number;
			var anchoElem:Number;
			var altoElem:Number;
			var XElem:Number;
			var YElem:Number;
							
			if ((cambioAncho)&&(cambioAlto))
			{
				ancho_actual = elemento_seleccionMultiple.contenedor.width;
				alto_actual = elemento_seleccionMultiple.contenedor.height;
				nuevoArray = elemento_seleccionMultiple.getArrayDatos();

				indice = nuevoArray.length - 1;
				
				for (i = 0; i<  elemento_seleccionMultiple.contenedor.numChildren; i++)
				{					
					anchoElem = nuevoArray[indice].ancho;
					altoElem = nuevoArray[indice].alto;					
					nuevoArray[indice].ancho = (anchoElem*ancho_actual)/ancho_anterior;
					nuevoArray[indice].alto = (altoElem*alto_actual)/alto_anterior;
					
					XElem = nuevoArray[indice].xpos - elemento_seleccionMultiple.x;
					YElem = nuevoArray[indice].ypos - elemento_seleccionMultiple.y;
					
					nuevoArray[indice].xpos = (XElem*ancho_actual)/ancho_anterior;
					nuevoArray[indice].xpos += elemento_seleccionMultiple.x;
					
					nuevoArray[indice].ypos = (YElem*alto_actual)/alto_anterior;
					nuevoArray[indice].ypos += elemento_seleccionMultiple.y;
					
					indice--;
				}
				elemento_seleccionMultiple.setArrayDatos(nuevoArray);
				cambioAncho = false;
				cambioAlto = false;
				elemento_seleccionMultiple.ajustarControladores();
			}
			else
			{
				if (cambioAncho) 
				{
					ancho_actual = elemento_seleccionMultiple.contenedor.width;
					nuevoArray = elemento_seleccionMultiple.getArrayDatos();
					indice = nuevoArray.length - 1;
					for (i = 0; i<  elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						anchoElem = nuevoArray[indice].ancho;
						nuevoArray[indice].ancho = (anchoElem*ancho_actual)/ancho_anterior;
						XElem = nuevoArray[indice].xpos - elemento_seleccionMultiple.x;
						nuevoArray[indice].xpos = (XElem*ancho_actual)/ancho_anterior;
						nuevoArray[indice].xpos += elemento_seleccionMultiple.x;
						indice--;
					}
					elemento_seleccionMultiple.setArrayDatos(nuevoArray);
					cambioAncho = false;
				}
					
				if (cambioAlto) 
				{
					alto_actual = elemento_seleccionMultiple.contenedor.height;
					nuevoArray = elemento_seleccionMultiple.getArrayDatos();
					indice = nuevoArray.length - 1;
					for (i = 0; i<  elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						altoElem = nuevoArray[indice].alto;
						nuevoArray[indice].alto = (altoElem*alto_actual)/alto_anterior;
						YElem = nuevoArray[indice].ypos - elemento_seleccionMultiple.y;
						nuevoArray[indice].ypos = (YElem*alto_actual)/alto_anterior;
						nuevoArray[indice].ypos += elemento_seleccionMultiple.y;
						indice--;
					}
					elemento_seleccionMultiple.setArrayDatos(nuevoArray);
					cambioAlto = false;
				}
			}
		}		
		
		///<summary>
		///Actualiza las profundidades de los elementos de la multiselección
		///</summary>
		function comprobarProfundidades()
		{
			if (listaElementosSeleccionados.length > 0)
			{
				zMax = listaElementosSeleccionados[0].getProfundidad();
				var i:int = 0;
				for (i = 0; i< lienzo.contenedor.numChildren; i++)
				{
					if (lienzo.contenedor.getChildAt(i) is CContenedorElemento)
					{
						var elem:CContenedorElemento = CContenedorElemento(lienzo.contenedor.getChildAt(i));
						if (elem.getProfundidad() > zMax)
						{
							actualizarProfundidades("down");
						}
					}
				}
			}
		}
		
		///<summary>
		///Saca un elemento de la multiseleccion
		///</summary>
		public function borrarUnElemento(mousex:Number,mousey:Number)
		{
			//trace("*****************borrarUnElemento***************");
			var xinit:Number;
			var yinit:Number;
			var i:int;
			var pos:int;
			
			borrado = false;
			
			pos = encontrarElemento(mousex,mousey);
			listaElementosSeleccionados.splice(pos,1);
			
			//Desactivamos el contenedor múltiple
			elemento_seleccionMultiple.stopDrag();
			xinit = elemento_seleccionMultiple.x;
			yinit = elemento_seleccionMultiple.y;
			
			arrayContenido = elemento_seleccionMultiple.getArrayDatos();
			elemento_seleccionMultiple.desactivarElemento();
			elemento_seleccionMultiple.eliminar();
			elemento_seleccionMultiple = null;
			deshacerSeleccionMultiple(xinit,yinit);
							
			if (listaElementosSeleccionados.length == 1) //SOLO QUEDA UN ELEMENTO, DESHACEMOS LA SELECCIÓN MÚLTIPLE
			{
				contenedorEliminado = true;
			}
			else
			{
				//trace("QUEDAN VARIOS ELEMENTOS EN LA SELECCIÓN MULTIPLE");
				for (i = 0; i<listaElementosSeleccionados.length; i++)
				{
					listaElementosSeleccionados[i].x -= dif_x;
					listaElementosSeleccionados[i].y -= dif_y;
				}
				
				if ((diferencia_x != dif_x)&&(diferencia_y != dif_y))
				{
					for (i = 0; i<listaElementosSeleccionados.length; i++)
					{
						listaElementosSeleccionados[i].x += dif_x;
						listaElementosSeleccionados[i].y += dif_y;
					}
				}

				//Creamos un nuevo contenedor
				calcularNuevasDimensiones(mousex,mousey);
												
				//reseteamos valores
				diferencia_x = 0;
				diferencia_y = 0;
								
				contenedorSeleccion = new CContenedorSeleccionMultiple(this);
				initContenedorMultiple();
									
				arrayDatos = new Array();		
				for (i = 0; i< listaElementosSeleccionados.length; i++)
				{
					var item:MovieClip;
					if (listaElementosSeleccionados[i].getUrlDatos() == null)item = listaElementosSeleccionados[i].datos_elemento.fondo;
					else item = listaElementosSeleccionados[i].datos_elemento;
					item.x = listaElementosSeleccionados[i].x - contenedorSeleccion.getXpos();
					item.y = listaElementosSeleccionados[i].y - contenedorSeleccion.getYpos();
					item.width = listaElementosSeleccionados[i].getAncho();
					item.height = listaElementosSeleccionados[i].getAlto();
								
					var elemento:CDatosElemento = new CDatosElemento(listaElementosSeleccionados[i].getTipo(),listaElementosSeleccionados[i].x,listaElementosSeleccionados[i].y,listaElementosSeleccionados[i].getProfundidad(),item.width,item.height,1,item,listaElementosSeleccionados[i].getUrlDatos(),listaElementosSeleccionados[i].lector_tiempo,listaElementosSeleccionados[pos].control_menu,listaElementosSeleccionados[pos].lector_rss,listaElementosSeleccionados[pos].getArrayPasafotos(),listaElementosSeleccionados[pos].getDireccionPasafotos(),listaElementosSeleccionados[pos].getSentidoPasafotos(),listaElementosSeleccionados[pos].getEfectoPasafotos(),listaElementosSeleccionados[pos].getTimerPasafotos(),listaElementosSeleccionados[pos].getVelocidadTransicion(),listaElementosSeleccionados[pos].control_reloj) ;
					elemento.xpos = listaElementosSeleccionados[i].x;
					elemento.ypos = listaElementosSeleccionados[i].y;
					
					arrayDatos.push(elemento);
					contenedorSeleccion.contenedor.addChild(item);
					contenedorSeleccion.contenedor.setChildIndex(item,0);
				}
				
				contenedorSeleccion.setArrayDatos(arrayDatos);
				contenedorSeleccion.width = totalWidth+10;
				contenedorSeleccion.height = totalHeight+10;			
				lienzo.contenedor.addChild(contenedorSeleccion);
				contenedorEliminado = false;
				
				//Borramos los cuadros que se han quedado vacíos
				for (i = 0; i<lienzo.contenedor.numChildren; i++)
				{
					if(lienzo.contenedor.getChildAt(i) is CContenedorElemento)
					{						
						var x_elem:Number = lienzo.contenedor.getChildAt(i).x;
						var esta:Boolean = false;
						for (var j:int = 0; j< listaElementosSeleccionados.length; j++) if (listaElementosSeleccionados[j].x == x_elem) esta = true;
						if (esta) 
						{
							lienzo.contenedor.removeChildAt(i);
							i=0;
						}
					}
				}
			}
		}
		
		///<summary>
		///Calcula las nuevas dimensiones del contenedor múltiple tras sacar un elemento
		///</summary>
		function calcularNuevasDimensiones(mousex,mousey)
		{
			//trace("***********************calcularNuevasDimensiones*************************");
			var i:int = 0;
			xmin = 1000;
			ymin = 1000;
			xtotal = -10;
			ytotal = -10;
			totalWidth = 0;
			totalHeight = 0;
					
			for (i=0; i<arrayDatos.length; i++)
			{
				var x1 = arrayDatos[i].xpos;
				var x2 = arrayDatos[i].xpos + arrayDatos[i].contenido.width;
				var y1 = arrayDatos[i].ypos;
				var y2 = arrayDatos[i].ypos + arrayDatos[i].contenido.height;
								
				if ((mousex >= x1)&&(mousex <= x2)&&(mousey >= y1)&&(mousey <= y2))
				{
					//ESTE ELEMENTO NO NOS INTERESA!! Es el que hemos des-seleccionado!!
				}
				else
				{				
					var x_pos:Number = arrayDatos[i].xpos;
					var y_pos:Number = arrayDatos[i].ypos;
					var width_elem:Number = arrayDatos[i].contenido.width;
					var height_elem:Number = arrayDatos[i].contenido.height;
					
					if (x_pos < xmin) xmin = x_pos;
					if (y_pos < ymin) ymin = y_pos;
					if ((x_pos + width_elem) > xtotal) xtotal = (x_pos + width_elem);
					if ((y_pos + height_elem) > ytotal) ytotal = (y_pos + height_elem);
				}
				
				totalWidth = xtotal - xmin;
				totalHeight = ytotal - ymin;
			}
		}
		/********************************************* FIN MULTISELECCIÓN ************************************************/
		
		/****************************************Profundidades***************************************/
		
		///<summary>
		///Cambia la profundidad del elemento seleccionado según el sentido indicado (up/down)
		///</summary>
		function actualizarProfundidades(sentido:String)
		{
			//trace("****************actualizarProfundidades*******************");
			var indice:int;
			if (elemento_seleccionado != null) indice = lienzo.contenedor.getChildIndex(elemento_seleccionado);
			else if (elemento_seleccionMultiple != null) indice = lienzo.contenedor.getChildIndex(elemento_seleccionMultiple);
			
			var limite = lienzo.contenedor.numChildren - 1;
			switch (sentido)
			{
				case "up":
					indice++;
					if (indice <= limite) 
					{
						if (elemento_seleccionado != null) lienzo.contenedor.setChildIndex(elemento_seleccionado,indice);
						else if (elemento_seleccionMultiple != null)  lienzo.contenedor.setChildIndex(elemento_seleccionMultiple,indice);
						actualizarDatos();
					}
					break;
				case "down":
					indice--;
					if (indice >= 1) 
					{
						if (elemento_seleccionado != null) lienzo.contenedor.setChildIndex(elemento_seleccionado,indice);
						else if (elemento_seleccionMultiple != null) lienzo.contenedor.setChildIndex(elemento_seleccionMultiple,indice);
						actualizarDatos();
					}
					break;
			}
			//trace(" ");
		}
		
		///<summary>
		///Cambia la profundidad del elemento seleccionado según el valor indicado 
		///</summary>
		public function actualizarProfundidades_int(nuevo_valor:int)
		{
			//trace("****************actualizarProfundidades*******************");
			var indice:int;
			if (elemento_seleccionado != null) indice = lienzo.contenedor.getChildIndex(elemento_seleccionado);
			else if (elemento_seleccionMultiple != null) indice = lienzo.contenedor.getChildIndex(elemento_seleccionMultiple);
			
			var limite = lienzo.contenedor.numChildren - 1;
			var sentido:String;
			
			if (indice < nuevo_valor) sentido = "up";
			else if (indice > nuevo_valor) sentido = "down";
			
			switch (sentido)
			{
				case "up":
					indice++;
					if (indice <= limite) 
					{
						if (elemento_seleccionado != null) lienzo.contenedor.setChildIndex(elemento_seleccionado,indice);
						else if (elemento_seleccionMultiple != null)  lienzo.contenedor.setChildIndex(elemento_seleccionMultiple,indice);
						actualizarDatos();
					}
					break;
				case "down":
					indice--;
					if (indice >= 1) 
					{
						if (elemento_seleccionado != null) lienzo.contenedor.setChildIndex(elemento_seleccionado,indice);
						else if (elemento_seleccionMultiple != null) lienzo.contenedor.setChildIndex(elemento_seleccionMultiple,indice);
						actualizarDatos();
					}
					break;
			}
			//trace(" ");
			if (elemento_seleccionado != null && elemento_seleccionMultiple == null) panel_propiedades.insertPropGenericas(elemento_seleccionado);
			else if (elemento_seleccionMultiple != null)  panel_propiedades.insertPropGenericas(elemento_seleccionMultiple);
		}
		
		
		///<summary>
		///Guarda el valor de la profundidad de cada elemento
		/// NOTA = cuando cambiamos la profundidad de un elemento, el elemento que estaba en esa profundidad pasa a tener
		///		   la del elemento cambiado, por lo que hay que actualizar sus datos
		///</summary>
		public function actualizarDatos()
		{
			//trace("**********************actualizarDatos**************");
			var i:int = 0;
			for (i=0; i<lienzo.contenedor.numChildren; i++)
			{
				if (lienzo.contenedor.getChildAt(i) is CContenedorElemento)
				{
					var item:CContenedorElemento = lienzo.contenedor.getChildAt(i) as CContenedorElemento;
					item.setProfundidad(lienzo.contenedor.getChildIndex(item));
				}
			}
		}
		/******************************************************************************************************/
		
		/********************************************* ALINEAR *******************************************/
		
		///<summary>
		///Actualiza posiciones de arrayDatos según la alineación indicada 
		///</summary>
		public function Align(accion:String,pos:Number,valor_max:Number)
		{
			var i:int = 0;
			var xmin:Number = 1000;
			var ymin:Number = 1000;
			var offset_x:Number = elemento_seleccionMultiple.x;
			var offset_y:Number = elemento_seleccionMultiple.y;
			
			if (accion == "left")
			{
				for (i = 0; i< arrayDatos.length; i++){arrayDatos[i].xpos = pos + offset_x;}
				elemento_seleccionMultiple.ajustarControladores();
			}
			else if (accion == "right")
			{
				for (i = 0; i< arrayDatos.length; i++)
				{
					arrayDatos[i].xpos = pos - arrayDatos[i].ancho + offset_x;
					if (arrayDatos[i].xpos < xmin) xmin = arrayDatos[i].xpos;
				}
				elemento_seleccionMultiple.ajustarX(xmin-offset_x,valor_max);
			}
			else if (accion == "top")
			{
				for (i = 0; i< arrayDatos.length; i++){arrayDatos[i].ypos = pos + offset_y;}
				elemento_seleccionMultiple.ajustarControladores();
			}
			else if (accion == "bottom")
			{
				for (i = 0; i< arrayDatos.length; i++)
				{
					arrayDatos[i].ypos = pos - arrayDatos[i].alto + offset_y;
					if (arrayDatos[i].ypos < ymin) ymin = arrayDatos[i].ypos;
				}
				elemento_seleccionMultiple.ajustarY(ymin-offset_y,valor_max);
			}
			else if (accion == "vertical_center")
			{
				for (i = 0; i< arrayDatos.length; i++)
				{
					arrayDatos[i].xpos = pos - arrayDatos[i].ancho/2 + offset_x;
					if (arrayDatos[i].xpos < xmin) xmin = arrayDatos[i].xpos;
				}
				elemento_seleccionMultiple.ajustarX(xmin-offset_x,valor_max);
			}
			else if (accion == "horizontal_center")
			{
				for (i = 0; i< arrayDatos.length; i++)
				{
					arrayDatos[i].ypos = pos - arrayDatos[i].alto/2 + offset_y;
					if (arrayDatos[i].ypos < ymin) ymin = arrayDatos[i].ypos;
				}
				elemento_seleccionMultiple.ajustarY(ymin-offset_y,valor_max);
			}
		}
		/***************************************************************************************************/
		/*********************************  IMPLEMENTACIÓN INTERFACE ****************************************/		
		///<summary>
		///Carga el fichero xml -> CUANDO SE IMPLEMENTE LA INTERFAZ HAY QUE BORRAR ESTA FUNCIÓN!!!!!
		///</summary>
		private function loadXML_provisional()
		{
			var urlRequest:URLRequest = new URLRequest("prueba_alpha_texto.xml");
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, parseXML);
			loader.load(urlRequest);
		}
		
		///<summary>
		///Parsea el contenido del xml -> CUANDO SE IMPLEMENTE LA INTERFAZ HAY QUE BORRAR ESTA FUNCIÓN!!!!!
		///</summary>
		private function parseXML(e:Event)
		{			
			var xml:String = e.target.data;
			loadXML(xml);
		}
		
		///<summary>
		///Recibe el contenido xml que hay que cargar en el lienzo
		///</summary>
		public function loadXML(xml:String):int
		{
			trace("[Flex - Flash] loadXML:");
			
			//trace("xml: ");
			//trace(xml);
			
			//Variables lienzo
			anL = 225; //Ancho del lienzo
			alL = 170; //Alto del lienzo
			anRes = 600; //Resolucion (ancho)
			alRes = 800; //Resolucion (alto)
			
			//Vaciamos lienzo por si acaso!!
			vaciarContenedor();
								
			if ((xml != "") && (xml != null))
			{
				var versionXML:XML = new XML(xml);
				elementos = versionXML.AREA.ELEMENTO;
				
				cargarFondo(versionXML.AREA.attribute("pathfondo"),versionXML.AREA.attribute("ID"));
				cargarElementosOrdenados();
			}

			return 1;
		}
		
		///<summary>
		///Crea el loader para la imagen de fondo
		///</summary>
		public function cargarFondo(url:String,id:String)
		{
			if ((url != null)&&(url != ""))
			{
				//Sacamos primero el nombre
				var fSlash: int = url.lastIndexOf("/");
				var bSlash: int = url.lastIndexOf("\\"); // reason for the double slash is just to escape the slash so it doesn't escape the quote!!!
				var slashIndex: int = fSlash > bSlash ? fSlash : bSlash;
				var imageName: String = url.substr(slashIndex + 1);
				
				this.setUrlFondo(url);
				this.getPanelPropiedades().nombre_fondo.text = imageName;
				this.getPanelPropiedades().setAuxID(id);
				
				//CREAR UN LOADER Y CARGAR LA IMAGEN!!!
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
			trace("[Flash] handleData - Cargando imagen de fondo");
			//Borramos si ya existe
			for (var i:int = 0; i<lienzo.contenedor.area_editable.numChildren; i++)
			{
				var tipo_elemento:String = lienzo.contenedor.area_editable.getChildAt(i);
				if (tipo_elemento.indexOf("MovieClip") != -1)
				{
					lienzo.contenedor.area_editable.removeChildAt(i);
					i=0;
				}
			}
			
			this.getPanelPropiedades().imagen_fondo = new MovieClip();
			this.getPanelPropiedades().setFondoID(this.getPanelPropiedades().getAuxID());
			this.getPanelPropiedades().imagen_fondo.addChild(e.currentTarget.content);
			this.getPanelPropiedades().imagen_fondo.width = this.anL;
			this.getPanelPropiedades().imagen_fondo.height = this.alL;
			lienzo.contenedor.area_editable.addChild(this.getPanelPropiedades().imagen_fondo);
		}
		
		///<summary>
		///Parsea el xml recibido y carga los elementos según su profundidad
		///</summary>
		private function cargarElementosOrdenados()
		{
			trace("[Flash] Cargando elementos ordenados en profundidad : "+elementos.length());
			for (var k:int = 1; k <= elementos.length(); k++) //Va de profundidad 1 a profundidad = elementos.length()
			{
				for (var i:int = 0; i < elementos.length(); i++)
				{
					if (elementos[i].attribute("profundidad") == k)
					{
						var tipo = elementos[i].attribute("tipo");
						var alto:Number = Math.round(Number(elementos[i].attribute("alto"))*alL);
						var ancho:Number = Math.round(Number(elementos[i].attribute("ancho"))*anL);
						var profundidad:int = int(elementos[i].attribute("profundidad"));
						var transparencia:Number = Number(elementos[i].attribute("transparencia"));
						var cy = Math.round(Number(elementos[i].attribute("cY"))*alL);
						var cx = Math.round(Number(elementos[i].attribute("cX"))*anL);
						var path = elementos[i].attribute("path");
						
						var cuadro:CContenedorElemento = new CContenedorElemento(this);
						cuadro.setTipo(tipo);
						cuadro.setXpos(cx); 
						cuadro.setYpos(cy);
						cuadro.setAlto(alto);
						cuadro.setAncho(ancho);
						cuadro.setProfundidad(profundidad);
						cuadro.setTransparencia(transparencia);
						cuadro.estado = 1;
						
						cuadro.datos_elemento.fondo.width = cuadro.getAncho();
						cuadro.datos_elemento.fondo.height = cuadro.getAlto();
						cuadro.datos_elemento.width = cuadro.getAncho();
						cuadro.datos_elemento.height = cuadro.getAlto();
						
						this.getPanelPropiedades().btnRelacion.selected = true;
						cuadro.setCandado(true);
												
						if (tipo == "texto") 
						{
							elementos[i].ignoreWhite = true;
							var parrafo:XMLList = elementos[i].P;
							
							for(var b:int=0; b< parrafo.length(); b++)
							{
								var prueba:XML = parrafo[b];
								if(prueba.children().toXMLString().indexOf('</FONT>') == -1)
								{
									try
									{
										delete elementos[i].P[b];
										parrafo = elementos[i].P;
										b=0;
									}
									catch (e:Error){trace("error al eliminar = ", e.toString());}
								}
							}
							
							var texto:String = parrafo.toXMLString();			
							texto = texto.split("\n").join("");
							//texto = texto.split("</P>").join("</P><BR/>");
							
							texto = texto.split("<P><LI").join("<LI");
							texto = texto.split("/LI></P>").join("/LI>");
												
							var texto_aux:TextField = new TextField();
							texto_aux.condenseWhite = true; 
							texto_aux.multiline = true;
							texto_aux.wordWrap = true;
							texto_aux.htmlText = texto;
							texto_aux.width = ancho;
							texto_aux.height = alto;
							texto_aux.alpha = transparencia;
					
							cuadro.loadContent(tipo,path,texto_aux,true);							
							cuadro.recargarTexto(texto_aux);
							lienzo.contenedor.addChild(cuadro);
							cuadro.setID(lienzo.contenedor.getChildIndex(cuadro));
							//panel_propiedades.insertPropGenericas(cuadro);
							listaElementos.push(cuadro);
							
							cuadro.load();
						}
						else if (tipo == "imagen") 
						{
							cuadro.setDimensiones(); //TIENE QUE IR PRIMERO PARA CARGAR LA PESTAÑA!
							if (path != null ) cuadro.loadContent(tipo,path,null,true);
						
							lienzo.contenedor.addChild(cuadro);						
							cuadro.setID(elementos[i].attribute("ID"));
							cuadro.setIDRecurso(elementos[i].attribute("ID"));
							//panel_propiedades.insertPropGenericas(cuadro);
							listaElementos.push(cuadro);
							cuadro.load();
						}
						else if (tipo == "swf") 
						{
							cuadro.setDimensiones(); //TIENE QUE IR PRIMERO PARA CARGAR LA PESTAÑA!
							if (path != null ) cuadro.loadContent(tipo,path,null,true);
														
							lienzo.contenedor.addChild(cuadro);						
							cuadro.setID(elementos[i].attribute("ID"));
							//panel_propiedades.insertPropGenericas(cuadro);
							listaElementos.push(cuadro);
							cuadro.load();
						}
						else if (tipo == "video") 
						{
							cuadro.setDimensiones(); //TIENE QUE IR PRIMERO PARA CARGAR LA PESTAÑA!
							
							if (elementos[i].attribute("bucle") == "true") cuadro.setBucle(true);
							else cuadro.setBucle(false);
							
							if (path != null ) cuadro.recargarVideo(path);
														
							lienzo.contenedor.addChild(cuadro);						
							cuadro.setID(elementos[i].attribute("ID"));
							cuadro.setIDRecurso(elementos[i].attribute("ID"));
							listaElementos.push(cuadro);
							cuadro.load();
						}
						else if (tipo == "tiempo") 
						{
							//Guardamos variables para actualizar el elemento
							cuadro.dia = elementos[i].attribute("dia"); 
							cuadro.cod_ciudad = elementos[i].attribute("ciudad"); 
							cuadro.pais = elementos[i].attribute("pais"); 
							cuadro.estilo_tiempo = elementos[i].attribute("estilo"); 
							cuadro.setPosicionTextos(elementos[i].attribute("posicion_textos"));
							cuadro.setFormatoFecha(elementos[i].attribute("fecha_formato")); 
							cuadro.setColorFecha(uint(elementos[i].attribute("fecha_color"))); 
							cuadro.setFuenteFecha(elementos[i].attribute("fecha_fuente")); 
							
							var path_elemento:String = elementos[i].attribute("path");
							if (path_elemento.indexOf("vertical") != -1) cuadro.tipo_tiempo = "vertical";
							else if (path_elemento.indexOf("horizontal") != -1) cuadro.tipo_tiempo = "horizontal";
							
							if(elementos[i].attribute("fecha_negrita") == "true") cuadro.setNegritaFecha(true) ;
							else cuadro.setNegritaFecha(false); 
							
							if(elementos[i].attribute("fecha_cursiva") == "true") cuadro.setCursivaFecha(true) ;
							else cuadro.setCursivaFecha(false); 
							
							if(elementos[i].attribute("fecha_subrayado") == "true") cuadro.setSubrayadoFecha(true) ;
							else cuadro.setSubrayadoFecha(false); 
							
							if(elementos[i].attribute("temp_negrita") == "true") cuadro.setNegritaTemp(true) ;
							else cuadro.setNegritaTemp(false); 
							
							if(elementos[i].attribute("temp_cursiva") == "true") cuadro.setCursivaTemp(true) ;
							else cuadro.setCursivaTemp(false); 
							
							if(elementos[i].attribute("temp_subrayado") == "true") cuadro.setSubrayadoTemp(true) ;
							else cuadro.setSubrayadoTemp(false); 
														
							cuadro.setColorTemp(uint(elementos[i].attribute("temp_color"))); 
							cuadro.setFuenteTemp(elementos[i].attribute("temp_fuente")); 
							
							//cuadro.cambiandoDeTipo = true;
														
							lienzo.contenedor.addChild(cuadro);						
							cuadro.setID(lienzo.contenedor.getChildIndex(cuadro));
							listaElementos.push(cuadro);
							cuadro.load();
							cuadro.setDimensiones(); //TIENE QUE IR PRIMERO PARA CARGAR LA PESTAÑA!
						}
						else if (tipo == "rss") 
						{
							//Guardamos variables para actualizar el elemento
							cuadro.rss_url = elementos[i].attribute("rss_url"); 
							cuadro.estilo_rss = elementos[i].attribute("estilo"); 
							cuadro.tiempo_trans_rss = int(elementos[i].attribute("tiempo_transicion"));
							cuadro.velocidad_rss = int(elementos[i].attribute("velocidad"));
							cuadro.velocidad_titulo = int(elementos[i].attribute("velocidad_titulo"));
							cuadro.color_sup = uint(elementos[i].attribute("color_superior"));
							cuadro.alpha_superior = Number(elementos[i].attribute("alpha_superior"));
							cuadro.color_inf = uint(elementos[i].attribute("color_inferior"));
							cuadro.alpha_inferior = Number(elementos[i].attribute("alpha_inferior"));
							cuadro.fuente_titulo = elementos[i].attribute("fuente_titulos"); 
							cuadro.fuente_texto = elementos[i].attribute("fuente_textos"); 
							cuadro.size_titulo = int(elementos[i].attribute("size_titulos"));
							cuadro.size_texto = int(elementos[i].attribute("size_textos")); 
							cuadro.color_titulo = uint(elementos[i].attribute("color_titulos"));
							cuadro.color_texto = uint(elementos[i].attribute("color_textos"));
							cuadro.align_titulo = elementos[i].attribute("align_titulos"); 
							cuadro.align_texto = elementos[i].attribute("align_textos"); 
														
							if(elementos[i].attribute("titulo_activo") == "true") cuadro.tituloActivo = true;
							else cuadro.tituloActivo = false;
							
							if(elementos[i].attribute("imagen_visible") == "true") cuadro.imagenVisible = true;
							else cuadro.imagenVisible = false;
							
							if(elementos[i].attribute("negrita_titulo") == "true") cuadro.negrita_titulo = true;
							else cuadro.negrita_titulo = false;
							
							if(elementos[i].attribute("negrita_texto") == "true") cuadro.negrita_texto = true;
							else cuadro.negrita_texto = false;
							
							if(elementos[i].attribute("cursiva_titulo") == "true") cuadro.cursiva_titulo = true;
							else cuadro.cursiva_titulo = false;
							
							if(elementos[i].attribute("cursiva_texto") == "true") cuadro.cursiva_texto = true;
							else cuadro.cursiva_texto = false;
							
							if(elementos[i].attribute("subrayado_titulo") == "true") cuadro.subrayado_titulo = true;
							else cuadro.subrayado_titulo = false;
							
							if(elementos[i].attribute("subrayado_texto") == "true") cuadro.subrayado_texto = true;
							else cuadro.subrayado_texto = false;
							
							//cuadro.setDimensiones(); //TIENE QUE IR PRIMERO PARA CARGAR LA PESTAÑA!
							cuadro.recargarFondoRSS();
																					
							lienzo.contenedor.addChild(cuadro);						
							cuadro.setID(lienzo.contenedor.getChildIndex(cuadro));
							listaElementos.push(cuadro);
							cuadro.load();
						}
						else if (tipo == "ticker")
						{
							if (elementos[i].attribute("negrita") == "true") cuadro.setNegritaTicker(true);
							else cuadro.setNegritaTicker(false);
							
							if (elementos[i].attribute("cursiva") == "true") cuadro.setCursivaTicker(true);
							else cuadro.setCursivaTicker(false);
							
							if (elementos[i].attribute("subrayado") == "true") cuadro.setSubrayadoTicker(true);
							else cuadro.setSubrayadoTicker(false);
							
							cuadro.setFuenteTicker(elementos[i].attribute("fuente"));
							cuadro.setColorTicker(uint(elementos[i].attribute("color")));
							cuadro.setAlineacionTicker(elementos[i].attribute("alineacion"));
							cuadro.setVelocidadTicker(elementos[i].attribute("velocidad"));
							cuadro.setSizeTicker(elementos[i].attribute("size"));
							
							var txt_aux:TextField = new TextField();
							txt_aux.multiline = false;
							txt_aux.wordWrap = false;
							txt_aux.text = "Texto del ticker";
							txt_aux.width = ancho;
							txt_aux.height = alto;
							txt_aux.selectable = false;
							
							var formato:TextFormat = new TextFormat();
							formato.bold = cuadro.getNegritaTicker();
							formato.italic = cuadro.getCursivaTicker();
							formato.underline = cuadro.getSubrayadoTicker();
							formato.color = cuadro.getColorTicker();
							formato.align = cuadro.getAlineacionTicker();
							formato.size = int(elementos[i].attribute("size"));
							formato.font = cuadro.getFuenteTicker();
							
							txt_aux.setTextFormat(formato);			
																				
							cuadro.recargarTexto(txt_aux);
							lienzo.contenedor.addChild(cuadro);
							cuadro.setID(lienzo.contenedor.getChildIndex(cuadro));
							//panel_propiedades.insertPropGenericas(cuadro);
							listaElementos.push(cuadro);
							
							cuadro.load();
						}
						else if (tipo == "anuncio")
						{
							cuadro.setDimensiones();
							lienzo.contenedor.addChild(cuadro);
							cuadro.setID(lienzo.contenedor.getChildIndex(cuadro));
							//panel_propiedades.insertPropGenericas(cuadro);
							listaElementos.push(cuadro);
							cuadro.load();
						}
						else if (tipo == "reloj")
						{
							cuadro.insertarPestañaInferior();
							
							cuadro.tipo_reloj = elementos[i].attribute("tipo_reloj");
							cuadro.url_reloj = elementos[i].attribute("path");
							cuadro.color_agujas = elementos[i].attribute("color_agujas");
							cuadro.alpha_agujas = elementos[i].attribute("alpha_agujas");
							cuadro.color_marcas = elementos[i].attribute("color_marcas");
							cuadro.alpha_marcas = elementos[i].attribute("alpha_marcas");
							cuadro.color_sombra = elementos[i].attribute("color_sombra");
							cuadro.alpha_sombra = elementos[i].attribute("alpha_sombra");
							cuadro.color_fondo = elementos[i].attribute("color_fondo");
							cuadro.alpha_fondo = elementos[i].attribute("alpha_fondo");
							cuadro.color_marco = elementos[i].attribute("color_marco");
							cuadro.alpha_marco = elementos[i].attribute("alpha_marco");
							cuadro.color_remarco = elementos[i].attribute("color_remarco");
							cuadro.alpha_remarco = elementos[i].attribute("alpha_remarco");
							cuadro.color_numeros = elementos[i].attribute("color_numeros");
							cuadro.alpha_numeros = elementos[i].attribute("alpha_numeros");
							cuadro.color_mes = elementos[i].attribute("color_mes");
							cuadro.color_dia = elementos[i].attribute("color_dia");
							cuadro.color_numDia = elementos[i].attribute("color_numDia");
							cuadro.alpha_mes = elementos[i].attribute("alpha_mes");
							cuadro.alpha_dia = elementos[i].attribute("alpha_dia");
							cuadro.alpha_numDia = elementos[i].attribute("alpha_numDia");
	
							if (cuadro.tipo_reloj == "analog") 
							{
								cuadro.cargarRelojAnalogico();
							}
							else if (cuadro.tipo_reloj == "digital")
							{
								//cuadro.datos_elemento.fondo.width = 160;
								//cuadro.datos_elemento.fondo.height = 50;
								cuadro.datos_elemento.fondo.width = ancho;
								cuadro.datos_elemento.fondo.height = alto;
								cuadro.cargarRelojDigital();
							}
							
							lienzo.contenedor.addChild(cuadro);
							cuadro.setID(lienzo.contenedor.getChildIndex(cuadro));
							//panel_propiedades.insertPropGenericas(cuadro);
							listaElementos.push(cuadro);
							cuadro.load();
						}
						else if (tipo == "pasafotos")
						{
							var string_imagenes:String = elementos[i].attribute("url_imagenes");
							var array_imagenes:Array = string_imagenes.split(",");
							var array_IDs:Array = (elementos[i].attribute("ID")).toString().split(",");
							var array_nombres:Array = new Array();
							
							var urlImagen:String;
							var m:int = 0;
						
							for (m=0 ; m<array_imagenes.length;m++)
							{
								urlImagen = array_imagenes[m];
								
								//Sacamos primero el nombre
								var fSlash: int = urlImagen.lastIndexOf("/");
								var bSlash: int = urlImagen.lastIndexOf("\\"); // reason for the double slash is just to escape the slash so it doesn't escape the quote!!!
								var slashIndex: int = fSlash > bSlash ? fSlash : bSlash;
								var imageName: String = urlImagen.substr(slashIndex + 1);
								
								array_nombres.push(imageName);
							}
														
							cuadro.setArrayPasafotos(array_imagenes);
							cuadro.setArrayNombresPasafotos(array_nombres);
							cuadro.setArrayIDsPasafotos(array_IDs);
							cuadro.setSentidoPasafotos(elementos[i].attribute("sentido"));
							cuadro.setDireccionPasafotos(elementos[i].attribute("direccion"));
							cuadro.setEfectoPasafotos(elementos[i].attribute("efecto"));
							cuadro.setTimerPasafotos(elementos[i].attribute("tiempo_trans")); 
							cuadro.setVelocidadTransicion(elementos[i].attribute("vel_trans"));
							
							
							cuadro.setDimensiones();						
							lienzo.contenedor.addChild(cuadro);
							cuadro.setID(lienzo.contenedor.getChildIndex(cuadro));
							//panel_propiedades.insertPropGenericas(cuadro);
							listaElementos.push(cuadro);
							cuadro.load();
							
							cuadro.datos_elemento.width = ancho;
							cuadro.datos_elemento.height = alto;
						}
						else if (tipo == "menu")
						{
							cuadro.nombreEstilo = elementos[i].attribute("estilo");
							cuadro.fondo_url = elementos[i].attribute("url_fondo");
							cuadro.fondoMenu_ID = elementos[i].attribute("ID");
							cuadro.fondo_color = elementos[i].attribute("color_fondo");
							cuadro.cabecera_txt = elementos[i].attribute("cabecera_txt");
							cuadro.tituloP_txt = elementos[i].attribute("tituloP_txt");
							cuadro.titulo1_txt = elementos[i].attribute("titulo1_txt");
							cuadro.titulo2_txt = elementos[i].attribute("titulo2_txt");
							cuadro.titulo3_txt = elementos[i].attribute("titulo3_txt");
							cuadro.texto1_txt = elementos[i].attribute("texto1_txt");
							cuadro.texto2_txt = elementos[i].attribute("texto2_txt");
							cuadro.texto3_txt = elementos[i].attribute("texto3_txt");
							cuadro.pie_txt = elementos[i].attribute("pie_txt");
							
							if (elementos[i].attribute("existe_fondo") == "true") cuadro.existe_fondo = true;
							else cuadro.existe_fondo = false;
							
							if (elementos[i].attribute("hayColorFondo") == "true") cuadro.hayColorFondo = true;
							else cuadro.hayColorFondo = false;
							
							if (elementos[i].attribute("cabecera_visible") == "true") cuadro.cabecera_visible = true;
							else cuadro.cabecera_visible = false;
							
							if (elementos[i].attribute("tituloP_visible") == "true") cuadro.tituloP_visible = true;
							else cuadro.tituloP_visible = false;
							
							if (elementos[i].attribute("titulo1_visible") == "true") cuadro.titulo1_visible = true;
							else cuadro.titulo1_visible = false;
							
							if (elementos[i].attribute("titulo2_visible") == "true") cuadro.titulo2_visible = true;
							else cuadro.titulo2_visible = false;
							
							if (elementos[i].attribute("titulo3_visible") == "true") cuadro.titulo3_visible = true;
							else cuadro.titulo3_visible = false;
							
							if (elementos[i].attribute("texto1_visible") == "true") cuadro.texto1_visible = true;
							else cuadro.texto1_visible = false;
							
							if (elementos[i].attribute("texto2_visible") == "true") cuadro.texto2_visible = true;
							else cuadro.texto2_visible = false;
							
							if (elementos[i].attribute("texto3_visible") == "true") cuadro.texto3_visible = true;
							else cuadro.texto3_visible = false;
							
							if (elementos[i].attribute("pie_visible") == "true") cuadro.pie_visible = true;
							else cuadro.pie_visible = false;				
							
							//Formatos
							var formato_cab:TextFormat = new TextFormat();
							formato_cab.align = elementos[i].attribute("cabecera_align");
							formato_cab.color = elementos[i].attribute("cabecera_color");
							formato_cab.size = elementos[i].attribute("cabecera_size");
							formato_cab.font = elementos[i].attribute("cabecera_fuente");
							if(elementos[i].attribute("cabecera_negrita") == "true") formato_cab.bold = true; else formato_cab.bold = false;
							if(elementos[i].attribute("cabecera_bullet") == "true") formato_cab.bullet = true; else formato_cab.bullet = false;
							if(elementos[i].attribute("cabecera_cursiva") == "true") formato_cab.italic = true; else formato_cab.italic = false;
							if(elementos[i].attribute("cabecera_subrayado") == "true") formato_cab.underline = true; else formato_cab.underline = false;
							cuadro.formato_cabecera = formato_cab;
							
							var formatoP:TextFormat = new TextFormat();
							formatoP.align = elementos[i].attribute("tituloP_align");
							formatoP.color = elementos[i].attribute("tituloP_color");
							formatoP.size = elementos[i].attribute("tituloP_size");
							formatoP.font = elementos[i].attribute("tituloP_fuente");							
							if(elementos[i].attribute("tituloP_negrita") == "true") formatoP.bold = true; else formatoP.bold = false;
							if(elementos[i].attribute("tituloP_bullet") == "true") formatoP.bullet = true; else formatoP.bullet = false;
							if(elementos[i].attribute("tituloP_cursiva") == "true") formatoP.italic = true; else formatoP.italic = false;
							if(elementos[i].attribute("tituloP_subrayado") == "true") formatoP.underline = true; else formatoP.underline = false;
							cuadro.formato_tituloP = formatoP;
							
							var formato_tit1:TextFormat = new TextFormat();
							formato_tit1.align = elementos[i].attribute("titulo1_align");
							formato_tit1.color = elementos[i].attribute("titulo1_color");
							formato_tit1.size = elementos[i].attribute("titulo1_size");
							formato_tit1.font = elementos[i].attribute("titulo1_fuente");							
							if(elementos[i].attribute("titulo1_negrita") == "true") formato_tit1.bold = true; else formato_tit1.bold = false;
							if(elementos[i].attribute("titulo1_bullet") == "true") formato_tit1.bullet = true; else formato_tit1.bullet = false;
							if(elementos[i].attribute("titulo1_cursiva") == "true") formato_tit1.italic = true; else formato_tit1.italic = false;
							if(elementos[i].attribute("titulo1_subrayado") == "true") formato_tit1.underline = true; else formato_tit1.underline = false;
							cuadro.formato_titulo1 = formato_tit1;
							
							var formato_tit2:TextFormat = new TextFormat();
							formato_tit2.align = elementos[i].attribute("titulo2_align");
							formato_tit2.color = elementos[i].attribute("titulo2_color");
							formato_tit2.size = elementos[i].attribute("titulo2_size");
							formato_tit2.font = elementos[i].attribute("titulo2_fuente");						
							if(elementos[i].attribute("titulo2_negrita") == "true") formato_tit2.bold = true; else formato_tit2.bold = false;
							if(elementos[i].attribute("titulo2_bullet") == "true") formato_tit2.bullet = true; else formato_tit2.bullet = false;
							if(elementos[i].attribute("titulo2_cursiva") == "true") formato_tit2.italic = true; else formato_tit2.italic = false;
							if(elementos[i].attribute("titulo2_subrayado") == "true") formato_tit2.underline = true; else formato_tit2.underline = false;
							cuadro.formato_titulo2 = formato_tit2;
														
							var formato_tit3:TextFormat = new TextFormat();
							formato_tit3.align = elementos[i].attribute("titulo3_align");
							formato_tit3.color = elementos[i].attribute("titulo3_color");
							formato_tit3.size = elementos[i].attribute("titulo3_size");
							formato_tit3.font = elementos[i].attribute("titulo3_fuente");							
							if(elementos[i].attribute("titulo3_negrita") == "true") formato_tit3.bold = true; else formato_tit3.bold = false;
							if(elementos[i].attribute("titulo3_bullet") == "true") formato_tit3.bullet = true; else formato_tit3.bullet = false;
							if(elementos[i].attribute("titulo3_cursiva") == "true") formato_tit3.italic = true; else formato_tit3.italic = false;
							if(elementos[i].attribute("titulo3_subrayado") == "true") formato_tit3.underline = true; else formato_tit3.underline = false;
							cuadro.formato_titulo3 = formato_tit3;
							
							var formato_txt1:TextFormat = new TextFormat();
							formato_txt1.align = elementos[i].attribute("texto1_align");
							formato_txt1.color = elementos[i].attribute("texto1_color");
							formato_txt1.size = elementos[i].attribute("texto1_size");
							formato_txt1.font = elementos[i].attribute("texto1_fuente");
							if(elementos[i].attribute("texto1_negrita") == "true") formato_txt1.bold = true; else formato_txt1.bold = false;
							if(elementos[i].attribute("texto1_bullet") == "true") formato_txt1.bullet = true; else formato_txt1.bullet = false;
							if(elementos[i].attribute("texto1_cursiva") == "true") formato_txt1.italic = true; else formato_txt1.italic = false;
							if(elementos[i].attribute("texto1_subrayado") == "true") formato_txt1.underline = true; else formato_txt1.underline = false;
							cuadro.formato_texto1 = formato_txt1;
							
							var formato_txt2:TextFormat = new TextFormat();
							formato_txt2.align = elementos[i].attribute("texto2_align");
							formato_txt2.color = elementos[i].attribute("texto2_color");
							formato_txt2.size = elementos[i].attribute("texto2_size");
							formato_txt2.font = elementos[i].attribute("texto2_fuente");							
							if(elementos[i].attribute("texto2_negrita") == "true") formato_txt2.bold = true; else formato_txt2.bold = false;
							if(elementos[i].attribute("texto2_bullet") == "true") formato_txt2.bullet = true; else formato_txt2.bullet = false;
							if(elementos[i].attribute("texto2_cursiva") == "true") formato_txt2.italic = true; else formato_txt2.italic = false;
							if(elementos[i].attribute("texto2_subrayado") == "true") formato_txt2.underline = true; else formato_txt2.underline = false;
							cuadro.formato_texto2 = formato_txt2;
							
							var formato_txt3:TextFormat = new TextFormat();
							formato_txt3.align = elementos[i].attribute("texto3_align");
							formato_txt3.color = elementos[i].attribute("texto3_color");
							formato_txt3.size = elementos[i].attribute("texto3_size");
							formato_txt3.font = elementos[i].attribute("texto3_fuente");
							if(elementos[i].attribute("texto3_negrita") == "true") formato_txt3.bold = true; else formato_txt3.bold = false;
							if(elementos[i].attribute("texto3_bullet") == "true") formato_txt3.bullet = true; else formato_txt3.bullet = false;
							if(elementos[i].attribute("texto3_cursiva") == "true") formato_txt3.italic = true; else formato_txt3.italic = false;
							if(elementos[i].attribute("texto3_subrayado") == "true") formato_txt3.underline = true; else formato_txt3.underline = false;
							cuadro.formato_texto3 = formato_txt3;
							
							var formato_pie:TextFormat = new TextFormat();
							formato_pie.align = elementos[i].attribute("pie_align");
							formato_pie.color = elementos[i].attribute("pie_color");
							formato_pie.size = elementos[i].attribute("pie_size");
							formato_pie.font = elementos[i].attribute("pie_fuente");
							if(elementos[i].attribute("pie_negrita") == "true") formato_pie.bold = true; else formato_pie.bold = false;
							if(elementos[i].attribute("pie_bullet") == "true") formato_pie.bullet = true; else formato_pie.bullet = false;
							if(elementos[i].attribute("pie_cursiva") == "true") formato_pie.italic = true; else formato_pie.italic = false;
							if(elementos[i].attribute("pie_subrayado") == "true") formato_pie.underline = true; else formato_pie.underline = false;
							cuadro.formato_pie = formato_pie;
							
							cuadro.insertarPestañaInferior();		
							cuadro.recargarMenu();
							lienzo.contenedor.addChild(cuadro);
							//panel_propiedades.insertPropGenericas(cuadro);
							listaElementos.push(cuadro);
							cuadro.load();
							
							cuadro.datos_elemento.width = ancho;
							cuadro.datos_elemento.height = alto;
							
						}
						
						cuadro.datos_elemento.alpha = cuadro.getTransparencia();
					}
				}
			}
			desactivarAnterior();
			panel_propiedades.borrarPanelPropiedades();
			this.getPanelPropiedadesEspecificas().descargarPanel();
		}
		
		public function setResourceLibrary(resourceLibrary:Object):void
		{
			trace("[oceEditor][Flex - Flash] setResourceLibrary.");
			this._resourceLibrary = resourceLibrary;
		}
		
		public function getResourceURLFlash(resource_type:int, default_resource:String = "0"):void
		{
			trace("[Main] -  getResourceURLFlash -> resource previo = "+default_resource);
			try
			{
				this._resourceLibrary.getResourceURL(resource_type, default_resource);
			}
			catch (error:Error)
			{
				trace("[oceEditor][ExInter] error aita getResourceURL: ",error.message);
			}
		}
		
		public function setSelectedResource(resource:Object):void
		{
			trace("[oceEditor][Flex - Flash] setSelectedResource.");
			var selectedResourceEvent:resourceReceivedEvent = new resourceReceivedEvent(resourceReceivedEvent.RESOURCE_RECEIVED);
			selectedResourceEvent.resource = resource;
			dispatchEvent(selectedResourceEvent);
		}
		
		public function saveContentFlash(contenidoXML:XML,resources:Array)
		{
			trace("[oceEditor][Flash - Flex] call saveContent");
			try
			{
				this._resourceLibrary.saveContent(contenidoXML, resources);
			}
			catch (error:Error)
			{
				trace("[oceEditor][ExInter] error aita saveContent: ",error.message);
			}
		}
		
		//volverSinGuardar
		public function volverSinGuardar()
		{
			trace("[oceEditor][Flash - Flex] volver");
			try
			{
				this._resourceLibrary.returnWithoutSaving ();
			}
			catch (error:Error)
			{
				trace("[oceEditor][ExInter] error aita volver: ",error.message);
			}
		}
		/***************************************************************************************************/
	}
	
}