package  {
	
	import flash.display.MovieClip;
	import cod.CElementoPasafotos;
	
	public class CMainPasafotosVDAP extends MovieClip 
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
		public var tipoArea:String;
		
		public var pathDatos:String;
				
		public function CMainPasafotosVDAP() 
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
			arrayPasafotos = (datos.@url_imagenes).toString().split(",");
			sentido = datos.@sentido;
			direccion = datos.@direccion;
			efecto = datos.@efecto;
			tiempo_timer = int(datos.@tiempo_trans);
			velocidad_transicion = Number(datos.@vel_trans);
			pathDatos = path;
			tipoArea = tipo_area;
			
			if(path != "")
			{
				for (var i:int = 0; i<arrayPasafotos.length; i++)
				{
					arrayPasafotos[i] = pathDatos.concat("\\",arrayPasafotos[i]);
				}
			}
			
			//Dimensiones
			var valAncho:Number;
			var valAlto:Number;
			
			trace("tipo_area = ", tipo_area);
			
			if(tipo_area.indexOf("CArea1") != -1)
			{
				valAncho = 375;
				valAlto = 800;
			}
			else if(tipo_area.indexOf("CArea3") != -1)
			{
				valAncho = 225;
				valAlto = 265;
			}
			else if(tipo_area.indexOf("CArea4") != -1)
			{
				valAncho = 225;
				valAlto = 170;
			}
			
			ancho = Number(datos.@ancho)*valAncho;
			alto = Number(datos.@alto)*valAlto;
			
			trace("ancho = ", datos.@ancho);
			trace("alto = ", datos.@ancho);
			
			trace("ancho = ", ancho);
			trace("alto = ", alto);
			
			cargarPasafotos();
		}
		
		public function descargarPasafotos()
		{
			//trace("*****CMainPasafotosVDAP - descargarPasafotos *******");
			if (pasafotos != null) pasafotos.unload();
		}
		
		public function cargarPasafotos()
		{
			pasafotos = new CElementoPasafotos(this);
			
			//if(tipoArea.indexOf("CArea1") != -1) pasafotos.setConstants(-375,375,800,-800);
			//else if(tipoArea.indexOf("CArea3") != -1) pasafotos.setConstants(-225,225,265,-265);
			//else if(tipoArea.indexOf("CArea4") != -1) pasafotos.setConstants(-225,225,170,-170);
			
			pasafotos.setConstants(Math.round(-ancho),Math.round(ancho),Math.round(alto),Math.round(-alto));
			
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
		
			addChild(pasafotos);	
		}
	}
	
}
