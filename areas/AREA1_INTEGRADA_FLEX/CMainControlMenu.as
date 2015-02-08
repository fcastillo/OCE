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
		}
		
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
	}
	
}
