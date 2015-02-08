package cod 
{
	import flash.display.*;	
	import flash.text.*;	
	
	public class CElementoTexto extends CElementoBase
	{
		//VARIABLES
		private var contenido:String;
		private var fuente:String;
		private var tamaño:Number;
		private var alineacion:String;
		private var color:String;
		private var negrita:Boolean;
		private var cursiva:Boolean;
		private var subrayado:Boolean;
		private var seleccionable:Boolean = false;
		private var wordwrap:Boolean = false;
		private var multilinea:Boolean = true;
		private var disableBooleanValues:Boolean = false;
		private var myTextField:TextField;
		
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CElementoTexto(aita:MovieClip) 
		{
			super(aita);	
		}
		
		//*****************************GETTERS/SETTERS************************************/
		public function getContenido():String { return contenido; }
		public function getFuente():String { return fuente; }	
		public function getTamaño():Number { return tamaño; }
		public function getAlineacion():String { return alineacion; }
		public function getColor():String { return color; }
		public function getNegrita():Boolean { return negrita; }
		public function getCursiva():Boolean { return cursiva; }
		public function getSubrayado():Boolean { return subrayado; }
		public function getSeleccionable():Boolean { return seleccionable; }
		public function getWordwrap():Boolean { return wordwrap; }
		public function getMultilinea():Boolean { return multilinea; }	
		public function getMyTextField():TextField {return myTextField;}
		public function getDisableBooleanValues():Boolean {return disableBooleanValues; }
		
		public function setContenido(val:String):void { contenido = val; }
		public function setFuente(val:String):void { fuente = val; }
		public function setTamaño(val:Number):void { tamaño = val; }
		public function setAlineacion(val:String):void { alineacion = val; }
		public function setColor(val:String):void { color = val; }
		public function setDisableBooleanValues(val:Boolean):void {disableBooleanValues = val;}
		
		public function setNegrita(val:String):void 
		{ 
			if (val == "true") negrita = true;
			else negrita = false;
		}
		public function setCursiva(val:String):void
		{			
			if (val == "true") cursiva = true;
			else cursiva = false;		
		}
		public function setSubrayado(val:String):void
		{
			if (val == "true") subrayado = true;
			else subrayado = false;	
		}
		public function setSeleccionable(val:String):void
		{
			if (val == "true") seleccionable = true;
			else seleccionable = false;				
		}
		public function setWordwrap(val:Boolean):void
		{
			if (val) wordwrap = true;
			else wordwrap = false;		
		}
		public function setMultilinea(val:Boolean):void
		{
			if (val) multilinea = true;
			else multilinea = false;
		}
		
		public function setMyTextField(val:TextField)
		{
			myTextField = val;
		}
		
		/****************************************************************************/
		
		///<summary>
		///Carga 
		///</summary>
		override public function load():int
		{	
			trace("CElementoTexto - load()");
			myTextField = new TextField();						
		
			myTextField.width = getPadre().width;		
			myTextField.height = getPadre().height;	
						
			myTextField.selectable = getSeleccionable();  
			myTextField.multiline = getMultilinea();
			//myTextField.multiline = true;
						
			myTextField.wordWrap = getWordwrap();
			myTextField.border = false;  

			var myFormat:TextFormat = new TextFormat();    
			switch (getAlineacion())
			{
				case "center": myFormat.align  = TextFormatAlign.CENTER; break;
				case "left": myFormat.align = TextFormatAlign.LEFT; break;
				case "right": myFormat.align = TextFormatAlign.RIGHT;  break;
				case "CENTER": myFormat.align  = TextFormatAlign.CENTER; break;
				case "LEFT": myFormat.align = TextFormatAlign.LEFT; break;
				case "RIGHT": myFormat.align = TextFormatAlign.RIGHT; break;
				default: break;
			}			
			
			myFormat.font = getFuente();
		    myFormat.color = getColor(); 
			if (getTamaño().toString() != "NaN") myFormat.size = getTamaño();  
			
			if (!disableBooleanValues)
			{
				myFormat.italic = getCursiva(); 
				myFormat.bold = getNegrita();
				myFormat.underline = getSubrayado(); 
			}
			
			 
			
			myTextField.type = TextFieldType.INPUT;
			myTextField.alpha = 1;
			
			myTextField.htmlText = contenido;
			myTextField.setTextFormat(myFormat); 
			return 0;
		}
		
		override public function unload():void 
		{ 	
			getPadre().removeChild(myTextField); 			
		}
	}
	
}
