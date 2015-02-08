package cod
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class CPrevisualizadorPasafotos extends CElementoBase
	{
		//VARIABLES
		private var pasafotos:CElementoPasafotos;
		private var array_fotos:Array = new Array();
		private var sentido:String = "Ninguno";
		private var direccion:String = "toIzda";
		private var efecto:String = "easeOutSine";
		private var tiempo_timer:int = 5000;
		private var velocidad_transicion:Number = 1;
		
		//Dimensiones y posiciones del pasafotos
		private var pPosX:int = 0;
		private var pPosY:int = 0;
		private var pAncho:int = 378;
		private var pAlto:int = 800;
		
		/***********************GETTERS/SETTERS************************************/
		public function getPasafotos():CElementoPasafotos {return pasafotos;}
		public function getArrayPasafotos():Array {return array_fotos;}
		public function getSentidoPasafotos():String {return sentido;}
		public function getDireccionPasafotos():String {return direccion;}
		public function getEfectoPasafotos():String {return efecto;}
		public function getTimerPasafotos():int {return tiempo_timer;}
		public function getVelocidadTransicion():int {return velocidad_transicion;}
		
		public function getPosXPasafotos():int {return pPosX;}
		public function getPosYPasafotos():int {return pPosY;}
		public function getAnchoPasafotos():int {return pAncho;}
		public function getAltoPasafotos():int {return pAlto;}
		
		public function setPasafotos(val:CElementoPasafotos) {pasafotos = val;}
		public function setArrayPasafotos(val:Array) {array_fotos = val;}
		public function setSentidoPasafotos(val:String) {sentido = val;}
		public function setDireccionPasafotos(val:String) {direccion = val;}
		public function setEfectoPasafotos(val:String) {efecto = val;}
		public function setTimerPasafotos(val:int) {tiempo_timer = val;}
		public function setVelocidadTransicion(val:Number) {velocidad_transicion = val;}
		
		public function setPosXPasafotos(val:int){pPosX = val;}
		public function setPosYPasafotos(val:int){pPosY = val;}
		public function setAnchoPasafotos(val:int){pAncho = val;}
		public function setAltoPasafotos(val:int){pAlto = val;}
		/******************************************************************************/
		
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CPrevisualizadorPasafotos(aita:MovieClip) 
		{
			super(aita);
		}
		
		///<summary>
		///Carga la ventana y activa el listener del botón Aceptar
		///</summary>
		override public function load():int
		{
			this.x = getXpos();
			this.y = getYpos();
			
			btnAceptar.addEventListener(MouseEvent.CLICK, onAceptar);
			return 0;
		}
		
		///<summary>
		///Función que carga el pasafotos
		///</summary>
		public function crearElementoPasafotos()
		{
			pasafotos = new CElementoPasafotos(this);
			pasafotos.setArrayUrls(array_fotos);
			pasafotos.setTiempoTimer(tiempo_timer);
			pasafotos.setSentidoTrans(sentido);
			pasafotos.cambiarTransiciones(efecto);
			pasafotos.setEfectoFade(efecto);	
			pasafotos.cambiarVelocidad(velocidad_transicion);
			pasafotos.setNumImagenes(array_fotos.length);
			pasafotos.setOperationMode(sentido);
			pasafotos.setDireccion(direccion);
			
			//Definimos dimensiones y posición
			pasafotos.setAncho(pAncho);
			pasafotos.setAlto(pAlto);
			pasafotos.setXpos(0);
			pasafotos.setYpos(0);
												
			pasafotos.load();
									
			lienzo.width = pAncho;
			lienzo.height = pAlto;
			lienzo.x = pPosX + 11; //Tenemos en cuenta los márgenes
			lienzo.y = pPosY + 33;

			lienzo.addChild(pasafotos);
		}
		
		///<summary>
		///Función que descarga el pasafotos y cierra el previsualizador
		///</summary>
		public function onAceptar (e:MouseEvent)
		{
			pasafotos.unload();
			getPadre().removeChild(this);
		}

	}
	
}
