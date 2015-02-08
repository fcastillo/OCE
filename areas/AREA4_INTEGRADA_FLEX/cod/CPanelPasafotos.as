package cod 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fl.controls.ComboBox; 
	import fl.data.DataProvider; 
	import flash.events.MouseEvent;
	import fl.controls.RadioButtonGroup;
	import flash.filters.DropShadowFilter;

	import cod.CPrevisualizadorPasafotos;
	import com.innovae.oce.domain.datamodel.resourceReceivedEvent;
	
	public class CPanelPasafotos extends CElementoBase
	{
		public var cont:int = 0;
		var array_horizontal:Array = new Array({label:"Hacia la izquierda",data:"toIzda"},{label:"Hacia la derecha",data:"toDrcha"});
		var array_vertical:Array = new Array({label:"Hacia abajo",data:"toDown"},{label:"Hacia arriba",data:"toUp"});
		
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CPanelPasafotos(aita:MovieClip) 
		{
			super(aita);
		}

		///<summary>
		///Función que activar los evet listener del panel
		///</summary>
		override public function load():int
		{
			changeTiempoTrans.addEventListener(Event.CHANGE, cambiarTiempoTransicion);
			changeVelocidad.addEventListener(Event.CHANGE, cambiarVelocidadTransicion);
			comboSentido.addEventListener(Event.CHANGE, cambiarSentidoTransicion);
			comboDireccion.addEventListener(Event.CHANGE, cambiarDireccionTransicion);
			comboDireccion.enabled = false;
			
			comboSentido.rowCount = 5;
			comboSentido.rowCount = 5;
			comboDireccion.rowCount = 5;
			comboImagenes.rowCount = 3;
			
			//Imágenes
			btnAñadir.addEventListener(MouseEvent.CLICK, añadirImagen);
			btnEliminar.addEventListener(MouseEvent.CLICK, eliminarImagen);
			btnPrevisualizar.addEventListener(MouseEvent.CLICK, previsualizar);
			
			//Radio buttons
			easeOutSine.addEventListener(MouseEvent.CLICK, onChangeEfecto); 
			easeInSine.addEventListener(MouseEvent.CLICK, onChangeEfecto); 
			easeOutBack.addEventListener(MouseEvent.CLICK, onChangeEfecto); 
			easeOutBounce.addEventListener(MouseEvent.CLICK, onChangeEfecto); 
			linear.addEventListener(MouseEvent.CLICK, onChangeEfecto); 
			
			//Efectos
			easeOutSine.enabled = false;
			easeInSine.enabled = false;
			easeOutBack.enabled = false;
			easeOutBounce.enabled = false;
			linear.enabled = false;
			
			return 0;
		}
		
		///<summary>
		///Función que define el tiempo durante el cual se muestra cada imagen
		///</summary>
		public function cambiarTiempoTransicion (e:Event)
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				getPadre().getPadre().elemento_seleccionado.setTimerPasafotos(int(changeTiempoTrans.text)*1000);
			}
		}
		
		///<summary>
		///Función que define la velocidad de las transiciones
		///</summary>
		public function cambiarVelocidadTransicion (e:Event)
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				getPadre().getPadre().elemento_seleccionado.setVelocidadTransicion(Number(changeVelocidad.text));
			}
		}
		
		///<summary>
		///Función que define el sentido de las transiciones y habilita/deshabilita
		///los elementos del panel
		///</summary>
		public function cambiarSentidoTransicion (e:Event)
		{
			getPadre().getPadre().elemento_seleccionado.setSentidoPasafotos(comboSentido.selectedItem.data);
			
			//Habilitamos los radio buttons de los efectos y los combos según 
			//el movimiento seleccionado
			if (comboSentido.selectedItem.data == "Ninguno") 
			{
				comboDireccion.enabled = false;
				easeOutSine.enabled = false;
				easeInSine.enabled = false;
				easeOutBack.enabled = false;
				easeOutBounce.enabled = false;
				linear.enabled = false;
			}
			else if (comboSentido.selectedItem.data == "Horizontal")
			{
				comboDireccion.dataProvider = new DataProvider (array_horizontal);
				getPadre().getPadre().elemento_seleccionado.setDireccionPasafotos("toIzda");
				comboDireccion.enabled = true;
				easeOutSine.enabled = true;
				easeInSine.enabled = true;
				easeOutBack.enabled = true;
				easeOutBounce.enabled = true;
				linear.enabled = true;
			}
			else 
			{
				comboDireccion.dataProvider = new DataProvider (array_vertical);
				getPadre().getPadre().elemento_seleccionado.setDireccionPasafotos("toDown");
				comboDireccion.enabled = true;
				easeOutSine.enabled = true;
				easeInSine.enabled = true;
				easeOutBack.enabled = true;
				easeOutBounce.enabled = true;
				linear.enabled = true;
			}
			
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				getPadre().getPadre().elemento_seleccionado.setSentidoPasafotos(comboSentido.selectedItem.data);
			}
		}
		
		///<summary>
		///Función que define la dirección de las transiciones 
		///</summary>
		public function cambiarDireccionTransicion (e:Event)
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				getPadre().getPadre().elemento_seleccionado.setDireccionPasafotos(comboDireccion.selectedItem.data);
			}
		}
		
		///<summary>
		///Función que llena el combo con los nombres de las imágenes 
		///</summary>
		public function llenarComboImagenes()
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				comboImagenes.dataProvider  = new DataProvider (getPadre().getPadre().elemento_seleccionado.getArrayNombresPasafotos());
			}
		}
		
		public function onBotonDown(e:MouseEvent)
		{
			e.currentTarget.gotoAndStop("disabled");
		}
		
		public function onBotonUp(e:MouseEvent)
		{
			e.currentTarget.gotoAndStop("enabled");
		}
		
		public function onBotonOver(e:MouseEvent)
		{
			e.currentTarget.gotoAndStop("over");
		}
		
		///<summary>
		///Función que llama a la librería de recursos para añadir una nueva imagen
		///</summary>
		public function añadirImagen(e:MouseEvent)
		{
			getPadre().getPadre().getResourceURLFlash(1,"-1");
			getPadre().getPadre().addEventListener(resourceReceivedEvent.RESOURCE_RECEIVED,loadDataFromResource);
		}
		
		///<summary>
		///Función que recibe los datos de la imagen seleccionada por el usuario
		///</summary>
		public function loadDataFromResource(e:resourceReceivedEvent):void
		{		
			trace("[Flash] loadDataFromResource en CPanelPasafotos, al cargar una imagen!!");
			getPadre().getPadre().removeEventListener(resourceReceivedEvent.RESOURCE_RECEIVED, loadDataFromResource);
			
			//Guardamos el nombre, path y el ID de la foto en los arrays
			var url:String = e.resource.url;
			if (url != null)
			{
				//Sacamos primero el nombre
				var fSlash: int = url.lastIndexOf("/");
				var bSlash: int = url.lastIndexOf("\\"); // reason for the double slash is just to escape the slash so it doesn't escape the quote!!!
				var slashIndex: int = fSlash > bSlash ? fSlash : bSlash;
				var imageName: String = url.substr(slashIndex + 1);
				
				getPadre().getPadre().elemento_seleccionado.getArrayPasafotos().push(url);
				getPadre().getPadre().elemento_seleccionado.getArrayNombresPasafotos().push(imageName);
				getPadre().getPadre().elemento_seleccionado.getArrayIDsPasafotos().push(e.resource.id);
				llenarComboImagenes();
			}
		}
		
		///<summary>
		///Función que elimina una imagen de la lista 
		///</summary>
		public function eliminarImagen(e:MouseEvent)
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
					var array_aux:Array = getPadre().getPadre().elemento_seleccionado.getArrayPasafotos();
					array_aux.splice(comboImagenes.selectedIndex,1);
					getPadre().getPadre().elemento_seleccionado.getArrayIDsPasafotos().splice(comboImagenes.selectedIndex,1);
					getPadre().getPadre().elemento_seleccionado.getArrayNombresPasafotos().splice(comboImagenes.selectedIndex,1);
					llenarComboImagenes(); //actualizamos el combo
			}
		}
		
		///<summary>
		///Función que controla los efectos
		///</summary>
		public function onChangeEfecto(e:MouseEvent)
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (comboDireccion.selectedItem.data == "toDown")
				{
					if (e.currentTarget.name == "easeInSine") getPadre().getPadre().elemento_seleccionado.setEfectoPasafotos("easeInExpo");
					else getPadre().getPadre().elemento_seleccionado.setEfectoPasafotos(e.currentTarget.name);
				}
				else getPadre().getPadre().elemento_seleccionado.setEfectoPasafotos(e.currentTarget.name);
			}
		}
		
		///<summary>
		///Función que abre el previsualizador del pasafotos
		///</summary>
		public function previsualizar(e:MouseEvent)
		{
			var previsualizador:CPrevisualizadorPasafotos = new CPrevisualizadorPasafotos(getPadre().getPadre());
			previsualizador.setXpos((940-previsualizador.width)/2);
			previsualizador.setYpos(1);
			previsualizador.load();
						
			//Posición y dimensiones del pasafotos
			previsualizador.setPosXPasafotos(getPadre().getPadre().elemento_seleccionado.getXpos());
			previsualizador.setPosYPasafotos(getPadre().getPadre().elemento_seleccionado.getYpos());
			previsualizador.setAnchoPasafotos(getPadre().getPadre().elemento_seleccionado.getAncho());
			previsualizador.setAltoPasafotos(getPadre().getPadre().elemento_seleccionado.getAlto());
			
			previsualizador.setArrayPasafotos(getPadre().getPadre().elemento_seleccionado.getArrayPasafotos());
			previsualizador.setSentidoPasafotos(getPadre().getPadre().elemento_seleccionado.getSentidoPasafotos());
			previsualizador.setDireccionPasafotos(getPadre().getPadre().elemento_seleccionado.getDireccionPasafotos());
			previsualizador.setEfectoPasafotos(getPadre().getPadre().elemento_seleccionado.getEfectoPasafotos());
			previsualizador.setTimerPasafotos(getPadre().getPadre().elemento_seleccionado.getTimerPasafotos());
			previsualizador.setVelocidadTransicion(getPadre().getPadre().elemento_seleccionado.getVelocidadTransicion());
			
			previsualizador.crearElementoPasafotos();
			
			var sombra:DropShadowFilter = new DropShadowFilter();
			sombra.distance = 7;
			sombra.color = 0;
			sombra.blurX = 0;
			sombra.blurY = 0;
			sombra.angle = 45;
			sombra.alpha = 0.2;
			sombra.quality = 2;
			previsualizador.filters = [sombra];
			
			getPadre().getPadre().addChild(previsualizador);
		}
		
		///<summary>
		///Función que actualiza el panel según los datos del pasafotos
		///</summary>
		public function mostrarValores()
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				var tiempoEntreTrans:int = getPadre().getPadre().elemento_seleccionado.getTimerPasafotos()/1000;
				var velocidad:Number = getPadre().getPadre().elemento_seleccionado.getVelocidadTransicion();
				var sentido:String = getPadre().getPadre().elemento_seleccionado.getSentidoPasafotos();
				var direccion:String = getPadre().getPadre().elemento_seleccionado.getDireccionPasafotos();
				var efecto:String = getPadre().getPadre().elemento_seleccionado.getEfectoPasafotos();
				
				llenarComboImagenes();
				changeTiempoTrans.text = tiempoEntreTrans.toString();
				changeVelocidad.text = velocidad.toString();
				
				//Efecto
				switch (efecto)
				{
					case "easeOutSine": easeOutSine.selected = true; break;
					case "easeInSine": easeInSine.selected = true; break;
					case "easeInExpo": easeInSine.selected = true; break;
					case "easeOutBack": easeOutBack.selected = true; break;
					case "easeOutBounce": easeOutBounce.selected = true; break;
					case "linear": linear.selected = true; break;
				}
				
				comboDireccion.enabled = true;
				easeOutSine.enabled = true;
				easeInSine.enabled = true;
				easeOutBack.enabled = true;
				easeOutBounce.enabled = true;
				linear.enabled = true;
		
				//Sentido
				switch (sentido)
				{
					case "Ninguno": 
						comboSentido.selectedIndex = 0; 
						comboDireccion.enabled = false;
						easeOutSine.enabled = false;
						easeInSine.enabled = false;
						easeOutBack.enabled = false;
						easeOutBounce.enabled = false;
						linear.enabled = false;
						break;
					case "Horizontal": 
						comboSentido.selectedIndex = 1; 
						comboDireccion.dataProvider = new DataProvider (array_horizontal);
						break;
					case "Vertical": 
						comboSentido.selectedIndex = 2; 
						comboDireccion.dataProvider = new DataProvider (array_vertical);
						break;
					default: comboSentido.selectedIndex = 0; break;
				}
				
				//Direccion
				switch (direccion)
				{
					case "toIzda": comboDireccion.selectedIndex = 0; break;
					case "toDrcha": comboDireccion.selectedIndex = 1; break;
					case "toDown": comboDireccion.selectedIndex = 0; break;
					case "toUp": comboDireccion.selectedIndex = 1; break;
				}
			}
		}
	}
	
}
