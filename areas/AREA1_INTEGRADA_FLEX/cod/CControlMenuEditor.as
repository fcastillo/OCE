package cod
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.Font;
	import fl.controls.RadioButtonGroup;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	import flash.display.DisplayObject;
	
	import com.innovae.oce.domain.datamodel.resourceReceivedEvent;
	
	public class CControlMenuEditor extends CElementoBase
	{
		private var userFonts:Array;
		private var allFontNames:Array;
		public var instancia:String = "txtCabecera";
		//public var array_tempFondos:Array = new Array ("fondo_estilo1.jpg","fondo_estilo2.jpg");
		public var lista_estilos:Array = new Array("Ninguno","Estilo1","Estilo2","Estilo3","Estilo4","Estilo5","Estilo6");
		public var url_imagenFondo:String;
		private var fondoMenu_ID:String = "";
		
		//Fuentes embebidas
		var fontTitular1:menu1Titular1 = new menu1Titular1();
		var fontTitular2:menu1Titular2 = new menu1Titular2();
		var fontTimes:timesLTSTD = new timesLTSTD();
		var fontTriplex:triplex = new triplex();
		
		///<summary>
		///Constructor; define el padre y la lista de fuentes
		///</summary>
		public function CControlMenuEditor(aita:MovieClip) 
		{
			userFonts = new Array("Arial","Arial Black","Century",fontTitular2.fontName,fontTitular1.fontName,"Comic Sans","Courier","Courier New","Georgia","Impact","Lucida Console","Lucida Sans","Microsoft Sans Serif","Modern","Symbol","Tahoma",fontTimes.fontName,"Times New Roman","Trebuchet MS","Verdana");			

			super(aita);
		}
		
		///<summary>
		///Inicializa el panel de propiedades del elemento menu y llama a cargarListeners
		///</summary>
		override public function load():int
		{
			cargarListeners();
						
			//Rellenamos el combo de las fuentes
			allFontNames = new Array();
			fontList.addItem( { label: "" } );
			allFontNames.push("");
			
			for (var i = 0; i < userFonts.length; i++ ) 
			{
				fontList.addItem( { label: userFonts[i]} );
				allFontNames.push(userFonts[i]);
			}
			return 0;
		}

		///<summary>
		///Configura los listeners para los botones del panel
		///</summary>
		public function cargarListeners()
		{
			//PLANTILLAS
			comboEstilo.addEventListener(Event.CHANGE, aplicarEstilo);
			comboEstilo.rowCount = 5;
			
			//Radio buttons - elementos
			txtCabecera.addEventListener(MouseEvent.CLICK, onChangeInstancia); 
			txtTitulo.addEventListener(MouseEvent.CLICK, onChangeInstancia); 
			txtSubtitulo1.addEventListener(MouseEvent.CLICK, onChangeInstancia); 
			txtSubtitulo2.addEventListener(MouseEvent.CLICK, onChangeInstancia); 
			txtSubtitulo3.addEventListener(MouseEvent.CLICK, onChangeInstancia); 
			txt1.addEventListener(MouseEvent.CLICK, onChangeInstancia); 
			txt2.addEventListener(MouseEvent.CLICK, onChangeInstancia); 
			txt3.addEventListener(MouseEvent.CLICK, onChangeInstancia); 
			txtPie.addEventListener(MouseEvent.CLICK, onChangeInstancia); 
			
			//Boton invisible
			btnInvisible.addEventListener(MouseEvent.CLICK, onChangeInvisible); 
			
			//Boton Aplicar
			btnAplicar.buttonMode = true;
			btnAplicar.addEventListener(MouseEvent.CLICK, enviarTexto); 
						
			//Botones formato
			buttonBold.buttonMode = true;
			buttonBold.addEventListener(MouseEvent.CLICK, onEdicion);
			buttonItalic.buttonMode = true;
			buttonItalic.addEventListener(MouseEvent.CLICK, onEdicion);
			buttonUnderline.buttonMode = true;
			buttonUnderline.addEventListener(MouseEvent.CLICK, onEdicion);
			buttonLeft.buttonMode = true;
			buttonLeft.addEventListener(MouseEvent.CLICK, onEdicion);
			buttonCenter.buttonMode = true;
			buttonCenter.addEventListener(MouseEvent.CLICK, onEdicion);
			buttonJustify.buttonMode = true;
			buttonJustify.addEventListener(MouseEvent.CLICK, onEdicion);
			buttonRight.buttonMode = true;
			buttonRight.addEventListener(MouseEvent.CLICK, onEdicion);
			buttonBullet.buttonMode = true;
			buttonBullet.addEventListener(MouseEvent.CLICK, onEdicion);
			
			//LISTENERS PARA LA FUENTE, TAMAÑO Y COLOR
			fontList.addEventListener(Event.CHANGE, onFontColorSizeChange);
			fontList.rowCount = 5;
			sizeSelect.addEventListener(Event.CHANGE, onFontColorSizeChange);
			colorSelect.addEventListener(Event.CHANGE, onFontColorSizeChange);
			
			//LISTENERS PARA EL FONDO
			colorSelectFondo.addEventListener(Event.CHANGE, onFondoColorChange);			
			btnEliminar.addEventListener(MouseEvent.CLICK,eliminarFondo);
			btnEliminarColor.addEventListener(MouseEvent.CLICK,eliminarColorFondo);
			btnAñadir.addEventListener(MouseEvent.CLICK,añadirFondo);
			
			//Grises - (El color picker no trae grises, así que los añadimos)
			if (colorSelect.colors.indexOf(0xd3d3d3) == -1) añadirGrises();
		}

		///<summary>
		///Añade los tonos grises a los color picker
		///</summary>
		private function añadirGrises()
		{
			//Añadimos grises a los color pickers
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
			
			if (colorSelectFondo.colors.indexOf(0xd3d3d3) == -1)
			{
				colorSelectFondo.colors.push(0xd3d3d3);
				colorSelectFondo.colors.push(0xc0c0c0);
				colorSelectFondo.colors.push(0xa9a9a9);
				colorSelectFondo.colors.push(0x999999);
				colorSelectFondo.colors.push(0x808080);
				colorSelectFondo.colors.push(0x666666);
				colorSelectFondo.colors.push(0x333333);
			}
		}
		
		///<summary>
		///Guarda en la variable "instancia" el texto que está siendo editado
		///</summary>
		public function onChangeInstancia(e:MouseEvent)
		{
			instancia = e.currentTarget.name;
			actualizarEditor();
		}
		
		///<summary>
		///Cambia la propiedad "visible" del texto que está siendo editado
		///</summary>
		public function onChangeInvisible(e:MouseEvent)
		{
			var seleccionado:Boolean = e.currentTarget.selected;
			
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.control_menu != null)
				{
					getPadre().getPadre().elemento_seleccionado.control_menu.editInvisible(!seleccionado,instancia);
				}
			}
		}
		
		///<summary>
		///Guarda el texto introducido por el usuario
		///</summary>
		public function enviarTexto(e:MouseEvent)
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.control_menu != null)
				{
					getPadre().getPadre().elemento_seleccionado.control_menu.editContenido(txtInput.text.toString(),instancia);
					txtInput.text = "";
				}
			}
		}
		
		///<summary>
		///Cambia la fuente, tamaño y color del texto que está siendo editado
		///</summary>
		function onFontColorSizeChange(e:Event)
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.control_menu != null)
				{
					switch (e.currentTarget.name)
					{
						case "fontList": 
							getPadre().getPadre().elemento_seleccionado.control_menu.editFuente(e.target.selectedItem.label,instancia);
							break;
						case "sizeSelect":
							getPadre().getPadre().elemento_seleccionado.control_menu.editTamaño(e.target.value,instancia);
							break;
						case "colorSelect":
							getPadre().getPadre().elemento_seleccionado.control_menu.editColor(colorSelect.selectedColor,instancia);
							break;
					}
				}
			}
		}
		
		///<summary>
		///Aplica al menú la plantilla seleccionada
		///</summary>
		function aplicarEstilo (e:Event)
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.control_menu != null)
				{
					getPadre().getPadre().elemento_seleccionado.control_menu.borrarFondo();
					getPadre().getPadre().elemento_seleccionado.control_menu.editEstilo(e.target.selectedItem.label);
					getPadre().getPadre().elemento_seleccionado.control_menu.setNombreEstilo(e.target.selectedItem.label);
					
					if (e.target.selectedItem.label != "Ninguno") 
					{
						getPadre().getPadre().elemento_seleccionado.control_menu.setExisteFondo(true);
						getPadre().getPadre().elemento_seleccionado.control_menu.setHayColorFondo(false);
					}
					else getPadre().getPadre().elemento_seleccionado.control_menu.setExisteFondo(false);
					
					actualizarEditor();
				}
			}
		}
		
		///<summary>
		///Edición del texto seleccionado por el usuario
		///</summary>
		function onEdicion(e:MouseEvent)
		{
			var val:Boolean = false;
			
			//BOTONES DE ALINEACIÓN - RESETEAMOS TODOS A UNSELECTED
			buttonLeft.gotoAndStop(1);
			buttonCenter.gotoAndStop(1);
			buttonRight.gotoAndStop(1);
			buttonJustify.gotoAndStop(1);
			
			if(e.currentTarget.currentFrame == 2) 
			{
				e.currentTarget.gotoAndStop(1); //Des-seleccionamos el botón
				val = false;
			}
			else 
			{
				e.currentTarget.gotoAndStop(2); //Seleccionamos el botón
				val = true;
			}
			
			//Actualizamos todos los botones según lo elegido por el usuario
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.control_menu != null)
				{
					switch(e.currentTarget.name)
					{
						case "buttonBold": getPadre().getPadre().elemento_seleccionado.control_menu.editNegrita(val,instancia); break;
						case "buttonItalic": getPadre().getPadre().elemento_seleccionado.control_menu.editCursiva(val,instancia); break;
						case "buttonUnderline": getPadre().getPadre().elemento_seleccionado.control_menu.editSubrayado(val,instancia); break;
						case "buttonLeft": getPadre().getPadre().elemento_seleccionado.control_menu.editAlineacion("left",instancia); break;
						case "buttonCenter": getPadre().getPadre().elemento_seleccionado.control_menu.editAlineacion("center",instancia); break;
						case "buttonJustify": getPadre().getPadre().elemento_seleccionado.control_menu.editAlineacion("justify",instancia); break;
						case "buttonRight": getPadre().getPadre().elemento_seleccionado.control_menu.editAlineacion("right",instancia); break;
						case "buttonBullet": getPadre().getPadre().elemento_seleccionado.control_menu.editViñetas(val,instancia); break;
						default: break;
					}
				}
			}
		}
		
		//**************************************************FONDO***********************************************************//		
		///<summary>
		///Elimina el fondo del menú
		///</summary>
		function eliminarFondo(e:MouseEvent)
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.control_menu != null)
				{
					getPadre().getPadre().elemento_seleccionado.control_menu.setExisteFondo(false);
					getPadre().getPadre().elemento_seleccionado.fondoMenu_ID = "";
					getPadre().getPadre().elemento_seleccionado.control_menu.borrarFondo();
				}
			}
		}

		///<summary>
		///Elimina el color de fondo del menú
		///</summary>
		function eliminarColorFondo(e:MouseEvent)
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.control_menu != null)
				{
					getPadre().getPadre().elemento_seleccionado.control_menu.borrarColorFondo();	
					colorSelectFondo.selectedColor = 0xffffff;
				}
			}
		}
		
		///<summary>
		///Llama a la librería de recursos para que el usuario elija una imagen de fondo
		///</summary>
		function añadirFondo (e:MouseEvent)
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.control_menu != null)
				{
					getPadre().getPadre().elemento_seleccionado.fondoMenu_ID = "";
					getPadre().getPadre().elemento_seleccionado.control_menu.borrarFondo();
				}
			}
						
			//Imagen -> 1
			if(url_imagenFondo == null)
			{
				getPadre().getPadre().getResourceURLFlash(1,"-1");
			}
			else
			{
				getPadre().getPadre().getResourceURLFlash(1,url_imagenFondo);
			}
			getPadre().getPadre().addEventListener(resourceReceivedEvent.RESOURCE_RECEIVED,loadDataFromResource);
		}
		
		///<summary>
		///Event listener que recibe los datos de la imagen de fondo
		///</summary>
		public function loadDataFromResource(e:resourceReceivedEvent):void
		{			
			removeEventListener(resourceReceivedEvent.RESOURCE_RECEIVED, loadDataFromResource);
			
			//Guardamos la url y el ID
			url_imagenFondo = e.resource.url;
			this.fondoMenu_ID = e.resource.id;
						
			//Cargamos la imagen
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleImage1);
			loader.load(new URLRequest(url_imagenFondo));
		}
		
		///<summary>
		///Event listener que recibe la imagen de fondo
		///</summary>
		function handleImage1 (e:Event)
		{
			var loaderInfo:LoaderInfo = e.target as LoaderInfo;
			var dispObj:DisplayObject = loaderInfo.content;
			dispObj.width = 378;
			dispObj.height = 800;
			var imagen:MovieClip = new MovieClip();
			imagen.addChild(dispObj)
												 
			//Editamos el control para que se vea el fondo 
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.control_menu != null)
				{
					getPadre().getPadre().elemento_seleccionado.fondoMenu_ID = this.fondoMenu_ID;
					getPadre().getPadre().elemento_seleccionado.control_menu.editFondo(imagen,url_imagenFondo);
				}
			}
		}
		
		///<summary>
		///Aplica un color al fondo del menú
		///</summary>
		function onFondoColorChange (e:Event)
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.control_menu != null)
				{
					getPadre().getPadre().elemento_seleccionado.control_menu.editColorFondo(colorSelectFondo.selectedColor);
					getPadre().getPadre().elemento_seleccionado.control_menu.setUrlFondo("");
					getPadre().getPadre().elemento_seleccionado.fondoMenu_ID = "";
					getPadre().getPadre().elemento_seleccionado.control_menu.setExisteFondo(false);
				}
			}
		}
		//*************************************************************************************************************//
		
		//*********************************************Actualizar editor*************************************************//
		///<summary>
		///Actualiza el estado de los botones del editor según el texto seleccionado
		///</summary>
		public function actualizarEditor ()
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.control_menu != null)
				{
					var formato:TextFormat = getPadre().getPadre().elemento_seleccionado.control_menu.getFormatoTexto(instancia);
					var nombre_estilo:String = getPadre().getPadre().elemento_seleccionado.control_menu.getNombreEstilo();
					
					//FONDO
					colorSelectFondo.selectedColor = getPadre().getPadre().elemento_seleccionado.control_menu.getColorFondo();
					
					// BOTONES NEGRITA/CURSIVA/SUBRAYADO
					formato.bold ? buttonBold.gotoAndStop(2) : buttonBold.gotoAndStop(1);
					formato.italic ? buttonItalic.gotoAndStop(2) : buttonItalic.gotoAndStop(1);
					formato.underline ? buttonUnderline.gotoAndStop(2) : buttonUnderline.gotoAndStop(1);
					
					// BOTONES ALINEACIÓN
					formato.align == "left" ? buttonLeft.gotoAndStop(2) : buttonLeft.gotoAndStop(1);
					formato.align == "center" ? buttonCenter.gotoAndStop(2) : buttonCenter.gotoAndStop(1);
					formato.align == "right" ? buttonRight.gotoAndStop(2) : buttonRight.gotoAndStop(1);
					formato.align == TextFormatAlign.JUSTIFY ? buttonJustify.gotoAndStop(2) : buttonJustify.gotoAndStop(1);
					
					// COLOR / FUENTE / TAMAÑO
					colorSelect.selectedColor = uint(formato.color);
					formato.font ? fontList.selectedIndex = allFontNames.indexOf(formato.font) : fontList.selectedIndex = -1;
					sizeSelect.value = int(formato.size);
										
					//VISIBILIDAD
					var seleccionado:Boolean = getPadre().getPadre().elemento_seleccionado.control_menu.getInvisible(instancia);
					if (seleccionado) btnInvisible.selected = true; //Si seleccionado es true es que no es visible
					else btnInvisible.selected = false;
					
					//ESTILO
					for (var i:int = 0; i< lista_estilos.length; i++)
					{
						if (lista_estilos[i] == nombre_estilo) break;
					}
					comboEstilo.selectedIndex = i;
				}
			}
			
		}
		//*************************************************************************************************************//
	}
	
}
