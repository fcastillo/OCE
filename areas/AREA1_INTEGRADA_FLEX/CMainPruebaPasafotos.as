package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.DisplayObject;
	
	import cod.*;
	
	public class CMainPruebaPasafotos extends MovieClip 
	{
		var control_pasafotos:CElementoControlPasafotos;
				
		public function CMainPruebaPasafotos() 
		{
			// constructor code
			cargarSWF();
		}
		
		public function cargarSWF()
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,handleData);
			loader.load(new URLRequest("control_pasafotos.swf"));
		}
		
		public function handleData(e:Event)
		{
			trace("*********handleData**************");
			control_pasafotos = new CElementoControlPasafotos(e.currentTarget.content);
			control_pasafotos.load();
						
			var arrayUrlImagenes:Array = new Array("edinburgo.jpg","rayo.jpg","rio.jpg","cascada.jpg");
						
			control_pasafotos.pararTemporizador();
			control_pasafotos.guardarNumImagenes(arrayUrlImagenes.length);
			control_pasafotos.guardarArrayImagenes(arrayUrlImagenes);
			control_pasafotos.reanudarTemporizador();
			
			e.currentTarget.content.width = fondo.width;
			e.currentTarget.content.height = fondo.height;
			fondo.addChild(e.currentTarget.content);
		}
	}
	
}
