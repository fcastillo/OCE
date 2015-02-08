package cod
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.media.Video;
	
	public class CAlinear extends CElementoBase
	{		
		var enEscenario:Boolean = false;
		
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CAlinear(aita:MovieClip) 
		{
			super(aita);
		}
		
		///<summary>
		///Inicializa el panel de propiedades y activa los event listeners
		///</summary>
		override public function load():int
		{
			this.x = this.getXpos();
			this.y = this.getYpos();
			
			btnAlignLeft.buttonMode = true;
			btnAlignRight.buttonMode = true;
			btnAlignTop.buttonMode = true;
			btnAlignBottom.buttonMode = true;
			btnAlignHorizontalCenter.buttonMode = true;
			btnAlignVerticalCenter.buttonMode = true;
			
			btnAlignLeft.addEventListener(MouseEvent.MOUSE_DOWN,onBotonAlinearDown);			
			btnAlignRight.addEventListener(MouseEvent.MOUSE_DOWN,onBotonAlinearDown);
			btnAlignTop.addEventListener(MouseEvent.MOUSE_DOWN,onBotonAlinearDown);
			btnAlignBottom.addEventListener(MouseEvent.MOUSE_DOWN,onBotonAlinearDown);
			btnAlignHorizontalCenter.addEventListener(MouseEvent.MOUSE_DOWN,onBotonAlinearDown);
			btnAlignVerticalCenter.addEventListener(MouseEvent.MOUSE_DOWN,onBotonAlinearDown);
			
			btnAlignLeft.addEventListener(MouseEvent.MOUSE_UP,onBotonUp);			
			btnAlignRight.addEventListener(MouseEvent.MOUSE_UP,onBotonUp);
			btnAlignTop.addEventListener(MouseEvent.MOUSE_UP,onBotonUp);
			btnAlignBottom.addEventListener(MouseEvent.MOUSE_UP,onBotonUp);
			btnAlignHorizontalCenter.addEventListener(MouseEvent.MOUSE_UP,onBotonUp);
			btnAlignVerticalCenter.addEventListener(MouseEvent.MOUSE_UP,onBotonUp);
			
			return 0;
		}
		
		///<summary>
		///Inicializa la posición de los botones
		///</summary>
		public function init()
		{
			btnAlignRight.gotoAndStop(1);
			btnAlignLeft.gotoAndStop(1);
			btnAlignTop.gotoAndStop(1);
			btnAlignBottom.gotoAndStop(1);
			btnAlignHorizontalCenter.gotoAndStop(1);
			btnAlignVerticalCenter.gotoAndStop(1);
			enEscenario = true;
		}
		
		///<summary>
		///Controla la alineación/distribución en el escenario
		///</summary>
		public function onBotonEscenario (e:MouseEvent)
		{
			enEscenario = true;
		}
		
		///<summary>
		///Envía el botón al frame 1
		///</summary>
		private function onBotonUp (e:MouseEvent)
		{
			e.currentTarget.gotoAndStop(1);
		}
		
		/**************************************************DISTRIBUIR***********************************************/
		
		///<summary>
		///Distribuye los elementos verticalmente
		///</summary>
		/*private function onBotonDistribuirVertical(e:MouseEvent)
		{
			e.currentTarget.gotoAndStop(2);
			var i:int = 0;
			var j:int = 0;
			var item:MovieClip;
						
			var eje_min:Number;
			var eje_max:Number = 0;
			var centro:Number = 0;
			var margen:Number = 0;
			var nuevo_eje:Number;
			var alto_elem:Number;
			var array_intermedios:Array = new Array();
			var kk:Object;
			getPadre().diferencia_x = 0;
			getPadre().diferencia_y = 0;
			
			//DE MOMENTO
			enEscenario = false;
			
			if ((getPadre().elemento_seleccionMultiple != null) && (getPadre().elemento_seleccionMultiple.height <= 530))
			{
				eje_min = getPadre().elemento_seleccionMultiple.height;
				
				//CALCULAMOS EJE_MIN Y EJE_MAX
				for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
				{
					item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
					if ((item.name == "datos_elemento") || (item.name == "fondo"))
					{
						centro = item.y + item.height/2;
						if (centro < eje_min) eje_min = Math.round(centro);
						if (centro > eje_max) 
						{
							eje_max = centro;
							alto_elem = item.height;
						}
					}
				}
				
				//if (enEscenario) //DISTRIBUIMOS EN ESCENA
				if (false) //DISTRIBUIR SIEMPRE ES ENTRE ELEMENTOS Y NO CON EL STAGE ...
				{
					eje_max = Math.round(getPadre().lienzo.contenedor.area_editable.height - alto_elem/2) -4;
									
					//EL MARGEN ENTRE EJES CENTRALES:
					margen = (534 - alto_elem/2 - eje_min)/(getPadre().elemento_seleccionMultiple.contenedor.numChildren-1)+1;
									
					//CREAMOS EL ARRAY DE LOS ELEMENTOS INTERMEDIOS
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						kk = new Object();
						kk.ypos = item.y;
						kk.alto = item.height;
						kk.xpos = item.x;
						array_intermedios.push(kk);
					}
					
					//ORDENAMOS EL ARRAY
					var ordenY:Boolean = false;
					for (i=0; i< array_intermedios.length; i++)
					{
						if (array_intermedios[i].ypos != 0) ordenY = true;
					}
					if (ordenY) array_intermedios.sortOn("ypos",Array.NUMERIC);
					else array_intermedios.sortOn("alto",Array.NUMERIC);
																		
					//DISTRIBUIMOS LOS ELEMENTOS SEGÚN SU ORDEN
					for (i = 0; i< array_intermedios.length; i++)
					{
						nuevo_eje = eje_min + margen*(i);
						for (j = 0; j< getPadre().elemento_seleccionMultiple.contenedor.numChildren; j++)
						{
							item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(j) as MovieClip;
							
							if (ordenY)
							{
								if (item.y == array_intermedios[i].ypos) 
								{
									item.y = nuevo_eje - item.height/2;
									break;
								}
							}
							else
							{
								if ((item.height == array_intermedios[i].alto) && (item.x == array_intermedios[i].xpos))
								{
									item.y = nuevo_eje - item.height/2;
									break;
								}
							}							
						}
					}
					
					getPadre().diferencia_y = -getPadre().elemento_seleccionMultiple.y;
					getPadre().elemento_seleccionMultiple.y = 0;
					getPadre().elemento_seleccionMultiple.setYpos(0);
					getPadre().elemento_seleccionMultiple.height = 534;
					getPadre().actualizarArrayDatos();
					
					getPadre().elemento_seleccionMultiple.ajustarControladores();
					distribuir("vertical",Math.round(eje_min),Math.round(534 - alto_elem/2),Math.round(margen-2),true,!ordenY);
				}
				else //DISTRIBUIMOS LOS ELEMENTOS DENTRO DEL CONTENEDOR MÚLTIPLE
				{
					//EL MARGEN ENTRE EJES CENTRALES:
					margen = (eje_max - eje_min)/(getPadre().elemento_seleccionMultiple.contenedor.numChildren-1);
										
					//CREAMOS EL ARRAY DE LOS ELEMENTOS INTERMEDIOS
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						centro = item.y + item.height/2;
						if ((centro > eje_min)&&(centro < eje_max)) 
						{
							kk = new Object();
							kk.ypos = item.y;
							array_intermedios.push(kk);
						}
					}
					
					//ORDENAMOS EL ARRAY
					array_intermedios.sortOn("ypos",Array.NUMERIC);
					
					//DISTRIBUIMOS LOS ELEMENTOS SEGÚN SU ORDEN
					for (i = 0; i< array_intermedios.length; i++)
					{
						nuevo_eje = eje_min + margen*(i+1);
						for (j = 0; j< getPadre().elemento_seleccionMultiple.contenedor.numChildren; j++)
						{
							item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(j) as MovieClip;
							if (item.y == array_intermedios[i].ypos) 
							{
								item.y = nuevo_eje - item.height/2;
								break;
							}
						}
					}
					distribuir("vertical",Math.round(eje_min),Math.round(eje_max),Math.round(margen),false,false);
				}
			}
			else if (getPadre().elemento_seleccionado != null)
			{
				if (enEscenario)
				{
					var pos:Number = Math.round(getPadre().lienzo.contenedor.area_editable.height/2 - getPadre().elemento_seleccionado.datos_elemento.height/2);
					getPadre().elemento_seleccionado.y = pos;
						
					getPadre().getPanelPropiedades().insertPropGenericas(getPadre().elemento_seleccionado);
					getPadre().elemento_seleccionado.setYpos(getPadre().elemento_seleccionado.y);
				}
			}
		}*/
		private function onBotonDistribuirVertical(e:MouseEvent)
		{
			//trace("[CAlinear] - onBotonDistribuirVertical()");
			e.currentTarget.gotoAndStop(2);
			var i:int = 0;
			var j:int = 0;
			var item:MovieClip;
						
			var eje_min:Number;
			var eje_max:Number = 0;
			var centro:Number = 0;
			var margen:Number = 0;
			var nuevo_eje:Number;
			var alto_elem:Number;
			var array_intermedios:Array = new Array();
			var kk:Object;
			getPadre().diferencia_x = 0;
			getPadre().diferencia_y = 0;
			
			//DE MOMENTO
			//enEscenario = false;
			
			//if ((getPadre().elemento_seleccionMultiple != null) && (getPadre().elemento_seleccionMultiple.height <= 530))
			if (getPadre().elemento_seleccionMultiple != null)
			{
				eje_min = getPadre().elemento_seleccionMultiple.height;
				
				//CALCULAMOS EJE_MIN Y EJE_MAX
				for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
				{
					item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
					if ((item.name == "datos_elemento") || (item.name == "fondo"))
					{
						centro = item.y + item.height/2;
						if (centro < eje_min) eje_min = Math.round(centro);
						if (centro > eje_max) 
						{
							eje_max = centro;
							alto_elem = item.height;
						}
					}
				}
				
				//if (enEscenario) //DISTRIBUIMOS EN ESCENA
				//if (enEscenario) //DISTRIBUIMOS EN ESCENA
				if (false) //DISTRIBUIR ES SIEMPRE ENTRE ELEMENTOS NO CON EL STAGE ...
				{
				}
				else
				{
					//EL MARGEN ENTRE EJES CENTRALES:
					margen = (eje_max - eje_min)/(getPadre().elemento_seleccionMultiple.contenedor.numChildren-1);
					//trace("[CAlinear] - onBotonDistribuirVertical() -> num elementos = "+getPadre().elemento_seleccionMultiple.contenedor.numChildren+", entre elementos = "+margen+" px");
					//CREAMOS EL ARRAY DE LOS ELEMENTOS INTERMEDIOS
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						
						kk = new Object();
						kk.ypos = item.y;
						kk.objeto = item;
						array_intermedios.push(kk);
					}
					
					//ORDENAMOS EL ARRAY
					array_intermedios.sortOn("ypos",Array.NUMERIC);
					//trace("[CAlinear] - onBotonDistribuirHorizontal() -> elementos intermedios="+array_intermedios.length+" 1("+array_intermedios[0].objeto.x+","+array_intermedios[0].objeto.y+") ult("+array_intermedios[array_intermedios.length-1].objeto.x+","+array_intermedios[array_intermedios.length-1].objeto.y+")");
					eje_min = array_intermedios[0].objeto.y;
					margen = ((array_intermedios[array_intermedios.length-1].objeto.y) - array_intermedios[0].objeto.y)/(array_intermedios.length-1);
					
					//DISTRIBUIMOS LOS ELEMENTOS SEGÚN SU ORDEN
					for (i = 1; i< array_intermedios.length-1; i++)
					{
						nuevo_eje = eje_min + margen*(i);
						array_intermedios[i].objeto.y = nuevo_eje;
					}
					distribuir("vertical",Math.round(eje_min),Math.round(eje_max),Math.round(margen),false,false);
				}
			}
			else if (getPadre().elemento_seleccionado != null)
			{
				if (enEscenario)
				{
					var pos:Number = Math.round(getPadre().lienzo.contenedor.area_editable.height/2 - getPadre().elemento_seleccionado.datos_elemento.height/2);
					getPadre().elemento_seleccionado.y = pos;
						
					getPadre().getPanelPropiedades().insertPropGenericas(getPadre().elemento_seleccionado);
					getPadre().elemento_seleccionado.setYpos(getPadre().elemento_seleccionado.y);
				}
			}
			trace("enEscenario = "+enEscenario);
			
		}
		///<summary>
		///Distribuye los elementos horizontalmente
		///</summary>
		/*private function onBotonDistribuirHorizontal (e:MouseEvent)
		{
			e.currentTarget.gotoAndStop(2);
			var i:int = 0;
			var j:int = 0;
			var item:MovieClip;
						
			var eje_min:Number = 0;
			var eje_max:Number = 0;
			var centro:Number = 0;
			var margen:Number = 0;
			var nuevo_eje:Number;
			var ancho_elem:Number;
			var array_intermedios:Array = new Array();
			var kk:Object;
			getPadre().diferencia_x = 0;
			getPadre().diferencia_y = 0;
			
			//DE MOMENTO
			enEscenario = false;
			
			if ((getPadre().elemento_seleccionMultiple != null) && (getPadre().elemento_seleccionMultiple.width <= 775))
			{
				//ENTRAMOS A DISTRIBUIR
				eje_min = getPadre().elemento_seleccionMultiple.width;
				
				//CALCULAMOS EJE_MIN Y EJE_MAX
				for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
				{
					item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
					if ((item.name == "datos_elemento") || (item.name == "fondo"))
					{
						centro = item.x + item.width/2;
						if (centro < eje_min) eje_min = Math.round(centro);
						if (centro > eje_max) 
						{
							eje_max = Math.round(centro);
							ancho_elem = item.width;
						}
					}
				}
				
				trace("[CAlinear] - onBotonDistribuirHorizontal() -> x min="+eje_min+", x max="+eje_max);
				
				//if (enEscenario) //DISTRIBUIMOS EN ESCENA
				if (false) //DISTRIBUIR ES SIEMPRE ENTRE ELEMENTOS NO CON EL STAGE ...
				{
					eje_max = Math.round(getPadre().lienzo.contenedor.area_editable.width - ancho_elem/2)-8;
										
					//EL MARGEN ENTRE EJES CENTRALES:
					margen = (764 - ancho_elem/2 - eje_min)/(getPadre().elemento_seleccionMultiple.contenedor.numChildren-1);
									
					//CREAMOS EL ARRAY DE LOS ELEMENTOS INTERMEDIOS
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						kk = new Object();
						kk.ancho = item.width;
						kk.alto = item.height;
						kk.ypos = item.y;
						kk.xpos = item.x;
						array_intermedios.push(kk);
					}
					
					//ORDENAMOS EL ARRAY
					var ordenX:Boolean = false;
					for (i=0; i< array_intermedios.length; i++)
					{
						if (array_intermedios[i].xpos != 0) ordenX = true;
					}
					if (ordenX) array_intermedios.sortOn("xpos",Array.NUMERIC);
					else array_intermedios.sortOn("ancho",Array.NUMERIC);
										
					//DISTRIBUIMOS LOS ELEMENTOS SEGÚN SU ORDEN
					for (i = 0; i< array_intermedios.length; i++)
					{
						nuevo_eje = eje_min + margen*(i);
						for (j = 0; j< getPadre().elemento_seleccionMultiple.contenedor.numChildren; j++)
						{
							item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(j) as MovieClip;
							if (ordenX)
							{
								if (item.x == array_intermedios[i].xpos)
								{
									item.x = nuevo_eje - item.width/2;
									break;
								}
							}
							else
							{
								if ((item.width == array_intermedios[i].ancho) && (item.y == array_intermedios[i].ypos))
								{
									item.x = nuevo_eje - item.width/2;
									break;
								}
							}
						}
					}
					
					getPadre().diferencia_x = -getPadre().elemento_seleccionMultiple.x;
					getPadre().elemento_seleccionMultiple.x = 0;
					getPadre().elemento_seleccionMultiple.setXpos(0);
					getPadre().elemento_seleccionMultiple.width = 764;
					
					getPadre().actualizarArrayDatos();
					
					getPadre().elemento_seleccionMultiple.ajustarControladores();
					distribuir("horizontal",Math.round(eje_min),Math.round(764-ancho_elem/2),Math.round(margen-2),true,!ordenX);
					getPadre().diferencia_x = 0;
				}
				else
				{
					//EL MARGEN ENTRE EJES CENTRALES:
					margen = (eje_max - eje_min)/(getPadre().elemento_seleccionMultiple.contenedor.numChildren-1);
					trace("[CAlinear] - onBotonDistribuirHorizontal() -> num elementos = "+getPadre().elemento_seleccionMultiple.contenedor.numChildren+", entre elementos = "+margen+" px");
					//CREAMOS EL ARRAY DE LOS ELEMENTOS INTERMEDIOS
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						centro = item.x + item.width/2;
						if ((centro > eje_min)&&(centro < eje_max)) 
						{
							kk = new Object();
							kk.xpos = item.x;
							array_intermedios.push(kk);
						}
					}
					
					//ORDENAMOS EL ARRAY
					array_intermedios.sortOn("xpos",Array.NUMERIC);
					trace("[CAlinear] - onBotonDistribuirHorizontal() -> elementos intermedios="+array_intermedios.length);
					//DISTRIBUIMOS LOS ELEMENTOS SEGÚN SU ORDEN
					for (i = 0; i< array_intermedios.length; i++)
					{
						nuevo_eje = eje_min + margen*(i+1);
						for (j = 0; j< getPadre().elemento_seleccionMultiple.contenedor.numChildren; j++)
						{
							item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(j) as MovieClip;
							if (item.x == array_intermedios[i].xpos) 
							{
								item.x = nuevo_eje - item.width/2;
								break;
							}
						}
					}
				
					distribuir("horizontal",Math.round(eje_min),Math.round(eje_max),Math.round(margen),false,false);
				}
			}
			else if (getPadre().elemento_seleccionado != null)
			{
				if (enEscenario)
				{
					var pos:Number = Math.round(getPadre().lienzo.contenedor.area_editable.width/2 - getPadre().elemento_seleccionado.datos_elemento.width/2);
					getPadre().elemento_seleccionado.x = pos;
					
					getPadre().getPanelPropiedades().insertPropGenericas(getPadre().elemento_seleccionado);
					getPadre().elemento_seleccionado.setXpos(getPadre().elemento_seleccionado.x);
				}
			}
		}*/
		
		private function onBotonDistribuirHorizontal (e:MouseEvent)
		{
			e.currentTarget.gotoAndStop(2);
			var i:int = 0;
			var j:int = 0;
			var item:MovieClip;
						
			var eje_min:Number = 0;
			var eje_max:Number = 0;
			var centro:Number = 0;
			var margen:Number = 0;
			var nuevo_eje:Number;
			var ancho_elem:Number;
			var array_intermedios:Array = new Array();
			var kk:Object;
			getPadre().diferencia_x = 0;
			getPadre().diferencia_y = 0;
			
			//DE MOMENTO
			//enEscenario = false;
			
			if ((getPadre().elemento_seleccionMultiple != null) && (getPadre().elemento_seleccionMultiple.width <= 775))
			{
				//ENTRAMOS A DISTRIBUIR
				eje_min = getPadre().elemento_seleccionMultiple.width;
				
				//CALCULAMOS EJE_MIN Y EJE_MAX
				for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
				{
					item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
					if ((item.name == "datos_elemento") || (item.name == "fondo"))
					{
						centro = item.x + item.width/2;
						if (centro < eje_min) eje_min = Math.round(centro);
						if (centro > eje_max) 
						{
							eje_max = Math.round(centro);
							ancho_elem = item.width;
						}
					}
				}
				
				//trace("[CAlinear] - onBotonDistribuirHorizontal() -> x min="+eje_min+", x max="+eje_max);
				
				//if (enEscenario) //DISTRIBUIMOS EN ESCENA
				if (false) //DISTRIBUIR ES SIEMPRE ENTRE ELEMENTOS NO CON EL STAGE ...
				{
				}
				else
				{
					//EL MARGEN ENTRE EJES CENTRALES:
					margen = (eje_max - eje_min)/(getPadre().elemento_seleccionMultiple.contenedor.numChildren-1);
					//trace("[CAlinear] - onBotonDistribuirHorizontal() -> num elementos = "+getPadre().elemento_seleccionMultiple.contenedor.numChildren+", entre elementos = "+margen+" px");
					//CREAMOS EL ARRAY DE LOS ELEMENTOS INTERMEDIOS
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						trace("-----  "+i);
						kk = new Object();
						kk.xpos = item.x;
						kk.objeto = item;
						array_intermedios.push(kk);
					}
					
					//ORDENAMOS EL ARRAY
					array_intermedios.sortOn("xpos",Array.NUMERIC);
					//trace("[CAlinear] - onBotonDistribuirHorizontal() -> elementos intermedios="+array_intermedios.length+" 1("+array_intermedios[0].objeto.x+","+array_intermedios[0].objeto.y+") ult("+array_intermedios[array_intermedios.length-1].objeto.x+","+array_intermedios[array_intermedios.length-1].objeto.y+")");
					eje_min = array_intermedios[0].objeto.x;
					margen = ((array_intermedios[array_intermedios.length-1].objeto.x) - array_intermedios[0].objeto.x)/(array_intermedios.length-1);
					
					//DISTRIBUIMOS LOS ELEMENTOS SEGÚN SU ORDEN
					for (i = 1; i< array_intermedios.length-1; i++)
					{
						nuevo_eje = eje_min + margen*(i);
						array_intermedios[i].objeto.x = nuevo_eje;
						/*for (j = 0; j< getPadre().elemento_seleccionMultiple.contenedor.numChildren; j++)
						{
							item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(j) as MovieClip;
							if (item.x == array_intermedios[i].xpos) 
							{
								item.x = nuevo_eje - item.width/2;
								break;
							}
						}*/
					}
					
					distribuir("horizontal",Math.round(eje_min),Math.round(eje_max),Math.round(margen),false,false);
				}
			}
			else if (getPadre().elemento_seleccionado != null)
			{
				if (enEscenario)
				{
					var pos:Number = Math.round(getPadre().lienzo.contenedor.area_editable.width/2 - getPadre().elemento_seleccionado.datos_elemento.width/2);
					getPadre().elemento_seleccionado.x = pos;
					
					getPadre().getPanelPropiedades().insertPropGenericas(getPadre().elemento_seleccionado);
					getPadre().elemento_seleccionado.setXpos(getPadre().elemento_seleccionado.x);
				}
			}
			//enEscenario = true;
		}
		
		///<summary>
		///Actualiza los elementos en el padre
		///</summary>
		public function distribuir(sentido:String,eje_min:Number,eje_max:Number,margen:Number,enEscenario:Boolean,dimension:Boolean)
		{
			var i:int = 0;
			var j:int = 0;
			var centro:Number = 0;
			var offset_x:Number = getPadre().elemento_seleccionMultiple.x;
			var offset_y:Number = getPadre().elemento_seleccionMultiple.y;
			var nuevo_eje:Number = 0;
			var array_intermedios:Array = new Array();
			var kk:Object = new Object();
			var aux:Object;
			
			var arrayDatos:Array = getPadre().arrayDatos;
			
			//DE MOMENTO!!
			enEscenario = false;
			
			if (sentido == "horizontal")
			{
				if (enEscenario)
				{
					//CREAMOS EL ARRAY DE OBJETOS INTERMEDIOS
					for (i = 0; i< arrayDatos.length; i++)
					{
						kk = new Object();
						kk.xpos = arrayDatos[i].xpos;
						kk.ancho = arrayDatos[i].ancho;
						kk.ypos = arrayDatos[i].ypos;
						kk.alto = arrayDatos[i].alto;
						array_intermedios.push(kk);
					}
					if (dimension)
					{
						array_intermedios.sortOn("ancho",Array.NUMERIC); 
						for (i = 0; i< array_intermedios.length-1; i++)
						{
							for (j = 1; j< array_intermedios.length; j++)
							{
								if (array_intermedios[j].ancho == array_intermedios[i].ancho)
								{
									if (array_intermedios[j].ypos < array_intermedios[i].ypos)
									{
										aux = array_intermedios[j];
										array_intermedios[j] = array_intermedios[i];
										array_intermedios[i] = aux;
									}
								}
							}
						}
					}
					else array_intermedios.sortOn("xpos",Array.NUMERIC); //ORDENAMOS EL ARRAY
					
					//ACTUALIZAMOS LAS POSICIONES EN arrayDatos
					for (i = 0; i< array_intermedios.length; i++)
					{
						nuevo_eje = eje_min + margen*(i);
						for (j = 0; j< arrayDatos.length; j++)
						{
							if (dimension)
							{
								if ((arrayDatos[j].ancho == array_intermedios[i].ancho) && (arrayDatos[j].ypos == array_intermedios[i].ypos))
								{
									arrayDatos[j].xpos = nuevo_eje - arrayDatos[j].ancho/2;
									break;
								}
							}
							else
							{
								if (arrayDatos[j].xpos == array_intermedios[i].xpos) 
								{
									arrayDatos[j].xpos = nuevo_eje - arrayDatos[j].ancho/2;
									break;
								}
							}
						}
					}
				}
				else
				{
					//CREAMOS EL ARRAY DE OBJETOS INTERMEDIOS
					for (i = 0; i< arrayDatos.length; i++)
					{
						centro = Math.round(arrayDatos[i].xpos + arrayDatos[i].ancho/2 - offset_x);
						if ((centro > eje_min)&&(centro < eje_max)) 
						{
							kk = new Object();
							kk.xpos = arrayDatos[i].xpos;
							array_intermedios.push(kk);
						}
					}
					array_intermedios.sortOn("xpos",Array.NUMERIC); //ORDENAMOS EL ARRAY
					
					//ACTUALIZAMOS LAS POSICIONES EN arrayDatos
					for (i = 0; i< array_intermedios.length; i++)
					{
						nuevo_eje = eje_min + margen*(i+1) + offset_x;
						for (j = 0; j< arrayDatos.length; j++)
						{
							if (arrayDatos[j].xpos == array_intermedios[i].xpos) 
							{
								arrayDatos[j].xpos = nuevo_eje - arrayDatos[j].ancho/2;
								break;
							}
						}
					}
				}
			}
			else if (sentido == "vertical")
			{	
				if (enEscenario)
				{
					//CREAMOS EL ARRAY DE OBJETOS INTERMEDIOS
					for (i = 0; i< arrayDatos.length; i++)
					{
						kk = new Object();
						kk.ypos = arrayDatos[i].ypos;
						kk.xpos = arrayDatos[i].xpos;
						kk.alto = arrayDatos[i].alto;
						kk.ancho = arrayDatos[i].ancho;
						array_intermedios.push(kk);
					}
					if (dimension) 
					{
						array_intermedios.sortOn("alto",Array.NUMERIC);
						for (i = 0; i< array_intermedios.length-1; i++)
						{
							for (j = 1; j< array_intermedios.length; j++)
							{
								if (array_intermedios[j].alto == array_intermedios[i].alto)
								{
									if (array_intermedios[j].xpos < array_intermedios[i].xpos)
									{
										aux = array_intermedios[j];
										array_intermedios[j] = array_intermedios[i];
										array_intermedios[i] = aux;
									}
								}
							}
						}
					}
					else array_intermedios.sortOn("ypos",Array.NUMERIC); //ORDENAMOS EL ARRAY
										
					//ACTUALIZAMOS LAS POSICIONES EN arrayDatos
					for (i = 0; i< array_intermedios.length; i++)
					{
						nuevo_eje = eje_min + margen*(i);
						for (j = 0; j< arrayDatos.length; j++)
						{
							if (dimension)
							{
								if ((arrayDatos[j].alto == array_intermedios[i].alto)  && (arrayDatos[j].xpos == array_intermedios[i].xpos))
								{
									arrayDatos[j].ypos = nuevo_eje - arrayDatos[j].alto/2;
									break;
								}
							}
							else
							{
								if (arrayDatos[j].ypos == array_intermedios[i].ypos) 
								{
									arrayDatos[j].ypos = nuevo_eje - arrayDatos[j].alto/2;
									break;
								}
							}
						}
					}
				}
				else
				{
					//CREAMOS EL ARRAY DE OBJETOS INTERMEDIOS
					for (i = 0; i< arrayDatos.length; i++)
					{
						centro = Math.round(arrayDatos[i].ypos + arrayDatos[i].alto/2 - offset_y);
						if ((centro > eje_min)&&(centro < eje_max)) 
						{
							kk = new Object();
							kk.ypos = arrayDatos[i].ypos;
							array_intermedios.push(kk);
						}
					}
					array_intermedios.sortOn("ypos",Array.NUMERIC); //ORDENAMOS EL ARRAY
					//ACTUALIZAMOS LAS POSICIONES EN arrayDatos
					for (i = 0; i< array_intermedios.length; i++)
					{
						nuevo_eje = eje_min + margen*(i+1) + offset_y;
						for (j = 0; j< arrayDatos.length; j++)
						{
							if (arrayDatos[j].ypos == array_intermedios[i].ypos) 
							{
								arrayDatos[j].ypos = nuevo_eje - arrayDatos[j].alto/2;
								break;
							}
						}
					}
				}
			}
			getPadre().arrayDatos = arrayDatos;
		}
		
		
		/**************************************************************************************************************/
		
		/******************************************************ALINEAR***************************************************/
		/*private function onBotonAlinearDown (e:MouseEvent)
		{
			e.currentTarget.gotoAndStop(2);
			
			var i:int = 0;
			var item:MovieClip;
			var xnueva:Number = 0;
			var ynueva:Number = 0;
			var ancho_max:Number = 0;
			var alto_max:Number = 0;
			var centro:Number = 0;
			
			if (e.currentTarget.name == "btnAlignLeft")
			{
				for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
				{
					item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
					if (item.name == "datos_elemento") 
					{
						if (item.width > ancho_max) ancho_max = item.width;
						item.x = 0;
					}
				}
				getPadre().Align("left",0,ancho_max);
			}
			else if (e.currentTarget.name == "btnAlignRight")
			{
				xnueva = 0;
				for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
				{
					item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
					if (item.name == "datos_elemento")
					{
						if ((item.x + item.width) > xnueva) xnueva = (item.x + item.width);
					}
				}
				for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
				{
					item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
					if (item.name == "datos_elemento")
					{
						if (item.width > ancho_max) ancho_max = item.width;
						item.x = xnueva - item.width;
					}
				}
				getPadre().Align("right",xnueva,ancho_max);
			}
			else if (e.currentTarget.name == "btnAlignTop")
			{
				for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
				{
					item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
					if (item.name == "datos_elemento") 
					{
						if (item.height > alto_max) alto_max = item.height;
						item.y = 0;
					}
				}
				getPadre().Align("top",0,alto_max);
			}
			else if (e.currentTarget.name == "btnAlignBottom")
			{
				ynueva = 0;
				for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
				{
					item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
					if (item.name == "datos_elemento")
					{
						if ((item.y + item.height) > ynueva) ynueva = (item.y + item.height);
					}
				}
				for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
				{
					item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
					if (item.name == "datos_elemento")
					{
						if (item.height > alto_max) alto_max = item.height;
						item.y = ynueva - item.height;
					}
				}
				getPadre().Align("bottom",ynueva,alto_max);
			}
			else if (e.currentTarget.name == "btnAlignVerticalCenter")
			{
				centro = getPadre().elemento_seleccionMultiple.contenedor.width/2;
				for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
				{
					item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
					if (item.name == "datos_elemento") 
					{
						if (item.width > ancho_max) ancho_max = item.width;
						item.x = centro - item.width/2;
					}
				}
				getPadre().Align("vertical_center",centro,ancho_max);
			}
			else if (e.currentTarget.name == "btnAlignHorizontalCenter")
			{
				centro = getPadre().elemento_seleccionMultiple.contenedor.height/2;
				for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
				{
					item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
					if (item.name == "datos_elemento") 
					{
						if (item.height > alto_max) alto_max = item.height;
						item.y = centro - item.height/2;
					}
				}
				getPadre().Align("horizontal_center",centro,alto_max);
			}
		}*/
		
		///<summary>
		///Alinea los elementos
		///</summary>
		private function onBotonAlinearDown (e:MouseEvent)
		{
			trace("*******onBotonAlinearDown*********");
			e.currentTarget.gotoAndStop(2);
			
			var i:int = 0;
			var pos:Number = 0;
			var item:MovieClip;
			var xnueva:Number = 0;
			var ynueva:Number = 0;
			var ancho_max:Number = 0;
			var alto_max:Number = 0;
			var centro:Number = 0;
			if(enEscenario && getPadre().elemento_seleccionMultiple != null)//alinear en escenario
			{
				trace("[CAlinear] - onBotonAlinearDown() -> alinear con escenario -> "+e.currentTarget.name );
				if (e.currentTarget.name == "btnAlignLeft")
				{
					getPadre().elemento_seleccionMultiple.x = 0;
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							item.x = 0;
						}
					}
				}
				else if (e.currentTarget.name == "btnAlignRight")
				{
					var xmin = int.MAX_VALUE;
					var xmax = int.MIN_VALUE;
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							item.x = getPadre().anL - item.width - getPadre().elemento_seleccionMultiple.x;
							if(xmin>item.x) xmin = item.x;
							if(xmax<item.x+item.width) xmax = item.x+item.width;
						}
					}
					
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							item.x = item.x - xmin;
						}
					}
					xmin = xmin + getPadre().elemento_seleccionMultiple.x;
					xmax = xmax + getPadre().elemento_seleccionMultiple.x;
					trace("[CAlinear] - onBotonAlinearDown() -> xmin="+xmin+", xmax="+xmax);
					//trace("[CAlinear] - onBotonAlinearDown() -> eSM.ancho="+getPadre().elemento_seleccionMultiple.getAncho()+", nuevaX="+xnueva);
					getPadre().elemento_seleccionMultiple.setAncho(xmax-xmin);
					getPadre().elemento_seleccionMultiple.x = xmin;
					getPadre().elemento_seleccionMultiple.ajustarBotonesAContenido();
				}
				else if (e.currentTarget.name == "btnAlignVerticalCenter")
				{
					var xmin = int.MAX_VALUE;
					var xmax = int.MIN_VALUE;
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							item.x = getPadre().anL/2 - item.width/2 - getPadre().elemento_seleccionMultiple.x;
							if(xmin>item.x) xmin = item.x;
							if(xmax<item.x+item.width) xmax = item.x+item.width;
						}
					}
					
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							item.x = item.x - xmin;
						}
					}
					xmin = xmin + getPadre().elemento_seleccionMultiple.x;
					xmax = xmax + getPadre().elemento_seleccionMultiple.x;
					trace("[CAlinear] - onBotonAlinearDown() -> xmin="+xmin+", xmax="+xmax);
					//trace("[CAlinear] - onBotonAlinearDown() -> eSM.ancho="+getPadre().elemento_seleccionMultiple.getAncho()+", nuevaX="+xnueva);
					getPadre().elemento_seleccionMultiple.setAncho(xmax-xmin);
					getPadre().elemento_seleccionMultiple.x = xmin;
					getPadre().elemento_seleccionMultiple.ajustarBotonesAContenido();
				}
				else if (e.currentTarget.name == "btnAlignTop")
				{
					getPadre().elemento_seleccionMultiple.y = 0;
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							item.y = 0;
						}
					}
				}
				else if (e.currentTarget.name == "btnAlignBottom")
				{
					var ymin = int.MAX_VALUE;
					var ymax = int.MIN_VALUE;
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							item.y = getPadre().alL - item.height - getPadre().elemento_seleccionMultiple.y;
							if(ymin>item.y) ymin = item.y;
							if(ymax<item.y+item.height) ymax = item.y+item.height;
						}
					}
					
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							item.y = item.y - ymin;
						}
					}
					ymin = ymin + getPadre().elemento_seleccionMultiple.y;
					ymax = ymax + getPadre().elemento_seleccionMultiple.y;
					trace("[CAlinear] - onBotonAlinearDown() -> xmin="+ymin+", xmax="+ymax);
					//trace("[CAlinear] - onBotonAlinearDown() -> eSM.ancho="+getPadre().elemento_seleccionMultiple.getAncho()+", nuevaX="+xnueva);
					getPadre().elemento_seleccionMultiple.setAlto(ymax-ymin);
					getPadre().elemento_seleccionMultiple.y = ymin;
					getPadre().elemento_seleccionMultiple.ajustarBotonesAContenido();
				}
				else if (e.currentTarget.name == "btnAlignHorizontalCenter")
				{
					var ymin = int.MAX_VALUE;
					var ymax = int.MIN_VALUE;
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							item.y = getPadre().alL/2 - item.height/2 - getPadre().elemento_seleccionMultiple.y;
							if(ymin>item.y) ymin = item.y;
							if(ymax<item.y+item.height) ymax = item.y+item.height;
						}
					}
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							item.y = item.y - ymin;
						}
					}
					ymin = ymin + getPadre().elemento_seleccionMultiple.y;
					ymax = ymax + getPadre().elemento_seleccionMultiple.y;
					trace("[CAlinear] - onBotonAlinearDown() -> xmin="+ymin+", xmax="+ymax);
					//trace("[CAlinear] - onBotonAlinearDown() -> eSM.ancho="+getPadre().elemento_seleccionMultiple.getAncho()+", nuevaX="+xnueva);
					getPadre().elemento_seleccionMultiple.setAlto(ymax-ymin);
					getPadre().elemento_seleccionMultiple.y = ymin;
					getPadre().elemento_seleccionMultiple.ajustarBotonesAContenido();
				}
				
				return;
			}
			if(getPadre().elemento_seleccionMultiple != null)
			{
				getPadre().diferencia_x = 0;
				getPadre().diferencia_y = 0;
				if (e.currentTarget.name == "btnAlignLeft")
				{
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							if (item.width > ancho_max) ancho_max = item.width;
							item.x = 0;
						}
					}
					getPadre().Align("left",0,ancho_max);
				}
				else if (e.currentTarget.name == "btnAlignRight")
				{
					xnueva = 0;
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							if ((item.x + item.width) > xnueva) xnueva = (item.x + item.width);
						}
					}
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							if (item.width > ancho_max) ancho_max = item.width;
							item.x = xnueva - item.width;
						}
					}
					getPadre().Align("right",xnueva,ancho_max);
					
					//trace("*************  Corrigiendo la x en multiseleccion al alinear a la derecha");
					var xmin = int.MAX_VALUE;
					var xmax = int.MIN_VALUE;
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							if(xmin>item.x) xmin = item.x;
							if(xmax<item.x+item.width) xmax = item.x+item.width;
						}
					}
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							item.x = item.x - xmin;
						}
					}
					xmin = xmin + getPadre().elemento_seleccionMultiple.x;
					xmax = xmax + getPadre().elemento_seleccionMultiple.x;
					trace("[CAlinear] - onBotonAlinearDown() -> xmin="+xmin+", xmax="+xmax);
					//trace("[CAlinear] - onBotonAlinearDown() -> eSM.ancho="+getPadre().elemento_seleccionMultiple.getAncho()+", nuevaX="+xnueva);
					getPadre().elemento_seleccionMultiple.setAncho(xmax-xmin);
					getPadre().elemento_seleccionMultiple.x = xmin;
					getPadre().elemento_seleccionMultiple.ajustarBotonesAContenido();
					
					
				}
				else if (e.currentTarget.name == "btnAlignTop")
				{
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							if (item.height > alto_max) alto_max = item.height;
							item.y = 0;
						}
					}
					
					getPadre().Align("top",0,alto_max);
				}
				else if (e.currentTarget.name == "btnAlignBottom")
				{
					ynueva = 0;
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							if ((item.y + item.height) > ynueva) ynueva = (item.y + item.height);
						}
					}
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							if (item.height > alto_max) alto_max = item.height;
							item.y = ynueva - item.height;
						}
					}
					getPadre().Align("bottom",ynueva,alto_max);
					
					var ymin = int.MAX_VALUE;
					var ymax = int.MIN_VALUE;
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							if(ymin>item.y) ymin = item.y;
							if(ymax<item.y+item.height) ymax = item.y+item.height;
						}
					}
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							item.y = item.y - ymin;
						}
					}
					ymin = ymin + getPadre().elemento_seleccionMultiple.y;
					ymax = ymax + getPadre().elemento_seleccionMultiple.y;
					trace("[CAlinear] - onBotonAlinearDown() -> ymin="+ymin+", ymax="+ymax);
					//trace("[CAlinear] - onBotonAlinearDown() -> eSM.ancho="+getPadre().elemento_seleccionMultiple.getAncho()+", nuevaX="+xnueva);
					getPadre().elemento_seleccionMultiple.setAlto(ymax-ymin);
					getPadre().elemento_seleccionMultiple.y = ymin;
					getPadre().elemento_seleccionMultiple.ajustarBotonesAContenido();
					
					
				}
				else if (e.currentTarget.name == "btnAlignVerticalCenter")
				{
					centro = getPadre().elemento_seleccionMultiple.contenedor.width/2;
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							if (item.width > ancho_max) ancho_max = item.width;
							item.x = centro - item.width/2;
						}
					}
					getPadre().Align("vertical_center",centro,ancho_max);
					
					var xmin = int.MAX_VALUE;
					var xmax = int.MIN_VALUE;
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							if(xmin>item.x) xmin = item.x;
							if(xmax<item.x+item.width) xmax = item.x+item.width;
						}
					}
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							item.x = item.x - xmin;
						}
					}
					xmin = xmin + getPadre().elemento_seleccionMultiple.x;
					xmax = xmax + getPadre().elemento_seleccionMultiple.x;
					trace("[CAlinear] - onBotonAlinearDown() -> xmin="+xmin+", xmax="+xmax);
					//trace("[CAlinear] - onBotonAlinearDown() -> eSM.ancho="+getPadre().elemento_seleccionMultiple.getAncho()+", nuevaX="+xnueva);
					getPadre().elemento_seleccionMultiple.setAncho(xmax-xmin);
					getPadre().elemento_seleccionMultiple.x = xmin;
					getPadre().elemento_seleccionMultiple.ajustarBotonesAContenido();
				}
				else if (e.currentTarget.name == "btnAlignHorizontalCenter")
				{
					centro = getPadre().elemento_seleccionMultiple.contenedor.height/2;
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							if (item.height > alto_max) alto_max = item.height;
							item.y = centro - item.height/2;
						}
					}
					getPadre().Align("horizontal_center",centro,alto_max);
					
					var ymin = int.MAX_VALUE;
					var ymax = int.MIN_VALUE;
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							if(ymin>item.y) ymin = item.y;
							if(ymax<item.y+item.height) ymax = item.y+item.height;
						}
					}
					for (i = 0; i< getPadre().elemento_seleccionMultiple.contenedor.numChildren; i++)
					{
						item = getPadre().elemento_seleccionMultiple.contenedor.getChildAt(i) as MovieClip;
						if ((item.name == "datos_elemento") || (item.name == "fondo"))
						{
							item.y = item.y - ymin;
						}
					}
					ymin = ymin + getPadre().elemento_seleccionMultiple.y;
					ymax = ymax + getPadre().elemento_seleccionMultiple.y;
					trace("[CAlinear] - onBotonAlinearDown() -> ymin="+ymin+", ymax="+ymax);
					//trace("[CAlinear] - onBotonAlinearDown() -> eSM.ancho="+getPadre().elemento_seleccionMultiple.getAncho()+", nuevaX="+xnueva);
					getPadre().elemento_seleccionMultiple.setAlto(ymax-ymin);
					getPadre().elemento_seleccionMultiple.y = ymin;
					getPadre().elemento_seleccionMultiple.ajustarBotonesAContenido();
					
					
				}
				if (enEscenario)
				{
					if (e.currentTarget.name == "btnAlignLeft")
					{
						getPadre().diferencia_x = 0 - Math.round(getPadre().elemento_seleccionMultiple.x);
						getPadre().elemento_seleccionMultiple.x = 0;
						getPadre().actualizarArrayDatos();
					}
					if (e.currentTarget.name == "btnAlignTop")
					{
						getPadre().diferencia_y = 0 - Math.round(getPadre().elemento_seleccionMultiple.y);
						getPadre().elemento_seleccionMultiple.y = 0;
						getPadre().actualizarArrayDatos();
					}
					if (e.currentTarget.name == "btnAlignRight")
					{
						pos = Math.round(getPadre().lienzo.contenedor.area_editable.width - xnueva);
						getPadre().diferencia_x = Math.round(pos - getPadre().elemento_seleccionMultiple.x)+1;
						getPadre().elemento_seleccionMultiple.x = pos;
						getPadre().actualizarArrayDatos();
					}
					else if (e.currentTarget.name == "btnAlignBottom") 
					{
						pos = Math.round(getPadre().lienzo.contenedor.area_editable.height - ynueva);
						getPadre().diferencia_y = pos - Math.round(getPadre().elemento_seleccionMultiple.y);
						getPadre().elemento_seleccionMultiple.y = pos-1;
						getPadre().actualizarArrayDatos();
					}
					else if (e.currentTarget.name == "btnAlignHorizontalCenter")
					{
						pos = Math.round(getPadre().lienzo.contenedor.area_editable.height/2 - centro);
						getPadre().diferencia_y = pos - Math.round(getPadre().elemento_seleccionMultiple.y);
						getPadre().elemento_seleccionMultiple.y = pos;
						getPadre().actualizarArrayDatos();
					}
					else if (e.currentTarget.name == "btnAlignVerticalCenter")
					{
						pos = Math.round(getPadre().lienzo.contenedor.area_editable.width/2 - centro);
						getPadre().diferencia_x = pos - Math.round(getPadre().elemento_seleccionMultiple.x);
						getPadre().elemento_seleccionMultiple.x = pos;
						getPadre().actualizarArrayDatos();
					}
				}
				getPadre().getPanelPropiedades().insertPropGenericas(getPadre().elemento_seleccionMultiple);
				getPadre().elemento_seleccionMultiple.setXpos(getPadre().elemento_seleccionMultiple.x);
				getPadre().elemento_seleccionMultiple.setYpos(getPadre().elemento_seleccionMultiple.y);
			}
			else if (getPadre().elemento_seleccionado != null)
			{
				if (enEscenario)
				{
					if (e.currentTarget.name == "btnAlignLeft")  getPadre().elemento_seleccionado.x = 0;
					else if (e.currentTarget.name == "btnAlignTop")  getPadre().elemento_seleccionado.y = 0;
					else if (e.currentTarget.name == "btnAlignRight") 
					{
						pos = Math.round(getPadre().lienzo.contenedor.area_editable.width - getPadre().elemento_seleccionado.datos_elemento.width);
						getPadre().elemento_seleccionado.x = pos;
					}
					else if (e.currentTarget.name == "btnAlignBottom") 
					{
						pos = Math.round(getPadre().lienzo.contenedor.area_editable.height - getPadre().elemento_seleccionado.datos_elemento.height);
						getPadre().elemento_seleccionado.y = pos;
					}
					else if (e.currentTarget.name == "btnAlignVerticalCenter")
					{
						pos = Math.round(getPadre().lienzo.contenedor.area_editable.width/2 - getPadre().elemento_seleccionado.datos_elemento.width/2);
						getPadre().elemento_seleccionado.x = pos;
					}
					else if (e.currentTarget.name == "btnAlignHorizontalCenter")
					{
						pos = Math.round(getPadre().lienzo.contenedor.area_editable.height/2 - getPadre().elemento_seleccionado.datos_elemento.height/2);
						getPadre().elemento_seleccionado.y = pos;
					}
					getPadre().getPanelPropiedades().insertPropGenericas(getPadre().elemento_seleccionado);
					getPadre().elemento_seleccionado.setXpos(getPadre().elemento_seleccionado.x);
					getPadre().elemento_seleccionado.setYpos(getPadre().elemento_seleccionado.y);
				}
			}
		}
		/*******************************************************************************************************************/
	}
	
}
