package cod
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Rectangle;
	
	public class CContenedorSeleccionMultiple extends CElementoBase
	{
		
		private var arrayDatos:Array;
		var centro_x:Number;
		var centro_y:Number;
		var tamaño_previo:Number;
		var x_init:Number;
		var y_init:Number;
		var x0:Number;
		var y0:Number;
		var candado:Boolean;
		var controlador_activo:MovieClip;
		
		var x_anterior:Number;
		var y_anterior:Number;
		
		//Controladores de tamaño
		var x_inicio:Number;
		var y_inicio:Number;
		var boton_pulsado:String;
		
		//Controlar drag&drop
		public var isDragging:Boolean = false;
		
		//*****************************GETTERS/SETTERS************************************/
		public function setArrayDatos(val:Array):void {arrayDatos = val;}
		public function setTamañoPrevio(val:Number):void {tamaño_previo = val;}
		public function setCandado(val:Boolean):void {candado = val;}
		
		public function getArrayDatos():Array {return arrayDatos};
		public function getTamañoPrevio():Number{return tamaño_previo;}
		public function getCandado():Boolean {return candado;}
		/***********************************************************************************/
		
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CContenedorSeleccionMultiple(aita:MovieClip) 
		{
			super(aita);
		}
				
		///<summary>
		///Función que carga el elemento, activando los event Listeners
		///		-> Devuelve una instancia del elemento
		///</summary>
		public function init():MovieClip
		{
			this.x = getXpos();
			this.y = getYpos();
			this.width = getAncho();
			this.height = getAlto();
			candado = false;
			
			ajustarBotonesAContenido();
			activarListeners();
			
			getPadre().elemento_seleccionMultiple = this;
			
			return this;
		}
		
		///<summary>
		///Función que carga el elemento, activando los event Listeners
		///		-> Devuelve 0 si todo es correcto
		///</summary>
		override public function load():int
		{
			this.x = getXpos();
			this.y = getYpos();
			this.width = getAncho();
			this.height = getAlto();
			candado = false;
			
			getPadre().desactivarAnterior();
			ajustarBotonesAContenido();
			activarListeners();
			
			getPadre().elemento_seleccionMultiple = this;
						
			return 0;
		}

		///<summary>
		///Función que coloca los controladores de tamaño (f0-f8) 
		///</summary>
		function ajustarBotonesAContenido()
		{
			centro_x = this.width / 2;
			centro_y = this.height / 2;
			
			//Probando
			f0.x = 0;
			f3.x =  0;
			f6.x =  0;
			f0.y = 0;
			f1.y =  0;
			f2.y =  0;
			
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
			
			actualizarPanelPropiedades();
		}
				
		///<summary>
		///Función que coloca los controladores de tamaño (f0-f8) según el contenedor
		///</summary>
		public function ajustarControladores()
		{
			centro_x = this.contenedor.width / 2;
			centro_y = this.contenedor.height / 2;
			setAncho(Math.round(this.contenedor.width));
			setAlto(Math.round(this.contenedor.height));
			
			f0.x = 0;
			f1.x = centro_x;
			f2.x = getAncho();
			f3.x = 0;
			f3.y = centro_y;
			f4.x = centro_x;
			f4.y = centro_y;
			f5.x = getAncho();
			f5.y = centro_y;
			f6.x = 0;
			f6.y = getAlto();
			f7.x = centro_x;
			f7.y = getAlto();
			f8.x = getAncho();
			f8.y = getAlto();
			
			actualizarPanelPropiedades();
		}
		
		///<summary>
		///Función que actualiza la coordenada en x de los controladores
		///</summary>
		public function ajustarX(xmin:Number,ancho:Number)
		{
			var centro:Number = xmin + ancho/2;
			var xmax:Number = xmin + ancho;
			f0.x = xmin;
			f1.x = centro;
			f2.x = xmax;
			f3.x = xmin;
			f4.x = centro;
			f5.x = xmax;
			f6.x = xmin;
			f7.x = centro;
			f8.x = xmax;
		}
		
		///<summary>
		///Función que actualiza la coordenada en y de los controladores
		///</summary>
		public function ajustarY(ymin:Number,alto:Number)
		{
			var centro:Number = ymin + alto/2;
			var ymax:Number = ymin + alto;
			f0.y = ymin;
			f1.y = ymin;
			f2.y = ymin;
			f3.y = centro;
			f4.y = centro;
			f5.y = centro;
			f6.y = ymax;
			f7.y = ymax;
			f8.y = ymax;
		}
		
		///<summary>
		///Función que activa los event listener de drag&drop y los controladores
		///</summary>
		function activarListeners()
		{
			contenedor.addEventListener(MouseEvent.MOUSE_DOWN,startDragging);
			contenedor.addEventListener(MouseEvent.MOUSE_UP,stopDragging);
											
			this.f5.buttonMode = true;
			this.f5.addEventListener(MouseEvent.MOUSE_DOWN,onF5Down);
			this.f5.addEventListener(MouseEvent.MOUSE_UP,onF5Up);
			
			this.f7.buttonMode = true;
			this.f7.addEventListener(MouseEvent.MOUSE_DOWN,onF7Down);
			this.f7.addEventListener(MouseEvent.MOUSE_UP,onF7Up);
			
			this.f8.buttonMode = true;
			this.f8.addEventListener(MouseEvent.MOUSE_DOWN,onF8Down);
			this.f8.addEventListener(MouseEvent.MOUSE_UP,onF8Up);
		}
		
		///<summary>
		///Función que controla el drag del contenedor multiselección
		///</summary>
		function startDragging(e:MouseEvent)
		{
			isDragging = true;
			getPadre().borrarElementos = true;
			var mousex:Number = mouseX + this.x;
			var mousey:Number = mouseY + this.y;
			x_init = this.x;
			y_init = this.y;
						
			if ((getPadre().getKeyCode() == "16")||(getPadre().getKeyCode() == "17"))  getPadre().borrarUnElemento(mousex,mousey);
			
			var dim_w:Number = getPadre().lienzo.contenedor.width - getAncho();
			var dim_h:Number = getPadre().lienzo.contenedor.height - getAlto();
			this.startDrag(false,new Rectangle(0,0,dim_w,dim_h));
			contenedor.addEventListener(MouseEvent.MOUSE_MOVE,onDrag);
		}

		///<summary>
		///Función que controla el drop del contenedor multiselección
		///		-> Llama a actualizarArrayDatos() para actualizar el cambio de posiciones
		///		   de los elementos
		///</summary>
		function stopDragging(e:MouseEvent)
		{
			contenedor.removeEventListener(MouseEvent.MOUSE_MOVE,onDrag);
			isDragging = false;
			this.stopDrag();
			setXpos(this.x);
			setYpos(this.y);
			getPadre().diferencia_x = getXpos() - x_init;
			getPadre().diferencia_y = getYpos() - y_init;
			getPadre().actualizarArrayDatos();
			actualizarPanelPropiedades();
		}
		
		///<summary>
		///Función que muestra la posición del contenedor en el panel de propiedades
		///durante el drag
		///</summary>
		function onDrag(e:MouseEvent)
		{
			setXpos(this.x);
			setYpos(this.y);
			
			actualizarPanelPropiedades();
		}
		
		///<summary>
		///Función actualiza los valores del panel de propiedades
		///</summary>
		public function actualizarPanelPropiedades()
		{
			getPadre().getPanelPropiedades().t_ancho.text = Math.round(getAncho()).toString();
			getPadre().getPanelPropiedades().t_alto.text = Math.round(getAlto()).toString();
			getPadre().getPanelPropiedades().t_x.text = Math.round(getXpos()).toString();
			getPadre().getPanelPropiedades().t_y.text = Math.round(getYpos()).toString();			
			
			//ALPHA!! SI TODOS LOS HIJOS TIENEN LA MISMA LO MOSTRAMOS, SINO NO!
			var valor_alpha:Number;
			var iguales:Boolean = true;
			var item:MovieClip;
			var i:int = 0;
			
			for (i = 0; i< contenedor.numChildren; i++)
			{
				if (contenedor.getChildAt(i).name != "fondo")
				{
					item = contenedor.getChildAt(i) as MovieClip;
					valor_alpha = item.alpha;
					break;
				}
			}
			for (i = 0; i< contenedor.numChildren; i++)
			{
				if (contenedor.getChildAt(i).name != "fondo")
				{
					item = contenedor.getChildAt(i) as MovieClip;
					if (valor_alpha != item.alpha) iguales = false;
				}
			}
			if (iguales)
			{
				getPadre().getPanelPropiedades().t_transparencia.text = valor_alpha.toString();
			}
			else
			{
				getPadre().getPanelPropiedades().t_transparencia.text ="---";
			}
			var hayReloj : Boolean = false;
			for(var i : int =0;i<getPadre().listaElementosSeleccionados.length;i++)
			{
				if(getPadre().listaElementosSeleccionados[i].getTipo() == "reloj" || getPadre().listaElementosSeleccionados[i].getTipo() == "analog" || getPadre().listaElementosSeleccionados[i].getTipo() == "digital")
				{
					trace("HAY RELOJ");
					hayReloj = true;
				}
			}
			if(hayReloj)
			{
				getPadre().getPanelPropiedades().btnRelacion.selected = true;
				getPadre().getPanelPropiedades().btnRelacion.alpha = 0.5;
				getPadre().getPanelPropiedades().btnRelacion.enabled = false;
			}
			else
			{
				getPadre().getPanelPropiedades().btnRelacion.alpha = 1.0;
				getPadre().getPanelPropiedades().btnRelacion.enabled = true;
			}
		}
		
		///<summary>
		///Función que pone a alpha=0 los controladores cuando el elemento no está activo
		///</summary>
		public function desactivarElemento()
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
		
		///<summary>
		///Función que pone a alpha=1 los controladores cuando el elemento está activo
		///</summary>
		public function activarElemento()
		{
			f0.alpha = 1;
			f1.alpha = 1;
			f2.alpha = 1;
			f3.alpha = 1;
			f4.alpha = 1;
			f5.alpha = 1;
			f6.alpha = 1;
			f7.alpha = 1;
			f8.alpha = 1;
		}
		
		///<summary>
		///Función que elimina del lienzo el contendor multiselección
		///</summary>
		public function eliminar():void
		{
			for (var i:int = 0; i< getPadre().lienzo.contenedor.numChildren; i++)
			{
				if (getPadre().lienzo.contenedor.getChildAt(i) is CContenedorSeleccionMultiple)
				{
					getPadre().lienzo.contenedor.removeChild(getPadre().lienzo.contenedor.getChildAt(i));
				}
			}
			
		}
				
		//****************************************LISTENERS CONTROLADORES******************************************************//
		function onF5Down(e:Event)
		{
			controlador_activo = f5;
			x_inicio = f5.x;
			y_inicio = f5.y;
			x0 = f5.x;
			y0 = f5.y;
			boton_pulsado = "f5";

			getPadre().ancho_anterior = this.contenedor.width;
			getPadre().alto_anterior = this.contenedor.height;
			this.contenedor.visible = false;
			f5.startDrag(false,new Rectangle(x_inicio-contenedor.width,y_inicio,getPadre().lienzo.contenedor.width,0));
			f5.addEventListener(Event.ENTER_FRAME, actualizarMedidas);
			getPadre().lienzo.contenedor.addEventListener(MouseEvent.MOUSE_UP,onF5Up)
		}
		
		function onF5Up(e:Event)
		{
			getPadre().lienzo.contenedor.removeEventListener(MouseEvent.MOUSE_UP,onF5Up)
			f5.stopDrag();
			this.contenedor.visible = true;
			f5.removeEventListener(Event.ENTER_FRAME, actualizarMedidas);
			actualizarMedidasPrueba();
			getPadre().comprobarCambiosEnDimensiones();
		}
		
		function onF7Down(e:Event)
		{
			controlador_activo = f7;
			x_inicio = f7.x;
			y_inicio = f7.y;
			x0 = f7.x;
			y0 = f7.y;
			boton_pulsado = "f7";
			
			getPadre().alto_anterior = this.contenedor.height;
			getPadre().ancho_anterior = this.contenedor.width;

			this.contenedor.visible = false;
			f7.startDrag(false,new Rectangle(x_inicio,y_inicio-contenedor.height,0,getPadre().lienzo.contenedor.height));
			f7.addEventListener(Event.ENTER_FRAME, actualizarMedidas);
			getPadre().lienzo.contenedor.addEventListener(MouseEvent.MOUSE_UP,onF7Up)
		}
		
		function onF7Up(e:Event)
		{
			getPadre().lienzo.contenedor.removeEventListener(MouseEvent.MOUSE_UP,onF7Up)
			f7.stopDrag();
			this.contenedor.visible = true;
			f7.removeEventListener(Event.ENTER_FRAME, actualizarMedidas);
			actualizarMedidasPrueba();
			getPadre().comprobarCambiosEnDimensiones();
		}
		
		function onF8Down(e:Event)
		{
			controlador_activo = f8;
			x_inicio = f8.x;
			y_inicio = f8.y;
			x0 = f8.x;
			y0 = f8.y;
			boton_pulsado = "f8";
			
			getPadre().alto_anterior = this.contenedor.height;
			getPadre().ancho_anterior = this.contenedor.width;
			
			if (candado)
			{
				f8.startDrag(false,new Rectangle(x_inicio-contenedor.width,y_inicio,getPadre().lienzo.contenedor.width,0));
			}
			else
			{
				f8.startDrag(false,new Rectangle(x_inicio-contenedor.width,y_inicio-contenedor.height,getPadre().lienzo.contenedor.width,getPadre().lienzo.contenedor.height));
			}
			this.contenedor.visible = false;
			f8.addEventListener(Event.ENTER_FRAME, actualizarMedidas);
			getPadre().lienzo.contenedor.addEventListener(MouseEvent.MOUSE_UP,onF8Up)
		}

		function onF8Up(e:Event)
		{
			getPadre().lienzo.contenedor.removeEventListener(MouseEvent.MOUSE_UP,onF8Up)
			f8.stopDrag();
			this.contenedor.visible = true;
			f8.removeEventListener(Event.ENTER_FRAME, actualizarMedidas);
			getPadre().cambioAlto = true;
			getPadre().cambioAncho = true;
			actualizarMedidasPrueba();
			getPadre().comprobarCambiosEnDimensiones();
		}
		
		///<summary>
		///	Actualiza las medidas del elemento tras haber pulsado los controladores
		/// de tamaño (f0 - f8)
		///</summary>
		function actualizarMedidas(e:Event)
		{
			var diferencia_ancho:Number = e.currentTarget.x - x0;
			var diferencia_alto:Number = e.currentTarget.y - y0;
			
			var ratio_ancho = e.currentTarget.x/getPadre().ancho_anterior;
			var ratio_alto = e.currentTarget.y/getPadre().alto_anterior;
						
			var alto_proporcional:Number;
			var ancho_proporcional:Number;
			
			ancho_proporcional = x0 * ratio_alto;
			alto_proporcional = y0 * ratio_ancho;
			
			trace("x0 = "+x0);
			trace("y0 = "+y0);
			trace("diferencia_ancho = "+diferencia_ancho);
			trace("diferencia_alto = "+diferencia_alto);
			trace("ratio_ancho = "+ratio_ancho);
			trace("ratio_alto = "+ratio_alto);
			trace("ancho_proporcional = "+ancho_proporcional);
			trace("alto_proporcional = "+alto_proporcional);
			var parar : Boolean = false;
			if (candado)
			{
				switch (e.currentTarget.name)
				{
					case "f5" :
						alto_proporcional = y0 * ratio_ancho * 2;
						//limitar el alto máximo al alto del lienzo
						if(alto_proporcional > getPadre().alL)
						{
							alto_proporcional = getPadre().alL;
							f2.x = x_inicio;
							f8.x = x_inicio;
							f5.x = x_inicio;
						}
						else
						{
							f2.x = e.currentTarget.x;
							f8.x = e.currentTarget.x;
						}
						f6.y = alto_proporcional;
						f7.y = alto_proporcional;
						f8.y = alto_proporcional;
						f5.y = alto_proporcional;
						break;
					case "f7" :
						
						ancho_proporcional = x0 * ratio_alto * 2;
						//limitar el ancho máximo al ancho del lienzo
						if(ancho_proporcional > getPadre().anL)
						{
							ancho_proporcional = getPadre().anL;
							f6.y = y_inicio;
							f8.y = y_inicio;
							f7.y = y_inicio;
						}
						else
						{
							f6.y = e.currentTarget.y;
							f8.y = e.currentTarget.y;
						}
						f2.x = ancho_proporcional;
						f5.x = ancho_proporcional;
						f8.x = ancho_proporcional;
						f7.x = ancho_proporcional/2;
						break;
					case "f8" :
						//limitar el alto máximo al alto del lienzo
						if(alto_proporcional > getPadre().alL)
						{
							alto_proporcional = getPadre().alL;
							f2.x = x_inicio;
							f5.x = x_inicio;
							f8.x = x_inicio;
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
				x_inicio = e.currentTarget.x;
				y_inicio = e.currentTarget.y;
				getPadre().cambioAncho = true;
				getPadre().cambioAlto = true;
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
						x_inicio = e.currentTarget.x;
						getPadre().cambioAncho = true;
						break;
					case "f7" :
						f6.y = e.currentTarget.y;
						f8.y = e.currentTarget.y;
						f3.y = (f7.y - f0.y)/2;
						f4.y = f3.y;
						f5.y = f3.y;
						y_inicio = e.currentTarget.y;
						getPadre().cambioAlto = true;
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
						x_inicio = e.currentTarget.x;
						y_inicio = e.currentTarget.y;
						getPadre().cambioAncho = true;
						getPadre().cambioAlto = true;
						break;
					default :
						break;
				}
			}
			getPadre().getPanelPropiedades().mostrarEnPanelPropiedades(Math.round(f8.x),Math.round(f8.y));
		}
		
		///<summary>
		///	Actualiza las medidas del elemento tras haber pulsado los controladores
		/// de tamaño (f0 - f8)
		///</summary>
		function actualizarMedidasPrueba()
		{
			
			var diferencia_ancho:Number = f8.x - x0;
			var diferencia_alto:Number = f8.y - y0;
			var ratio_ancho = f8.x/getPadre().ancho_anterior;
			var ratio_alto = f8.y/getPadre().alto_anterior;
			var alto_proporcional:Number;
			var ancho_proporcional:Number;
			if (candado)
			{
				switch (controlador_activo.name)
				{
					case "f7" :
						ancho_proporcional = getPadre().ancho_anterior * ratio_alto;
						contenedor.width =  ancho_proporcional;
						contenedor.height +=  diferencia_alto;
						y_init = controlador_activo.y;
						break;
					default :
						alto_proporcional = getPadre().alto_anterior * ratio_ancho;
						contenedor.height =  alto_proporcional;
						contenedor.width +=  diferencia_ancho;
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
						contenedor.width +=  diferencia_ancho;
						x_init = controlador_activo.x;
						break;
					case "f7" :
						contenedor.height +=  diferencia_alto;
						y_init = controlador_activo.y;
						break;
					case "f8" :
						contenedor.height +=  diferencia_alto;
						contenedor.width +=  diferencia_ancho;
						x_init = controlador_activo.x;
						y_init = controlador_activo.y;
						break;
					default :
						break;
				}
			}

			//ajustarControladores();
			actualizarPanelPropiedades();
		}
		//**********************************************************************************************************************//
	}
	
}
