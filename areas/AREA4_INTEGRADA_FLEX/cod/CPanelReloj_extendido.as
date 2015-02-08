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
	
	public class CPanelReloj_extendido extends CElementoBase
	{
		//VARIABLES
		var userFonts:Array;
		var city_list:Array;
		var allFontNames:Array;
		var tipo_reloj:String = "btnAnalog";
		
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CPanelReloj_extendido(aita:MovieClip) 
		{
			super(aita);
		}
		
		///<summary>
		///Carga el panel de propiedades del elemento reloj
		///</summary>
		override public function load():int
		{
			this.x = getXpos();
			this.y = getYpos();
			
			enableButtons();	
			activarListeners();
			return 0;
		}
		
		///<summary>
		///Activa los listeners para poder cambiar de tipo de reloj
		///</summary>
		private function enableButtons():void 
		{	
			//Radio buttons
			btnAnalog.addEventListener(MouseEvent.CLICK, onChangeTipo); 
			btnDigital.addEventListener(MouseEvent.CLICK, onChangeTipo); 
			
			//Añadimos grises a los color pickers
			if (params_analog.sombraCP.colors.indexOf(0xd3d3d3) == -1) añadirGrises();
		}
		
		///<summary>
		///Activa los listeners en los botones y check boxes
		///		-> Nunca están activos todos a la vez; cuando tengamos un reloj analógico 
		///		   params_analog estará visible y activo, si estamos con uno digital, params_digital
		///</summary>
		private function activarListeners():void
		{
			//Color
			params_analog.sombraCP.addEventListener(Event.CHANGE, colorChange);
			params_analog.fondoCP.addEventListener(Event.CHANGE, colorChange);
			params_analog.marcoCP.addEventListener(Event.CHANGE, colorChange);
			params_analog.remarcoCP.addEventListener(Event.CHANGE, colorChange);
			params_analog.agujasCP.addEventListener(Event.CHANGE, colorChange);
			params_analog.marcasCP.addEventListener(Event.CHANGE, colorChange);
			params_analog.numerosCP.addEventListener(Event.CHANGE, colorChange);
			
			params_digital.fondoCP_digital.addEventListener(Event.CHANGE, colorChange);
			params_digital.numerosCP_digital.addEventListener(Event.CHANGE, colorChange);
			params_digital.diaCP.addEventListener(Event.CHANGE, colorChange);
			params_digital.numDiaCP.addEventListener(Event.CHANGE, colorChange);
			params_digital.mesCP.addEventListener(Event.CHANGE, colorChange);
			
			//Alpha
			params_analog.alpha_sombra.addEventListener(Event.CHANGE, alphaChange);
			params_analog.alpha_fondo.addEventListener(Event.CHANGE, alphaChange);
			params_analog.alpha_marco.addEventListener(Event.CHANGE, alphaChange);
			params_analog.alpha_remarco.addEventListener(Event.CHANGE, alphaChange);
			params_analog.alpha_agujas.addEventListener(Event.CHANGE, alphaChange);
			params_analog.alpha_marcas.addEventListener(Event.CHANGE, alphaChange);
			params_analog.alpha_numeros.addEventListener(Event.CHANGE, alphaChange);
			
			params_digital.alpha_fondo_digital.addEventListener(Event.CHANGE, alphaChange);
			params_digital.alpha_numeros_digital.addEventListener(Event.CHANGE, alphaChange);
			params_digital.alpha_dia.addEventListener(Event.CHANGE, alphaChange);
			params_digital.alpha_numDia.addEventListener(Event.CHANGE, alphaChange);
			params_digital.alpha_mes.addEventListener(Event.CHANGE, alphaChange);
		}
		
		///<summary>
		///Cambia el tipo de reloj
		///</summary>
		public function onChangeTipo(e:MouseEvent)
		{				
			if (tipo_reloj != e.currentTarget.name)
			{
				tipo_reloj = e.currentTarget.name;
				if (getPadre().getPadre().elemento_seleccionado != null)
				{
					if (getPadre().getPadre().elemento_seleccionado.control_reloj != null)
					{
						getPadre().getPadre().elemento_seleccionado.cambiarDeReloj(tipo_reloj);
					}
				}
			}
		}
				
		///<summary>
		///Event Listener que controla la transparencia de los colores mediante la caja de texto
		///</summary>
		function alphaChange(e:Event):void
		{		
			var valor:Number = Number(e.currentTarget.text)/100;
			
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.control_reloj != null)
				{
					if (e.currentTarget.name == "alpha_sombra") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editAlpha(e.currentTarget.name,valor);
						getPadre().getPadre().elemento_seleccionado.alpha_sombra = valor;
					}
					else if (e.currentTarget.name == "alpha_fondo") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editAlpha(e.currentTarget.name,valor);
						getPadre().getPadre().elemento_seleccionado.alpha_fondo = valor;
					}
					else if (e.currentTarget.name == "alpha_marco") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editAlpha(e.currentTarget.name,valor);
						getPadre().getPadre().elemento_seleccionado.alpha_marco = valor;
					}
					else if (e.currentTarget.name == "alpha_remarco") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editAlpha(e.currentTarget.name,valor);
						getPadre().getPadre().elemento_seleccionado.alpha_remarco = valor;
					}
					else if (e.currentTarget.name == "alpha_agujas") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editAlpha(e.currentTarget.name,valor);
						getPadre().getPadre().elemento_seleccionado.alpha_agujas = valor;
					}
					else if (e.currentTarget.name == "alpha_marcas") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editAlpha(e.currentTarget.name,valor);
						getPadre().getPadre().elemento_seleccionado.alpha_marcas = valor;
					}
					else if (e.currentTarget.name == "alpha_numeros") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editAlpha(e.currentTarget.name,valor);
						getPadre().getPadre().elemento_seleccionado.alpha_numeros = valor;
					}
					else if (e.currentTarget.name == "alpha_fondo_digital") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editAlpha("alpha_fondo",valor);
						getPadre().getPadre().elemento_seleccionado.alpha_fondo = valor;
					}
					else if (e.currentTarget.name == "alpha_numeros_digital") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editAlpha("alpha_numeros",valor);
						getPadre().getPadre().elemento_seleccionado.alpha_numeros = valor;
					}
					else if (e.currentTarget.name == "alpha_dia") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editAlpha(e.currentTarget.name,valor);
						getPadre().getPadre().elemento_seleccionado.alpha_dia = valor;
					}
					else if (e.currentTarget.name == "alpha_numDia") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editAlpha(e.currentTarget.name,valor);
						getPadre().getPadre().elemento_seleccionado.alpha_numDia = valor;
					}
					else if (e.currentTarget.name == "alpha_mes") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editAlpha(e.currentTarget.name,valor);
						getPadre().getPadre().elemento_seleccionado.alpha_mes = valor;
					}
				}
			}
		}
				
		///<summary>
		///Listener que modifica los colores
		///</summary>
		function colorChange(e:Event)
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.control_reloj != null)
				{
					if (e.currentTarget.name == "fondoCP") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editColor(e.currentTarget.name,params_analog.fondoCP.selectedColor);
						getPadre().getPadre().elemento_seleccionado.color_fondo = uint(params_analog.fondoCP.selectedColor);
					}
					else if (e.currentTarget.name == "sombraCP") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editColor(e.currentTarget.name,params_analog.sombraCP.selectedColor);
						getPadre().getPadre().elemento_seleccionado.color_sombra = uint(params_analog.sombraCP.selectedColor);
					}
					else if (e.currentTarget.name == "marcoCP") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editColor(e.currentTarget.name,params_analog.marcoCP.selectedColor);
						getPadre().getPadre().elemento_seleccionado.color_marco = uint(params_analog.marcoCP.selectedColor);
					}
					else if (e.currentTarget.name == "remarcoCP") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editColor(e.currentTarget.name,params_analog.remarcoCP.selectedColor);
						getPadre().getPadre().elemento_seleccionado.color_remarco = uint(params_analog.remarcoCP.selectedColor);
					}
					else if (e.currentTarget.name == "agujasCP") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editColor(e.currentTarget.name,params_analog.agujasCP.selectedColor);
						getPadre().getPadre().elemento_seleccionado.color_agujas = uint(params_analog.agujasCP.selectedColor);
					}
					else if (e.currentTarget.name == "marcasCP") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editColor(e.currentTarget.name,params_analog.marcasCP.selectedColor);
						getPadre().getPadre().elemento_seleccionado.color_marcas = uint(params_analog.marcasCP.selectedColor);
					}
					else if (e.currentTarget.name == "numerosCP") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editColor(e.currentTarget.name,params_analog.numerosCP.selectedColor);
						getPadre().getPadre().elemento_seleccionado.color_numeros = uint(params_analog.numerosCP.selectedColor);
					}
					else if (e.currentTarget.name == "fondoCP_digital") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editColor("fondoCP",params_digital.fondoCP_digital.selectedColor);
						getPadre().getPadre().elemento_seleccionado.color_fondo = uint(params_digital.fondoCP_digital.selectedColor);
					}
					else if (e.currentTarget.name == "numerosCP_digital") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editColor("numerosCP",params_digital.numerosCP_digital.selectedColor);
						getPadre().getPadre().elemento_seleccionado.color_numeros = uint(params_digital.numerosCP_digital.selectedColor);
					}
					else if (e.currentTarget.name == "diaCP") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editColor(e.currentTarget.name,params_digital.diaCP.selectedColor);
						getPadre().getPadre().elemento_seleccionado.color_dia = uint(params_digital.diaCP.selectedColor);
					}
					else if (e.currentTarget.name == "numDiaCP") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editColor(e.currentTarget.name,params_digital.numDiaCP.selectedColor);
						getPadre().getPadre().elemento_seleccionado.color_numDia = uint(params_digital.numDiaCP.selectedColor);
					}
					else if (e.currentTarget.name == "mesCP") 
					{
						getPadre().getPadre().elemento_seleccionado.control_reloj.editColor(e.currentTarget.name,params_digital.mesCP.selectedColor);
						getPadre().getPadre().elemento_seleccionado.color_mes = uint(params_digital.mesCP.selectedColor);
					}
				}
			}
		}
				
		///<summary>
		///Actualiza el panel
		///		-> Cada vez que se seleccione un elemento de tipo reloj en el lienzo
		///		-> Cuando cambiamos el tipo de reloj, mostramos valores por defecto
		///</summary>
		function actualizarPanel()
		{
			var color_fondo:uint;
			var alphaFondo:Number;
			var color_numeros:uint;
			var alphaNumeros:Number;
			
			
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.control_reloj != null)
				{
					var tipo:String = getPadre().getPadre().elemento_seleccionado.control_reloj.getTipo();				
					color_fondo = getPadre().getPadre().elemento_seleccionado.control_reloj.getColorFondo();
					color_numeros = getPadre().getPadre().elemento_seleccionado.control_reloj.getColorNumeros();
					alphaFondo = getPadre().getPadre().elemento_seleccionado.control_reloj.getAlphaFondo()*100;
					alphaNumeros = getPadre().getPadre().elemento_seleccionado.control_reloj.getAlphaNumeros()*100;
										
					if (tipo == "analog") 
					{
						params_digital.visible = false;
						params_digital.enabled = false;
						
						btnAnalog.selected = true;
						tipo_reloj = "btnAnalog";
						
						var color_sombra:uint = getPadre().getPadre().elemento_seleccionado.control_reloj.getColorSombra();
						var color_marco:uint = getPadre().getPadre().elemento_seleccionado.control_reloj.getColorMarco();
						var color_remarco:uint = getPadre().getPadre().elemento_seleccionado.control_reloj.getColorRemarco();
						var color_agujas:uint = getPadre().getPadre().elemento_seleccionado.control_reloj.getColorAgujas();
						var color_marcas:uint = getPadre().getPadre().elemento_seleccionado.control_reloj.getColorMarcas();
												
						var alphaSombra:Number = Math.round(getPadre().getPadre().elemento_seleccionado.control_reloj.getAlphaSombra()*100);
						var alphaMarco:Number = Math.round(getPadre().getPadre().elemento_seleccionado.control_reloj.getAlphaMarco()*100);
						var alphaRemarco:Number = Math.round(getPadre().getPadre().elemento_seleccionado.control_reloj.getAlphaRemarco()*100);
						var alphaAgujas:Number = Math.round(getPadre().getPadre().elemento_seleccionado.control_reloj.getAlphaAgujas()*100);
						var alphaMarcas:Number = Math.round(getPadre().getPadre().elemento_seleccionado.control_reloj.getAlphaMarcas()*100);
																
						//COLOR
						params_analog.sombraCP.selectedColor = color_sombra;
						params_analog.fondoCP.selectedColor = color_fondo;
						params_analog.marcoCP.selectedColor = color_marco;
						params_analog.remarcoCP.selectedColor = color_remarco;
						params_analog.agujasCP.selectedColor = color_agujas;
						params_analog.marcasCP.selectedColor = color_marcas;
						params_analog.numerosCP.selectedColor = color_numeros;
						
						//ALPHA
						params_analog.alpha_sombra.text = alphaSombra.toString();
						params_analog.alpha_fondo.text = alphaFondo.toString();
						params_analog.alpha_marco.text = alphaMarco.toString();
						params_analog.alpha_remarco.text = alphaRemarco.toString();
						params_analog.alpha_agujas.text = alphaAgujas.toString();
						params_analog.alpha_marcas.text = alphaMarcas.toString();
						params_analog.alpha_numeros.text = alphaNumeros.toString();
					}
					else if (tipo == "digital") 
					{
						params_analog.visible = false;
						params_analog.enabled = false;
						
						btnDigital.selected = true;
						tipo_reloj = "btnDigital";
						
						var color_dia:uint = getPadre().getPadre().elemento_seleccionado.control_reloj.getColorDia();
						var color_numDia:uint = getPadre().getPadre().elemento_seleccionado.control_reloj.getColorNumDia();
						var color_mes:uint = getPadre().getPadre().elemento_seleccionado.control_reloj.getColorMes();
						
						var alphaDia:Number = getPadre().getPadre().elemento_seleccionado.control_reloj.getAlphaDia();
						var alphaNumDia:Number = getPadre().getPadre().elemento_seleccionado.control_reloj.getAlphaNumDia();
						var alphaMes:Number = getPadre().getPadre().elemento_seleccionado.control_reloj.getAlphaMes();
						
						params_digital.fondoCP_digital.selectedColor = color_fondo;
						params_digital.numerosCP_digital.selectedColor = color_numeros;
						params_digital.diaCP.selectedColor = color_dia;
						params_digital.numDiaCP.selectedColor = color_numDia;
						params_digital.mesCP.selectedColor = color_mes;
						
						params_digital.alpha_fondo_digital.text = alphaFondo.toString();
						params_digital.alpha_numeros_digital.text = alphaNumeros.toString();
						params_digital.alpha_dia.text = alphaDia.toString();
						params_digital.alpha_numDia.text = alphaNumDia.toString();
						params_digital.alpha_mes.text = alphaMes.toString();
					}
											
				}
			}
		}
		
		/***************************************************** GRISES ************************************************************/
		///<summary>
		///Añade los tonos grises a los color picker
		///</summary>
		private function añadirGrises()
		{
			if (params_analog.sombraCP.colors.indexOf(0xd3d3d3) == -1)
			{
				params_analog.sombraCP.colors.push(0xd3d3d3);
				params_analog.sombraCP.colors.push(0xc0c0c0);
				params_analog.sombraCP.colors.push(0xa9a9a9);
				params_analog.sombraCP.colors.push(0x999999);
				params_analog.sombraCP.colors.push(0x808080);
				params_analog.sombraCP.colors.push(0x666666);
				params_analog.sombraCP.colors.push(0x333333);
			}
			
			if (params_analog.fondoCP.colors.indexOf(0xd3d3d3) == -1)
			{
				params_analog.fondoCP.colors.push(0xd3d3d3);
				params_analog.fondoCP.colors.push(0xc0c0c0);
				params_analog.fondoCP.colors.push(0xa9a9a9);
				params_analog.fondoCP.colors.push(0x999999);
				params_analog.fondoCP.colors.push(0x808080);
				params_analog.fondoCP.colors.push(0x666666);
				params_analog.fondoCP.colors.push(0x333333);
			}
			
			if (params_analog.marcoCP.colors.indexOf(0xd3d3d3) == -1)
			{
				params_analog.marcoCP.colors.push(0xd3d3d3);
				params_analog.marcoCP.colors.push(0xc0c0c0);
				params_analog.marcoCP.colors.push(0xa9a9a9);
				params_analog.marcoCP.colors.push(0x999999);
				params_analog.marcoCP.colors.push(0x808080);
				params_analog.marcoCP.colors.push(0x666666);
				params_analog.marcoCP.colors.push(0x333333);
			}
			
			if (params_analog.remarcoCP.colors.indexOf(0xd3d3d3) == -1)
			{
				params_analog.remarcoCP.colors.push(0xd3d3d3);
				params_analog.remarcoCP.colors.push(0xc0c0c0);
				params_analog.remarcoCP.colors.push(0xa9a9a9);
				params_analog.remarcoCP.colors.push(0x999999);
				params_analog.remarcoCP.colors.push(0x808080);
				params_analog.remarcoCP.colors.push(0x666666);
				params_analog.remarcoCP.colors.push(0x333333);
			}
			
			if (params_analog.agujasCP.colors.indexOf(0xd3d3d3) == -1)
			{
				params_analog.agujasCP.colors.push(0xd3d3d3);
				params_analog.agujasCP.colors.push(0xc0c0c0);
				params_analog.agujasCP.colors.push(0xa9a9a9);
				params_analog.agujasCP.colors.push(0x999999);
				params_analog.agujasCP.colors.push(0x808080);
				params_analog.agujasCP.colors.push(0x666666);
				params_analog.agujasCP.colors.push(0x333333);
			}
			
			if (params_analog.marcasCP.colors.indexOf(0xd3d3d3) == -1)
			{
				params_analog.marcasCP.colors.push(0xd3d3d3);
				params_analog.marcasCP.colors.push(0xc0c0c0);
				params_analog.marcasCP.colors.push(0xa9a9a9);
				params_analog.marcasCP.colors.push(0x999999);
				params_analog.marcasCP.colors.push(0x808080);
				params_analog.marcasCP.colors.push(0x666666);
				params_analog.marcasCP.colors.push(0x333333);
			}
			
			if (params_analog.numerosCP.colors.indexOf(0xd3d3d3) == -1)
			{
				params_analog.numerosCP.colors.push(0xd3d3d3);
				params_analog.numerosCP.colors.push(0xc0c0c0);
				params_analog.numerosCP.colors.push(0xa9a9a9);
				params_analog.numerosCP.colors.push(0x999999);
				params_analog.numerosCP.colors.push(0x808080);
				params_analog.numerosCP.colors.push(0x666666);
				params_analog.numerosCP.colors.push(0x333333);
			}
			//DIGITAL
			if (params_digital.numerosCP_digital.colors.indexOf(0xd3d3d3) == -1)
			{
				params_digital.numerosCP_digital.colors.push(0xd3d3d3);
				params_digital.numerosCP_digital.colors.push(0xc0c0c0);
				params_digital.numerosCP_digital.colors.push(0xa9a9a9);
				params_digital.numerosCP_digital.colors.push(0x999999);
				params_digital.numerosCP_digital.colors.push(0x808080);
				params_digital.numerosCP_digital.colors.push(0x666666);
				params_digital.numerosCP_digital.colors.push(0x333333);
			}
			
			if (params_digital.fondoCP_digital.colors.indexOf(0xd3d3d3) == -1)
			{
				params_digital.fondoCP_digital.colors.push(0xd3d3d3);
				params_digital.fondoCP_digital.colors.push(0xc0c0c0);
				params_digital.fondoCP_digital.colors.push(0xa9a9a9);
				params_digital.fondoCP_digital.colors.push(0x999999);
				params_digital.fondoCP_digital.colors.push(0x808080);
				params_digital.fondoCP_digital.colors.push(0x666666);
				params_digital.fondoCP_digital.colors.push(0x333333);
			}
			
			if (params_digital.diaCP.colors.indexOf(0xd3d3d3) == -1)
			{
				params_digital.diaCP.colors.push(0xd3d3d3);
				params_digital.diaCP.colors.push(0xc0c0c0);
				params_digital.diaCP.colors.push(0xa9a9a9);
				params_digital.diaCP.colors.push(0x999999);
				params_digital.diaCP.colors.push(0x808080);
				params_digital.diaCP.colors.push(0x666666);
				params_digital.diaCP.colors.push(0x333333);
			}
			
			if (params_digital.numDiaCP.colors.indexOf(0xd3d3d3) == -1)
			{
				params_digital.numDiaCP.colors.push(0xd3d3d3);
				params_digital.numDiaCP.colors.push(0xc0c0c0);
				params_digital.numDiaCP.colors.push(0xa9a9a9);
				params_digital.numDiaCP.colors.push(0x999999);
				params_digital.numDiaCP.colors.push(0x808080);
				params_digital.numDiaCP.colors.push(0x666666);
				params_digital.numDiaCP.colors.push(0x333333);
			}
			
			if (params_digital.mesCP.colors.indexOf(0xd3d3d3) == -1)
			{
				params_digital.mesCP.colors.push(0xd3d3d3);
				params_digital.mesCP.colors.push(0xc0c0c0);
				params_digital.mesCP.colors.push(0xa9a9a9);
				params_digital.mesCP.colors.push(0x999999);
				params_digital.mesCP.colors.push(0x808080);
				params_digital.mesCP.colors.push(0x666666);
				params_digital.mesCP.colors.push(0x333333);
			}
		}
		/*******************************************************************************************************/

	}
	
}
