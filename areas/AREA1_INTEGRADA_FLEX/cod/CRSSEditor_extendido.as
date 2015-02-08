package cod
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.Font;
	import fl.controls.RadioButtonGroup;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.filters.DropShadowFilter;
	
	public class CRSSEditor_extendido extends CElementoBase
	{
		//VARIABLES
		public var userFonts:Array = new Array("Arial","Arial Black","Comic Sans","Courier","Courier New","Georgia","Impact","Lucida Console","Lucida Sans","Microsoft Sans Serif","Modern","Symbol","Tahoma","Times New Roman","Trebuchet MS","Verdana");

		var allFontNames:Array;
		var instancia:String = "1";
		var estilo:String = "estilo1";
		var url_rss:String = "http://feeds.bbci.co.uk/news/world/rss.xml";
		var velocidad:int = 200;
		
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CRSSEditor_extendido(aita) 
		{
			super(aita);
		}
		
		///<summary>
		///Carga el panel de propiedades del elemento rss
		///		-> Llama a las funciones que activan los event listener de los botones del panel
		///		-> Llena el combo de las fuentes disponibles
		///</summary>
		override public function load():int 
		{	
			activarListeners();
			enableButtons();
			
			instancia = "1";
			
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
		///Activa los listeners en los radio buttons y el texto
		///</summary>
		private function activarListeners():void 
		{
			//Radio buttons
			rCabecera.addEventListener(MouseEvent.CLICK, onChangeInstancia); 
			rTextos.addEventListener(MouseEvent.CLICK, onChangeInstancia);

			//Url
			texto_url.addEventListener(Event.CHANGE, onChangeURL); 	
			
			//ComboEstilos
			comboEstilo.addEventListener(Event.CHANGE, onChangeEstilo);
			comboEstilo.rowCount = 3;
			
			//Tiempo entre transiciones
			tiempo_trans.addEventListener(Event.CHANGE, onChangeTiempoEntreTransiciones); 
			
			//imagen
			check_imagen.addEventListener(MouseEvent.CLICK, setImagenVisible); 
			
			//velocidad de desplazamiento del título
			check_titulo.addEventListener(MouseEvent.CLICK, setMovimientoTitulo); 
			configSliderVelocidadTitulo();

			//velocidad
			configSliderVelocidad();
		}
				
		///<summary>
		///Activa los listeners en los botones de edición
		///</summary>
		private function enableButtons():void 
		{			
			// Componentes
			fontList.addEventListener(Event.CHANGE, onFontColorChange);
			colorSelect.addEventListener(Event.CHANGE, onFontColorChange);
			colorSuperior.addEventListener(Event.CHANGE, onFontColorChange);
			colorInferior.addEventListener(Event.CHANGE, onFontColorChange);
			alphaSuperior.addEventListener(Event.CHANGE, onAlphaChange);
			alphaInferior.addEventListener(Event.CHANGE, onAlphaChange);
			sizeSelect.addEventListener(Event.CHANGE, onSizeChange);

			//Añadimos grises en el color picker
			if (colorSelect.colors.indexOf(0xd3d3d3) == -1) añadirGrises();
						
			//Botones
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
			if (colorSuperior.colors.indexOf(0xd3d3d3) == -1)
			{
				colorSuperior.colors.push(0xd3d3d3);
				colorSuperior.colors.push(0xc0c0c0);
				colorSuperior.colors.push(0xa9a9a9);
				colorSuperior.colors.push(0x999999);
				colorSuperior.colors.push(0x808080);
				colorSuperior.colors.push(0x666666);
				colorSuperior.colors.push(0x333333);
			}
			if (colorInferior.colors.indexOf(0xd3d3d3) == -1)
			{
				colorInferior.colors.push(0xd3d3d3);
				colorInferior.colors.push(0xc0c0c0);
				colorInferior.colors.push(0xa9a9a9);
				colorInferior.colors.push(0x999999);
				colorInferior.colors.push(0x808080);
				colorInferior.colors.push(0x666666);
				colorInferior.colors.push(0x333333);
			}
		}
		
		///<summary>
		///Controla la parte del rss que está siendo editada: titular o texto
		///</summary>
		public function onChangeInstancia(e:MouseEvent)
		{
			switch( e.target.label)
			{
				case "Titular": instancia = "1"; break;
				case "Texto":  instancia = "2"; break;
				default: break;
			}
			actualizarEditor();
		}
		
		///<summary>
		///Controla si la imagen está visible o no
		///</summary>
		public function setImagenVisible(e:MouseEvent)
		{
			if (check_imagen.selected) getPadre().getPadre().elemento_seleccionado.imagenVisible = true;
			else getPadre().getPadre().elemento_seleccionado.imagenVisible = false;
			getPadre().getPadre().elemento_seleccionado.elementoFondoRSS.imagen.visible = check_imagen.selected;
		}

		///<summary>
		///Controla el movimiento del titulo; el usuario decide si el título se desplaza o no
		///</summary>
		public function setMovimientoTitulo(e:MouseEvent)
		{
			if (check_titulo.selected) getPadre().getPadre().elemento_seleccionado.tituloActivo = false;
			else getPadre().getPadre().elemento_seleccionado.tituloActivo = true;
		}

		///<summary>
		///Evento que controla si se ha modificado la URL
		///</summary>
		public function onChangeURL(e:Event)
		{
			getPadre().getPadre().elemento_seleccionado.rss_url = texto_url.text;
		}
		
		///<summary>
		///Controla si cambiamos de estilo de RSS
		///</summary>
		public function onChangeEstilo(e:Event)
		{
			trace("[CRSSEditor_extendido] - onChange1Estilo -> estilo:"+estilo+" == label:"+e.target.selectedItem.label+" selecc:"+getPadre().getPadre().elemento_seleccionado.estilo_rss);
			estilo = getPadre().getPadre().elemento_seleccionado.estilo_rss; //miramos que tipo de RSS tenemos seleccionado
			if (estilo != e.target.selectedItem.label)
			{
				estilo = e.target.selectedItem.label;
				getPadre().getPadre().elemento_seleccionado.cambiarEstilo(estilo);
			}
		}

		///<summary>
		///Configura el slider para la velocidad del titulo
		///</summary>
		private function configSliderVelocidadTitulo()
		{
			//Definimos máximo, mínimo y punto de partida del slider
			velocidadTitulo.minimum = 2;
			velocidadTitulo.maximum = 22;
			velocidadTitulo.value = 12;
			velocidadTitulo.tickInterval = 2; //Intervalo de las marcas
			velocidadTitulo.snapInterval = 2; //Precisión; los valores siempre serán múltiplo de 2
			velocidadTitulo.liveDragging = false; 
			velocidadTitulo.addEventListener(Event.CHANGE, TituloSliderChanged);
		}
		
		///<summary>
		///Configura el slider para la velocidad del scroll
		///</summary>
		private function configSliderVelocidad()
		{
			//Definimos máximo, mínimo y punto de partida del slider
			velocidadRSS.minimum = 2;
			velocidadRSS.maximum = 102;
			velocidadRSS.value = 50;
			velocidadRSS.tickInterval = 10; //Intervalo de las marcas
			velocidadRSS.snapInterval = 2;  //Precisión; los valores siempre serán múltiplo de 2
			velocidadRSS.liveDragging = false; 
			velocidadRSS.addEventListener(Event.CHANGE, RSSsliderChanged);
		}
		
		///<summary>
		///Cambia el tiempo entre transiciones
		///</summary>
		private function onChangeTiempoEntreTransiciones(e:Event)
		{
			getPadre().getPadre().elemento_seleccionado.tiempo_trans_rss = int(tiempo_trans.text);
		}

		///<summary>
		///Listener que controla el slider de la velocidad del titulo
		///</summary>
		function TituloSliderChanged(evt:Event):void 
		{
			var valor:int = velocidadTitulo.value;
			getPadre().getPadre().elemento_seleccionado.velocidad_titulo = valor;
		}
				
		///<summary>
		///Listener que controla el slider de la velocidad
		///</summary>
		function RSSsliderChanged(evt:Event):void 
		{
			var valor:int = velocidadRSS.value;
			getPadre().getPadre().elemento_seleccionado.velocidad_rss = valor;
		}
		
		///<summary>
		///Actualiza el editor 
		///		-> Cada vez que seleccionamos un elemento RSS del lienzo
		///		-> Cada vez que estamos editando el titular y pasamos a editar el texto, o viceversa
		///</summary>
		public function actualizarEditor()
		{
			var color_titulos:String;
			var color_texto:String;
			var fuente:String;
			var alineacion:String; 
			var etiquetas:String = "";
			var negrita:Boolean;
			var cursiva:Boolean;
			var subrayado:Boolean;
			
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				//Imagen visible
				if (getPadre().getPadre().elemento_seleccionado.imagenVisible) check_imagen.selected = true;
				else check_imagen.selected = false;
				
				//Titulo activo
				if (getPadre().getPadre().elemento_seleccionado.tituloActivo) check_titulo.selected = false;
				else check_titulo.selected = true;
				
				//URL
				url_rss = getPadre().getPadre().elemento_seleccionado.rss_url;
				texto_url.text = getPadre().getPadre().elemento_seleccionado.rss_url;
				
				// Velocidades
				velocidadTitulo.value = int(getPadre().getPadre().elemento_seleccionado.velocidad_titulo);
				velocidadRSS.value = int(getPadre().getPadre().elemento_seleccionado.velocidad_rss);
				
				tiempo_trans.text = getPadre().getPadre().elemento_seleccionado.tiempo_trans_rss;
				
				
		
				if (getPadre().getPadre().elemento_seleccionado.estilo_rss == "estilo3")
				{
					deshabilitarOpciones(); //Es estilo 3 solo tiene titular
					
					//Barra superior
					colorSuperior.selectedColor = getPadre().getPadre().elemento_seleccionado.color_sup;
					//Formato titular
					rCabecera.selected = true;					
					colorSelect.selectedColor = getPadre().getPadre().elemento_seleccionado.color_titulo;
					fuente = getPadre().getPadre().elemento_seleccionado.fuente_titulo;
					alineacion = getPadre().getPadre().elemento_seleccionado.align_titulo;
					negrita = getPadre().getPadre().elemento_seleccionado.negrita_titulo;
					cursiva = getPadre().getPadre().elemento_seleccionado.cursiva_titulo;
					subrayado = getPadre().getPadre().elemento_seleccionado.subrayado_titulo;
					sizeSelect.value = getPadre().getPadre().elemento_seleccionado.size_titulo;
				}
				else
				{
					habilitarOpciones();
					
					//Barras
					colorSuperior.selectedColor = getPadre().getPadre().elemento_seleccionado.color_sup;
					colorInferior.selectedColor = getPadre().getPadre().elemento_seleccionado.color_inf;
								
					switch (instancia)
					{
						case "1": 
							rCabecera.selected = true;					
							colorSelect.selectedColor = getPadre().getPadre().elemento_seleccionado.color_titulo;
							fuente = getPadre().getPadre().elemento_seleccionado.fuente_titulo;
							alineacion = getPadre().getPadre().elemento_seleccionado.align_titulo;
							negrita = getPadre().getPadre().elemento_seleccionado.negrita_titulo;
							cursiva = getPadre().getPadre().elemento_seleccionado.cursiva_titulo;
							subrayado = getPadre().getPadre().elemento_seleccionado.subrayado_titulo;
							sizeSelect.value = getPadre().getPadre().elemento_seleccionado.size_titulo;
							break;
						case "2": 
							rTextos.selected = true;
							colorSelect.selectedColor = getPadre().getPadre().elemento_seleccionado.color_texto;
							fuente = getPadre().getPadre().elemento_seleccionado.fuente_texto;
							alineacion = getPadre().getPadre().elemento_seleccionado.align_texto;
							negrita = getPadre().getPadre().elemento_seleccionado.negrita_texto;
							cursiva = getPadre().getPadre().elemento_seleccionado.cursiva_texto;
							subrayado = getPadre().getPadre().elemento_seleccionado.subrayado_texto;
							sizeSelect.value = getPadre().getPadre().elemento_seleccionado.size_texto;
							break;
						default: break;
					}
				}
	
				var i:int = 0;
				
				//Estilo
				for (i = 0; i< comboEstilo.length; i++)
				{
					if (comboEstilo.getItemAt(i).label == getPadre().getPadre().elemento_seleccionado.estilo_rss) break;
				}
				comboEstilo.selectedIndex = i;
				
				//Fuente
				for (i = 0; i< fontList.length; i++)
				{
					if (fontList.getItemAt(i).label == fuente) break;
				}
				fontList.selectedIndex = i;
				
				//Botones negrita, cursiva, subrayado
				if (negrita)  btnBold.gotoAndStop(2);
				else btnBold.gotoAndStop(1);
				
				if (cursiva)  btnItalic.gotoAndStop(2);
				else btnItalic.gotoAndStop(1);
				
				if (subrayado)  btnUnderline.gotoAndStop(2);
				else btnUnderline.gotoAndStop(1);
				
				//Alineación
				//btnLeft.gotoAndStop(1);
				//btnCenter.gotoAndStop(1);
				//btnRight.gotoAndStop(1);
				//btnJustificar.gotoAndStop(1);
				
				/*switch (alineacion)
				{
					case "left": btnLeft.gotoAndStop(2); break;
					case "center": btnCenter.gotoAndStop(2); break;
					case "right": btnRight.gotoAndStop(2); break;
					case "justify": btnJustificar.gotoAndStop(2); break;
				}*/
			}
		}
		
		///<summary>
		///Listener que modifica los colores de fondo y la fuente de los textos
		///</summary>
		function onFontColorChange(e:Event)
		{
			if (e.currentTarget.name == "fontList") 
			{
				if (instancia == "1") getPadre().getPadre().elemento_seleccionado.fuente_titulo = e.target.selectedItem.label;
				else if (instancia == "2") getPadre().getPadre().elemento_seleccionado.fuente_texto = e.target.selectedItem.label;
			}
			else if (e.currentTarget.name == "colorSuperior") 
			{
				getPadre().getPadre().elemento_seleccionado.color_sup = e.target.selectedColor;				
			}
			else if (e.currentTarget.name == "colorInferior") 
			{
				getPadre().getPadre().elemento_seleccionado.color_inf = e.target.selectedColor;		
			}
			else 
			{
				if (instancia == "1") getPadre().getPadre().elemento_seleccionado.color_titulo = e.target.selectedColor;
				else if (instancia == "2") getPadre().getPadre().elemento_seleccionado.color_texto = e.target.selectedColor;
			}
			
			getPadre().getPadre().elemento_seleccionado.actualizarFondoRSS();
		}
		
		///<summary>
		///Listener que modifica el tamaño de la fuente de los textos
		///</summary>
		function onSizeChange(e:Event)
		{
			if (instancia == "1") getPadre().getPadre().elemento_seleccionado.size_titulo = e.target.value;
			else if (instancia == "2") getPadre().getPadre().elemento_seleccionado.size_texto = e.target.value;
		
			getPadre().getPadre().elemento_seleccionado.actualizarFondoRSS();
		}
		
		///<summary>
		///Listener que modifica el alpha de los fondos
		///</summary>
		function onAlphaChange(e:Event)
		{
			var alpha_value:Number;
			if (e.currentTarget.name == "alphaSuperior") 
			{
				alpha_value = Number(alphaSuperior.text)/100;
				getPadre().getPadre().elemento_seleccionado.alpha_superior = alpha_value;
			}
			else if (e.currentTarget.name == "alphaInferior") 
			{
				alpha_value = Number(alphaInferior.text)/100;
				getPadre().getPadre().elemento_seleccionado.alpha_inferior = alpha_value;
			}
			getPadre().getPadre().elemento_seleccionado.actualizarFondoRSS();
		}
		
		///<summary>
		///Listener que modifica el color y la fuente del elemento rss
		///</summary>
		function onEdicion(e:MouseEvent)
		{
			//Guardamos en "val" la selección del usuario
			var val:Boolean = false;
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
				case "btnBold": 
					if (instancia == "1") getPadre().getPadre().elemento_seleccionado.negrita_titulo = val;
					else if (instancia == "2") getPadre().getPadre().elemento_seleccionado.negrita_texto = val;
					break;
				case "btnItalic":  
					if (instancia == "1") getPadre().getPadre().elemento_seleccionado.cursiva_titulo = val;
					else if (instancia == "2") getPadre().getPadre().elemento_seleccionado.cursiva_texto = val;
					break;
				case "btnUnderline": 
					if (instancia == "1") getPadre().getPadre().elemento_seleccionado.subrayado_titulo = val;
					else if (instancia == "2") getPadre().getPadre().elemento_seleccionado.subrayado_texto = val;
					break;
				/*case "btnLeft": 
					if (instancia == "1") getPadre().getPadre().elemento_seleccionado.align_titulo = "left";
					else if (instancia == "2") getPadre().getPadre().elemento_seleccionado.align_texto = "left";
					break;
				case "btnCenter":  
					if (instancia == "1") getPadre().getPadre().elemento_seleccionado.align_titulo = "center";
					else if (instancia == "2") getPadre().getPadre().elemento_seleccionado.align_texto = "center";
					break;
				case "btnJustificar": 
					if (instancia == "1") getPadre().getPadre().elemento_seleccionado.align_titulo = "justify";
					else if (instancia == "2") getPadre().getPadre().elemento_seleccionado.align_texto = "justify";
					break;
				case "btnRight": 
					if (instancia == "1") getPadre().getPadre().elemento_seleccionado.align_titulo = "right";
					else if (instancia == "2") getPadre().getPadre().elemento_seleccionado.align_texto = "right";
					break;*/
				default: break;
			}
			getPadre().getPadre().elemento_seleccionado.actualizarFondoRSS();
			actualizarEditor();
		}

		///<summary>
		///Función que se encarga de deshabilitar algunas opciones para el estilo 3
		///</summary>
		public function deshabilitarOpciones()
		{
			check_imagen.enabled = false;
			rTextos.enabled = false;
			velocidadRSS.enabled = false;
			colorInferior.enabled = false;
			alphaInferior.type = TextFieldType.DYNAMIC;
			alphaInferior.text = "";
		}

		///<summary>
		///Función que se encarga volver a habilitar todos los elementos
		///</summary>
		public function habilitarOpciones()
		{
			check_imagen.enabled = true;
			rTextos.enabled = true;
			velocidadRSS.enabled = true;
			colorInferior.enabled = true;
			alphaInferior.type = TextFieldType.INPUT;
			alphaInferior.text = Math.round(100*getPadre().getPadre().elemento_seleccionado.alpha_inferior).toString();
			alphaSuperior.text = Math.round(100*getPadre().getPadre().elemento_seleccionado.alpha_superior).toString();
		}
	}
	
}
