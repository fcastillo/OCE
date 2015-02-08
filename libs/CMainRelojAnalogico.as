package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import fl.motion.Color;
	import flash.text.TextFormat;
	
	public class CMainRelojAnalogico extends MovieClip 
	{
		//VARIABLES
		private var tipo:String = "analog";
		private var color_agujas:uint = 0x000000; 
		private var alpha_agujas:Number = 1;
		private var color_marcas:uint = 0x000000; 
		private var alpha_marcas:Number = 1;
		private var color_sombra:uint = 0x989898;
		private var alpha_sombra:Number = 1;
		private var color_fondo:uint = 0xffffff;
		private var alpha_fondo:Number = 1;
		private var color_marco:uint = 0x000000;
		private var alpha_marco:Number = 1;
		private var color_remarco:uint = 0xC6C6C6;
		private var alpha_remarco:Number = 1;
		private var color_numeros:uint = 0x000000;
		private var alpha_numeros:Number = 1;
		
		private var ancho:Number;
		private var alto:Number;
		
		//Fecha hora
		var time:Date = new Date();
		
		//Reloj
		var reloj:CRelojAnalogico;
		
		var kont:int = 0;
								
		/***************************GETTERS/SETTERS*************************************/
		public function getTipo():String {return tipo;}
		public function getColorAgujas():uint {return color_agujas;}
		public function getAlphaAgujas():Number {return alpha_agujas;}
		public function getColorMarcas():uint {return color_marcas;}
		public function getAlphaMarcas():Number {return alpha_marcas;}
		public function getColorSombra():uint {return color_sombra;}
		public function getAlphaSombra():Number {return alpha_sombra;}
		public function getColorFondo():uint {return color_fondo;}
		public function getAlphaFondo():Number {return alpha_fondo;}
		public function getColorMarco():uint {return color_marco;}
		public function getAlphaMarco():Number {return alpha_marco;}
		public function getColorRemarco():uint {return color_remarco;}
		public function getAlphaRemarco():Number {return alpha_remarco;}
		public function getColorNumeros():uint {return color_numeros;}
		public function getAlphaNumeros():Number {return alpha_numeros;}
		
		public function setTipo(val:String):void {tipo = val;}
		public function setColorAgujas(val:uint):void {color_agujas = val;}
		public function setAlphaAgujas(val:Number):void {alpha_agujas = val;}
		public function setColorMarcas(val:uint):void {color_marcas = val;}
		public function setAlphaMarcas(val:Number):void {alpha_marcas = val;}
		public function setColorSombra(val:uint):void {color_sombra = val;}
		public function setAlphaSombra(val:Number):void {alpha_sombra = val;}
		public function setColorFondo(val:uint):void {color_fondo = val;}
		public function setAlphaFondo(val:Number):void {alpha_fondo = val;}
		public function setColorMarco(val:uint):void {color_marco = val;}
		public function setAlphaMarco(val:Number):void {alpha_marco = val;}
		public function setColorRemarco(val:uint):void {color_remarco = val;}
		public function setAlphaRemarco(val:Number):void {alpha_remarco = val;}
		public function setColorNumeros(val:uint):void {color_numeros = val;}
		public function setAlphaNumeros(val:Number):void {alpha_numeros = val;}
		/********************************************************************************/
		
		public function CMainRelojAnalogico() 
		{
			time = new Date();
			//load();
			//var xml : XML = new XML('<ELEMENTO alto="0.3675" ancho="0.784" tipo="reloj" tipo_reloj="analog" color_agujas="0" alpha_agujas="0" color_marcas="0" alpha_marcas="0" color_sombra="13027014" alpha_sombra="0" color_fondo="16777215" alpha_fondo="0" color_marco="0" alpha_marco="0" color_remarco="13027014" alpha_remarco="0" color_numeros="0" alpha_numeros="0" color_mes="13421772" color_dia="13421772" color_numDia="10066329" alpha_mes="0" alpha_dia="0" alpha_numDia="0" profundidad="1" transparencia="1" cY="0.2175" cX="0.07466666666666667" path="reloj_analog_v2.swf"/>'); 
			//loadXML(xml, "CArea1");
		}
		
		public function load()
		{
			reloj = new CRelojAnalogico();
			reloj.x = 6;
			reloj.y = 6;
			fondo.addChild(reloj);									
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);	
			
		}
		
		//---------Función loadXML---------//
		//-- Edita el control según los atributos leídos en el dpe
		//-- Variables de entrada:
			//--datos: nodo xml del dpe
		//--------------------------------------//
		public function loadXML(datos:XML,tipoArea:String)
		{
			if (tipoArea == "CArea1")
			{
				ancho = Number(datos.@ancho)*375;
				alto = Number(datos.@alto)*800;
			}
			else if (tipoArea == "CArea3")
			{
				ancho = Number(datos.@ancho)*225;
				alto = Number(datos.@alto)*265;
			}
			else if (tipoArea == "CArea4")
			{
				ancho = Number(datos.@ancho)*225;
				alto = Number(datos.@alto)*170;
			}
			
			load();
			var tipo_reloj:String = datos.@tipo_reloj;
			if (tipo_reloj == "analog")
			{
				editColorSombra(uint(datos.@color_sombra));
				editColorFondo(uint(datos.@color_fondo));
				editColorMarco(uint(datos.@color_marco));
				editColorRemarco(uint(datos.@color_remarco));
				
				editColorMarcas(uint(datos.@color_marcas));
				editColorNumeros(uint(datos.@color_numeros));
				editColorAgujas(uint(datos.@color_agujas));
				
				editAlphaSombra(datos.@alpha_sombra);
				editAlphaFondo(datos.@alpha_fondo);
				editAlphaMarco(datos.@alpha_marco);
				editAlphaRemarco(datos.@alpha_remarco);
				editAlphaMarcas(datos.@alpha_marcas);
				editAlphaNumeros(datos.@alpha_numeros);
				editAlphaAgujas(datos.@alpha_agujas);	
			}		
		}
		
		//--Función enterFrameHandler
		//	Rota las agujas del reloj según la hora
		//--
		public function enterFrameHandler(e:Event):void 
		{		
			kont++;
			if(kont < 24) return;
			kont = 0;
			
			time = new Date();
			var hourHand = time.getHours();
			var minuteHand = time.getMinutes();
			var secondHand = time.getSeconds();
	 
			reloj.mcHoras.rotation = 30 * hourHand + minuteHand / 2;
			reloj.mcMinutos.rotation = 6 * minuteHand;
		}
		
		//--Función editColorFondo
		//	Cambia el color del óvalo de fondo
		//--
		public function editColorFondo(val:uint)
		{
			var color:Color = new Color();
			color.setTint(val,1);
			reloj.fondo_reloj.transform.colorTransform = color;
			this.color_fondo = val;
		}
		
		//--Función editAlphaFondo
		//	Cambia el alpha del óvalo de fondo
		//--
		public function editAlphaFondo(val:Number)
		{
			reloj.fondo_reloj.alpha = val;
			this.alpha_fondo = val;
		}
		
		//--Función editColorSombra
		//	Cambia el color de la sombra
		//--
		public function editColorSombra(val:uint)
		{
			
			var color:Color = new Color();
			color.setTint(val,this.alpha_sombra);
			reloj.sombra.transform.colorTransform = color;
			this.color_sombra = val;
		}
		
		//--Función editAlphaSombra
		//	Cambia el alpha de la sombra
		//--
		public function editAlphaSombra(val:Number)
		{			
			//for (var i:int = 0; i< reloj.sombra.ovalo.numChildren; i++)
//			{
//				var objeto:String = reloj.sombra.ovalo.getChildAt(i).toString();
//				if (objeto.indexOf("Shape") != -1)
//				{
//					reloj.sombra.ovalo.getChildAt(i).alpha = val;
//				}
//				trace(reloj.sombra.ovalo.getChildAt(i));
//			}
			trace("********************editAlphaSombra*****************");
						
			var color:Color = new Color();
			color.setTint(this.color_sombra,val);
			reloj.sombra.transform.colorTransform = color;
			this.alpha_sombra = val;
		}
		
		//--Función editColorMarco
		//	Cambia el color del marco
		//--
		public function editColorMarco(val:uint)
		{
			var color:Color = new Color();
			color.setTint(val,1);
			reloj.marco.transform.colorTransform = color;
			this.color_marco = val;
		}
		
		//--Función editAlphaMarco
		//	Cambia el alpha del marco
		//--
		public function editAlphaMarco(val:Number)
		{
			reloj.marco.alpha = val;
			this.alpha_marco = val;
		}
		
		//--Función editColorRemarco
		//	Cambia el color del remarco
		//--
		public function editColorRemarco(val:uint)
		{
			var color:Color = new Color();
			color.setTint(val,1);
			reloj.remarco.transform.colorTransform = color;
			this.color_remarco = val;
		}
		
		//--Función editAlphaRemarco
		//	Cambia el alpha del remarco
		//--
		public function editAlphaRemarco(val:Number)
		{
			reloj.remarco.alpha = val;
			this.alpha_remarco = val;
		}
		
		//--Función editColorNumeros
		//	Cambia el color de los números
		//--
		public function editColorNumeros(val:uint)
		{
			var formato:TextFormat = reloj.num12.getTextFormat();
			formato.color = val;
			reloj.num12.setTextFormat(formato);
			reloj.num3.setTextFormat(formato);
			reloj.num6.setTextFormat(formato);
			reloj.num9.setTextFormat(formato);
			this.color_numeros = val;
		}
		
		//--Función editAlphaNumeros
		//	Cambia el alpha de los números
		//--
		public function editAlphaNumeros(val:Number)
		{
			//trace("******RELOJ ANALOGICO - editAlphaNumeros***********");
			reloj.num12.alpha = val;
			reloj.num3.alpha = val;
			reloj.num6.alpha = val;
			reloj.num9.alpha = val;
			this.alpha_numeros = val;
		}
		
		//--Función editColorMarcas
		//	Cambia el color de las marcas
		//--
		public function editColorMarcas(val:uint)
		{
			var color:Color = new Color();
			color.setTint(val,1);
			reloj.h1.transform.colorTransform = color;
			reloj.h2.transform.colorTransform = color;
			reloj.h3.transform.colorTransform = color;
			reloj.h4.transform.colorTransform = color;
			reloj.h5.transform.colorTransform = color;
			reloj.h6.transform.colorTransform = color;
			reloj.h7.transform.colorTransform = color;
			reloj.h8.transform.colorTransform = color;
			reloj.h9.transform.colorTransform = color;
			reloj.h10.transform.colorTransform = color;
			reloj.h11.transform.colorTransform = color;
			reloj.h12.transform.colorTransform = color;
			this.color_marcas = val;
		}
		
		//--Función editAlphaMarcas
		//	Cambia el alpha de las marcas
		//--
		public function editAlphaMarcas(val:Number)
		{
			reloj.h1.alpha = val;
			reloj.h2.alpha = val;
			reloj.h3.alpha = val;
			reloj.h4.alpha = val;
			reloj.h5.alpha = val;
			reloj.h6.alpha = val;
			reloj.h7.alpha = val;
			reloj.h8.alpha = val;
			reloj.h9.alpha = val;
			reloj.h10.alpha = val;
			reloj.h11.alpha = val;
			reloj.h12.alpha = val;
			this.alpha_marcas = val;
		}
		
		//--Función editColorAgujas
		//	Cambia el color de las agujas
		//--
		public function editColorAgujas(val:uint)
		{
			var color:Color = new Color();
			color.setTint(val,1);
			reloj.mcHoras.transform.colorTransform = color;
			reloj.mcMinutos.transform.colorTransform = color;
			reloj.centro.transform.colorTransform = color;
			reloj.color_agujas = val;
		}
		
		//--Función editAlphaAgujas
		//	Cambia el alpha de las agujas
		//--
		public function editAlphaAgujas(val:Number)
		{
			reloj.mcHoras.alpha = val;
			reloj.mcMinutos.alpha = val;
			reloj.centro.alpha = val;
			this.alpha_agujas = val;
		}
		
		public function unload()
		{
			removeEventListener(Event.ENTER_FRAME,enterFrameHandler);	
			if (reloj != null) fondo.removeChild(reloj);
		}
	}
	
}
