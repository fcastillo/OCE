package cod
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.Font;
	import fl.controls.RadioButtonGroup;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import fl.data.DataProvider;
	
	public class CPanelTiempo_extendido extends CElementoBase
	{
		//VARIABLES
		public var userFonts:Array = new Array("Arial","Arial Black","Comic Sans","Courier","Courier New","Georgia","Impact","Lucida Console","Lucida Sans","Microsoft Sans Serif","Modern","Symbol","Tahoma","Times New Roman","Trebuchet MS","Verdana");

		var country_list:Array;
		var city_list:Array;
		var allFontNames:Array;
		var pais:String = "España";
		var codigo_ciudad:String = "SPXX0087";
		var dia:String = "Hoy";
		var estilo:String = "cartoon";
		var instancia:int = 1;
		var posicion:String = "Arriba";
		var formato_fecha:String = "dd/mm";
		
		//Variables para guardar las características de los textos
		var val_negrita_fecha:Boolean = true;
		var val_cursiva_fecha:Boolean = false;
		var val_subrayado_fecha:Boolean = false;
		var val_color_fecha:uint = 0x5D5D5D;
		var val_fuente_fecha:String = "Arial";
		var val_negrita_temp:Boolean = true;
		var val_cursiva_temp:Boolean = false;
		var val_subrayado_temp:Boolean = false;
		var val_color_temp:uint = 0x5D5D5D;
		var val_fuente_temp:String = "Arial";
		var estilo_dia_changed:Boolean = false;
		
		///<summary>
		///Constructor 
		///		-> Define el padre
		///		-> Inicializa los arrays para guardar los estados y las ciudades
		///		-> Llama a las funciones que llenan los combos
		///</summary>
		public function CPanelTiempo_extendido(aita:MovieClip) 
		{
			super(aita);
			
			city_list = new Array();
			country_list = new Array();
			cargarArrayPaises();
			cargarArrayCiudades("España");
		}
		
		///<summary>
		///Carga el panel de propiedades del elemento tiempo
		////	-> Llama a las funciones que activan los event listeners de los componentes
		///		-> Llena el combo con las fuentes disponibles
		///</summary>
		override public function load():int
		{
			this.x = getXpos();
			this.y = getYpos();
			
			activarListeners();
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
			//Posicion textos
			comboPosicion.addEventListener(Event.CHANGE, onChangePosicion);
			comboPosicion.rowCount = 2;
			
			//Formato fecha (dd/mm o mm/dd para países con formato anglosajón)
			comboFormato.addEventListener(Event.CHANGE, onChangeFormato);
			comboFormato.rowCount = 2;
			
			// Componentes
			btnFecha.addEventListener(MouseEvent.CLICK,onChangeInstancia);
			btnTemp.addEventListener(MouseEvent.CLICK,onChangeInstancia);
			fontList.addEventListener(Event.CHANGE, onFontColorChange);
			colorSelect.addEventListener(Event.CHANGE, onFontColorChange);
						
			// Botones
			btnBold.buttonMode = true;
			btnBold.addEventListener(MouseEvent.CLICK, onEdicion);
			//btnItalic.buttonMode = true;
			//btnItalic.addEventListener(MouseEvent.CLICK, onEdicion);
			btnUnderline.buttonMode = true;
			btnUnderline.addEventListener(MouseEvent.CLICK, onEdicion);
						
			cartoon.gotoAndStop(2);
		}
		
		///<summary>
		///Listener que controla la disposición de los elementos
		///		-> pos = "Arriba",; el texto está encima de la imagen -> tiempo_vertical.swf
		///		-> pos = "Derecha"; el texto está a la derecha de la imagen -> tiempo_horizontal.swf
		///</summary>
		function onChangePosicion(e:Event)
		{
			var pos:String = e.target.selectedItem.label;
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.lector_tiempo != null)
				{		
					getPadre().getPadre().elemento_seleccionado.lector_tiempo.editPosicion(pos);
					getPadre().getPadre().elemento_seleccionado.cambiarTiempoDeTipo(pos);
					getPadre().getPadre().elemento_seleccionado.ajustarBotonesAcontenido(); //Ajustamos los controladores de tamaño (f0-f8)
				}
			}
		}
		
		///<summary>
		///Listener que controla el formato de la fecha
		///		-> dd/mm o mm/dd para países con formato de fecha anglosajón
		///		-> NOTA! Cuando accedemos a getPadre().getPadre().elemento_seleccionado.lector_tiempo
		///		   para que cambie el formato de la fecha dentro del swf, perdemos el formato del texto (color, negrita, fuente, etc.)
		///		-> Es por eso que cogemos los valores guardados en elemento_seleccionado para volver a crear
		///		   los formatos y actualizar los textos
		///</summary>
		function onChangeFormato(e:Event)
		{
			var formato:String = e.target.selectedItem.label;
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.lector_tiempo != null)
				{		
					formato_fecha = formato;
					getPadre().getPadre().elemento_seleccionado.lector_tiempo.editFormatoFecha(formato);
					getPadre().getPadre().elemento_seleccionado.setFormatoFecha(formato);
										
					//Creamos los formatos de nuevo para actualizar los textos
					val_negrita_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getNegritaFecha();
					val_cursiva_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getCursivaFecha();
					val_subrayado_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getSubrayadoFecha();
					val_color_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getColorFecha();
					val_fuente_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFuenteFecha();
					
					val_negrita_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getNegritaTemp();
					val_cursiva_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getCursivaTemp();
					val_subrayado_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getSubrayadoTemp();
					val_color_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getColorTemp();
					val_fuente_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFuenteTemp();
					
					var f_fecha:TextFormat = new TextFormat(val_fuente_fecha,17,val_color_fecha,val_negrita_fecha,val_cursiva_fecha,val_subrayado_fecha,null,null,"center",null,null,null,null);
					var f_temp:TextFormat = new TextFormat(val_fuente_temp,17,val_color_temp,val_negrita_temp,val_cursiva_temp,val_subrayado_temp,null,null,"center",null,null,null,null);
					getPadre().getPadre().elemento_seleccionado.lector_tiempo.actualizarFormatoTextos(f_fecha,f_temp);
				}
			}
		}
		
		///<summary>
		///Listener que controla si estamos editando la fecha o la temperatura
		///</summary>
		function onChangeInstancia(e:Event)
		{
			if (e.currentTarget.name == "btnFecha") instancia = 1;
			else if (e.currentTarget.name == "btnTemp") instancia = 2;
			actualizarEditor();
		}

		///<summary>
		///Listener que modifica el color y la fuente del elemento texto
		///</summary>
		function onFontColorChange(e:Event)
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.lector_tiempo != null)
				{					
					if (e.currentTarget.name == "fontList") 
					{
						if (instancia == 1) val_fuente_fecha = e.target.selectedItem.label;
						else val_fuente_temp = e.target.selectedItem.label;
						getPadre().getPadre().elemento_seleccionado.lector_tiempo.editFuente(instancia,e.target.selectedItem.label);
					}
					else 
					{
						if (instancia == 1) val_color_fecha = colorSelect.selectedColor;
						else val_color_temp = colorSelect.selectedColor;
						
						getPadre().getPadre().elemento_seleccionado.lector_tiempo.editColor(instancia,colorSelect.selectedColor);
					}
					actualizarTrasCambioDeEstilo();
				}
			}
		}
		
		///<summary>
		///Listener que modifica las propiedades negrita/cursiva/subrayado del elemento texto
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
			
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.lector_tiempo != null)
				{
					//Botones
					switch(e.currentTarget.name)
					{
						case "btnBold": 
							if (instancia == 1) val_negrita_fecha = val;
							else val_negrita_temp = val;
							getPadre().getPadre().elemento_seleccionado.lector_tiempo.editNegrita(instancia,val); 
							break;
						case "btnItalic": 
							if (instancia == 1) val_cursiva_fecha = val;
							else val_cursiva_temp = val;
							getPadre().getPadre().elemento_seleccionado.lector_tiempo.editCursiva(instancia,val); 
							break;
						case "btnUnderline": 
							if (instancia == 1) val_subrayado_fecha = val;
							else val_subrayado_temp = val;
							getPadre().getPadre().elemento_seleccionado.lector_tiempo.editSubrayado(instancia,val); 
							break;
						default: break;
					}
					actualizarTrasCambioDeEstilo();
				}
			}
		}
		
		///<summary>
		///Actualiza el estado del panel según el elemento tiempo pulsado
		///</summary>
		public function actualizarEditor()
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				var i:int = 0;
				if (getPadre().getPadre().elemento_seleccionado.lector_tiempo != null)
				{
					var valor_negrita:Boolean;
					var valor_cursiva:Boolean;
					var valor_subrayado:Boolean;
					var valor_color:uint;
					var valor_fuente:String;
										
					if (btnFecha.selected)
					{
						valor_negrita = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getNegritaFecha();
						valor_cursiva = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getCursivaFecha();
						valor_subrayado = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getSubrayadoFecha();
						valor_color = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getColorFecha();
						valor_fuente = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFuenteFecha();
						val_negrita_fecha = valor_negrita;
						val_cursiva_fecha = valor_cursiva;
						val_subrayado_fecha = valor_subrayado;
						val_color_fecha = valor_color;
						val_fuente_fecha = valor_fuente;
						
						//Guardamos los valores de la temperatura tambien
						val_negrita_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getNegritaTemp();
						val_cursiva_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getCursivaTemp();
						val_subrayado_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getSubrayadoTemp();
						val_color_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getColorTemp();
						val_fuente_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFuenteTemp();
					}
					else if (btnTemp.selected)
					{
						valor_negrita = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getNegritaTemp();
						valor_cursiva = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getCursivaTemp();
						valor_subrayado = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getSubrayadoTemp();
						valor_color = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getColorTemp();
						valor_fuente = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFuenteTemp();
						val_negrita_temp = valor_negrita;
						val_cursiva_temp = valor_cursiva;
						val_subrayado_temp = valor_subrayado;
						val_color_temp = valor_color;
						val_fuente_temp = valor_fuente;
						
						//Guardamos valores de la fecha tambien
						val_negrita_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getNegritaFecha();
						val_cursiva_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getCursivaFecha();
						val_subrayado_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getSubrayadoFecha();
						val_color_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getColorFecha();
						val_fuente_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFuenteFecha();
					}
										
					//FUENTE
					for (i = 0; i< fontList.length; i++)
					{
						if (fontList.getItemAt(i).label == valor_fuente) break;
					}
					fontList.selectedIndex = i;
					fontList.rowCount = 5;
										
					//COLOR
					colorSelect.selectedColor = valor_color;
					
					//NEGRITA - CURSIVA - SUBRAYADO
					if (valor_negrita)  btnBold.gotoAndStop(2);
					else btnBold.gotoAndStop(1);
					
					if (valor_cursiva)  btnItalic.gotoAndStop(2);
					else btnItalic.gotoAndStop(1);
					
					if (valor_subrayado)  btnUnderline.gotoAndStop(2);
					else btnUnderline.gotoAndStop(1);
					
					//COMBO DÍAS
					var auxNombre:String = getPadre().getPadre().elemento_seleccionado.dia;
					dia = auxNombre;
					switch(auxNombre)
					{
						case "Hoy": comboDias.selectedIndex = 0; break;
						case "Mañana": comboDias.selectedIndex = 1; break;
						case "Pasado": comboDias.selectedIndex = 2; break;
						case "Siguiente": comboDias.selectedIndex = 3;	break;
					}
					
					//COMBO PAÍS
					pais = getPadre().getPadre().elemento_seleccionado.pais;
					for (i = 0; i< country_list.length; i++)
					{
						if (country_list[i].value == getPadre().getPadre().elemento_seleccionado.pais) break;
					}
					comboPaises.selectedIndex = i;
					comboPaises.rowCount = 5;	
					cargarArrayCiudades(pais);
										
					//CODIGO CIUDAD
					codigo_ciudad = getPadre().getPadre().elemento_seleccionado.cod_ciudad;
					for (i = 0; i< city_list.length; i++)
					{
						if (city_list[i].value == getPadre().getPadre().elemento_seleccionado.cod_ciudad) break;
					}
					comboCiudades.selectedIndex = i;
					comboCiudades.rowCount = 5;	
					
					//POSICIÓN TEXTOS
					posicion = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getPosicion();
					if (getPadre().getPadre().elemento_seleccionado.lector_tiempo.getPosicion() == "Arriba") comboPosicion.selectedIndex = 0;
					else comboPosicion.selectedIndex = 1;
					
					//FORMATO FECHA dd/mm o mm/dd
					formato_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFormatoFecha();
					if (getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFormatoFecha() == "dd/mm") comboFormato.selectedIndex = 0;
					else comboFormato.selectedIndex = 1;
					
					//ESTILO
					cartoon.gotoAndStop(1);
					simple.gotoAndStop(1);
					clasico.gotoAndStop(1);
					estilo = getPadre().getPadre().elemento_seleccionado.estilo_tiempo;
					switch(getPadre().getPadre().elemento_seleccionado.estilo_tiempo)
					{
						case "cartoon": cartoon.gotoAndStop(2); break;
						case "simple": simple.gotoAndStop(2); break;
						case "clasico": clasico.gotoAndStop(2); break;
					}
				}
			}
		}
		
		///<summary>
		///Activa los listeners en los botones y check boxes
		///</summary>
		private function activarListeners():void
		{
			//Combo países
			comboPaises.dataProvider = new DataProvider(country_list);
			comboPaises.addEventListener(Event.CHANGE, onChangePais);
			comboPaises.selectedIndex = 5;
			comboPaises.rowCount = 5;
			
			//Combo ciudades
			comboCiudades.dataProvider = new DataProvider(city_list);
			comboCiudades.addEventListener(Event.CHANGE, onChangeCiudad);
			comboCiudades.rowCount = 5;
			
			//Combo día
			comboDias.addEventListener(Event.CHANGE, onChangeDia);
			comboDias.rowCount = 5;
			
			//Estilos
			cartoon.addEventListener(MouseEvent.CLICK,changeEstilo);
			simple.addEventListener(MouseEvent.CLICK,changeEstilo);
			clasico.addEventListener(MouseEvent.CLICK,changeEstilo);
		}
		
		///<summary>
		///Controla el combo de los paises
		///</summary>
		public function onChangePais(e:Event)
		{
			pais = comboPaises.selectedItem.value;
			cargarArrayCiudades(pais);
			
			if ((getPadre().getPadre().elemento_seleccionado != null) && (getPadre().getPadre().elemento_seleccionado.lector_tiempo != null))
			{
				getPadre().getPadre().elemento_seleccionado.pais = pais;
				comboCiudades.selectedIndex = 0;
				codigo_ciudad = comboCiudades.selectedItem.value;
				actualizarTrasChangeCiudad();
			}
		}
		
		///<summary>
		///Controla el combo de las ciudades
		///</summary>
		public function onChangeCiudad(e:Event)
		{
			codigo_ciudad = comboCiudades.selectedItem.value;
			actualizarTrasChangeCiudad();
		}
		
		///<summary>
		///Actualiza el control tras cambiar la ciudad
		///</summary>
		public function actualizarTrasChangeCiudad()
		{
			if ((getPadre().getPadre().elemento_seleccionado != null) && (getPadre().getPadre().elemento_seleccionado.lector_tiempo != null))
			{
				estilo_dia_changed = true;
				posicion = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getPosicion();
				formato_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFormatoFecha();
				val_negrita_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getNegritaFecha();
				val_cursiva_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getCursivaFecha();
				val_subrayado_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getSubrayadoFecha();
				val_color_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getColorFecha();
				val_fuente_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFuenteFecha();
				
				val_negrita_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getNegritaTemp();
				val_cursiva_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getCursivaTemp();
				val_subrayado_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getSubrayadoTemp();
				val_color_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getColorTemp();
				val_fuente_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFuenteTemp();
				
				for (var i:int = 0; i< getPadre().getPadre().elemento_seleccionado.datos_elemento.numChildren; i++)
				{
					var nombre:String = getPadre().getPadre().elemento_seleccionado.datos_elemento.getChildAt(i);
					var nombre2:String = getPadre().getPadre().elemento_seleccionado.datos_elemento.getChildAt(i).name;
					
					//Borramos el contenido, ya que tenemos que volver a cargar el swf con la nueva ciudad
					if ((nombre.indexOf("MainTimeline") != -1) || (nombre2 == "datos_elemento"))
					{
						getPadre().getPadre().elemento_seleccionado.datos_elemento.removeChildAt(i);
						i = 0;
					}
				}
				
				getPadre().getPadre().elemento_seleccionado.cargarTiempo(dia,codigo_ciudad,estilo);
			}
		}
		
		///<summary>
		///Controla el combo del día
		///</summary>
		public function onChangeDia(e:Event)
		{
			dia = comboDias.selectedItem.data;
			if ((getPadre().getPadre().elemento_seleccionado != null) && (getPadre().getPadre().elemento_seleccionado.lector_tiempo != null))
			{
				estilo_dia_changed = true;
				posicion = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getPosicion();
				formato_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFormatoFecha();
				val_negrita_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getNegritaFecha();
				val_cursiva_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getCursivaFecha();
				val_subrayado_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getSubrayadoFecha();
				val_color_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getColorFecha();
				val_fuente_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFuenteFecha();
				
				val_negrita_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getNegritaTemp();
				val_cursiva_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getCursivaTemp();
				val_subrayado_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getSubrayadoTemp();
				val_color_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getColorTemp();
				val_fuente_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFuenteTemp();
					
				for (var i:int = 0; i< getPadre().getPadre().elemento_seleccionado.datos_elemento.numChildren; i++)
				{
					var nombre:String = getPadre().getPadre().elemento_seleccionado.datos_elemento.getChildAt(i);
					var nombre2:String = getPadre().getPadre().elemento_seleccionado.datos_elemento.getChildAt(i).name;
					
					//Borramos el contenido, ya que tenemos que volver a cargar el swf con el nuevo día
					if ((nombre.indexOf("MainTimeline") != -1) || (nombre2 == "datos_elemento"))
					{
						getPadre().getPadre().elemento_seleccionado.datos_elemento.removeChildAt(i);
						i = 0;
					}
				}
				trace("[CPanelTiempo_extendido] - onChangeDia() -> elemento_seleccionado="+getPadre().getPadre().elemento_seleccionado);
				getPadre().getPadre().elemento_seleccionado.cargarTiempo(dia,codigo_ciudad,estilo);
			}
		}
		
		///<summary>
		///Cambia el "estilo" del elemento tiempo
		///</summary>
		public function changeEstilo (e:MouseEvent)
		{
			if (e.currentTarget.currentFrame == 1)
			{
				cartoon.gotoAndStop(1);
				simple.gotoAndStop(1);
				clasico.gotoAndStop(1);
				e.currentTarget.gotoAndStop(2);
				estilo = e.currentTarget.name;
								
				if ((getPadre().getPadre().elemento_seleccionado != null) && (getPadre().getPadre().elemento_seleccionado.lector_tiempo != null))
				{
					estilo_dia_changed = true;
					posicion = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getPosicion();
					formato_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFormatoFecha();
					val_negrita_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getNegritaFecha();
					val_cursiva_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getCursivaFecha();
					val_subrayado_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getSubrayadoFecha();
					val_color_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getColorFecha();
					val_fuente_fecha = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFuenteFecha();
					
					val_negrita_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getNegritaTemp();
					val_cursiva_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getCursivaTemp();
					val_subrayado_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getSubrayadoTemp();
					val_color_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getColorTemp();
					val_fuente_temp = getPadre().getPadre().elemento_seleccionado.lector_tiempo.getFuenteTemp();
										
					for (var i:int = 0; i< getPadre().getPadre().elemento_seleccionado.datos_elemento.numChildren; i++)
					{
						var nombre:String = getPadre().getPadre().elemento_seleccionado.datos_elemento.getChildAt(i);
						var nombre2:String = getPadre().getPadre().elemento_seleccionado.datos_elemento.getChildAt(i).name;
					
						//Borramos el contenido, ya que tenemos que volver a cargar el swf con el nuevo estilo
						if ((nombre.indexOf("MainTimeline") != -1) || (nombre2 == "datos_elemento"))
						{
							getPadre().getPadre().elemento_seleccionado.datos_elemento.removeChildAt(i);
							i = 0;
						}
					}
					getPadre().getPadre().elemento_seleccionado.cargarTiempo(getPadre().getPadre().elemento_seleccionado.dia,getPadre().getPadre().elemento_seleccionado.cod_ciudad,estilo);
				}
			}
		}
		
		///<summary>
		///Actualiza el editor y el elemento tras cambiar de estilo
		///</summary>
		public function actualizarTrasCambioDeEstilo()
		{		
			//Creamos formatos
			var f_fecha:TextFormat = new TextFormat(val_fuente_fecha,17,val_color_fecha,val_negrita_fecha,val_cursiva_fecha,val_subrayado_fecha,null,null,"center",null,null,null,null);
			var f_temp:TextFormat = new TextFormat(val_fuente_temp,17,val_color_temp,val_negrita_temp,val_cursiva_temp,val_subrayado_temp,null,null,"center",null,null,null,null);
			
			//Actualizamos editor y elemento
			getPadre().getPadre().elemento_seleccionado.lector_tiempo.editNegrita(1,val_negrita_fecha);
			getPadre().getPadre().elemento_seleccionado.lector_tiempo.editCursiva(1,val_cursiva_fecha);
			getPadre().getPadre().elemento_seleccionado.lector_tiempo.editSubrayado(1,val_subrayado_fecha);
			getPadre().getPadre().elemento_seleccionado.lector_tiempo.editColor(1,val_color_fecha);
			getPadre().getPadre().elemento_seleccionado.lector_tiempo.editFuente(1,val_fuente_fecha);
			getPadre().getPadre().elemento_seleccionado.lector_tiempo.editNegrita(2,val_negrita_temp);
			getPadre().getPadre().elemento_seleccionado.lector_tiempo.editCursiva(2,val_cursiva_temp);
			getPadre().getPadre().elemento_seleccionado.lector_tiempo.editSubrayado(2,val_subrayado_temp);
			getPadre().getPadre().elemento_seleccionado.lector_tiempo.editColor(2,val_color_temp);
			getPadre().getPadre().elemento_seleccionado.lector_tiempo.editFuente(2,val_fuente_temp);
			getPadre().getPadre().elemento_seleccionado.lector_tiempo.editPosicion(posicion);
			getPadre().getPadre().elemento_seleccionado.lector_tiempo.editFormatoFecha(formato_fecha);
			getPadre().getPadre().elemento_seleccionado.lector_tiempo.actualizarFormatoTextos(f_fecha,f_temp);
			estilo_dia_changed = false;
			actualizarEditor();
		}
		
		/******************************************** ARRAY PAISES/CIUDADES ******************************************/
		///<summary>
		///Función que llena el array de países
		///</summary>
		private function cargarArrayPaises()
		{
			country_list.push({label:"Andorra",value:"Andorra"});
			country_list.push({label:"Alemania",value:"Alemania"});
			country_list.push({label:"Dinamarca",value:"Dinamarca"});
			country_list.push({label:"Eslovaquia",value:"Eslovaquia"});
			country_list.push({label:"Eslovenia",value:"Eslovenia"});
			country_list.push({label:"España",value:"España"});
			country_list.push({label:"Estonia",value:"Estonia"});
			country_list.push({label:"Finlandia",value:"Finlandia"});
			country_list.push({label:"Francia",value:"Francia"});
			country_list.push({label:"Gibraltar",value:"Gibraltar"});
			country_list.push({label:"Grecia",value:"Grecia"});
			country_list.push({label:"Hungría",value:"Hungría"});
			country_list.push({label:"Irlanda",value:"Irlanda"});
			country_list.push({label:"Islandia",value:"Islandia"});
			country_list.push({label:"Italia",value:"Italia"});
			country_list.push({label:"Letonia",value:"Letonia"});
			country_list.push({label:"Liechtenstein",value:"Liechtenstein"});
			country_list.push({label:"Lituania",value:"Lituania"});
			country_list.push({label:"Luxemburgo",value:"Luxemburgo"});
			country_list.push({label:"Macedonia",value:"Macedonia"});
			country_list.push({label:"Malta",value:"Malta"});
			country_list.push({label:"Moldavia",value:"Moldavia"});
			country_list.push({label:"Mónaco",value:"Mónaco"});
			country_list.push({label:"Montenegro",value:"Montenegro"});
			country_list.push({label:"Noruega",value:"Noruega"});
			country_list.push({label:"Países Bajos",value:"Países Bajos"});
			country_list.push({label:"Polonia",value:"Polonia"});
			country_list.push({label:"Portugal",value:"Portugal"});
			country_list.push({label:"Reino Unido",value:"Reino Unido"});
			country_list.push({label:"Rumania",value:"Rumania"});
			country_list.push({label:"San Marino",value:"San Marino"});
			country_list.push({label:"Serbia",value:"Serbia"});
			country_list.push({label:"Suecia",value:"Suecia"});
			country_list.push({label:"Suiza",value:"Suiza"});
			country_list.push({label:"Ucrania",value:"Ucrania"});
			country_list.push({label:"Vaticano, Ciudad del",value:"Vaticano"});
			
		}
		
		///<summary>
		///Función que llena el array de ciudades según el país elegido
		///</summary>
		private function cargarArrayCiudades(pais:String)
		{
			city_list = new Array();
			switch(pais)
			{
				case "España":
					city_list.push({label:"Agreda",value:"SPXX0087"});
					city_list.push({label:"Agudo",value:"SPXX0253"});
					city_list.push({label:"Albacete/Los Llanos",value:"SPXX0197"});
					city_list.push({label:"Alcala de Guadaira",value:"SPXX0001"});
					city_list.push({label:"Alcala de Henares",value:"SPXX0002"});
					city_list.push({label:"Alcazar de San Juan",value:"SPXX0003"});
					city_list.push({label:"Alcira",value:"SPXX0004"});
					city_list.push({label:"Alcobendas",value:"SPXX0005"});
					city_list.push({label:"Alcoi",value:"SPXX0133"});
					city_list.push({label:"Alcorcón",value:"SPXX0006"});
					city_list.push({label:"Alcudia",value:"SPXX0007"});
					city_list.push({label:"Algeciras",value:"SPXX0088"});
					city_list.push({label:"Alicante",value:"SPXX0008"});
					city_list.push({label:"Almansa",value:"SPXX0261"});
					city_list.push({label:"Almería",value:"SPXX0009"});
					city_list.push({label:"Andújar",value:"SPXX0250"});
					city_list.push({label:"Antequera",value:"SPXX0089"});
					city_list.push({label:"Aracena",value:"SPXX0090"});
					city_list.push({label:"Aranjuez",value:"SPXX0010"});
					city_list.push({label:"Arenas de San Pedro",value:"SPXX0135"});
					city_list.push({label:"Arizgoiti",value:"SPXX0011"});
					city_list.push({label:"Armilla",value:"SPXX0091"});
					city_list.push({label:"Arrecife",value:"SPXX0012"});
					city_list.push({label:"Asturias/Aviles",value:"SPXX0202"});
					city_list.push({label:"Ávila",value:"SPXX0231"});
					city_list.push({label:"Ayamonte",value:"SPXX0092"});
					city_list.push({label:"Badajoz",value:"SPXX0203"});
					city_list.push({label:"Badajoz/Talavera La Real",value:"SPXX0198"});
					city_list.push({label:"Badalona",value:"SPXX0013"});
					city_list.push({label:"Bailén",value:"SPXX0251"});
					city_list.push({label:"Baracaldo",value:"SPXX0014"});
					city_list.push({label:"Barcelona",value:"SPXX0015"});
					city_list.push({label:"Baza",value:"SPXX0266"});
					city_list.push({label:"Benasque",value:"SPXX0093"});
					city_list.push({label:"Benidorm",value:"SPXX0165"});
					city_list.push({label:"Bilbao",value:"SPXX0016"});
					city_list.push({label:"Blanes",value:"SPXX0137"});
					city_list.push({label:"Boi Taull",value:"SPXX0236"});
					city_list.push({label:"Buitrago",value:"SPXX0094"});
					city_list.push({label:"Burgos",value:"SPXX0193"});
					city_list.push({label:"Cáceres",value:"SPXX0204"});
					city_list.push({label:"Cádiz",value:"SPXX0017"});
					city_list.push({label:"Calahorra",value:"SPXX0138"});
					city_list.push({label:"Calamocha",value:"SPXX0205"});
					city_list.push({label:"Calatayud",value:"SPXX0095"});
					city_list.push({label:"Camas",value:"SPXX0018"});
					city_list.push({label:"Cartagena",value:"SPXX0019"});
					city_list.push({label:"Castelldefels",value:"SPXX0020"});
					city_list.push({label:"Castellón de la Plana",value:"SPXX0021"});
					city_list.push({label:"Cazalla de la Sierra",value:"SPXX0139"});
					city_list.push({label:"Cazorla",value:"SPXX0098"});
					city_list.push({label:"Ceuta",value:"SPXX0022"});
					city_list.push({label:"Cieza",value:"SPXX0265"});
					city_list.push({label:"Ciudad Real",value:"SPXX0023"});
					city_list.push({label:"Ciudad Rodrigo",value:"SPXX0140"});
					city_list.push({label:"Consuegra",value:"SPXX0254"});
					city_list.push({label:"Córdoba",value:"SPXX0220"});
					city_list.push({label:"Córdova",value:"SPXX0024"});
					city_list.push({label:"Covadonga",value:"SPXX0166"});
					city_list.push({label:"Cuarte de Huerva",value:"SPXX0025"});
					city_list.push({label:"Cuenca",value:"SPXX0100"});
					city_list.push({label:"Denia",value:"SPXX0258"});
					city_list.push({label:"Donostia-San Sebastián ",value:"SPXX0026"});
					city_list.push({label:"Dos Hermanas",value:"SPXX0027"});
					city_list.push({label:"Durango",value:"SPXX0101"});
					city_list.push({label:"Écija",value:"SPXX0028"});
					city_list.push({label:"Eibar",value:"SPXX0029"});
					city_list.push({label:"El Alquián",value:"SPXX0030"});
					city_list.push({label:"El Astillero",value:"SPXX0031"});
					city_list.push({label:"El Ejido",value:"SPXX0032"});
					city_list.push({label:"El Prat de Llobregat",value:"SPXX0033"});
					city_list.push({label:"El Puerto de Santa María",value:"SPXX0034"});
					city_list.push({label:"Elche",value:"SPXX0035"});
					city_list.push({label:"Elizondo",value:"SPXX0102"});
					city_list.push({label:"Estépa",value:"SPXX0247"});
					city_list.push({label:"Figueras",value:"SPXX0141"});
					city_list.push({label:"Fuenlabrada",value:"SPXX0036"});
					city_list.push({label:"Fuerteventura (La Oliva)",value:"SPXX0142"});
					city_list.push({label:"Galdar",value:"SPXX0235"});
					city_list.push({label:"Gandía",value:"SPXX0037"});
					city_list.push({label:"Gerona",value:"SPXX0038"});
					city_list.push({label:"Getafe",value:"SPXX0039"});
					city_list.push({label:"Gijón",value:"SPXX0222"});
					city_list.push({label:"Girona",value:"SPXX0143"});
					city_list.push({label:"Gomera (San Sebastián)",value:"SPXX0144"});
					city_list.push({label:"Gran Canaria",value:"SPXX0238"});
					city_list.push({label:"Gran Canaria Sur",value:"SPXX0171"});
					city_list.push({label:"Granada",value:"SPXX0040"});
					city_list.push({label:"Granada/Aeropuerto",value:"SPXX0200"});
					city_list.push({label:"Guadalajara",value:"SPXX0041"});
					city_list.push({label:"GuadiX",value:"SPXX0042"});
					city_list.push({label:"Hellin",value:"SPXX0145"});
					city_list.push({label:"Isla del Hierro",value:"SPXX0206"});
					city_list.push({label:"Hinojosa del Duque",value:"SPXX0146"});
					city_list.push({label:"Huelva",value:"SPXX0225"});
					city_list.push({label:"Huesca",value:"SPXX0043"});
					city_list.push({label:"Huescar",value:"SPXX0104"});
					city_list.push({label:"Ibiza",value:"SPXX0044"});
					city_list.push({label:"Infantes",value:"SPXX0241"});
					city_list.push({label:"Isla de Alborán",value:"SPXX0172"});
					city_list.push({label:"Jaén",value:"SPXX0045"});
					city_list.push({label:"Jerez",value:"SPXX0105"});
					city_list.push({label:"Jerez de la Frontera",value:"SPXX0046"});
					city_list.push({label:"Jodar",value:"SPXX0252"});
					city_list.push({label:"L Hospitalet de Llobregat",value:"SPXX0049"});
					city_list.push({label:"La Coruña",value:"SPXX0189"});
					city_list.push({label:"La Isla de la Palma",value:"SPXX0207"});
					city_list.push({label:"Laguardia",value:"SPXX0106"});
					city_list.push({label:"Lalin",value:"SPXX0147"});
					city_list.push({label:"Langreo",value:"SPXX0173"});
					city_list.push({label:"Lanzarote",value:"SPXX0239"});
					city_list.push({label:"Las Palmas",value:"SPXX0047"});
					city_list.push({label:"Las Palmas de Gran Canaria/Gando",value:"SPXX0201"});
					city_list.push({label:"Las Pedroneras",value:"SPXX0256"});
					city_list.push({label:"Leganés",value:"SPXX0048"});
					city_list.push({label:"León/Virgen del Camino",value:"SPXX0192"});
					city_list.push({label:"Lleida",value:"SPXX0175"});
					city_list.push({label:"Logroño/Agoncillo",value:"SPXX0194"});
					city_list.push({label:"Lora del Rio",value:"SPXX00246"});
					city_list.push({label:"Lorca",value:"SPXX0109"});
					city_list.push({label:"Lucena",value:"SPXX0249"});
					city_list.push({label:"Lugo",value:"SPXX0110"});
					city_list.push({label:"Madrid",value:"SPXX0050"});
					city_list.push({label:"Mahón",value:"SPXX0051"});
					city_list.push({label:"Málaga",value:"SPXX0052"});
					city_list.push({label:"Manacor",value:"SPXX0050"});
					city_list.push({label:"Manresa",value:"SPXX0242"});
					city_list.push({label:"Manzaneda",value:"SPXX0176"});
					city_list.push({label:"Marbella",value:"SPXX0054"});
					city_list.push({label:"Mataró",value:"SPXX0055"});
					city_list.push({label:"Melilla",value:"SPXX0226"});
					city_list.push({label:"Mérida",value:"SPXX0111"});
					city_list.push({label:"Miranda de Ebro",value:"SPXX0152"});
					city_list.push({label:"Molina de Aragón",value:"SPXX0153"});
					city_list.push({label:"Montalbán",value:"SPXX0112"});
					city_list.push({label:"Montmeló",value:"SPXX0234"});
					city_list.push({label:"Moforte de Lemos",value:"SPXX0154"});
					city_list.push({label:"Morón de la Frontera",value:"SPXX0056"});
					city_list.push({label:"Móstoles",value:"SPXX0057"});
					city_list.push({label:"Motilla de Palancar",value:"SPXX0257"});
					city_list.push({label:"Motril",value:"SPXX0058"});
					city_list.push({label:"Murcia",value:"SPXX0059"});
					city_list.push({label:"Muriedas",value:"SPXX0060"});
					city_list.push({label:"Navacerrada",value:"SPXX0113"});
					city_list.push({label:"Olot",value:"SPXX0262"});
					city_list.push({label:"Orense",value:"SPXX0223"});
					city_list.push({label:"Oviedo",value:"SPXX0190"});
					city_list.push({label:"Pajares",value:"SPXX0177"});
					city_list.push({label:"Palencia",value:"SPXX0228"});
					city_list.push({label:"Palma de Mallorca",value:"SPXX0061"});
					city_list.push({label:"Pamplona",value:"SPXX0114"});
					city_list.push({label:"Paterna",value:"SPXX0062"});
					city_list.push({label:"Pinoso",value:"SPXX0260"});
					city_list.push({label:"Plasencia",value:"SPXX0245"});
					city_list.push({label:"Pollensa",value:"SPXX0157"});
					city_list.push({label:"Pontevedra",value:"SPXX115"});
					city_list.push({label:"Potocolom",value:"SPXX0178"});
					city_list.push({label:"Pozuelo de Alarcón",value:"SPXX0063"});
					city_list.push({label:"Premia de Mar",value:"SPXX0064"});
					city_list.push({label:"Priego",value:"SPXX0116"});
					city_list.push({label:"Puerto de La Cruz",value:"SPXX0158"});
					city_list.push({label:"Puerto del Rosario",value:"SPXX0065"});
					city_list.push({label:"Puertollano",value:"SPXX0264"});
					city_list.push({label:"Reinosa",value:"SPXX0180"});
					city_list.push({label:"Rentería",value:"SPXX0181"});
					city_list.push({label:"Requena",value:"SPXX0117"});
					city_list.push({label:"Reus",value:"SPXX0118"});
					city_list.push({label:"Riano",value:"SPXX0119"});
					city_list.push({label:"Riaza",value:"SPXX0120"});
					city_list.push({label:"Ronda",value:"SPXX0121"});
					city_list.push({label:"Sabadell",value:"SPXX0066"});
					city_list.push({label:"Sahagun",value:"SPXX0122"});
					city_list.push({label:"Salamanca",value:"SPXX0196"});
					city_list.push({label:"Salas de los Infantes",value:"SPXX0182"});
					city_list.push({label:"Salou",value:"SPXX0183"});
					city_list.push({label:"San Antonio Abad",value:"SPXX0067"});
					city_list.push({label:"San Sebastián",value:"SPXX0191"});
					city_list.push({label:"Sanlucar de Barrameda",value:"SPXX0068"});
					city_list.push({label:"Santa Coloma de Gramanet",value:"SPXX0069"});
					city_list.push({label:"Santa Cruz de Tenerife",value:"SPXX0070"});
					city_list.push({label:"Santa Pola",value:"SPXX0071"});
					city_list.push({label:"Santander",value:"SPXX0072"});
					city_list.push({label:"Santiago de Compostela",value:"SPXX0208"});
					city_list.push({label:"Segovia",value:"SPXX0227"});
					city_list.push({label:"Sestao",value:"SPXX0073"});
					city_list.push({label:"Sevilla",value:"SPXX0074"});
					city_list.push({label:"Sierra Nevada",value:"SPXX0233"});
					city_list.push({label:"Soria",value:"SPXX0243"});
					city_list.push({label:"Talavera de la Reina",value:"SPXX0075"});
					city_list.push({label:"Tarancón",value:"SPXX0255"});
					city_list.push({label:"Tarifa",value:"SPXX0237"});
					city_list.push({label:"Tarragona",value:"SPXX0076"});
					city_list.push({label:"Tenerife/Sur Reina",value:"SPXX0210"});
					city_list.push({label:"Teruel",value:"SPXX0230"});
					city_list.push({label:"Toledo",value:"SPXX0077"});
					city_list.push({label:"Tordesillas",value:"SPXX0126"});
					city_list.push({label:"Toro",value:"SPXX0240"});
					city_list.push({label:"Torrelavega",value:"SPXX0078"});
					city_list.push({label:"Tortosa",value:"SPXX0209"});
					city_list.push({label:"Trujillo",value:"SPXX0244"});
					city_list.push({label:"Tudela",value:"SPXX0079"});
					city_list.push({label:"Urbión-Ventrosa",value:"SPXX0187"});
					city_list.push({label:"Utebo",value:"SPXX0080"});
					city_list.push({label:"Utrera",value:"SPXX0081"});
					city_list.push({label:"Valencia",value:"SPXX0082"});
					city_list.push({label:"Valladolid",value:"SPXX0195"});
					city_list.push({label:"Vicar",value:"SPXX0083"});
					city_list.push({label:"Vigo",value:"SPXX0084"});
					city_list.push({label:"Vilanova I La Geltru",value:"SPXX0085"});
					city_list.push({label:"Villanueva de Córdoba",value:"SPXX0248"});
					city_list.push({label:"Villanueva de La Serena",value:"SPXX0263"});
					city_list.push({label:"Villena",value:"SPXX0259"});
					city_list.push({label:"Viso del Marqués",value:"SPXX0211"});
					city_list.push({label:"Vitoria",value:"SPXX0224"});
					city_list.push({label:"Xativa",value:"SPXX0188"});
					city_list.push({label:"Zamora",value:"SPXX0229"});
					city_list.push({label:"Zaragoza",value:"SPXX0086"});
					break;
				case "Andorra":
					city_list.push({label:"Andorra",value:"ANXX0001"});
					break;
				case "Alemania":
					city_list.push({label:"Berlin",value:"GMXX0007"});
					city_list.push({label:"Bremen",value:"GMXX0014"});
					city_list.push({label:"Dortmund",value:"GMXX0024"});
					city_list.push({label:"Dusseldorf",value:"GMXX0028"});
					city_list.push({label:"Frankfurt",value:"GMXX0185"});
					city_list.push({label:"Hamburg",value:"GMXX0049"});
					city_list.push({label:"Hannover",value:"GMXX0051"});
					city_list.push({label:"Munich",value:"GMXX0087"});
					city_list.push({label:"Nurnberg",value:"GMXX0096"});
					break;
				case "Dinamarca":
					city_list.push({label:"Aalborg",value:"DAXX0002"});
					city_list.push({label:"Arhus",value:"DAXX0003"});
					city_list.push({label:"Billund",value:"DAXX0005"});
					city_list.push({label:"Copenhagen",value:"DAXX0009"});
					city_list.push({label:"Esbjerg",value:"DAXX0010"});
					city_list.push({label:"Odense",value:"DAXX0024"});
					break;
				case "Eslovaquia":
					city_list.push({label:"Bratislava",value:"LOXX0001"});
					city_list.push({label:"Kosice",value:"LOXX0003"});
					city_list.push({label:"Poprad",value:"LOXX0005"});
					city_list.push({label:"Nitra",value:"LOXX0021"});
					break;
				case "Eslovenia":
					city_list.push({label:"Celje",value:"SIXX0004"});
					city_list.push({label:"Ljubljana",value:"SIXX0002"});
					city_list.push({label:"Portoroz",value:"SIXX0011"});
					city_list.push({label:"Postojna",value:"SIXX0007"});
					break;
				case "Finlandia":
					city_list.push({label:"Espoo",value:"FIXX0001"});
					city_list.push({label:"Helsinki",value:"FIXX0002"});
					city_list.push({label:"Lappeentranta",value:"FIXX0040"});
					city_list.push({label:"Rovaniemi",value:"FIXX0053"});
					city_list.push({label:"Tampere",value:"FIXX0031"});
					break;
				case "Francia":
					city_list.push({label:"Bordeaux",value:"FRXX0016"});
					city_list.push({label:"Cannes",value:"FRXX0023"});
					city_list.push({label:"Lille",value:"FRXX0052"});
					city_list.push({label:"Lyon",value:"FRXX0055"});
					city_list.push({label:"Nice",value:"FRXX0073"});
					city_list.push({label:"Paris",value:"FRXX0076"});
					city_list.push({label:"Toulouse",value:"FRXX0099"});
					city_list.push({label:"Marseille",value:"FRXX0059"});
					city_list.push({label:"Toulouse",value:"FRXX0099"});
					break;
				case "Gibraltar":
					city_list.push({label:"Gibraltar",value:"GIXX0001"});
					break;
				case "Grecia":
					city_list.push({label:"Atenas",value:"GRXX0004"});
					city_list.push({label:"Corfu",value:"GRXX0068"});
					city_list.push({label:"Creta",value:"GRXX0046"});
					city_list.push({label:"Korinthos",value:"GRXX0010"});
					city_list.push({label:"Milos",value:"GRXX0056"});
					city_list.push({label:"Mykonos",value:"GRXX0045"});
					city_list.push({label:"Naxos",value:"GRXX0041"});
					city_list.push({label:"Rhodas",value:"GRXX0017"});
					city_list.push({label:"Santorini",value:"GRXX0044"});
					break;
				case "Hungría":
					
					city_list.push({label:"Budapest",value:"HUXX0002"});
					city_list.push({label:"Debrecen",value:"HUXX0004"});
					city_list.push({label:"Eger",value:"HUXX0042"});
					city_list.push({label:"Pecs",value:"HUXX0018"});
					break;
				case "Irlanda":
					city_list.push({label:"Cork",value:"EIXX0011"});
					city_list.push({label:"Dublin",value:"EIXX0014"});
					city_list.push({label:"Galway",value:"EIXX0017"});
					city_list.push({label:"Limerick",value:"EIXX0026"});
					break;
				case "Islandia":
					city_list.push({label:"Akurnes",value:"ICXX0006"});
					city_list.push({label:"Hveragerdi",value:"ICXX0001"});
					city_list.push({label:"Reykjavik",value:"ICXX0002"});
					break;
				case "Italia":
					city_list.push({label:"Bari",value:"ITXX0003"});
					city_list.push({label:"Bologna",value:"ITXX0006"});
					city_list.push({label:"Florence",value:"ITXX0028"});
					city_list.push({label:"Genova",value:"ITXX0031"});
					city_list.push({label:"Livorno",value:"ITXX0036"});
					city_list.push({label:"Milán",value:"ITXX0042"});
					city_list.push({label:"Módena",value:"ITXX0043"});
					city_list.push({label:"Nápoles",value:"ITXX0052"});
					city_list.push({label:"Palermo",value:"ITXX0055"});
					city_list.push({label:"Roma",value:"ITXX0067"});
					city_list.push({label:"Siena",value:"ITXX0072"});
					city_list.push({label:"Turín",value:"ITXX0081"});
					city_list.push({label:"Venecia",value:"ITXX0085"});
					city_list.push({label:"Verona",value:"ITXX0091"});
					break;
				case "Letonia":
					city_list.push({label:"Ogre",value:"LGXX0002"});
					city_list.push({label:"Riga",value:"LGXX0004"});
					city_list.push({label:"Valmiera",value:"LGXX0005"});
					break;
				case "Liechtenstein":
					city_list.push({label:"Schaan",value:"LSXX0001"});
					city_list.push({label:"Vaduz",value:"LSXX0002"});
					city_list.push({label:"Schrunz",value:"LSXX0003"});
					break;
				case "Lituania":
					city_list.push({label:"Kaunas",value:"LHXX0002"});
					city_list.push({label:"Nemencine",value:"LHXX0004"});
					city_list.push({label:"Vilnius",value:"LHXX0005"});
					break;
				case "Luxemburgo":
					city_list.push({label:"Dudelange",value:"LUXX0001"});
					city_list.push({label:"Luxembourg",value:"LUXX0003"});
					city_list.push({label:"Mersch",value:"LUXX0004"});
					break;
				case "Macedonia":
					city_list.push({label:"Bitola",value:"MKXX0005"});
					city_list.push({label:"Skopje",value:"MKXX0001"});
					city_list.push({label:"Tetovo",value:"MKXX0013"});
					break;
				case "Malta":
					city_list.push({label:"Gozo",value:"MTXX0004"});
					city_list.push({label:"Valletta",value:"MTXX0001"});
					break;
				case "Moldavia":
					city_list.push({label:"Chisinau",value:"MDXX0001"});
					city_list.push({label:"Kishinev",value:"MDXX0003"});
					city_list.push({label:"Tiraspol",value:"MDXX0005"});
					break;
				case "Mónaco":
					city_list.push({label:"Monte Carlo",value:"MNXX0001"});
					break;
				case "Montenegro":
					city_list.push({label:"Niksic",value:"MWXX0004"});
					city_list.push({label:"Plevlja",value:"MWXX0003"});
					city_list.push({label:"Podgorica",value:"MDXX0001"});
					break;
				case "Noruega":
					city_list.push({label:"Bergen",value:"NOXX0004"});
					city_list.push({label:"Kristiansand",value:"NOXX0017"});
					city_list.push({label:"Oslo",value:"NOXX0029"});
					city_list.push({label:"Stavanger",value:"NOXX0035"});
					city_list.push({label:"Trondheim",value:"NOXX0039"});
					break;
				case "Países Bajos":
					city_list.push({label:"Amsterdam",value:"NLXX0002"});
					city_list.push({label:"Eindhoven",value:"NLXX0007"});
					city_list.push({label:"La Haya",value:"NLXX0016"});
					city_list.push({label:"Rotterdam",value:"NLXX0015"});
					city_list.push({label:"Utrecht",value:"NLXX0018"});
					break;
				case "Polonia":
					city_list.push({label:"Gdansk",value:"PLXX0005"});
					city_list.push({label:"Krakow",value:"PLXX0012"});
					city_list.push({label:"Wroclaw",value:"PLXX0029"});
					city_list.push({label:"Poznan",value:"PLXX0040"});
					city_list.push({label:"Warsaw",value:"PLXX0028"});
					break;
				case "Portugal":
					city_list.push({label:"Braga",value:"POXX0008"});
					city_list.push({label:"Coimbra",value:"POXX0035"});
					city_list.push({label:"Faro",value:"POXX0013"});
					city_list.push({label:"Lisboa",value:"POXX0016"});
					city_list.push({label:"Oporto",value:"POXX0022"});
					break;
				case "Reino Unido":
					city_list.push({label:"Aberdeen",value:"UKXX0001"});
					city_list.push({label:"Belfast",value:"UKXX0015"});
					city_list.push({label:"Birmingham",value:"UKXX0018"});
					city_list.push({label:"Bristol",value:"UKXX0025"});
					city_list.push({label:"Cambridge",value:"UKXX0028"});
					city_list.push({label:"Cardiff",value:"UKXX0030"});
					city_list.push({label:"Edinburgh",value:"UKXX0052"});
					city_list.push({label:"Glasgow",value:"UKXX0061"});
					city_list.push({label:"Inverness",value:"UKXX0071"});
					city_list.push({label:"Manchester",value:"UKXX0092"});
					city_list.push({label:"Liverpool",value:"UKXX0083"});
					city_list.push({label:"London",value:"UKXX0085"});
					city_list.push({label:"Newcastle",value:"UKXX0098"});
					city_list.push({label:"Oxford",value:"UKXX0106"});
					break;
				case "Rumania":
					city_list.push({label:"Brasov",value:"ROXX0002"});
					city_list.push({label:"Bucarest ",value:"ROXX0003"});
					city_list.push({label:"Constanza",value:"ROXX0034"});
					break;
				case "San Marino":
					city_list.push({label:"San Marino",value:"SMXX0001"});
					break;
				case "Serbia":
					city_list.push({label:"Belgrado",value:"SRXX0005"});
					break;
				case "Suecia":
					city_list.push({label:"Estocolmo",value:"SWXX0031"});
					city_list.push({label:"Gothenburg",value:"SWXX0007"});
					city_list.push({label:"Malmoe",value:"SWXX0020"});
					city_list.push({label:"Uppsala",value:"SWXX0040"});
					city_list.push({label:"Visby",value:"SWXX0061"}); 
					break;
				case "Suiza":
					city_list.push({label:"Basilea",value:"SZXX0004"});
					city_list.push({label:"Berna",value:"SZXX0006"});
					city_list.push({label:"Ginebra",value:"SZXX0013"});
					city_list.push({label:"Lausanne",value:"SZXX0017"});
					city_list.push({label:"Lucerna",value:"SZXX0019"}); 
					city_list.push({label:"Zúrich",value:"SZXX0033"}); 
					break;
				case "Ucrania":
					city_list.push({label:"Kiev",value:"UPXX0016"});
					city_list.push({label:"Odesa ",value:"UPXX0021"});
					city_list.push({label:"Sebastopol ",value:"UPXX0022"});
					city_list.push({label:"Yalta",value:"UPXX0056"});
					
					break;
				case "Vaticano":
					city_list.push({label:"Ciudad del Vaticano",value:"ITXX0083"});
					break;
				default: break;
				
			}
			
			comboCiudades.dataProvider = new DataProvider(city_list);
		}
		/*******************************************************************************************************/
	}
	
}
