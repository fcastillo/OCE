package  {
	
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	public class CMainCargarMenu extends MovieClip {
		
		
		public function CMainCargarMenu() 
		{
			// constructor code
			cargarPasafotos();
		}
		
		function cargarMenu()
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleData);
			loader.load(new URLRequest("control_menu.swf"));					
		}
		
		function cargarPasafotos()
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleDataPasafotos);
			loader.load(new URLRequest("pasafotos_VDAP.swf"));	
		}
		
		function handleData(e:Event)
		{
			var nodo:XML = new XML('<ELEMENTO alto="1" ancho="1" tipo="menu" ID="" estilo="Ninguno" url_fondo="fondo_verde.jpg" color_fondo="16777215" hayColorFondo="false" existe_fondo="false" cabecera_txt="19 de Abril de 2012" tituloP_txt="TÍTULO PRINCIPAL&#xA;MENÚ DE FIN DE SEMANA" titulo1_txt="Entrantes - Título 1" titulo2_txt="Plato principal - Título 2" titulo3_txt="Postre - Título 3" texto1_txt="Plato1&#xA;Plato 2&#xA;Plato 3&#xA;Plato 4&#xA;Plato 5&#xA;Plato 6" texto2_txt="Plato1&#xA;Plato 2&#xA;Plato 3&#xA;Plato 4&#xA;Plato 5&#xA;Plato 6" texto3_txt="Plato1&#xA;Plato 2&#xA;Plato 3&#xA;Plato 4&#xA;Plato 5&#xA;Plato 6" pie_txt="PIE" cabecera_visible="true" tituloP_visible="true" titulo1_visible="true" titulo2_visible="true" titulo3_visible="true" texto1_visible="true" texto2_visible="true" texto3_visible="true" pie_visible="true" cabecera_color="13056" tituloP_color="13056" titulo1_color="13056" titulo2_color="13056" titulo3_color="13056" texto1_color="0" texto2_color="0" texto3_color="0" pie_color="0" cabecera_fuente="Arial" tituloP_fuente="Arial" titulo1_fuente="Arial" titulo2_fuente="Arial" titulo3_fuente="Arial" texto1_fuente="Arial" texto2_fuente="Arial" texto3_fuente="Arial" pie_fuente="Arial" cabecera_size="16" tituloP_size="26" titulo1_size="20" titulo2_size="20" titulo3_size="20" texto1_size="18" texto2_size="18" texto3_size="18" pie_size="16" cabecera_align="right" tituloP_align="left" titulo1_align="left" titulo2_align="center" titulo3_align="center" texto1_align="right" texto2_align="left" texto3_align="left" pie_align="right" cabecera_negrita="false" tituloP_negrita="true" titulo1_negrita="true" titulo2_negrita="true" titulo3_negrita="true" texto1_negrita="false" texto2_negrita="false" texto3_negrita="false" pie_negrita="false" cabecera_cursiva="false" tituloP_cursiva="false" titulo1_cursiva="false" titulo2_cursiva="false" titulo3_cursiva="false" texto1_cursiva="false" texto2_cursiva="false" texto3_cursiva="false" pie_cursiva="false" cabecera_subrayado="false" tituloP_subrayado="false" titulo1_subrayado="false" titulo2_subrayado="false" titulo3_subrayado="false" texto1_subrayado="false" texto2_subrayado="false" texto3_subrayado="false" pie_subrayado="false" cabecera_bullet="false" tituloP_bullet="false" titulo1_bullet="false" titulo2_bullet="false" titulo3_bullet="false" texto1_bullet="false" texto2_bullet="false" texto3_bullet="false" pie_bullet="false" profundidad="1" transparencia="0.5553" cY="0" cX="0" path="null"/>')
			
			e.currentTarget.content.loadXML(nodo);
			
			var menu:MovieClip = new MovieClip();
			menu.addChild(e.currentTarget.content)
						
			menu.x = 0;
			menu.y = 0;
			
			addChild(menu);
		}
		
		function handleDataPasafotos(e:Event)
		{
			var nodo:XML = new XML('<ELEMENTO alto="0.5" ancho="0.5" tipo="pasafotos" ID="3,4,6" url_imagenes="CAPTURAS_0000_Capa 16.jpg,CAPTURAS_0002_Capa 14.jpg,CAPTURAS_0010_Capa 6.jpg" tiempo_trans="5000" vel_trans="1" sentido="Vertical" direccion="toUp" efecto="easeOutBack" profundidad="1" transparencia="1" cY="0" cX="0" path="pasafotos_VDAP.swf"/>')
			
			e.currentTarget.content.loadXML(nodo,"","CArea1");
			
			var menu:MovieClip = new MovieClip();
			menu.addChild(e.currentTarget.content)
						
			menu.x = 0;
			menu.y = 0;
			
			addChild(menu);
		}
	}
	
}
