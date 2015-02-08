package  cod
{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	import flash.geom.ColorTransform;
		
	public class CElementoEstilo extends MovieClip
	{
		private var padre:MovieClip;
		private var nombre:String;
		private var txtCabecera:Object= new Object();
		private var txtTitulo:Object= new Object();
		private var txtSubtitulo1:Object= new Object();
		private var txtSubtitulo2:Object= new Object();
		private var txtSubtitulo3:Object= new Object();
		private var txt1:Object= new Object();
		private var txt2:Object= new Object();
		private var txt3:Object= new Object();
		private var txtPie:Object= new Object();
		private var imagen_fondo:MovieClip;

		//************************************GETTERS/SETTERS**************************************//
		public function getPadre():MovieClip {return padre;}
		public function getNombreEstilo():String {return nombre;}
		public function getObjetoCabecera():Object {return txtCabecera;}
		public function getObjetoTitulo():Object {return txtTitulo;}
		public function getObjetoSubtitulo1():Object {return txtSubtitulo1;}
		public function getObjetoSubtitulo2():Object {return txtSubtitulo2;}
		public function getObjetoSubtitulo3():Object {return txtSubtitulo3;}
		public function getObjetoTxt1():Object {return txt1;}
		public function getObjetoTxt2():Object {return txt2;}
		public function getObjetoTxt3():Object {return txt3;}
		public function getObjetoTxtPie():Object {return txtPie;}
		public function getFondo():MovieClip {return imagen_fondo;}
		
		public function setPadre(val:MovieClip):void {padre = val;}
		public function setNombreEstilo(val:String):void {nombre = val;}
		public function setObjetoCabecera(val:Object):void {txtCabecera = val;}
		public function setObjetoTitulo(val:Object):void {txtTitulo = val;}
		public function setObjetoSubtitulo1(val:Object):void {txtSubtitulo1 = val;}
		public function setObjetoSubtitulo2(val:Object):void {txtSubtitulo2 = val;}
		public function setObjetoSubtitulo3(val:Object):void {txtSubtitulo3 = val;}
		public function setObjetoTxt1(val:Object):void {txt1 = val;}
		public function setObjetoTxt2(val:Object):void {txt2 = val;}
		public function setObjetoTxt3(val:Object):void {txt3 = val;}
		public function setObjetoTxtPie(val:Object):void {txtPie = val;}
		public function setFondo(val:MovieClip):void {imagen_fondo = val;}
		//************************************************************************************************//
		
		///<summary>
		///Constructor; define el padre
		///		-> Esta clase permite almacenar los estilos del control especial menú
		///		-> Elementos del control = cajas de texto +  fondo
		///		-> Cada estilo tiene sus formatos y su fondo
		///</summary>
		public function CElementoEstilo(aita:MovieClip) 
		{
			padre = aita;
		}
		
		///<summary>
		///Función que aplica un formato al texto indicado
		///</summary>
		public function setFormatoATexto(formato_texto:TextFormat,instancia:String):void
		{			
			switch(instancia)
			{
				case "txtCabecera": txtCabecera.formato = formato_texto; break;
				case "txtTitulo": txtTitulo.formato = formato_texto; break;
				case "txtSubtitulo1": txtSubtitulo1.formato = formato_texto; break;
				case "txtSubtitulo2": txtSubtitulo2.formato = formato_texto; break;
				case "txtSubtitulo3": txtSubtitulo3.formato = formato_texto; break;
				case "txt1": txt1.formato = formato_texto; break;
				case "txt2": txt2.formato = formato_texto; break;
				case "txt3": txt3.formato = formato_texto; break;
				case "txtPie": txtPie.formato = formato_texto; break;
			}
		}
		
		///<summary>
		///Función que devuelve el formato del texto indicado
		///</summary>
		public function getFormatoTexto (instancia:String):TextFormat
		{
			var formato_texto:TextFormat = new TextFormat();
			switch(instancia)
			{
				case "txtCabecera": formato_texto = txtCabecera.formato; break;
				case "txtTitulo": formato_texto = txtTitulo.formato; break;
				case "txtSubtitulo1": formato_texto = txtSubtitulo1.formato; break;
				case "txtSubtitulo2": formato_texto = txtSubtitulo2.formato; break;
				case "txtSubtitulo3": formato_texto = txtSubtitulo3.formato; break;
				case "txt1": formato_texto = txt1.formato; break;
				case "txt2": formato_texto = txt2.formato; break;
				case "txt3": formato_texto = txt3.formato; break;
				case "txtPie": formato_texto = txtPie.formato; break;
			}
			return formato_texto;
		}

	}
	
}
