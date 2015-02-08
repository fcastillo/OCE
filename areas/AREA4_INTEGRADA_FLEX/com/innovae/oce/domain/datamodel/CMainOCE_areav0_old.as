package  com.innovae.oce.domain.datamodel
{
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.text.*;	
	import flash.text.TextField;
	
	import cod.*;
	
	import flash.external.ExternalInterface;
	import com.innovae.oce.domain.datamodel.oceEditorInterface;
	import com.innovae.oce.domain.datamodel.oceEditorProviderInterface;
		
	public class CMainOCE_areav0 extends MovieClip  implements oceEditorInterface
	{		
		//*****************************VARIABLES************************************/
		//Interface
		public var _resourceLibrary:oceEditorProviderInterface;
		
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
		
		//**************************FIN VARIABLES**********************************/
		
		//*****************************GETTERS/SETTERS************************************/
		public function getPanelHerramientas():CHerramientas {return panel_herramientas;}
		public function getPanelPropiedades():CPanelPropiedades {return panel_propiedades;}
		public function getPanelPropiedadesEspecificas():CPanelPropiedadesEspecificas {return panel_propEsp;}
		public function getCandadoPadre():Boolean {return candado_padre;}
		public function getListaElementos():Array {return listaElementos;}
		
		public function getTipoElemento():String {return tipo_elemento;}
		public function getKeyCode():String {return keyCode;}
		
		public function setPanelHerramientas(val:CHerramientas):void {panel_herramientas = val;}
		public function setPanelPropiedades(val:CPanelPropiedades):void {panel_propiedades = val;}
		public function setPanelPropiedadesEspecificas(val:CPanelPropiedadesEspecificas):void {panel_propEsp = val;}
		public function setCandadoPadre(val:Boolean):void {candado_padre = val;}
		public function setListaElementos(val:Array):void {listaElementos = val;}
		
		public function setTipoElemento(val:String):void {tipo_elemento = val;}
		public function setKeyCode(val:String):void {keyCode = val;}
		//********************************************************************************/
		
		///<summary>
		///Constructor; carga los paneles en el stage
		///</summary>
		public function CMainOCE_areav0() 
		{
			//Inicializamos variables
			listaElementos = new Array();
			
			//Caragmos paneles
			cargarPanelHerramientas();
			cargarPanelPropiedades();
			cargarPanelPropiedadesEspecíficas();
			
			//Cargamos listeners
			cargarListeners();
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
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
			//--------------------------------------------------------------------------------//
			
			//------------------------------AREA DE EDICIÓN----------------------------------//
			lienzo.contenedor.area_editable.addEventListener(MouseEvent.MOUSE_DOWN, startRect);
			lienzo.contenedor.area_editable.addEventListener(MouseEvent.CLICK, onAreaEditable);
			//--------------------------------------------------------------------------------//
		}
		
		//******************************Eventos teclado**************************************//
		///<summary>
		///Controla si están pulsadas las teclas Ctrl y Mayus para la multiselección, o las flechas para mover objetos
		///</summary>
		function keyDownHandler( e:KeyboardEvent ):void
		{
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
			switch(e.keyCode)
			{
				case 16: break;
				case 17: break;
				case 37: moverObjeto("left"); break;
				case 38: moverObjeto("up"); break;
				case 39: moverObjeto("right"); break;
				case 40: moverObjeto("down"); break;
			}
		}
		
		///<summary>
		///Controla si se ha dejado de pulsar alguna tecla
		///</summary>
		function keyUpHandler( e:KeyboardEvent ):void
		{
			if ((e.keyCode == 16) || (e.keyCode == 17)) 
			{
				permitirSeleccion = false;
			}
			keyCode = "";
		}
		
		///<summary>
		///Mueve el elemento seleccionado mediante el teclado
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
			//CUIDADO!! IGUAL HAY QUE DESCOMENTAR PARA QUE LOS TEXTOS NO SE QUEDEN CON EL CURSOR!!!!!
			if ((elemento_seleccionado!= null)&&(elemento_seleccionado.texto != null))
			{
				elemento_seleccionado.texto.setSelection(elemento_seleccionado.texto.text.length,elemento_seleccionado.texto.text.length);
				elemento_seleccionado.texto.type = TextFieldType.DYNAMIC;
			}
			desactivarAnterior();
			this.initX = mouseX;
			this.initY = mouseY;
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
			pizarra.graphics.clear();
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
		///Dejamos de pintar el cuadrado y activamos la multiselección
		///</summary>
		function endRect(e:MouseEvent)
		{
			//prueba
			this.removeEventListener(Event.ENTER_FRAME, pintandoCuadrado);
			pizarra.graphics.clear();		
					
			var contenedorTocado:Boolean = false;
			var elementoTocado:Boolean = false;
						
			var pos_mouseX:Number = e.currentTarget.mouseX - lienzo.x;
			var pos_mouseY:Number = e.currentTarget.mouseY - lienzo.y;
			
			for (var i:int = 0; i< listaElementos.length; i++)
			{
				var elem_posX:Number = listaElementos[i].x;
				var elem_posY:Number = listaElementos[i].y;
				if ((pos_mouseX >= elem_posX) && (pos_mouseX <= (elem_posX + listaElementos[i].width)) && (pos_mouseX >= elem_posY) && (pos_mouseY <= (elem_posY + listaElementos[i].height))) elementoTocado = true;
			}
						
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
			if (listaElementos.length > 0)
			{
				for (i = 0; i< listaElementos.length; i++)
				{
					item = listaElementos[i];
					var item_width:Number = item.datos_elemento.width;
					var item_height:Number = item.datos_elemento.height;
					var x1:Number = item.x + item_width;
					var y1:Number = item.y + item_height;
															
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

			}
		}
		
		public function comprobarSiEstaDentro(item:CContenedorElemento,xmin:Number,xmax:Number,ymin:Number,ymax:Number,x1:Number,y1:Number)
		{
			//if (item.getTipo() != "pasafotos")
			//{
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
			//}
		}
		
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
			cuadro.load();
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
				comprobarCambiosEnDimensiones();
				elemento_seleccionMultiple.stopDrag();
				var xinit:Number = elemento_seleccionMultiple.x;
				var yinit:Number = elemento_seleccionMultiple.y;
				
				arrayContenido = elemento_seleccionMultiple.getArrayDatos();
				elemento_seleccionMultiple.desactivarElemento();
				elemento_seleccionMultiple.eliminar();
				elemento_seleccionMultiple = null;
				deshacerSeleccionMultiple(xinit,yinit);
				
				diferencia_x = 0; //Reseteamos valores offset del movimiento del contenedor múltiple
				diferencia_y = 0;
				
				borrado = true;
				panel_propiedades.borrarPanelPropiedades();
				borrarLista();
			}
		}
		
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
			}
		}
		/********************************************************************************************************/
		
		/******************************************** onAreaEditable ********************************************/
		
		///<summary>
		///Función que controla los clicks sobre el lienzo - Si es necesario desactiva los elementos seleccionados
		///</summary>
		function onAreaEditable(e:MouseEvent)
		{
			trace("**********onAreaEditable");
			if (!desactivarOnAreaEditable) //no está desactivada la función; si es true, significa que estamos con multiselección
			{
				desactivarElementos();
			}
			else desactivarOnAreaEditable = false;
			
			trace("*********FIN onAreaEditable");
			trace(" ");
		}
		
		///<summary>
		///Función que desactiva los elementos seleccionados
		///</summary>
		function desactivarElementos()
		{
			trace("**********desactivarElementos************");			
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
			
			//linkado.esconderCombo();
//			panel_pasafotos.visible = false;		
//							
			diferencia_x = 0; //Reseteamos valores offset del movimiento del contenedor múltiple
			diferencia_y = 0;
			zMax = 0;
//			
			borrado = true;
			
			panel_propiedades.borrarPanelPropiedades();
			panel_propEsp.descargarPanel();
			borrarLista();
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
				arrayContenido[i].contenido.x = 0;
				arrayContenido[i].contenido.y = 0;
				arrayContenido[i].contenido.width = anchoContenido;
				arrayContenido[i].contenido.height = altoContenido;
																
				var cuadro:CContenedorElemento = new CContenedorElemento(this);
				cuadro.setTipo(arrayContenido[i].tipo);
				cuadro.setXpos(arrayContenido[i].xpos); 
				cuadro.setYpos(arrayContenido[i].ypos);
				cuadro.setUrlDatos(arrayContenido[i].url_datos);
				cuadro.lector_tiempo = arrayContenido[i].lector_tiempo;
				cuadro.control_menu = arrayContenido[i].control_menu;
				cuadro.control_reloj = arrayContenido[i].control_reloj;
				
				//CÓDIGO ANTERIOR
				//cuadro.pasafotos = arrayContenido[i].pasafotos;
//				if (cuadro.pasafotos != null) 
//				{
//					cuadro.pasafotos.load();
//				}
				//FIN CÓDIGO ANTERIOR
				
				cuadro.lector_rss = arrayContenido[i].lector_rss;
				
				if ( cuadro.lector_tiempo != null)
				{
					cuadro.dia = cuadro.lector_tiempo.getDia();
					cuadro.cod_ciudad = cuadro.lector_tiempo.getCodigoCiudad();
					cuadro.estilo_tiempo = cuadro.lector_tiempo.getEstilo();
				}
				
				if ( cuadro.control_reloj != null)
				{
					cuadro.color_numeros = cuadro.control_reloj.getColor();
					cuadro.color_fondo = cuadro.control_reloj.getColorFondo();
					cuadro.color_sombra = cuadro.control_reloj.getColorSombra();
					cuadro.fuente = cuadro.control_reloj.getFuente();
					cuadro.alpha_numeros = cuadro.control_reloj.getAlphaNum();
					cuadro.alpha_fondo = cuadro.control_reloj.getAlphaFondo();
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
				
				cuadro.datos_elemento.alpha = arrayContenido[i].transparencia;
				cuadro.setTransparencia(arrayContenido[i].transparencia);
				
				cuadro.load();
				
				//if ((arrayContenido[i].tipo != "texto")&&(arrayContenido[i].tipo != "ticker")&&(arrayContenido[i].tipo != "tiempo")&&(arrayContenido[i].tipo != "pasafotos")&&(arrayContenido[i].tipo != "menu")&&(arrayContenido[i].tipo != "rss")) cuadro.setDimensiones();
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
			trace(" ");
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
		///Función que actualiza las posiciones de los elementos de la multiselección
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
				//trace("CREAMOS UNO NUEVO");
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
		///Función que calcula las dimensaiones del contenedor múltiple
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
		///Recorre la lista de elementos seleccionados, e introduce el contenido de cada elemento en el contenedor multiselección
		///</summary>
		function elemento2SeleccionMultiple(pos:int)
		{
			trace("*************elemento2SeleccionMultiple**************");
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
				//trace("hijos en datos_elemento de un pasafotos!!");
//				for (i=0; i<listaElementosSeleccionados[pos].datos_elemento.numChildren; i++)
//				{
//					trace(listaElementosSeleccionados[pos].datos_elemento.getChildAt(i));
//					trace(listaElementosSeleccionados[pos].datos_elemento.getChildAt(i).name);
//				}
				//listaElementosSeleccionados[pos].pasafotos.getTemporizador().stop();
//				listaElementosSeleccionados[pos].pasafotos.setSentidoTrans("Ninguno");
//				listaElementosSeleccionados[pos].pasafotos.setDireccionTrans("toIzda");
//				listaElementosSeleccionados[pos].pasafotos.resetContenedores();
//				listaElementosSeleccionados[pos].pasafotos.getTemporizador().start();
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
		///Actualiza las posiciones de los elementos de la multiselección
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
				//trace("SOLO QUEDA UN ELEMENTO, DESHACEMOS LA SELECCIÓN MÚLTIPLE");
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
			trace("****************actualizarProfundidades*******************");
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
			trace(" ");
		}
		
		///<summary>
		///Cambia la profundidad del elemento seleccionado según el valor indicado 
		///</summary>
		public function actualizarProfundidades_int(nuevo_valor:int)
		{
			trace("****************actualizarProfundidades*******************");
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
			trace(" ");
			if (elemento_seleccionado != null) panel_propiedades.insertPropGenericas(elemento_seleccionado);
			else if (elemento_seleccionMultiple != null)  panel_propiedades.insertPropGenericas(elemento_seleccionMultiple);
		}
		
		
		///<summary>
		///Guarda el valor de la profundidad de cada elemento
		/// NOTA = cuando cambiamos la profundidad de un elemento, el elemento que estaba en esa profundidad pasa a tener
		///		   la del elemento cambiado, por lo que hay que actualizar sus datos mediante setProfundidad()
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
		public function loadXML(xml:String):int
		{
			trace("[Flex - Flash] loadXML"+xml+".");
			return 1;
		}
		
		public function setResourceLibrary(resourceLibrary:Object):void
		{
			trace("[Flex - Flash] setResourceLibrary.");
			this._resourceLibrary = resourceLibrary as oceEditorProviderInterface;
		}
		
		public function getResourceURLFlash(resource_type:int):Object
		{
			trace("[Flash - Flex] call getResourceURL");
			var resource:Object;
			try
			{
				resource = this._resourceLibrary.getResourceURL(resource_type);
				trace("[Flash - Flex] response getResourceURL ["+resource.id+"]["+resource.name+"]["+resource.url+"]["+resource.type+"]");
			}
			catch (error:Error)
			{
				trace("[ExInter] error aita getResourceURL: ",error.message);
			}
			return resource;
		}
		
		public function saveContentFlash(contenidoXML:String,resources:Array)
		{
			trace("[Flash - Flex] call saveContent");
			try
			{
				this._resourceLibrary.saveContent(contenidoXML, resources);
			}
			catch (error:Error)
			{
				trace("[ExInter] error aita saveContent: ",error.message);
			}
		}
		/****************************************************************************************************************/
	}
	
}
