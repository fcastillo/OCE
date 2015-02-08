package cod
{
	import flash.display.MovieClip
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	import flash.geom.ColorTransform;
	import flash.ui.Mouse;
	
	
	public class CTextEditor extends MovieClip implements IEventDispatcher
	{
		//VARIABLES
		private var _mainText:TextField; //Instancia al texto que estamos editando
		private var userFonts:Array = new Array("Arial","Arial Black","Comic Sans","Courier","Courier New","Georgia","Impact","Lucida Console","Lucida Sans","Microsoft Sans Serif","Modern","Symbol","Tahoma","Times New Roman","Trebuchet MS","Verdana");
		private var allFontNames:Array;
		
		public var padre:MovieClip;
		
		//***********************************GETTERS/SETTERS*************************************//
		public function getMainText():TextField {return _mainText;}

		function setMainText(mainText:TextField)
		{
			_mainText = mainText;
			_mainText.alwaysShowSelection = true;
			_mainText.addEventListener(MouseEvent.MOUSE_UP, checkTextFormat);
		}
		//***************************************************************************************//
		
		///<summary>
		///Constructor; define el padre y llama a init()
		///</summary>
		public function CTextEditor(aita:MovieClip) 
		{
			padre = aita;
			init();
		}
		
		///<summary>
		///Función que llama a enableButtons() para activar los event listeners y llena el combo
		///con las fuentes disponibles
		///</summary>
		public function init():void 
		{			
			//Para activar listeners
			enableButtons();
			
			//Para activar listeners
			allFontNames = new Array();
			fontList.addItem( { label: "" } );
			allFontNames.push("");
			
			for (var i = 0; i < userFonts.length; i++ ) 
			{
				fontList.addItem( { label: userFonts[i]} );
				allFontNames.push(userFonts[i]);
			}
			fontList.rowCount = 5;
		}
		
		///<summary>
		///Activa los listeners en los botones de edición
		///</summary>
		private function enableButtons():void 
		{					
			// Componentes
			fontList.addEventListener(Event.CHANGE, changeFont);
			sizeSelect.addEventListener(Event.CHANGE, changeSize);
			colorSelect.addEventListener(Event.CHANGE, changeColor);
			if (colorSelect.colors.indexOf(0xd3d3d3) == -1) añadirGrises();
			
			// Botones
			buttonBold.buttonMode = true;
			buttonBold.addEventListener(MouseEvent.CLICK, changeBold);
			buttonItalic.buttonMode = true;
			buttonItalic.addEventListener(MouseEvent.CLICK, changeItalic);
			buttonUnderline.buttonMode = true;
			buttonUnderline.addEventListener(MouseEvent.CLICK, changeUnderline);
			buttonLeft.buttonMode = true;
			buttonLeft.addEventListener(MouseEvent.CLICK, setLeft);
			buttonCenter.buttonMode = true;
			buttonCenter.addEventListener(MouseEvent.CLICK, setCenter);
			buttonRight.buttonMode = true;
			buttonRight.addEventListener(MouseEvent.CLICK, setRight);
			buttonJustify.buttonMode = true;
			buttonJustify.addEventListener(MouseEvent.CLICK, setJustify);
			buttonBullet.buttonMode = true;
			buttonBullet.addEventListener(MouseEvent.CLICK, setBullets);
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
		///Listener que llama a editTextFormat con el nuevo valor de la fuente
		///</summary>
		private function changeFont(e:Event):void 
		{
			editTextFormat("font", e.target.selectedItem.label);
		}
		
		///<summary>
		///Listener que llama a editTextFormat con el nuevo valor del tamaño la fuente
		///</summary>
		private function changeSize(e:Event):void {
			editTextFormat("size", e.target.value);
		}
		
		///<summary>
		///Listener que llama a editTextFormat con el nuevo valor del color del texto
		///</summary>
		private function changeColor(e:Event):void {
			editTextFormat("color", e.target.selectedColor);
		}
		
		///<summary>
		///Listener que llama a editTextFormat con el nuevo valor de la negrita del texto
		///</summary>
		private function changeBold(e:Event):void {
			editTextFormat("bold");
		}
		
		///<summary>
		///Listener que llama a editTextFormat con el nuevo valor de la cursiva del texto
		///</summary>
		private function changeItalic(e:MouseEvent):void {
			editTextFormat("italic");
		}
		
		///<summary>
		///Listener que llama a editTextFormat con el nuevo valor del subrayado del texto
		///</summary>
		private function changeUnderline(e:MouseEvent):void {
			editTextFormat("underline");
		}
		
		///<summary>
		///Listener que llama a editTextFormat para alinear el texto a la izda
		///</summary>
		private function setLeft(e:MouseEvent):void {
			editTextFormat("left");
		}
		
		///<summary>
		///Listener que llama a editTextFormat para centrar el texto
		///</summary>
		private function setCenter(e:MouseEvent):void {
			editTextFormat("center");
		}
		
		///<summary>
		///Listener que llama a editTextFormat para alinear el texto a la drcha
		///</summary>
		private function setRight(e:MouseEvent):void {
			editTextFormat("right");
		}
		
		///<summary>
		///Listener que llama a editTextFormat para justificar el texto
		///</summary>
		private function setJustify(e:MouseEvent):void {
			editTextFormat("justify");
		}
		
		///<summary>
		///Listener que llama a editTextFormat para colocar viñetas al texto
		///</summary>
		private function setBullets(e:MouseEvent):void {
			editTextFormat("bullets");
		}
		
		///<summary>
		///Evento que salta cada vez que hay un evento Mouse_up en el texto
		///		-> Cada vez que el usuario seleccione parte del texto actualizamos el panel para
		///			reflejar las características del texto seleccionado
		///</summary>
		private function checkTextFormat(e:Event = null):void 
		{
			actualizarEditor();
		}
		
		///<summary>
		///Función que actualiza el panel para reflejar las características del texto seleccionado
		///</summary>
		public function actualizarEditor()
		{		
			if (_mainText != null)
			{
				if (_mainText.selectionBeginIndex != _mainText.selectionEndIndex)
				{
					var tempTextFormat:TextFormat = _mainText.getTextFormat(_mainText.selectionBeginIndex, _mainText.selectionEndIndex);			
					
					// Botones negrita, cursiva y subrayado
					tempTextFormat.bold ? buttonBold.gotoAndStop(2) : buttonBold.gotoAndStop(1);
					tempTextFormat.italic ? buttonItalic.gotoAndStop(2) : buttonItalic.gotoAndStop(1);
					tempTextFormat.underline ? buttonUnderline.gotoAndStop(2) : buttonUnderline.gotoAndStop(1);
					
					// Botones alineación
					tempTextFormat.align == "left" ? buttonLeft.gotoAndStop(2) : buttonLeft.gotoAndStop(1);
					tempTextFormat.align == "center" ? buttonCenter.gotoAndStop(2) : buttonCenter.gotoAndStop(1);
					tempTextFormat.align == "right" ? buttonRight.gotoAndStop(2) : buttonRight.gotoAndStop(1);
					tempTextFormat.align == TextFormatAlign.JUSTIFY ? buttonJustify.gotoAndStop(2) : buttonJustify.gotoAndStop(1);
					
					// Color picker
					colorSelect.selectedColor = uint(tempTextFormat.color);
					
					// Fuente
					tempTextFormat.font ? fontList.selectedIndex = allFontNames.indexOf(tempTextFormat.font) : fontList.selectedIndex = -1;
					fontList.rowCount = 5;
					
					// Tamaño de fuente
					sizeSelect.value = int(tempTextFormat.size);
				}
			}
		}
		
		///<summary>
		///Función que edita el texto seleccionado
		///</summary>
		private function editTextFormat(type:String, val:* = null) 
		{
			trace("_mainText.selectionBeginIndex="+_mainText.selectionBeginIndex+" _mainText.selectionEndIndex="+_mainText.selectionEndIndex);
			if (_mainText.selectionBeginIndex != _mainText.selectionEndIndex)
			{
			
				// Aplicamos los cambios a partir del formato de esa porción de texto
				var tempTextFormat:TextFormat = _mainText.getTextFormat(_mainText.selectionBeginIndex, _mainText.selectionEndIndex);
				
				// Editamos alguna de las características
				switch(type)
				{
					case "font":
						tempTextFormat.font = val;
						break;
					case "size":
						tempTextFormat.size = val;
						break;
					case "color":
						tempTextFormat.color = val;
						break;
					case "bold":
						tempTextFormat.bold ? tempTextFormat.bold = false : tempTextFormat.bold = true;
						break;	
					case "italic":
						tempTextFormat.italic ? tempTextFormat.italic = false : tempTextFormat.italic = true;
						break;	
					case "underline":
						tempTextFormat.underline ? tempTextFormat.underline = false : tempTextFormat.underline = true;
						break;
					case "left":
						tempTextFormat.align = "left";
						break;				
					case "center":
						tempTextFormat.align = "center";
						break;				
					case "right":
						tempTextFormat.align = "right";
						break;	
					case "justify":
						tempTextFormat.align = TextFormatAlign.JUSTIFY;
						break;	
					case "bullets":
						tempTextFormat.bullet = !tempTextFormat.bullet;
						break;
					case "target":
						tempTextFormat.target = val;
						break;							
					default:
						break;
				}
				
				// Aplicamos el cambio
				_mainText.setTextFormat(tempTextFormat, _mainText.selectionBeginIndex, _mainText.selectionEndIndex);
				checkTextFormat();
			}
		}
	}
}
