package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class CMainCargarRSS extends MovieClip 
	{		
		public function CMainCargarRSS() 
		{
			// constructor code
			cargarControl();
			//cargarRelojDigital();
		}
		
		function cargarControl()
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleData);
			loader.load(new URLRequest("controlRSS_estilo1Player_v2.swf"));					
		}
		
		function cargarRelojDigital()
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleData);
			loader.load(new URLRequest("reloj_analog_v2.swf"));					
		}
		
		function handleData(e:Event)
		{
			var nodo:XML = new XML('<ELEMENTO alto="0.10625" ancho="1" tipo="rss" estilo="estilo1" tiempo_transicion="15" velocidad="100" titulo_activo="true" velocidad_titulo="12" imagen_visible="true" color_superior="17766" alpha_superior="1" color_inferior="6257920" alpha_inferior="1" color_titulos="16777215" color_textos="16777215" fuente_titulos="Times New Roman" fuente_textos="Arial" size_titulos="18" size_textos="12" align_titulos="left" align_textos="left" negrita_titulo="false" negrita_texto="false" cursiva_titulo="false" cursiva_texto="false" subrayado_titulo="false" subrayado_texto="false" rss_url="http://feeds.bbci.co.uk/news/world/rss.xml?edition=uk" profundidad="1" transparencia="1" cY="0.7325" cX="0.005333333333333333" path="controlRSS_estilo1Player_v2.swf"/>')
			
			e.currentTarget.content.loadXML(nodo);
			
			var control:MovieClip = new MovieClip();
			control.addChild(e.currentTarget.content)
						
			control.x = 0;
			control.y = 0;
			
			addChild(control);
		}
	}
	
}
