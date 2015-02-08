package  cod
{
	import flash.display.MovieClip;
	import flash.text.TextFormat;
	
	public class CElementoTiempo extends CElementoBase
	{
		private var cod_ciudad:String;
		private var dia:String;
		private var pais:String;
		private var estilo:String;
		private var posicion:String = "Arriba";
		private var formato_fecha:String = "dd/mm";
		
		private var negrita_fecha:Boolean = true;
		private var cursiva_fecha:Boolean = false;
		private var subrayado_fecha:Boolean = false;
		private var color_fecha:uint = 0x5D5D5D;
		private var fuente_fecha:String = "Arial";
		
		private var negrita_temp:Boolean = true;
		private var cursiva_temp:Boolean = false;
		private var subrayado_temp:Boolean = false;
		private var color_temp:uint = 0x5D5D5D;
		private var fuente_temp:String = "Arial";
			
		/***************************************GETTERS/SETTERS***************************************/
		public function getCodigoCiudad():String {return cod_ciudad;}
		public function getDia():String {return dia;}
		public function getPais():String {return pais;}
		public function getEstilo():String {return estilo;}
		public function getPosicion():String {return posicion;}
		public function getFormatoFecha():String {return formato_fecha;}
		public function getNegritaFecha():Boolean {return negrita_fecha;}
		public function getCursivaFecha():Boolean {return cursiva_fecha;}
		public function getSubrayadoFecha():Boolean {return subrayado_fecha;}
		public function getColorFecha():uint {return color_fecha;}
		public function getFuenteFecha():String {return fuente_fecha;}
		public function getNegritaTemp():Boolean {return negrita_temp;}
		public function getCursivaTemp():Boolean {return cursiva_temp;}
		public function getSubrayadoTemp():Boolean {return subrayado_temp;}
		public function getColorTemp():uint {return color_temp;}
		public function getFuenteTemp():String {return fuente_temp;}
		
		public function setCodigoCiudad(val:String) {cod_ciudad = val;}
		public function setDia(val:String) {dia = val;}
		public function setPais(val:String) {pais = val;}
		public function setEstilo(val:String) {estilo = val;}
		public function setPosicion(val:String) {posicion = val;}
		public function setFormatoFecha(val:String) {formato_fecha = val;}
		public function setNegritaFecha(val:Boolean) {negrita_fecha = val;}
		public function setCursivaFecha(val:Boolean) {cursiva_fecha = val;}
		public function setSubrayadoFecha(val:Boolean) {subrayado_fecha = val;}
		public function setColorFecha(val:uint) {color_fecha = val;}
		public function setFuenteFecha(val:String) {fuente_fecha = val;}
		public function setNegritaTemp(val:Boolean) {negrita_temp = val;}
		public function setCursivaTemp(val:Boolean) {cursiva_temp = val;}
		public function setSubrayadoTemp(val:Boolean) {subrayado_temp = val;}
		public function setColorTemp(val:uint) {color_temp = val;}
		public function setFuenteTemp(val:String) {fuente_temp = val;}
		/***************************************************************************************************/
		
		///<summary>
		///Constructor; define el padre
		///		-> El padre es el swf; tiempo_vertical.swf o tiempo_horizontal.swf
		///</summary>
		public function CElementoTiempo(aita:MovieClip) 
		{
			super(aita); 
		}
		
		///<summary>
		///Carga el tiempo en el día y ciudad seleccionados
		///		-> Dentro del swf se carga la url pasándole el código de la ciudad
		///</summary>
		override public function load():int
		{
			getPadre().setEstiloImagenes(estilo);
			if (dia == "Hoy")
			{
				getPadre().getToday(cod_ciudad);
			}
			else if (dia == "Mañana") getPadre().getTomorrow(cod_ciudad);
			else if (dia == "Pasado") getPadre().getDayAfterTomorrow(cod_ciudad);
			else if (dia == "Siguiente") getPadre().get2DaysAfterTomorrow(cod_ciudad);
			return 0;
		}
		
		///<summary>
		///Función que edita la negrita de los textos
		///</summary>
		public function editNegrita(instancia:int,op:Boolean) 
		{
			if (instancia == 1) negrita_fecha = op;
			else negrita_temp = op;
			getPadre().negritaTexto(instancia,op); 
		}
		
		///<summary>
		///Función que edita el subrayado de los textos
		///</summary>
		public function editSubrayado(instancia:int,op:Boolean)	
		{
			if (instancia == 1) subrayado_fecha = op;
			else subrayado_temp = op;
			getPadre().subrayadoTexto(instancia,op); 
		}
		
		///<summary>
		///Función que edita la cursiva de los textos
		///</summary>
		public function editCursiva(instancia:int,op:Boolean) 
		{
			if (instancia == 1) cursiva_fecha = op;
			else cursiva_temp = op;
			getPadre().cursivaTexto(instancia,op); 
		}
		
		///<summary>
		///Función que edita la fuente de los textos
		///</summary>
		public function editFuente(instancia:int,val:String) 
		{
			if (instancia == 1) fuente_fecha = val;
			else fuente_temp = val;
			getPadre().fuenteTexto(instancia,val); 
		}
		
		///<summary>
		///Función que guarda la posición de los textos
		///		-> Arriba: tiempo_vertical.swf
		///		-> Derecha: tiempo_horizontal.swf
		///</summary>
		public function editPosicion(val:String) 
		{
			posicion = val;
		}
		
		///<summary>
		///Función que edita el formato de la fecha, dd/mm  o mm/dd
		///</summary>
		public function editFormatoFecha(val:String)
		{
			formato_fecha = val;
			getPadre().cambiarFormatoFecha(val);
		}
		
		///<summary>
		///Función que actualiza el formato de los textos
		///</summary>
		public function actualizarFormatoTextos(f_fecha:TextFormat,f_temp:TextFormat)
		{
			getPadre().actualizarFormatoTextos(f_fecha,f_temp);
		}
		
		///<summary>
		///Función que edita el color de los textos
		///</summary>
		public function editColor(instancia:int,val:String) 
		{
			var color_hex = displayInHex(uint(val));
			if (instancia == 1) color_fecha = uint(val);
			else color_temp = uint(val);
			color_hex = "#"+color_hex;
			getPadre().colorTexto1(instancia,color_hex);
		}
				
		//------------------------------De uint a hex-----------------------------------//
		///<summary>
		///Función que pasa el valor de un color de uin a hexadecimal
		///</summary>
		function displayInHex(c:uint):String 
		{
			var r:String=extractRed(c).toString(16).toUpperCase();
			var g:String=extractGreen(c).toString(16).toUpperCase();
			var b:String=extractBlue(c).toString(16).toUpperCase();
			var hs:String="";
			var zero:String="0";
			
			if(r.length==1) r=zero.concat(r);
			if(g.length==1) g=zero.concat(g);
			if(b.length==1) b=zero.concat(b);
			hs=r+g+b;
			
			return hs;
		}
		
		function extractRed(c:uint):uint { return (( c >> 16 ) & 0xFF);	}
		function extractGreen(c:uint):uint { return ( (c >> 8) & 0xFF ); }
		function extractBlue(c:uint):uint { return ( c & 0xFF );}
		//------------------------------------------------------------------------------------//
	}
	
}
