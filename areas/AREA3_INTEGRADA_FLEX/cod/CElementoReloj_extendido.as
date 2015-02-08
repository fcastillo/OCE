package cod
{
	import flash.display.MovieClip;
	
	public class CElementoReloj_extendido extends CElementoBase
	{
		//VARIABLES
		
		//Comunes
		private var color_fondo:uint = 0xffffff;
		private var alpha_fondo:Number = 1;
		private var color_numeros:uint = 0x000000;
		private var alpha_numeros:Number = 1;
		
		//Analogico
		private var color_agujas:uint = 0x000000; 
		private var alpha_agujas:Number = 1;
		private var color_marcas:uint = 0x000000; 
		private var alpha_marcas:Number = 1;
		private var color_sombra:uint = 0xC6C6C6;
		private var alpha_sombra:Number = 0.28;
		private var color_marco:uint = 0x000000;
		private var alpha_marco:Number = 1;
		private var color_remarco:uint = 0xC6C6C6;
		private var alpha_remarco:Number = 0.28;
		
		//Digital
		private var color_mes:uint = 0xCCCCCC;
		private var color_dia:uint = 0xCCCCCC;
		private var color_numDia:uint = 0x999999;
		private var alpha_mes:Number = 1;
		private var alpha_dia:Number = 1;
		private var alpha_numDia:Number = 1;
				
		/************************GETTERS/SETTERS***********************/
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
		public function getColorMes():uint {return color_mes;}
		public function getColorDia():uint {return color_dia;}
		public function getColorNumDia():uint {return color_numDia;}
		public function getAlphaMes():uint {return alpha_mes;}
		public function getAlphaDia():uint {return alpha_dia;}
		public function getAlphaNumDia():uint {return alpha_numDia;}
		
		public function setColorMes(val:uint) {color_mes = val;}
		public function setColorDia(val:uint) {color_dia = val;}
		public function setColorNumDia(val:uint) {color_numDia = val;}
		public function setAlphaMes(val:uint) {alpha_mes = val;}
		public function setAlphaDia(val:uint) {alpha_dia = val;}
		public function setAlphaNumDia(val:uint) {alpha_numDia = val;}
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
		/***************************************************************/
		
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CElementoReloj_extendido(aita:MovieClip) 
		{
			super(aita); //El padre es el swf que estamos cargando
		}
		
		///<summary>
		///Llama a la función load dentro del swf
		///</summary>
		override public function load():int
		{
			getPadre().load();
			return 0;
		}
				
		///<summary>
		///Edita los colores de los elementos del reloj dentro del swf
		///		-> Editamos el alpha porque en ocasiones se pierde el valor
		///</summary>
		public function editColor(instancia:String,val:String) 
		{
			switch(instancia)
			{
				case "sombraCP":
					this.color_sombra = uint(val);
					getPadre().editColorSombra(uint(val));
					getPadre().editAlphaSombra(this.alpha_sombra);
					break;
				case "fondoCP":
					this.color_fondo = uint(val);
					getPadre().editColorFondo(uint(val));
					getPadre().editAlphaFondo(this.alpha_fondo);
					break;
				case "marcoCP":
					this.color_marco = uint(val);
					getPadre().editColorMarco(uint(val));
					getPadre().editAlphaMarco(this.alpha_marco);
					break;
				case "remarcoCP":
					this.color_remarco = uint(val);
					getPadre().editColorRemarco(uint(val));
					getPadre().editAlphaRemarco(this.alpha_remarco);
					break;
				case "marcasCP":
					this.color_marcas = uint(val);
					getPadre().editColorMarcas(uint(val));
					getPadre().editAlphaMarcas(this.alpha_marcas);
					break;
				case "numerosCP":
					this.color_numeros = uint(val);
					getPadre().editColorNumeros(uint(val));
					getPadre().editAlphaNumeros(this.alpha_numeros);
					break;
				case "agujasCP":
					this.color_agujas = uint(val);
					getPadre().editColorAgujas(uint(val));
					getPadre().editAlphaAgujas(this.alpha_agujas);
					break;
				case "diaCP":
					this.color_dia = uint(val);
					getPadre().editColorDia(uint(val));
					getPadre().editAlphaDia(this.alpha_dia);
					break;
				case "numDiaCP":
					this.color_numDia = uint(val);
					getPadre().editColorNumDia(uint(val));
					getPadre().editAlphaNumDia(this.alpha_numDia);
					break;
				case "mesCP":
					this.color_mes = uint(val);
					getPadre().editColorMes(uint(val));
					getPadre().editAlphaMes(this.alpha_mes);
					break;
			}
		}
		
		///<summary>
		///Edita el alpha de los elementos del reloj dentro del swf
		///</summary>
		public function editAlpha(instancia:String,val:Number) 
		{
			switch(instancia)
			{
				case "alpha_sombra":
					this.alpha_sombra = val;
					getPadre().editAlphaSombra(val);
					break;
				case "alpha_fondo":
					this.alpha_fondo = val;
					getPadre().editAlphaFondo(val);
					break;
				case "alpha_marco":
					this.alpha_marco = val;
					getPadre().editAlphaMarco(val);
					break;
				case "alpha_remarco":
					this.alpha_remarco = val;
					getPadre().editAlphaRemarco(val);
					break;
				case "alpha_marcas":
					this.alpha_marcas = val;
					getPadre().editAlphaMarcas(val);
					break;
				case "alpha_numeros":
					this.alpha_numeros = val;
					getPadre().editAlphaNumeros(val);
					break;
				case "alpha_agujas":
					this.alpha_agujas = val;
					getPadre().editAlphaAgujas(val);
					break;
				case "alpha_dia":
					this.alpha_dia = val;
					getPadre().editAlphaDia(val);
					break;
				case "alpha_numDia":
					this.alpha_numDia = val;
					getPadre().editAlphaNumDia(val);
					break;
				case "alpha_mes":
					this.alpha_mes = val;
					getPadre().editAlphaMes(val);
					break;
			}
		}
	}
	
}
