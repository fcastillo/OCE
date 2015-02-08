package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import fl.motion.Color;
	import flash.text.TextFormat;
	
	public class CMainRelojDigital extends MovieClip 
	{
		private var tipo:String = "digital";
		private var color_fondo:uint = 0x000000;
		private var color_numeros:uint = 0xffffff;
		private var color_mes:uint = 0xCCCCCC;
		private var color_dia:uint = 0xCCCCCC;
		private var color_numDia:uint = 0x999999;
		private var alpha_fondo:Number = 1;
		private var alpha_numeros:Number = 1;
		private var alpha_mes:Number = 1;
		private var alpha_dia:Number = 1;
		private var alpha_numDia:Number = 1;
		
		private var ancho:Number;
		private var alto:Number;
		
		var arrDias : Array = new Array();
		var arrMeses : Array = new Array();
		
		//Fecha hora
		var time:Date = new Date();
		
		//Reloj
		var reloj:CRelojDigital;
		
		var kont : int = 0;
		
		/***************************GETTERS/SETTERS*************************************/
		public function getTipo():String {return tipo;}
		public function getColorFondo():uint {return color_fondo;}
		public function getColorNumeros():uint {return color_numeros;}
		public function getColorMes():uint {return color_mes;}
		public function getColorDia():uint {return color_dia;}
		public function getColorNumDia():uint {return color_numDia;}
		public function getAlphaFondo():uint {return alpha_fondo;}
		public function getAlphaNumeros():uint {return alpha_numeros;}
		public function getAlphaMes():uint {return alpha_mes;}
		public function getAlphaDia():uint {return alpha_dia;}
		public function getAlphaNumDia():uint {return alpha_numDia;}
		public function getAlto():uint {return alto;}
		public function getAncho():uint {return ancho;}
		public function getRelojAlto():uint {return reloj.height;}
		public function getRelojAncho():uint {return reloj.width;}
		
		
		public function setTipo(val:String) {tipo = val;}
		public function setColorFondo(val:uint) {color_fondo = val;}
		public function setColorNumeros(val:uint) {color_numeros = val;}
		public function setColorMes(val:uint) {color_mes = val;}
		public function setColorDia(val:uint) {color_dia = val;}
		public function setColorNumDia(val:uint) {color_numDia = val;}
		public function setAlphaFondo(val:uint) {alpha_fondo = val;}
		public function setAlphaNumeros(val:uint) {alpha_numeros = val;}
		public function setAlphaMes(val:uint) {alpha_mes = val;}
		public function setAlphaDia(val:uint) {alpha_dia = val;}
		public function setAlphaNumDia(val:uint) {alpha_numDia = val;}
		public function setAlto(val:uint) {alto = val; reloj.height = alto;}
		public function setAncho(val:uint) {ancho= val; reloj.width = ancho;}
		/*********************************************************************************/
		
		public function CMainRelojDigital() 
		{
			time = new Date();
			
			//por defecto en castellano
			arrDias = new Array("dom","lun", "mar", "mie","jue", "vie", "sab");
			arrMeses = new Array("ene","feb","mar","abr","may","jun","jul","ago","sep","oct","nov","dic");
			
			//load();
		}
		
		public function setDiasSemana(s:String):void
		{
			arrDias = s.split(",");
		}
		public function setMeses(s:String):void
		{
			arrMeses = s.split(",");
		}
		public function load()
		{
			reloj = new CRelojDigital();
			reloj.x = 0;
			reloj.y = 0;
			reloj.width = ancho;
			reloj.height = alto;
			
			fondo.addChild(reloj);	

			addEventListener(Event.ENTER_FRAME,enterFrameHandler);	
		}
		
		public function unload()
		{
			removeEventListener(Event.ENTER_FRAME,enterFrameHandler);	
			fondo.removeChild(reloj);	
		}
		
		//---------Función loadXML---------//
		//-- Edita el control según los atributos leídos en el dpe
		//-- Variables de entrada:
			//--datos: nodo xml del dpe
		//--------------------------------------//
		public function loadXML(datos:XML,tipoArea:String)
		{
			//Vemos el tamaño según el area
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
			//trace("RELOJ DIGITAL w: "+ancho+" - h: "+alto);
			load();
			var tipo_reloj:String = datos.@tipo_reloj;
			if (tipo_reloj == "digital")
			{
				editColorFondo(uint(datos.@color_fondo));
				editColorNumeros(uint(datos.@color_numeros));
				editColorDia(uint(datos.@color_dia));
				editColorNumDia(uint(datos.@color_numDia));
				editColorMes(uint(datos.@color_mes));
								
				editAlphaFondo(datos.@alpha_fondo);				
				editAlphaNumeros(datos.@alpha_numeros);
				editAlphaDia(uint(datos.@alpha_dia));
				editAlphaNumDia(uint(datos.@alpha_numDia));
				editAlphaMes(uint(datos.@alpha_mes));
				
			}		
		}
		
		//--Función enterFrameHandler
		//	Cambia los valores según la hora
		//--
		public function enterFrameHandler(e:Event):void 
		{
			kont++;
			if(kont < 24) return;
			kont = 0;
			
			time = new Date();
			var horas = time.getHours();
			var minutos = time.getMinutes();
			var dia = time.getDay();
			var mes = time.getMonth();
			var numDia = time.getDate();
			
			if (int(horas) < 10) horas = "0"+horas;
			if (int(minutos) < 10) minutos = "0"+minutos;
									
			reloj.txtHoras.text = horas.toString();
			reloj.txtMinutos.text = minutos.toString();
			reloj.mes.text = traducirMes(mes);
			reloj.dia.text = traducirDiaSemana(dia);
			reloj.numDia.text = numDia;
			
			var formato:TextFormat = reloj.txtHoras.getTextFormat();
			formato.color = this.color_numeros;
			reloj.txtHoras.setTextFormat(formato);
			reloj.txtMinutos.setTextFormat(formato);
			reloj.puntos.setTextFormat(formato);
			
			formato = reloj.mes.getTextFormat();
			formato.color = this.color_mes;
			reloj.mes.setTextFormat(formato);
			
			formato = reloj.dia.getTextFormat();
			formato.color = this.color_dia;
			reloj.dia.setTextFormat(formato);
			
			formato = reloj.numDia.getTextFormat();
			formato.color = this.color_numDia;
			reloj.numDia.setTextFormat(formato);
		}
		
		//--Función traducirDiaSemana
		//	Devuelve en texto el día de la semana
		//--
		private function traducirDiaSemana(val:String):String
		{
			var devolver:String;
			switch (val)
			{
				case "0": devolver = arrDias[0]; break;
				case "1": devolver = arrDias[1]; break;
				case "2": devolver = arrDias[2]; break;
				case "3": devolver = arrDias[3]; break;
				case "4": devolver = arrDias[4]; break;
				case "5": devolver = arrDias[5]; break;
				case "6": devolver = arrDias[6]; break;
			}
			return devolver;
		}
		
		//--Función traducirMes
		//	Devuelve en texto el mes del año
		//--
		private function traducirMes(val:String):String
		{
			var devolver:String;
			switch (val)
			{
				case "0": devolver = arrMeses[0]; break;
				case "1": devolver = arrMeses[1]; break;
				case "2": devolver = arrMeses[2]; break;
				case "3": devolver = arrMeses[3]; break;
				case "4": devolver = arrMeses[4]; break;
				case "5": devolver = arrMeses[5]; break;
				case "6": devolver = arrMeses[6]; break;
				case "7": devolver = arrMeses[7]; break;
				case "8": devolver = arrMeses[8]; break;
				case "9": devolver = arrMeses[9]; break;
				case "10": devolver = arrMeses[10]; break;
				case "11": devolver = arrMeses[11]; break;
			}
			return devolver;
		}
		
		/******************************************** FORMATO ***************************************************/
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
		
		//--Función editColorNumeros
		//	Cambia el color de los números
		//--
		public function editColorNumeros(val:uint)
		{
			var formato:TextFormat = reloj.txtHoras.getTextFormat();
			formato.color = val;
			reloj.txtHoras.setTextFormat(formato);
			reloj.txtMinutos.setTextFormat(formato);
			reloj.puntos.setTextFormat(formato);
			this.color_numeros = val;
		}
		
		//--Función editAlphaNumeros
		//	Cambia el alpha de los números
		//--
		public function editAlphaNumeros(val:Number)
		{
			reloj.txtHoras.alpha = val;
			reloj.txtMinutos.alpha = val;
			reloj.puntos.alpha = val;
			this.alpha_numeros = val;
		}
		
		//--Función editColorMes
		//	Cambia el color del mes
		//--
		public function editColorMes(val:uint)
		{
			var formato:TextFormat = reloj.mes.getTextFormat();
			formato.color = val;
			reloj.mes.setTextFormat(formato);
			this.color_mes = val;
		}
		
		//--Función editAlphaMes
		//	Cambia el alpha del mes
		//--
		public function editAlphaMes(val:Number)
		{
			reloj.mes.alpha = val;
			this.alpha_mes = val;
		}
		
		//--Función editColorDia
		//	Cambia el color del dia
		//--
		public function editColorDia(val:uint)
		{
			var formato:TextFormat = reloj.dia.getTextFormat();
			formato.color = val;
			reloj.dia.setTextFormat(formato);
			this.color_dia = val;
		}
		
		//--Función editAlphaDia
		//	Cambia el alpha del dia
		//--
		public function editAlphaDia(val:Number)
		{
			reloj.dia.alpha = val;
			this.alpha_dia = val;
		}
		
		//--Función editColorNumDia
		//	Cambia el color del dia (el número)
		//--
		public function editColorNumDia(val:uint)
		{
			var formato:TextFormat = reloj.numDia.getTextFormat();
			formato.color = val;
			reloj.numDia.setTextFormat(formato);
			this.color_numDia = val;
		}
		
		//--Función editAlphaNumDia
		//	Cambia el alpha del dia (el número)
		//--
		public function editAlphaNumDia(val:Number)
		{
			reloj.numDia.alpha = val;
			this.alpha_numDia = val;
		}
		/*********************************************************************************************************/
	}
	
}
