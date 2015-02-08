package  {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.DisplayObject;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	import flash.geom.ColorTransform;
	
	import cod.CElementoEstilo;
	
	public class CMainControlMenu extends MovieClip 
	{
		public var formato_texto:TextFormat;
		var arrayFondos:Array = new Array("fondo_estilo1.jpg", "fondo_estilo2.jpg");
		var estilo1_fondo:MovieClip = new MovieClip();
		var estilo2_fondo:MovieClip = new MovieClip();
		var conEstilo:Boolean = false;
		var nombre_estilo:String = "";
		var rectangulo:Sprite;
		
		var pathDatos:String;
		
		//Array para guardar estilos
		var array_estilos:Array;
		
		//Fuentes embebidas
		var fontTitular1:menu1Titular1 = new menu1Titular1();
		var fontTitular2:menu1Titular2 = new menu1Titular2();
		var fontTimes:timesLTSTD = new timesLTSTD();
		var fontTriplex:triplex = new triplex();
				
		public function CMainControlMenu() 
		{
			// constructor code
			array_estilos = new Array();
			
			crearEstilos();
			var xml = new XML('<ELEMENTO alto="0.205" ancho="0.20533333333333334" tipo="menu" estilo="ninguno" url_fondo="tulipanes.jpg" color_fondo="16777215" hayColorFondo="false" existe_fondo="true" cabecera_txt="CABECERA" tituloP_txt="TÍTULO PRINCIPAL&#xA;MENÚ DE FIN DE SEMANA" titulo1_txt="Entrantes - Título 1" titulo2_txt="Plato principal - Título 2" titulo3_txt="Postre - Título 3" texto1_txt="Plato1&#xA;Plato 2&#xA;Plato 3&#xA;Plato 4&#xA;Plato 5&#xA;Plato 6" texto2_txt="Plato1&#xA;Plato 2&#xA;Plato 3&#xA;Plato 4&#xA;Plato 5&#xA;Plato 6" texto3_txt="Plato1&#xA;Plato 2&#xA;Plato 3&#xA;Plato 4&#xA;Plato 5&#xA;Plato 6" pie_txt="PIE" cabecera_visible="true" tituloP_visible="true" titulo1_visible="true" titulo2_visible="true" titulo3_visible="true" texto1_visible="true" texto2_visible="true" texto3_visible="true" pie_visible="true" cabecera_color="0" tituloP_color="0" titulo1_color="0" titulo2_color="0" titulo3_color="0" texto1_color="10027008" texto2_color="10027008" texto3_color="10027008" pie_color="0" cabecera_fuente="Times New Roman" tituloP_fuente="Clarendon LT Std" titulo1_fuente="Chocolate Amargo" titulo2_fuente="Chocolate Amargo" titulo3_fuente="Chocolate Amargo" texto1_fuente="Times LT Std" texto2_fuente="Times LT Std" texto3_fuente="Times LT Std" pie_fuente="Times New Roman" cabecera_size="30" tituloP_size="30" titulo1_size="36" titulo2_size="36" titulo3_size="36" texto1_size="18" texto2_size="18" texto3_size="18" pie_size="16" cabecera_align="center" tituloP_align="center" titulo1_align="center" titulo2_align="center" titulo3_align="center" texto1_align="center" texto2_align="center" texto3_align="center" pie_align="center" cabecera_negrita="false" tituloP_negrita="false" titulo1_negrita="false" titulo2_negrita="false" titulo3_negrita="false" texto1_negrita="false" texto2_negrita="false" texto3_negrita="false" pie_negrita="false" cabecera_cursiva="false" tituloP_cursiva="false" titulo1_cursiva="true" titulo2_cursiva="true" titulo3_cursiva="true" texto1_cursiva="true" texto2_cursiva="true" texto3_cursiva="true" pie_cursiva="false" cabecera_subrayado="false" tituloP_subrayado="false" titulo1_subrayado="true" titulo2_subrayado="true" titulo3_subrayado="true" texto1_subrayado="false" texto2_subrayado="false" texto3_subrayado="false" pie_subrayado="false" cabecera_bullet="false" tituloP_bullet="false" titulo1_bullet="false" titulo2_bullet="false" titulo3_bullet="false" texto1_bullet="false" texto2_bullet="false" texto3_bullet="false" pie_bullet="false" profundidad="8" transparencia="1" cY="0.7925" cX="0.792" path="control_menu.swf"/>');
			
			
			var xml2 = new XML('<ELEMENTO alto="1" ancho="1" tipo="menu" estilo="Ninguno" url_fondo="" color_fondo="16777215" hayColorFondo="false" existe_fondo="false" cabecera_txt="1111111111111111111111111111111111111111111111122222222222222222222222222222222222222222222222333333333333333333333333333333333333333333333334444444444444444444444444444444444444444444444455555555555555555555555555555555555555555555555&#xD;&#xD;" tituloP_txt="1111111111111111111111111111111111111111111111122222222222222222222222222222222222222222222222333333333333333333333333333333333333333333333334444444444444444444444444444444444444444444444455555555555555555555555555555555555555555555555" titulo1_txt="1111111111111111111111111111111111111111111111122222222222222222222222222222222222222222222222333333333333333333333333333333333333333333333334444444444444444444444444444444444444444444444455555555555555555555555555555555555555555555555" titulo2_txt="1111111111111111111111111111111111111111111111122222222222222222222222222222222222222222222222333333333333333333333333333333333333333333333334444444444444444444444444444444444444444444444455555555555555555555555555555555555555555555555" titulo3_txt="1111111111111111111111111111111111111111111111122222222222222222222222222222222222222222222222333333333333333333333333333333333333333333333334444444444444444444444444444444444444444444444455555555555555555555555555555555555555555555555" texto1_txt="1111111111111111111111111111111111111111111111122222222222222222222222222222222222222222222222333333333333333333333333333333333333333333333334444444444444444444444444444444444444444444444455555555555555555555555555555555555555555555555" texto2_txt="1111111111111111111111111111111111111111111111122222222222222222222222222222222222222222222222333333333333333333333333333333333333333333333334444444444444444444444444444444444444444444444455555555555555555555555555555555555555555555555" texto3_txt="1111111111111111111111111111111111111111111111122222222222222222222222222222222222222222222222333333333333333333333333333333333333333333333334444444444444444444444444444444444444444444444455555555555555555555555555555555555555555555555" pie_txt="1111111111111111111111111111111111111111111111122222222222222222222222222222222222222222222222333333333333333333333333333333333333333333333334444444444444444444444444444444444444444444444455555555555555555555555555555555555555555555555" cabecera_visible="true" tituloP_visible="true" titulo1_visible="true" titulo2_visible="true" titulo3_visible="true" texto1_visible="true" texto2_visible="true" texto3_visible="true" pie_visible="true" cabecera_color="0" tituloP_color="0" titulo1_color="0" titulo2_color="0" titulo3_color="0" texto1_color="0" texto2_color="0" texto3_color="0" pie_color="0" cabecera_fuente="Arial" tituloP_fuente="Arial" titulo1_fuente="Arial" titulo2_fuente="Arial" titulo3_fuente="Arial" texto1_fuente="Arial" texto2_fuente="Arial" texto3_fuente="Arial" pie_fuente="Arial" cabecera_size="16" tituloP_size="16" titulo1_size="16" titulo2_size="16" titulo3_size="16" texto1_size="16" texto2_size="16" texto3_size="16" pie_size="16" cabecera_align="right" tituloP_align="center" titulo1_align="left" titulo2_align="left" titulo3_align="left" texto1_align="left" texto2_align="left" texto3_align="left" pie_align="right" cabecera_negrita="false" tituloP_negrita="false" titulo1_negrita="false" titulo2_negrita="false" titulo3_negrita="false" texto1_negrita="false" texto2_negrita="false" texto3_negrita="false" pie_negrita="false" cabecera_cursiva="false" tituloP_cursiva="false" titulo1_cursiva="false" titulo2_cursiva="false" titulo3_cursiva="false" texto1_cursiva="false" texto2_cursiva="false" texto3_cursiva="false" pie_cursiva="false" cabecera_subrayado="false" tituloP_subrayado="false" titulo1_subrayado="false" titulo2_subrayado="false" titulo3_subrayado="false" texto1_subrayado="false" texto2_subrayado="false" texto3_subrayado="false" pie_subrayado="false" cabecera_bullet="false" tituloP_bullet="false" titulo1_bullet="false" titulo2_bullet="false" titulo3_bullet="false" texto1_bullet="false" texto2_bullet="false" texto3_bullet="false" pie_bullet="false" profundidad="1" transparencia="1" cY="0" cX="0" path="control_menu.swf"/>');
			//loadXML(xml2,"");
		}
		
		//---------Función loadXML---------//
		//-- Edita el control según los atributos leídos en el dpe
		//-- Variables de entrada:
			//--datos: nodo xml del dpe
		//--------------------------------------//
		public function loadXML(datos:XML,path:String)
		{			
			trace("[CMainControlMenu] - loadXML() -> datos="+datos+", path="+path);
			//Path de datos
			pathDatos = path;
					
			//ESTILO
			var estilo:String = datos.@estilo;
			if (estilo != "Ninguno") cambiar_estilo(estilo);
			
			//EXISTE FONDO
			var existe_fondo:Boolean;
			datos.@existe_fondo == "true" ? existe_fondo = true : existe_fondo = false;
			if (!existe_fondo) borrar_fondo();
			
			//IMAGEN O COLOR DE FONDO
			var url_fondo:String = datos.@url_fondo;
			var color_fondo:String = datos.@color_fondo;
			var color_hex = displayInHex(uint(color_fondo));
			color_hex = "#"+color_hex;
			
			var hayColorFondo:Boolean;
			datos.@hayColorFondo == "true" ? hayColorFondo = true : hayColorFondo = false;
			
			if (url_fondo != "") 
			{
				if(pathDatos == null) pathDatos = "";
				if(pathDatos != "") url_fondo = pathDatos.concat("\\",url_fondo);
				cargarImagenFondo(url_fondo);
			}
			else if (hayColorFondo) editar_colorFondo(color_hex);
			
			//CABECERA
			var cabecera_visible:Boolean;
			datos.@cabecera_visible == "true" ? cabecera_visible = true : cabecera_visible = false;
			
			if (cabecera_visible)
			{
				var cabecera_txt:String = datos.@cabecera_txt;
				var cabecera_color:String = datos.@cabecera_color;
				var cabecera_fuente:String = datos.@cabecera_fuente;
				var cabecera_size:String = datos.@cabecera_size;
				var cabecera_align:String = datos.@cabecera_align;
				var cabecera_negrita:Boolean;
				var cabecera_cursiva:Boolean;
				var cabecera_subrayado:Boolean;
				var cabecera_bullet:Boolean;
							
				datos.@cabecera_negrita == "true" ? cabecera_negrita = true : cabecera_negrita = false;
				datos.@cabecera_cursiva == "true" ? cabecera_cursiva = true : cabecera_cursiva = false;
				datos.@cabecera_subrayado == "true" ? cabecera_subrayado = true : cabecera_subrayado = false;
				datos.@cabecera_bullet == "true" ? cabecera_bullet = true : cabecera_bullet = false;
				
				txtCabecera.text = cabecera_txt;
				var formato_cabecera:TextFormat = new TextFormat(cabecera_fuente,cabecera_size,cabecera_color,cabecera_negrita,cabecera_cursiva,cabecera_subrayado,null,null,cabecera_align,null,null,null,null);
				formato_cabecera.bullet = cabecera_bullet;
				txtCabecera.setTextFormat(formato_cabecera);
				txtCabecera.height = txtCabecera.textHeight + 10;
			}
			else txtCabecera.visible = false;
			
			//TITULO PRINCIPAL
			var tituloP_visible:Boolean;
			datos.@tituloP_visible == "true" ? tituloP_visible = true : tituloP_visible = false;
			
			if (tituloP_visible)
			{
				var tituloP_txt:String = datos.@tituloP_txt;
				var tituloP_color:String = datos.@tituloP_color;
				var tituloP_fuente:String = datos.@tituloP_fuente;
				var tituloP_size:String = datos.@tituloP_size;
				var tituloP_align:String = datos.@tituloP_align;
				var tituloP_negrita:Boolean;
				var tituloP_cursiva:Boolean;
				var tituloP_subrayado:Boolean;
				var tituloP_bullet:Boolean;
				
				datos.@tituloP_negrita == "true" ? tituloP_negrita = true : tituloP_negrita = false;
				datos.@tituloP_cursiva == "true" ? tituloP_cursiva = true : tituloP_cursiva = false;
				datos.@tituloP_subrayado == "true" ? tituloP_subrayado = true : tituloP_subrayado = false;
				datos.@tituloP_bullet == "true" ? tituloP_bullet = true : tituloP_bullet = false;
				
				txtTitulo.text = tituloP_txt;
				var formato_tituloP:TextFormat = new TextFormat(tituloP_fuente,tituloP_size,tituloP_color,tituloP_negrita,tituloP_cursiva,tituloP_subrayado,null,null,tituloP_align,null,null,null,null);
				formato_tituloP.bullet = tituloP_bullet;
				txtTitulo.setTextFormat(formato_tituloP);
				txtTitulo.defaultTextFormat = formato_tituloP;
				txtTitulo.height = txtTitulo.textHeight + 10;
			}
			else txtTitulo.visible = false;
			
			//TITULO 1
			var titulo1_visible:Boolean;
			datos.@titulo1_visible == "true" ? titulo1_visible = true : titulo1_visible = false;
			
			if (titulo1_visible)
			{
				var titulo1_txt:String = datos.@titulo1_txt;
				var titulo1_color:String = datos.@titulo1_color;
				var titulo1_fuente:String = datos.@titulo1_fuente;
				var titulo1_size:String = datos.@titulo1_size;
				var titulo1_align:String = datos.@titulo1_align;
				var titulo1_negrita:Boolean;
				var titulo1_cursiva:Boolean;
				var titulo1_subrayado:Boolean;
				var titulo1_bullet:Boolean;
				
				datos.@titulo1_negrita == "true" ? titulo1_negrita = true : titulo1_negrita = false;
				datos.@titulo1_cursiva == "true" ? titulo1_cursiva = true : titulo1_cursiva = false;
				datos.@titulo1_subrayado == "true" ? titulo1_subrayado = true : titulo1_subrayado = false;
				datos.@titulo1_bullet == "true" ? titulo1_bullet = true : titulo1_bullet = false;
				
				txtSubtitulo1.text = titulo1_txt;
				var formato_titulo1:TextFormat = new TextFormat(titulo1_fuente,titulo1_size,titulo1_color,titulo1_negrita,titulo1_cursiva,titulo1_subrayado,null,null,titulo1_align,null,null,null,null);
				formato_titulo1.bullet = titulo1_bullet;
				txtSubtitulo1.setTextFormat(formato_titulo1);
				txtSubtitulo1.height = txtSubtitulo1.textHeight + 10;
				//txtSubtitulo1.width = txtSubtitulo1.textWidth + 10;
			}
			else txtSubtitulo1.visible = false;
			
			//TITULO 2
			var titulo2_visible:Boolean;
			datos.@titulo2_visible == "true" ? titulo2_visible = true : titulo2_visible = false;
			
			if (titulo2_visible)
			{
				var titulo2_txt:String = datos.@titulo2_txt;
				var titulo2_color:String = datos.@titulo2_color;
				var titulo2_fuente:String = datos.@titulo2_fuente;
				var titulo2_size:String = datos.@titulo2_size;
				var titulo2_align:String = datos.@titulo2_align;
				var titulo2_negrita:Boolean;
				var titulo2_cursiva:Boolean;
				var titulo2_subrayado:Boolean;
				var titulo2_bullet:Boolean;
				
				datos.@titulo2_negrita == "true" ? titulo2_negrita = true : titulo2_negrita = false;
				datos.@titulo2_cursiva == "true" ? titulo2_cursiva = true : titulo2_cursiva = false;
				datos.@titulo2_subrayado == "true" ? titulo2_subrayado = true : titulo2_subrayado = false;
				datos.@titulo2_bullet == "true" ? titulo2_bullet = true : titulo2_bullet = false;
				
				txtSubtitulo2.text = titulo2_txt;
				var formato_titulo2:TextFormat = new TextFormat(titulo2_fuente,titulo2_size,titulo2_color,titulo2_negrita,titulo2_cursiva,titulo2_subrayado,null,null,titulo2_align,null,null,null,null);
				formato_titulo2.bullet = titulo2_bullet;
				txtSubtitulo2.setTextFormat(formato_titulo2);
				txtSubtitulo2.height = txtSubtitulo2.textHeight + 10;
			}
			else txtSubtitulo2.visible = false;
			
			//TITULO 3
			var titulo3_visible:Boolean;
			datos.@titulo3_visible == "true" ? titulo3_visible = true : titulo3_visible = false;
			
			if (titulo3_visible)
			{
				var titulo3_txt:String = datos.@titulo3_txt;
				var titulo3_color:String = datos.@titulo3_color;
				var titulo3_fuente:String = datos.@titulo3_fuente;
				var titulo3_size:String = datos.@titulo3_size;
				var titulo3_align:String = datos.@titulo3_align;
				var titulo3_negrita:Boolean;
				var titulo3_cursiva:Boolean;
				var titulo3_subrayado:Boolean;
				var titulo3_bullet:Boolean;
				
				datos.@titulo3_negrita == "true" ? titulo3_negrita = true : titulo3_negrita = false;
				datos.@titulo3_cursiva == "true" ? titulo3_cursiva = true : titulo3_cursiva = false;
				datos.@titulo3_subrayado == "true" ? titulo3_subrayado = true : titulo3_subrayado = false;
				datos.@titulo3_bullet == "true" ? titulo3_bullet = true : titulo3_bullet = false;
				
				txtSubtitulo3.text = titulo3_txt;
				var formato_titulo3:TextFormat = new TextFormat(titulo3_fuente,titulo3_size,titulo3_color,titulo3_negrita,titulo3_cursiva,titulo3_subrayado,null,null,titulo3_align,null,null,null,null);
				formato_titulo3.bullet = titulo3_bullet;
				txtSubtitulo3.setTextFormat(formato_titulo3);
				txtSubtitulo3.height = txtSubtitulo3.textHeight + 10;
			}
			else txtSubtitulo3.visible = false;
			
			//TEXTO 1
			var texto1_visible:Boolean;
			datos.@texto1_visible == "true" ? texto1_visible = true : texto1_visible = false;
			
			if (texto1_visible)
			{
				var texto1_txt:String = datos.@texto1_txt;
				var texto1_color:String = datos.@texto1_color;
				var texto1_fuente:String = datos.@texto1_fuente;
				var texto1_size:String = datos.@texto1_size;
				var texto1_align:String = datos.@texto1_align;
				var texto1_negrita:Boolean;
				var texto1_cursiva:Boolean;
				var texto1_subrayado:Boolean;
				var texto1_bullet:Boolean;
				
				datos.@texto1_negrita == "true" ? texto1_negrita = true : texto1_negrita = false;
				datos.@texto1_cursiva == "true" ? texto1_cursiva = true : texto1_cursiva = false;
				datos.@texto1_subrayado == "true" ? texto1_subrayado = true : texto1_subrayado = false;
				datos.@texto1_bullet == "true" ? texto1_bullet = true : texto1_bullet = false;
				
				txt1.text = texto1_txt;
				var formato_texto1:TextFormat = new TextFormat(texto1_fuente,texto1_size,texto1_color,texto1_negrita,texto1_cursiva,texto1_subrayado,null,null,texto1_align,null,null,null,null);
				formato_texto1.bullet = texto1_bullet;
				txt1.setTextFormat(formato_texto1);
			}
			else txt1.visible = false;
			
			//TEXTO 2
			var texto2_visible:Boolean;
			datos.@texto2_visible == "true" ? texto2_visible = true : texto2_visible = false;
			
			if (texto2_visible)
			{
				var texto2_txt:String = datos.@texto2_txt;
				var texto2_color:String = datos.@texto2_color;
				var texto2_fuente:String = datos.@texto2_fuente;
				var texto2_size:String = datos.@texto2_size;
				var texto2_align:String = datos.@texto2_align;
				var texto2_negrita:Boolean;
				var texto2_cursiva:Boolean;
				var texto2_subrayado:Boolean;
				var texto2_bullet:Boolean;
				
				datos.@texto2_negrita == "true" ? texto2_negrita = true : texto2_negrita = false;
				datos.@texto2_cursiva == "true" ? texto2_cursiva = true : texto2_cursiva = false;
				datos.@texto2_subrayado == "true" ? texto2_subrayado = true : texto2_subrayado = false;
				datos.@texto2_bullet == "true" ? texto2_bullet = true : texto2_bullet = false;
				
				txt2.text = texto2_txt;
				var formato_texto2:TextFormat = new TextFormat(texto2_fuente,texto2_size,texto2_color,texto2_negrita,texto2_cursiva,texto2_subrayado,null,null,texto2_align,null,null,null,null);
				formato_texto2.bullet = texto2_bullet;
				txt2.setTextFormat(formato_texto2);
			}
			else txt2.visible = false;
			
			//TEXTO 3
			var texto3_visible:Boolean;
			datos.@texto3_visible == "true" ? texto3_visible = true : texto3_visible = false;
			
			if (texto3_visible)
			{
				var texto3_txt:String = datos.@texto3_txt;
				var texto3_color:String = datos.@texto3_color;
				var texto3_fuente:String = datos.@texto3_fuente;
				var texto3_size:String = datos.@texto3_size;
				var texto3_align:String = datos.@texto3_align;
				var texto3_negrita:Boolean;
				var texto3_cursiva:Boolean;
				var texto3_subrayado:Boolean;
				var texto3_bullet:Boolean;
				
				datos.@texto3_negrita == "true" ? texto3_negrita = true : texto3_negrita = false;
				datos.@texto3_cursiva == "true" ? texto3_cursiva = true : texto3_cursiva = false;
				datos.@texto3_subrayado == "true" ? texto3_subrayado = true : texto3_subrayado = false;
				datos.@texto3_bullet == "true" ? texto3_bullet = true : texto3_bullet = false;
				
				txt3.text = texto3_txt;
				var formato_texto3:TextFormat = new TextFormat(texto3_fuente,texto3_size,texto3_color,texto3_negrita,texto3_cursiva,texto3_subrayado,null,null,texto3_align,null,null,null,null);
				formato_texto3.bullet = texto3_bullet;
				txt3.setTextFormat(formato_texto3);
			}
			else txt3.visible = false;
			
			//PIE
			var pie_visible:Boolean;
			datos.@pie_visible == "true" ? pie_visible = true : pie_visible = false;
			
			if (pie_visible)
			{
				var pie_txt:String = datos.@pie_txt;
				var pie_color:String = datos.@pie_color;
				var pie_fuente:String = datos.@pie_fuente;
				var pie_size:String = datos.@pie_size;
				var pie_align:String = datos.@pie_align;
				var pie_negrita:Boolean;
				var pie_cursiva:Boolean;
				var pie_subrayado:Boolean;
				var pie_bullet:Boolean;
				
				datos.@pie_negrita == "true" ? pie_negrita = true : pie_negrita = false;
				datos.@pie_cursiva == "true" ? pie_cursiva = true : pie_cursiva = false;
				datos.@pie_subrayado == "true" ? pie_subrayado = true : pie_subrayado = false;
				datos.@pie_bullet == "true" ? pie_bullet = true : pie_bullet = false;
				
				txtPie.text = pie_txt;
				var formato_pie:TextFormat = new TextFormat(pie_fuente,pie_size,pie_color,pie_negrita,pie_cursiva,pie_subrayado,null,null,pie_align,null,null,null,null);
				formato_pie.bullet = pie_bullet;
				txtPie.setTextFormat(formato_pie);
			}
			else txtPie.visible = false;
		}
		
		//---------Función cargarImagenFondo---------//
		//-- Crea un loader para cargar una imagen para el fondo
		//-- Variables de entrada:
			//--url_fondo: url a la imagen
		//--------------------------------------//
		public function cargarImagenFondo(url_fondo:String)
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onHandleFondo);
			loader.load(new URLRequest(url_fondo));
		}
		
		//---------Event Listener onHandleFondo---------//
		//-- Inserta una imagen en el fondo
		//--------------------------------------//
		public function onHandleFondo(e:Event)
		{
			var imagen:MovieClip = new MovieClip();
			imagen.addChild(e.currentTarget.content);
			cambiar_fondo(imagen);
		}
		
		//---------Funcion crearEstilos---------//
		//-- Llama a crearEstilosPredefinidos
		//--------------------------------------//
		public function crearEstilos()
		{	
			crearEstilosPredefinidos("Ninguno",null);
			
			crearEstilosPredefinidos("Estilo1",new fondo1());
			crearEstilosPredefinidos("Estilo2",new fondo4());
			crearEstilosPredefinidos("Estilo3",new fondo2());
			crearEstilosPredefinidos("Estilo4",new fondo3());
			
			crearEstilosPredefinidos("Estilo5",new fondo5());
			crearEstilosPredefinidos("Estilo6",new fondo6());
		}
				
		//---------Función editar_texto---------//
		//-- Inserta un texto en la caja indicada
		//-- Variables de entrada:
			//--texto: string a insertar
			//--instancia: texto a modificar
		//--------------------------------------//
		public function editar_texto(texto,instancia) 
		{
			formato_texto = TextField(this.getChildByName(instancia)).getTextFormat();
			TextField(this.getChildByName(instancia)).text = texto;
			TextField(this.getChildByName(instancia)).setTextFormat(formato_texto);
		}
		
		//---------Función editar_color---------//
		//-- Modifica el color de los textos
		//-- Variables de entrada:
			//--color: nuevo color
			//--instancia: texto a modificar
		//--------------------------------------//
		public function editar_color(color,instancia) 
		{
			if(color.charAt(0)=="#") color = "0x"+color.substring(1,7);
			formato_texto = TextField(this. getChildByName(instancia)).getTextFormat();
			formato_texto.color = color;
			TextField(this. getChildByName(instancia)).setTextFormat(formato_texto);
		}
		
		//---------Función editar_colorFondo---------//
		//-- Crea un fondo del color indicado
		//-- Variables de entrada:
			//--color: nuevo color
		//--------------------------------------//
		public function editar_colorFondo(color) 
		{
			var i:int = 0;
			
			if(color.charAt(0)=="#") color = "0x"+color.substring(1,7);
			
			for (i=0; i< fondo.numChildren; i++)
			{
				if (fondo.getChildAt(i) is MovieClip)
				{
					fondo.removeChildAt(i);
					i=0;
				}
			}
			
			//CREAMOS UN RECTÁNGULO COMO MOVIECLIP PARA EL FONDO
			rectangulo = new Sprite();
			rectangulo.graphics.lineStyle(0);
			rectangulo.graphics.beginFill(color);
			rectangulo.graphics.drawRect(0,0,fondo.width,fondo.height);
			rectangulo.graphics.endFill();
			rectangulo.x = 0;
			rectangulo.y = 0;
			fondo.addChild(rectangulo);
		}
		
		//---------Función borrar_fondo---------//
		//-- Borra el fondo
		//--------------------------------------//
		public function borrar_fondo() 
		{
			for (var i:int=0; i< fondo.numChildren; i++)
			{
				if ((fondo.getChildAt(i) is MovieClip) || (fondo.getChildAt(i) is Sprite))
				{
					fondo.removeChildAt(i);
					i=0;
				}
			}
		}
		
		//---------Función borrar_fondo---------//
		//-- Borra el fondo
		//--------------------------------------//
		public function eliminar_color_fondo() 
		{
			for (var i:int=0; i< fondo.numChildren; i++)
			{
				if (fondo.getChildAt(i) is Sprite)
				{
					fondo.removeChildAt(i);
					i=0;
				}
			}
		}
		
		//---------Función editar_fuente---------//
		//-- Modifica la tipografía de los textos
		//-- Variables de entrada:
			//--fuente: nueva tipografía
			//--instancia: texto a modificar
		//--------------------------------------//
		public function editar_fuente(fuente,instancia) 
		{			
			formato_texto = TextField(this. getChildByName(instancia)).getTextFormat();
			formato_texto.font = fuente;
			TextField(this. getChildByName(instancia)).setTextFormat(formato_texto);
		}
		
		//---------Función editar_tamaño---------//
		//-- Modifica el tamaño de la tipografía de los textos
		//-- Variables de entrada:
			//--tamaño: nuevo tamaño
			//--instancia: texto a modificar
		//--------------------------------------//
		public function editar_tamaño(tamaño,instancia) 
		{			
			formato_texto = TextField(this. getChildByName(instancia)).getTextFormat();
			formato_texto.size = tamaño;
			TextField(this. getChildByName(instancia)).setTextFormat(formato_texto);
		}
		
		//---------Función editar_alineacion---------//
		//-- Modifica la alineación de los textos
		//-- Variables de entrada:
			//--val: nueva alineación
			//--instancia: texto a modificar
		//--------------------------------------//
		public function editar_alineacion(val,instancia) 
		{			
			var alineacion;
			switch (val)
			{
				case "left" : alineacion = TextFormatAlign.LEFT; break;
				case "right" : alineacion = TextFormatAlign.RIGHT; break;
				case "center" : alineacion = TextFormatAlign.CENTER; break;
				case "justify" : alineacion = TextFormatAlign.JUSTIFY; break;
				default: alineacion = TextFormatAlign.LEFT; break;
			}
			formato_texto = TextField(this. getChildByName(instancia)).getTextFormat();
			formato_texto.align = alineacion;
			TextField(this. getChildByName(instancia)).setTextFormat(formato_texto);
		}
		
		//---------Función editar_negrita---------//
		//-- Modifica la propiedad "negrita" de los textos
		//-- Variables de entrada:
			//--op: valor, true o false
			//--instancia: texto a modificar
		//--------------------------------------//
		public function editar_negrita(op:Boolean,instancia) 
		{			
			formato_texto = TextField(this. getChildByName(instancia)).getTextFormat();
			formato_texto.bold = op;
			TextField(this. getChildByName(instancia)).setTextFormat(formato_texto);
		}
		
		//---------Función editar_cursiva---------//
		//-- Modifica la propiedad "cursiva" de los textos
		//-- Variables de entrada:
			//--op: valor, true o false
			//--instancia: texto a modificar
		//--------------------------------------//
		public function editar_cursiva(op:Boolean,instancia) 
		{			
			formato_texto = TextField(this. getChildByName(instancia)).getTextFormat();
			formato_texto.italic = op;
			TextField(this. getChildByName(instancia)).setTextFormat(formato_texto);
		}
		
		//---------Función editar_subrayado---------//
		//-- Modifica la propiedad "subrayado" de los textos
		//-- Variables de entrada:
			//--op: valor, true o false
			//--instancia: texto a modificar
		//--------------------------------------//
		public function editar_subrayado(op:Boolean,instancia) 
		{			
			formato_texto = TextField(this. getChildByName(instancia)).getTextFormat();
			formato_texto.underline = op;
			TextField(this. getChildByName(instancia)).setTextFormat(formato_texto);
		}
		
		//---------Función editar_invisible---------//
		//-- Modifica la propiedad "visible" de los textos
		//-- Variables de entrada:
			//--op: valor, true o false
			//--instancia: texto a modificar
		//--------------------------------------//
		public function editar_invisible(op:Boolean,instancia) 
		{			
			this.getChildByName(instancia).visible = op;
		}
		
		//---------Función getInvisible---------//
		//-- Devuelve la propiedad "visible" del texto indicado
		//--------------------------------------//
		public function getInvisible(instancia):Boolean
		{			
			return(!this.getChildByName(instancia).visible);
		}
		
		//---------Función insertar_viñetas---------//
		//-- Inserta viñetas a la izquierda del texto
		//-- Variables de entrada:
			//--op: valor, true o false
			//--instancia: texto a modificar
		//--------------------------------------//
		public function insertar_viñetas(op:Boolean,instancia) 
		{			
			formato_texto = TextField(this. getChildByName(instancia)).getTextFormat();
			formato_texto.bullet = op;
			TextField(this. getChildByName(instancia)).setTextFormat(formato_texto);
		}
		
		//---------Función cambiar_fondo---------//
		//-- Modifica el fondo
		//-- Variables de entrada:
			//--imagen: movieclip que se cargará como fondo
		//--------------------------------------//
		public function cambiar_fondo(imagen:MovieClip) 
		{	
			if (imagen != null)
			{
				imagen.width = fondo.width;
				imagen.height = fondo.height;
				fondo.addChild(imagen);
			}
		}
		
		//---------Función getTextFormat---------//
		//-- Devuelve el formato de un texto
		//-- Variables de entrada:
			//--instancia: texto del que se quiere conocer el formato
		//-- Variables de salida:
			//-- formato_texto = formato del texto
		//--------------------------------------//
		public function getFormato_texto(instancia):TextFormat
		{	
			formato_texto = TextField(this.getChildByName(instancia)).getTextFormat();
			return formato_texto;
		}
		
		//---------Función cambiar_estilo---------//
		//-- Modifica el estilo de todo el menú basándose en una plantilla
		//-- Variables de entrada:
			//--nombre: nombre del estilo
		//--------------------------------------//
		public function cambiar_estilo(nombre:String)
		{
			var estilo:CElementoEstilo;
			for (var i:int = 0; i<array_estilos.length; i++)
			{
				var objeto:CElementoEstilo = array_estilos[i];
				if (objeto != null)
				{
					if (objeto.getNombreEstilo() == nombre)
					{
						estilo = objeto;
						break;
					}
				}
				
			}
			
			//Ya tenemos el estilo que queremos guardar en la variable objeto
			if (estilo != null)
			{
				//Fondo
				cambiar_fondo(estilo.getFondo());
				
				//Cabecera
				txtCabecera.setTextFormat(estilo.getFormatoTexto("txtCabecera"));
								
				//Titular
				txtTitulo.setTextFormat(estilo.getFormatoTexto("txtTitulo"));
				trace( estilo.getFormatoTexto("txtTitulo").color);
																
				//Subtítulos
				txtSubtitulo1.setTextFormat(estilo.getFormatoTexto("txtSubtitulo1"));
				txtSubtitulo2.setTextFormat(estilo.getFormatoTexto("txtSubtitulo2"));
				txtSubtitulo3.setTextFormat(estilo.getFormatoTexto("txtSubtitulo3"));
											
								
				//Textos
				var formato_txt1:TextFormat = estilo.getFormatoTexto("txt1");
				var formato_txt2:TextFormat = estilo.getFormatoTexto("txt2");
				var formato_txt3:TextFormat = estilo.getFormatoTexto("txt3");
				
				if (estilo.getNombreEstilo() == "Estilo6")
				{
					formato_txt1.bullet = true;
					formato_txt2.bullet = true;
					formato_txt3.bullet = true;
				}
				else
				{
					formato_txt1.bullet = false;
					formato_txt2.bullet = false;
					formato_txt3.bullet = false;
				}
				
				txt1.setTextFormat(formato_txt1);
				txt2.setTextFormat(formato_txt2);
				txt3.setTextFormat(formato_txt3);
												
				//Pie
				txtPie.setTextFormat(estilo.getFormatoTexto("txtPie"));
				
				if (estilo.getFondo() != null) fondo.addChild(estilo.getFondo());
				
				if ((estilo.getNombreEstilo() == "Estilo1") || (estilo.getNombreEstilo() == "Estilo2"))
				{
					txtCabecera.y = 30;
					txtCabecera.x =10;
					txtCabecera.width = 358;
					txtTitulo.y = 80;
					//txtTitulo.visible = true;
					txtSubtitulo1.y = 208;
					txtSubtitulo2.y = 369;
					txtSubtitulo3.y = 544;
					txt1.y = 243;
					txt2.y = 406;
					txt3.y = 579;
					txtPie.y = 720;
					txtPie.x =10;
					txtPie.width = 358;
				}
				else if ((estilo.getNombreEstilo() == "Estilo3") || (estilo.getNombreEstilo() == "Estilo4"))
				{
					txtCabecera.y = 30;
					txtCabecera.x =20;
					txtCabecera.width = 328;
					txtTitulo.y = 130;
					//txtTitulo.visible = false;
					txtSubtitulo1.y = 218;
					txtSubtitulo2.y = 379;
					txtSubtitulo3.y = 554;
					txt1.y = 253;
					txt2.y = 416;
					txt3.y = 589;
					txtPie.y = 720;
					txtPie.x =20;
					txtPie.width = 328;
				}
				else
				{
					txtCabecera.y = 10;
					txtCabecera.x =10;
					txtCabecera.width = 358;
					txtTitulo.y = 110;
					//txtTitulo.visible = true;
					txtSubtitulo1.y = 200;
					txtSubtitulo2.y = 378;
					txtSubtitulo3.y = 556;
					txt1.y = 232;
					txt2.y = 410;
					txt3.y = 588;
					txtPie.y = 748;
					txtPie.x =10;
					txtPie.width = 358;
				}
			}
		}
		
		/**************************************************CREAR ESTILO****************************************************/
		//---------Función crearEstilosPredefinidos---------//
		//-- Crea las plantillas y las guarda en el array de estilos
		//-- Variables de entrada:
			//--nombre: nombre del estilo
			//--imagen_fondo: imagen de fondo del estilo
		//--------------------------------------//
		public function crearEstilosPredefinidos(nombre:String,imagen_fondo:MovieClip = null) //Estilos Ninguno, 1 , 2 y 3
		{
			//trace("********************crearEstilosPredefinidos*********************");
						
			var estilo:CElementoEstilo = new CElementoEstilo(this);
			estilo.setNombreEstilo(nombre);
			if (imagen_fondo != null) estilo.setFondo(imagen_fondo);
			
			//CREAMOS EL FORMATO DE LOS TEXTOS
			var formato_texto:TextFormat;
			if (nombre == "Ninguno")
			{
				//HAY QUE PONER TODO A LA IZDA!!
				formato_texto = new TextFormat("Arial",16,"0x000000",false,false,false,null,null,"left",null,null,null,null);
				
				//Cabecera
				estilo.setFormatoATexto(formato_texto,"txtCabecera");
				
				//Titular
				estilo.setFormatoATexto(formato_texto,"txtTitulo");
																
				//Subtítulos
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo1");
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo2");
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo3");	
				
				//Textos
				estilo.setFormatoATexto(formato_texto,"txt1");
				estilo.setFormatoATexto(formato_texto,"txt2");
				estilo.setFormatoATexto(formato_texto,"txt3");
								
				//Pie
				estilo.setFormatoATexto(formato_texto,"txtPie");
																		
				array_estilos[0] = estilo;
			}
			else if (nombre == "Estilo5")
			{
				formato_texto = new TextFormat("Century",16,"0x336633",false,false,false,null,null,"left",null,null,null,null);
				
				//Cabecera
				estilo.setFormatoATexto(formato_texto,"txtCabecera");
				
				//Pie
				estilo.setFormatoATexto(formato_texto,"txtPie");
								
				//Textos - mismo formato pero centrados!
				formato_texto = new TextFormat("Century",16,"0x336633",false,false,false,null,null,"center",null,null,null,null);
				estilo.setFormatoATexto(formato_texto,"txt1");
				estilo.setFormatoATexto(formato_texto,"txt2");
				estilo.setFormatoATexto(formato_texto,"txt3");
				
				//Títular
				formato_texto = new TextFormat("Century",20,"0x336633",true,false,true,null,null,"center",null,null,null,null);
				estilo.setFormatoATexto(formato_texto,"txtTitulo");
									
				//Subtítulos
				formato_texto = new TextFormat("Century",18,"0x336633",true,true,false,null,null,"center",null,null,null,null);
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo1");
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo2");
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo3");			
				
				array_estilos[1] = estilo;
			}
			else if (nombre == "Estilo6")
			{
				
				formato_texto = new TextFormat("Century",16,"0x990000",false,true,false,null,null,"right",null,null,null,null);
				
				//Cabecera
				estilo.setFormatoATexto(formato_texto,"txtCabecera");
			
				//Pie
				estilo.setFormatoATexto(formato_texto,"txtPie");
				
				//Textos
				formato_texto = new TextFormat("Century",16,"0x990000",false,false,false,null,null,"left",null,null,null,null);
				formato_texto.bullet = true;
				estilo.setFormatoATexto(formato_texto,"txt1");
				estilo.setFormatoATexto(formato_texto,"txt2");
				estilo.setFormatoATexto(formato_texto,"txt3");
				
				//Subtítulos
				formato_texto = new TextFormat("Century",18,"0x990000",true,false,false,null,null,"left",null,null,null,null);
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo1");
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo2");
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo3");		
					
				//Títular
				formato_texto = new TextFormat("Century",20,"0x990000",true,false,true,null,null,"center",null,null,null,null);
				estilo.setFormatoATexto(formato_texto,"txtTitulo");
				
				array_estilos[2] = estilo;
			}
			else if (nombre == "Estilo1")
			{
				formato_texto = new TextFormat(fontTimes.fontName,16,"0x000000",false,true,false,null,null,"center",null,null,null,null);
				
				//Cabecera
				estilo.setFormatoATexto(formato_texto,"txtCabecera");
				
				//Pie
				formato_texto.font = "Times New Roman";
				formato_texto.italic = false;
				estilo.setFormatoATexto(formato_texto,"txtPie");
								
				//Textos - mismo formato pero centrados y en color diferente!
				formato_texto = new TextFormat(fontTimes.fontName,18,"0x990000",false,true,false,null,null,"center",null,null,null,null);
				estilo.setFormatoATexto(formato_texto,"txt1");
				estilo.setFormatoATexto(formato_texto,"txt2");
				estilo.setFormatoATexto(formato_texto,"txt3");
				
				//Títular
				formato_texto = new TextFormat(fontTitular1.fontName,30,"0x000000",false,false,false,null,null,"center",null,null,null,null);
				estilo.setFormatoATexto(formato_texto,"txtTitulo");
				
				//Subtítulos
				formato_texto = new TextFormat(fontTitular2.fontName,18,"0x000000",false,true,true,null,null,"center",null,null,null,null);
				formato_texto.underline = true;
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo1");
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo2");
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo3");		
				
				array_estilos[3] = estilo;
			}
			else if (nombre == "Estilo2")
			{
				formato_texto = new TextFormat(fontTimes.fontName,16,"0x000000",false,true,false,null,null,"center",null,null,null,null);
				
				//Cabecera
				estilo.setFormatoATexto(formato_texto,"txtCabecera");
				
				//Pie
				formato_texto.font = "Times New Roman";
				formato_texto.italic = false;
				estilo.setFormatoATexto(formato_texto,"txtPie");
								
				//Textos - mismo formato pero centrados y en color diferente!
				formato_texto = new TextFormat(fontTimes.fontName,18,"0x666666",false,true,false,null,null,"center",null,null,null,null);
				estilo.setFormatoATexto(formato_texto,"txt1");
				estilo.setFormatoATexto(formato_texto,"txt2");
				estilo.setFormatoATexto(formato_texto,"txt3");
				
				//Títular
				formato_texto = new TextFormat(fontTitular1.fontName,30,"0x000000",false,false,false,null,null,"center",null,null,null,null);
				estilo.setFormatoATexto(formato_texto,"txtTitulo");
				
				//Subtítulos
				formato_texto = new TextFormat(fontTitular2.fontName,18,"0x000000",false,true,true,null,null,"center",null,null,null,null);
				formato_texto.underline = true;
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo1");
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo2");
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo3");		
				
				array_estilos[4] = estilo;
			}
			else if (nombre == "Estilo3")
			{
				formato_texto = new TextFormat(fontTriplex.fontName,16,"0x000000",false,false,false,null,null,"right",null,null,null,null);
				
				//Cabecera
				estilo.setFormatoATexto(formato_texto,"txtCabecera");
				
				//Pie
				estilo.setFormatoATexto(formato_texto,"txtPie");
								
				//Textos - mismo formato pero centrados!
				formato_texto = new TextFormat(fontTriplex.fontName,18,"0x000000",false,false,false,null,null,"center",null,null,null,null);
				estilo.setFormatoATexto(formato_texto,"txt1");
				estilo.setFormatoATexto(formato_texto,"txt2");
				estilo.setFormatoATexto(formato_texto,"txt3");
				
				//Títular
				formato_texto = new TextFormat(fontTriplex.fontName,26,"0x003300",true,false,false,null,null,"center",null,null,null,null);
				estilo.setFormatoATexto(formato_texto,"txtTitulo");
				
				//Subtítulos
				formato_texto = new TextFormat(fontTriplex.fontName,20,"0x003300",true,false,false,null,null,"center",null,null,null,null);
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo1");
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo2");
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo3");		
				
				array_estilos[5] = estilo;
			}
			else if (nombre == "Estilo4")
			{
				formato_texto = new TextFormat(fontTriplex.fontName,16,"0x000000",false,false,false,null,null,"right",null,null,null,null);
				
				//Cabecera
				estilo.setFormatoATexto(formato_texto,"txtCabecera");
				
				//Pie
				estilo.setFormatoATexto(formato_texto,"txtPie");
								
				//Textos - mismo formato pero centrados!
				formato_texto = new TextFormat(fontTriplex.fontName,18,"0x000000",false,false,false,null,null,"center",null,null,null,null);
				estilo.setFormatoATexto(formato_texto,"txt1");
				estilo.setFormatoATexto(formato_texto,"txt2");
				estilo.setFormatoATexto(formato_texto,"txt3");
				
				//Títular
				formato_texto = new TextFormat(fontTriplex.fontName,26,"0x330000",true,false,false,null,null,"center",null,null,null,null);
				estilo.setFormatoATexto(formato_texto,"txtTitulo");
				
				//Subtítulos
				formato_texto = new TextFormat(fontTriplex.fontName,20,"0x330000",true,false,false,null,null,"center",null,null,null,null);
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo1");
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo2");
				estilo.setFormatoATexto(formato_texto,"txtSubtitulo3");		
				
				array_estilos[6] = estilo;
			}
		}
		
		//---------Función guardar_estilo---------//
		//-- Guarda el estilo de todo el menú en el array de estilos     ->NO SE ESTÁ USANDO!!!
		//-- Variables de entrada:
			//--nombre: nombre del estilo
		//--------------------------------------//
		public function guardar_estilo(nombre:String)
		{
			var imagen_fondo:MovieClip = new MovieClip();
			for (var i:int = 0; i< fondo.numChildren; i++)
			{
				if (fondo.getChildAt(i) is MovieClip || Sprite) imagen_fondo.addChild(fondo.getChildAt(i));
				
			}
			var estilo:CElementoEstilo = new CElementoEstilo(this);
			estilo.setNombreEstilo(nombre);
			estilo.setFondo(imagen_fondo);
			
			//GUARDAMOS EL FORMATO DE LOS TEXTOS
			var formato_texto:TextFormat;
			//Cabecera
			formato_texto = txtCabecera.getTextFormat();
			estilo.setFormatoATexto(formato_texto,"txtCabecera");
			//Títular
			formato_texto = txtTitulo.getTextFormat();
			estilo.setFormatoATexto(formato_texto,"txtTitulo");
			//Subtítulo 1
			formato_texto = txtSubtitulo1.getTextFormat();
			estilo.setFormatoATexto(formato_texto,"txtSubtitulo1");
			//Subtítulo 2
			formato_texto = txtSubtitulo2.getTextFormat();
			estilo.setFormatoATexto(formato_texto,"txtSubtitulo2");
			//Subtítulo 3
			formato_texto = txtSubtitulo3.getTextFormat();
			estilo.setFormatoATexto(formato_texto,"txtSubtitulo3");
			//Texto 1
			formato_texto = txt1.getTextFormat();
			estilo.setFormatoATexto(formato_texto,"txt1");
			//Texto 2
			formato_texto = txt2.getTextFormat();
			estilo.setFormatoATexto(formato_texto,"txt2");
			//Texto 3
			formato_texto = txt3.getTextFormat();
			estilo.setFormatoATexto(formato_texto,"txt3");
			//Pie
			formato_texto = txtPie.getTextFormat();
			estilo.setFormatoATexto(formato_texto,"txtPie");
			
			array_estilos.push(estilo);
		}
		/******************************************************************************************************************/
		
		//------------------------------De uint a hex-----------------------------------//
		function displayInHex(c:uint):String 
		{
			var r:String=extractRed(c).toString(16).toUpperCase();
			var g:String=extractGreen(c).toString(16).toUpperCase();
			var b:String=extractBlue(c).toString(16).toUpperCase();
			var hs:String="";
			var zero:String="0";
			
			if(r.length==1) r=zero.concat(r);
			if(g.length==1) g=zero.concat(g);
			if(b.length==1) b=zero.concat(b);
			hs=r+g+b;
			
			return hs;
		}
		
		function extractRed(c:uint):uint { return (( c >> 16 ) & 0xFF);	}
		function extractGreen(c:uint):uint { return ( (c >> 8) & 0xFF ); }
		function extractBlue(c:uint):uint { return ( c & 0xFF );}
		//------------------------------------------------------------------------------------//
	}
	
}
