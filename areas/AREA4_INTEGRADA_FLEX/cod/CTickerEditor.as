package cod
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.Font;
	import fl.controls.RadioButtonGroup;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class CTickerEditor extends CElementoBase
	{
		//VARIABLES
		public var userFonts:Array = new Array("Arial","Arial Black","Comic Sans","Courier","Courier New","Georgia","Impact","Lucida Console","Lucida Sans","Microsoft Sans Serif","Modern","Symbol","Tahoma","Times New Roman","Trebuchet MS","Verdana");

		var allFontNames:Array;
		private var texto_ticker:TextField;
		
		//***********************************GETTERS/SETTERS*************************************//
		public function getTextoTicker():TextField {return texto_ticker;}
		public function setTextoTicker(val:TextField):void {texto_ticker = val;}
		//***************************************************************************************//
		
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CTickerEditor(aita:MovieClip) 
		{
			super(aita);
		}
		
		///<summary>
		///Función que llama a enableButtons() para activar los event listeners y llena el combo
		///con las fuentes disponibles
		///</summary>
		override public function load():int
		{
			enableButtons();
						
			allFontNames = new Array();
			fontList.addItem( { label: "" } );
			allFontNames.push("");
			
			for (var i = 0; i < userFonts.length; i++ ) 
			{
				fontList.addItem( { label: userFonts[i]} );
				allFontNames.push(userFonts[i]);
			}
			fontList.rowCount = 5;
			
			return 0;
		}
		
		///<summary>
		///Activa los listeners en los botones de edición
		///</summary>
		private function enableButtons():void 
		{	
			// Componentes
			fontList.addEventListener(Event.CHANGE, onFontColorSizeChange);
			colorSelect.addEventListener(Event.CHANGE, onFontColorSizeChange);
			if (colorSelect.colors.indexOf(0xd3d3d3) == -1) añadirGrises();
			sizeSelect.addEventListener(Event.CHANGE, onFontColorSizeChange);
			
			// Botones
			btnBold.buttonMode = true;
			btnBold.addEventListener(MouseEvent.CLICK, onEdicion);
			btnItalic.buttonMode = true;
			btnItalic.addEventListener(MouseEvent.CLICK, onEdicion);
			btnUnderline.buttonMode = true;
			btnUnderline.addEventListener(MouseEvent.CLICK, onEdicion);
			/*btnLeft.buttonMode = true;
			btnLeft.addEventListener(MouseEvent.CLICK, onEdicion);
			btnCenter.buttonMode = true;
			btnCenter.addEventListener(MouseEvent.CLICK, onEdicion);
			btnJustificar.buttonMode = true;
			btnJustificar.addEventListener(MouseEvent.CLICK, onEdicion);
			btnRight.buttonMode = true;
			btnRight.addEventListener(MouseEvent.CLICK, onEdicion);*/
			
			velocidad_ticker.addEventListener(Event.CHANGE, cambiarVelocidad);
		}	
		
		///<summary>
		///Añade los tonos grises a los color picker
		///</summary>
		private function añadirGrises()
		{
			if (colorSelect.colors.indexOf(0xd3d3d3) == -1)
			{
				colorSelect.colors.push(0xd3d3d3);
				colorSelect.colors.push(0xc0c0c0);
				colorSelect.colors.push(0xa9a9a9);
				colorSelect.colors.push(0x999999);
				colorSelect.colors.push(0x808080);
				colorSelect.colors.push(0x666666);
				colorSelect.colors.push(0x333333);
			}
		}
	
		///<summary>
		///Función que actualiza el panel cada vez que seleccionemos un elemento ticker en el lienzo
		///</summary>
		public function actualizarEditor()
		{
			//Actualizamos el panel según el formato del texto guardado
			var formato:TextFormat = this.texto_ticker.getTextFormat();
						
			//Fuente
			for (var i:int = 0; i< fontList.length; i++)
			{
				if (fontList.getItemAt(i).label == formato.font) break;
			}
			fontList.selectedIndex = i;
			
			//Color
			colorSelect.selectedColor = formato.color as uint;
			
			//velocidad ticker
			velocidad_ticker.text = getPadre().getPadre().elemento_seleccionado.velocidad_ticker;
			
			//Tamaño de la fuente
			sizeSelect.value = Number(formato.size);
						
			//Negrita, cursiva y subrayado
			if (formato.bold)  btnBold.gotoAndStop(2);
			else btnBold.gotoAndStop(1);
			
			if (formato.italic)  btnItalic.gotoAndStop(2);
			else btnItalic.gotoAndStop(1);
			
			if (formato.underline)  btnUnderline.gotoAndStop(2);
			else btnUnderline.gotoAndStop(1);
			
			//Alineación
			/*btnLeft.gotoAndStop(1);
			btnCenter.gotoAndStop(1);
			btnRight.gotoAndStop(1);
			btnJustificar.gotoAndStop(1);
						
			switch (formato.align)
			{
				case "left": btnLeft.gotoAndStop(2); break;
				case "center": btnCenter.gotoAndStop(2); break;
				case "right": btnRight.gotoAndStop(2); break;
				case "justify": btnJustificar.gotoAndStop(2); break;
			}*/
		}
		
		///<summary>
		///Función que edita el color, fuente y tamaño de la fuente
		///</summary>
		function onFontColorSizeChange(e:Event)
		{
			if (e.currentTarget.name == "fontList") getPadre().getPadre().elemento_seleccionado.editarTicker("fuente", e.target.selectedItem.label);
			else if (e.currentTarget.name == "sizeSelect") getPadre().getPadre().elemento_seleccionado.editarTicker("tamaño",e.target.value);
			else getPadre().getPadre().elemento_seleccionado.editarTicker("color", colorSelect.selectedColor);
		}
		
		///<summary>
		///Función que edita el texto (negrtita, cursiva, alineación, etc.)
		///</summary>
		function onEdicion(e:MouseEvent)
		{
			var val:Boolean = false;
						
			//Pasamos a todos a unselected
			/*btnLeft.gotoAndStop(1);
			btnCenter.gotoAndStop(1);
			btnRight.gotoAndStop(1);
			btnJustificar.gotoAndStop(1);*/
			
			//Guardamos en "val" la selección del usuario
			if(e.currentTarget.currentFrame == 2) 
			{
				e.currentTarget.gotoAndStop(1);
				val = false; //"val" a false si el botón queda des-seleccionado
			}
			else 
			{
				e.currentTarget.gotoAndStop(2);
				val = true; //"val" a true si el botón queda seleccionado
			}
			
			//Botones
			switch(e.currentTarget.name)
			{
				case "btnBold": getPadre().getPadre().elemento_seleccionado.editarTicker("negrita",val); break;
				case "btnItalic": getPadre().getPadre().elemento_seleccionado.editarTicker("cursiva",val); break;
				case "btnUnderline": getPadre().getPadre().elemento_seleccionado.editarTicker("subrayado",val); break;
				case "btnLeft": getPadre().getPadre(). elemento_seleccionado.editarTicker("alineacion","left"); break;
				case "btnCenter": getPadre().getPadre().elemento_seleccionado.editarTicker("alineacion","center"); break;
				case "btnJustificar": getPadre().getPadre().elemento_seleccionado.editarTicker("alineacion","justify"); break;
				case "btnRight": getPadre().getPadre().elemento_seleccionado.editarTicker("alineacion","right"); break;
				default: break;
			}
			actualizarEditor();
		}
		
		///<summary>
		///Función que edita la velocidad del ticker
		///</summary>
		function cambiarVelocidad(e:Event)
		{
			getPadre().getPadre().elemento_seleccionado.editarTicker("velocidad",Number(velocidad_ticker.text));
		}
	}
	
}
