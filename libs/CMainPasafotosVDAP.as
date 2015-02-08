package  {
	
	import flash.display.MovieClip;
	import cod.CElementoPasafotos;
	import flash.display.DisplayObject;
	
	public class CMainPasafotosVDAP extends MovieClip 
	{
		public var pasafotos:CElementoPasafotos; 
		public var arrayPasafotos:Array = new Array();
		public var arraydO : Array = new Array(); 
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
			//loadXML(new XML('<ELEMENTO alto="0.2525" ancho="0.5866666666666667" tipo="pasafotos" ID="15,16" url_imagenes="Orona-IDeO-innovation-city.jpg,piso3-fondo.jpg" tiempo_trans="5000" vel_trans="1" sentido="Ninguno" direccion="toIzda" efecto="easeOutSine" profundidad="7" transparencia="1" cY="0.315" cX="0.4026666666666667" path="pasafotos_VDAP.swf"/>'),'C:\\Xampp\\htdocs\\orona_oce\\DATOS_OCP','CArea1');
		}
		
		public function getDispObjArr():Array
		{
			return(arraydO);
		}
		//---------Función loadXML---------//
		//-- Edita el control según los atributos leídos en el dpe
		//-- Variables de entrada:
			//--datos: nodo xml del dpe
		//--------------------------------------//
		public function loadXML(datos:XML,path:String,tipo_area:String)
		{	
			trace("loadXML de pasafotos datos= "+datos.toXMLString()+" path = "+path+" tipo_area="+tipo_area);
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
				trace(arrayPasafotos.length);
				for (var i:int = 0; i<arrayPasafotos.length; i++)
				{
					trace("concatenando path a imagenes del pasafotos -> "+i+" - "+pathDatos.concat("\\",arrayPasafotos[i]));
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
			
			//ancho = 225;
			//alto = 170;
			
			
			trace("Dentro del pasafotos : AREA "+tipo_area+" ancho = "+ancho+", alto = "+alto);
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
		
		public function descargarPasafotos()
		{
			//trace("*****CMainPasafotosVDAP - descargarPasafotos *******");
			if (pasafotos != null) pasafotos.unload();
		}
		
		public function cargarPasafotos()
		{
			trace("CargarPasafotos");
			pasafotos = new CElementoPasafotos(this);
			
			//if(tipoArea.indexOf("CArea1") != -1) pasafotos.setConstants(-375,375,800,-800);
			//else if(tipoArea.indexOf("CArea3") != -1) pasafotos.setConstants(-225,225,265,-265);
			//else if(tipoArea.indexOf("CArea4") != -1) pasafotos.setConstants(-225,225,170,-170);
			trace("--> "+Math.round(-ancho)+" "+Math.round(ancho)+" "+Math.round(alto)+" "+Math.round(-alto));
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
			
			/////// iñaki 2013-04-29
			//pasafotos.width = ancho;
			//pasafotos.height = alto;
			///////
			
			pasafotos.load();
			
			//Mascara???
			var mascara:CMascara = new CMascara();
			mascara.width = ancho;
			mascara.height = alto;
			
			trace("PAPAPAPAsafotos "+pasafotos.width+", "+pasafotos.height);
			/*pasafotos.width = ancho;
			pasafotos.height = alto;
			contenedor.width = ancho;
			contenedor.height = alto;*/
			contenedor.addChild(pasafotos);
			
			//addChild(mascara);
			//pasafotos.mask = mascara;
			
		}
		
		public function init()
		{
			cargarPasafotos();
		}
	}
	
}
