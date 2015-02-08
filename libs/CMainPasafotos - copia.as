package  {
	
	import flash.display.MovieClip;
	import cod.CElementoPasafotos;
	
	public class CMainPasafotos extends MovieClip 
	{
		public var pasafotos:CElementoPasafotos; 
		public var arrayPasafotos:Array = new Array();
		public var sentido:String = "Ninguno";
		public var direccion:String = "toIzda";
		public var efecto:String = "easeOutSine";
		public var tiempo_timer:int = 5000;
		public var velocidad_transicion:Number = 1;
		
		public var ancho:int = 225;
		public var alto:int = 170;
		
		public var pathDatos:String;
				
		public function CMainPasafotos() 
		{
			// constructor code
		}
		
		//---------Función loadXML---------//
		//-- Edita el control según los atributos leídos en el dpe
		//-- Variables de entrada:
			//--datos: nodo xml del dpe
		//--------------------------------------//
		public function loadXML(datos:XML,path:String,tipo_area:String)
		{		
			trace("*************loadXML***************");
			arrayPasafotos = (datos.@url_imagenes).toString().split(",");
			sentido = datos.@sentido;
			direccion = datos.@direccion;
			efecto = datos.@efecto;
			tiempo_timer = int(datos.@tiempo_trans);
			velocidad_transicion = Number(datos.@vel_trans);
			
			pathDatos = path;
			
			if (pathDatos != "")
			{
				for (var i:int = 0; i<arrayPasafotos.length; i++)
				{
					arrayPasafotos[i] = pathDatos.concat("\\",arrayPasafotos[i]);
				}
			}
			
			ancho = int(datos.@ancho)*600;
			alto = int(datos.@alto)*800;
			
			cargarPasafotos();
		}
		
		public function cargarPasafotos()
		{
			trace("******************cargarPasafotos****************");
			pasafotos = new CElementoPasafotos(this);
			
			pasafotos.setConstants(Math.round(-ancho),Math.round(ancho),Math.round(alto),Math.round(-alto));
			
			trace("pasafotos = ", pasafotos);
			
			pasafotos.setAncho(ancho);
			pasafotos.setAlto(alto);
			pasafotos.setXpos(0);
			pasafotos.setYpos(0);
			pasafotos.setArrayUrls(arrayPasafotos);
			pasafotos.setSentidoTrans(sentido);
			pasafotos.setOperationMode(sentido);
			pasafotos.setDireccion(direccion);
			pasafotos.setEfectoFade(efecto);			
			pasafotos.setTiempoTimer(tiempo_timer);
			pasafotos.cambiarVelocidad(velocidad_transicion);
			pasafotos.cambiarTransiciones(efecto);
			pasafotos.load();
			
			trace("pasafotos = ", pasafotos);
					
			addChild(pasafotos);	
		}
		
		public function unload()
		{
			if (pasafotos != null) pasafotos.unload();
			
			arrayPasafotos = new Array();
			sentido = "Ninguno";
			direccion = "toIzda";
			efecto = "easeOutSine";
			tiempo_timer = 5000;
			velocidad_transicion = 1;
		}
	}
	
}
