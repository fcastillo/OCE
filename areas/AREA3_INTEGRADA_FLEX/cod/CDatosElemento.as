package cod
{
	import flash.display.MovieClip;
	
	public class CDatosElemento extends MovieClip
	{
		//VARIABLES
		public var tipo:String;
		public var xpos:Number;
		public var ypos:Number;
		public var zpos:Number;
		public var ancho:Number;
		public var alto:Number;
		public var transparencia:Number;
		public var contenido:MovieClip;
		public var url_datos:String;
		public var lector_tiempo:CElementoTiempo;
		public var control_menu:CElementoControlMenu;
		public var lector_rss:CElementoRSS_extendido;
		public var control_reloj:CElementoReloj_extendido;
		
		public var array_pasafotos:Array;
		public var direccion:String;
		public var sentido:String;
		public var efecto:String;
		public var tiempo:int;
		public var velocidad:Number;
		
		///<summary>
		///Constructor; almacenamos todos los datos de un elemento de tipo CContenedorElemento
		///</summary>
		public function CDatosElemento(tipo_mc,xpos,ypos,profundidad,dim_w,dim_h,valor_alpha,datos,url,elem_tiempo,menu,rss,fotos,dir,sntido,efect,valor_tiempo:int,vel:Number,reloj) 
		{
			//Variables comunes a todos los elementos
			tipo = tipo_mc;
			xpos = xpos;
			ypos = ypos;
			zpos = profundidad;
			ancho = dim_w;
			alto = dim_h;
			transparencia = valor_alpha;
			contenido = datos;
			url_datos = url
			
			//Controladores para los controles especiales
			lector_tiempo = elem_tiempo;
			control_menu = menu;
			lector_rss = rss;
			control_reloj = reloj;
			
			//pasafotos
			array_pasafotos = fotos;
			direccion = dir;
			sentido = sntido;
			efecto = efect;
			tiempo = valor_tiempo;
			velocidad = Number(vel);
		}
	}
	
}
