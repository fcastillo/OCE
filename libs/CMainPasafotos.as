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
		public var arraydO : Array = new Array();
		
		public var ancho:Number = 225;
		public var alto:Number = 170;
		public var xPos:Number = 0;
		public var yPos:Number = 0;
		
		public var pathDatos:String;
		
		
		public function getDispObjArr():Array
		{
			return(arraydO);
		}
		
		public function CMainPasafotos() 
		{
			// constructor code
		}
		
		//---------Función loadXML---------//
		//-- Edita el control según los atributos leídos en el dpe
		//-- Variables de entrada:
			//--datos: nodo xml del dpe
		//--------------------------------------//
		public function loadXML(datos:XML,path:String,pw:int, ph:int)
		{		
			//trace("*************pasafotos loadXML***************");
			arrayPasafotos = (datos.@url_imagenes).toString().split(",");
			sentido = datos.@sentido;
			direccion = datos.@direccion;
			efecto = datos.@efecto;
			tiempo_timer = int(datos.@tiempo_trans);
			velocidad_transicion = Number(datos.@vel_trans);
			
			pathDatos = path;
			
			/*if ((pathDatos != "") && (pathDatos != null))
			{
				for (var i:int = 0; i<arrayPasafotos.length; i++)
				{
					arrayPasafotos[i] = pathDatos.concat("\\",arrayPasafotos[i]);
				}
			}*/
						
			ancho = Number(datos.@ancho)*pw;
			alto = Number(datos.@alto)*ph;
			xPos = Number(datos.@cX)*pw;
			yPos = Number(datos.@cY)*ph;
			
			trace("[CMainPasafotos] - loadXML()) -> ancho="+ancho+" alto="+alto+" xPos="+xPos+" yPos="+yPos);
			this.fondo.width = ancho;
			this.fondo.height = alto;
			this.masc.width = ancho;
			this.masc.height = alto;
			this.fondo.x = 0;
			this.fondo.y = 0;
			this.masc.x = 0;
			this.masc.y = 0;
			cargarPasafotos();
		}
		
		/*public function loadXML(datos:XML,path:String,tipo_area:String="")
		{		
			//trace("*************pasafotos loadXML***************");
			arrayPasafotos = (datos.@url_imagenes).toString().split(",");
			sentido = datos.@sentido;
			direccion = datos.@direccion;
			efecto = datos.@efecto;
			tiempo_timer = int(datos.@tiempo_trans);
			velocidad_transicion = Number(datos.@vel_trans);
			
			pathDatos = path;
			
			if ((pathDatos != "") && (pathDatos != null))
			{
				for (var i:int = 0; i<arrayPasafotos.length; i++)
				{
					arrayPasafotos[i] = pathDatos.concat("\\",arrayPasafotos[i]);
				}
			}
						
			ancho = Number(datos.@ancho)*600;
			alto = Number(datos.@alto)*800;
			xPos = Number(datos.@cX)*600;
			yPos = Number(datos.@cY)*800;
			
			cargarPasafotos();
		}*/
		
		public function cargarPasafotos()
		{
			//trace("******************cargarPasafotos****************");
			pasafotos = new CElementoPasafotos(this);
			
			pasafotos.setConstants(Math.round(-ancho),Math.round(ancho),Math.round(alto),Math.round(-alto));
						
			pasafotos.setAncho(ancho);
			pasafotos.setAlto(alto);
			pasafotos.setXpos(xPos);
			pasafotos.setYpos(yPos);
			pasafotos.setArrayUrls(arrayPasafotos);
			pasafotos.setSentidoTrans(sentido);
			pasafotos.setOperationMode(sentido);
			pasafotos.setDireccion(direccion);
			pasafotos.setEfectoFade(efecto);			
			pasafotos.setTiempoTimer(tiempo_timer);
			pasafotos.cambiarVelocidad(velocidad_transicion);
			pasafotos.cambiarTransiciones(efecto);
			pasafotos.load();
						
			//Mascara???
			var mascara:CMascara = new CMascara();
			mascara.width = ancho;
			mascara.height = alto;
			mascara.x = xPos;
			mascara.y = yPos;
			pasafotos.mask = mascara;
					
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
