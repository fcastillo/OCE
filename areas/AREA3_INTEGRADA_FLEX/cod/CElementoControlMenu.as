package cod
{
	import flash.display.MovieClip;
	import flash.text.TextFormat;
	
	public class CElementoControlMenu extends CElementoBase
	{
		//Estilo y fondo
		private var nombreEstilo:String = "Ninguno";
		private var fondo_url:String = "";
		private var fondo_color:uint = 0xffffff;
		private var hayColorFondo:Boolean = false;
		private var existe_fondo:Boolean = false;
		//Contenido textos
		private var cabecera_txt:String = "CABECERA";
		private var tituloP_txt:String = "TÍTULO PRINCIPAL\nMENÚ DE FIN DE SEMANA";
		private var titulo1_txt:String = "Entrantes - Título 1";
		private var titulo2_txt:String = "Plato principal - Título 2";
		private var titulo3_txt:String = "Postre - Título 3";
		private var texto1_txt:String = "Plato1\nPlato 2\nPlato 3\nPlato 4\nPlato 5\nPlato 6";
		private var texto2_txt:String = "Plato1\nPlato 2\nPlato 3\nPlato 4\nPlato 5\nPlato 6";
		private var texto3_txt:String = "Plato1\nPlato 2\nPlato 3\nPlato 4\nPlato 5\nPlato 6";
		private var pie_txt:String = "PIE";
		//Visibilidad textos
		private var cabecera_visible:Boolean = true;
		private var tituloP_visible:Boolean = true;
		private var titulo1_visible:Boolean = true;
		private var titulo2_visible:Boolean = true;
		private var titulo3_visible:Boolean = true;
		private var texto1_visible:Boolean = true;
		private var texto2_visible:Boolean = true;
		private var texto3_visible:Boolean = true;
		private var pie_visible:Boolean = true;
		//Color textos
		private var cabecera_color:uint = 0x000000;
		private var tituloP_color:uint = 0x000000;
		private var titulo1_color:uint = 0x000000;
		private var titulo2_color:uint = 0x000000;
		private var titulo3_color:uint = 0x000000;
		private var texto1_color:uint = 0x000000;
		private var texto2_color:uint = 0x000000;
		private var texto3_color:uint = 0x000000;
		private var pie_color:uint = 0x000000;
		//Fuente textos
		private var cabecera_fuente:String = "Arial";
		private var tituloP_fuente:String = "Arial";
		private var titulo1_fuente:String = "Arial";
		private var titulo2_fuente:String = "Arial";
		private var titulo3_fuente:String = "Arial";
		private var texto1_fuente:String = "Arial";
		private var texto2_fuente:String = "Arial";
		private var texto3_fuente:String = "Arial";
		private var pie_fuente:String = "Arial";
		//Tamaño textos
		private var cabecera_size:int = 16;
		private var tituloP_size:int = 16;
		private var titulo1_size:int = 16;
		private var titulo2_size:int = 16;
		private var titulo3_size:int = 16;
		private var texto1_size:int = 16;
		private var texto2_size:int = 16;
		private var texto3_size:int = 16;
		private var pie_size:int = 16;
		//Alineacion textos
		private var cabecera_align:String = "right";
		private var tituloP_align:String = "center";
		private var titulo1_align:String = "left";
		private var titulo2_align:String = "left";
		private var titulo3_align:String = "left";
		private var texto1_align:String = "left";
		private var texto2_align:String = "left";
		private var texto3_align:String = "left";
		private var pie_align:String = "right";
		//Negrita textos
		private var cabecera_negrita:Boolean = false;
		private var tituloP_negrita:Boolean = false;
		private var titulo1_negrita:Boolean = false;
		private var titulo2_negrita:Boolean = false;
		private var titulo3_negrita:Boolean = false;
		private var texto1_negrita:Boolean = false;
		private var texto2_negrita:Boolean = false;
		private var texto3_negrita:Boolean = false;
		private var pie_negrita:Boolean = false;
		//Cursiva textos
		private var cabecera_cursiva:Boolean = false;
		private var tituloP_cursiva:Boolean = false;
		private var titulo1_cursiva:Boolean = false;
		private var titulo2_cursiva:Boolean = false;
		private var titulo3_cursiva:Boolean = false;
		private var texto1_cursiva:Boolean = false;
		private var texto2_cursiva:Boolean = false;
		private var texto3_cursiva:Boolean = false;
		private var pie_cursiva:Boolean = false;
		//Subrayado textos
		private var cabecera_subrayado:Boolean = false;
		private var tituloP_subrayado:Boolean = false;
		private var titulo1_subrayado:Boolean = false;
		private var titulo2_subrayado:Boolean = false;
		private var titulo3_subrayado:Boolean = false;
		private var texto1_subrayado:Boolean = false;
		private var texto2_subrayado:Boolean = false;
		private var texto3_subrayado:Boolean = false;
		private var pie_subrayado:Boolean = false;
		//Viñetas textos
		private var cabecera_bullet:Boolean = false;
		private var tituloP_bullet:Boolean = false;
		private var titulo1_bullet:Boolean = false;
		private var titulo2_bullet:Boolean = false;
		private var titulo3_bullet:Boolean = false;
		private var texto1_bullet:Boolean = false;
		private var texto2_bullet:Boolean = false;
		private var texto3_bullet:Boolean = false;
		private var pie_bullet:Boolean = false;
		
		/********************************GETTERS/SETTERS*************************************/
		public function getNombreEstilo():String {return nombreEstilo;}
		public function getUrlFondo():String {return fondo_url;}
		public function getColorFondo():uint {return fondo_color;}
		public function getHayColorFondo():Boolean {return hayColorFondo;}
		public function getExisteFondo():Boolean {return existe_fondo;}
		public function getTxtCabecera():String {return cabecera_txt;}	//TEXTOS
		public function getTxtTituloP():String {return tituloP_txt;}
		public function getTxtTitulo1():String {return titulo1_txt;}
		public function getTxtTitulo2():String {return titulo2_txt;}
		public function getTxtTitulo3():String {return titulo3_txt;}
		public function getTxtTexto1():String {return texto1_txt;}
		public function getTxtTexto2():String {return texto2_txt;}
		public function getTxtTexto3():String {return texto3_txt;}
		public function getTxtPie():String {return pie_txt;}
		public function getVisibleCabecera():Boolean {return cabecera_visible;} //VISIBILIDAD
		public function getVisibleTituloP():Boolean {return tituloP_visible;}
		public function getVisibleTitulo1():Boolean {return titulo1_visible;}
		public function getVisibleTitulo2():Boolean {return titulo2_visible;}
		public function getVisibleTitulo3():Boolean {return titulo3_visible;}
		public function getVisibleTexto1():Boolean {return texto1_visible;}
		public function getVisibleTexto2():Boolean {return texto2_visible;}
		public function getVisibleTexto3():Boolean {return texto3_visible;}
		public function getVisiblePie():Boolean {return pie_visible;}
		public function getColorCabecera():uint {return cabecera_color;}	//COLOR
		public function getColorTituloP():uint {return tituloP_color;}
		public function getColorTitulo1():uint {return titulo1_color;}
		public function getColorTitulo2():uint {return titulo2_color;}
		public function getColorTitulo3():uint {return titulo3_color;}
		public function getColorTexto1():uint {return texto1_color;}
		public function getColorTexto2():uint {return texto2_color;}
		public function getColorTexto3():uint {return texto3_color;}
		public function getColorPie():uint {return pie_color;}
		public function getFuenteCabecera():String {return cabecera_fuente;}	//FUENTE
		public function getFuenteTituloP():String {return tituloP_fuente;}
		public function getFuenteTitulo1():String {return titulo1_fuente;}
		public function getFuenteTitulo2():String {return titulo2_fuente;}
		public function getFuenteTitulo3():String {return titulo3_fuente;}
		public function getFuenteTexto1():String {return texto1_fuente;}
		public function getFuenteTexto2():String {return texto2_fuente;}
		public function getFuenteTexto3():String {return texto3_fuente;}
		public function getFuentePie():String {return pie_fuente;}
		public function getTamañoCabecera():int {return cabecera_size;}

	//TAMAÑO
		public function getTamañoTituloP():int {return tituloP_size;}
		public function getTamañoTitulo1():int {return titulo1_size;}
		public function getTamañoTitulo2():int {return titulo2_size;}
		public function getTamañoTitulo3():int {return titulo3_size;}
		public function getTamañoTexto1():int {return texto1_size;}
		public function getTamañoTexto2():int {return texto2_size;}
		public function getTamañoTexto3():int {return texto3_size;}
		public function getTamañoPie():int {return pie_size;}
		public function getAlineacionCabecera():String {return cabecera_align;}	//ALINEACIÓN
		public function getAlineacionTituloP():String {return tituloP_align;}
		public function getAlineacionTitulo1():String {return titulo1_align;}
		public function getAlineacionTitulo2():String {return titulo2_align;}
		public function getAlineacionTitulo3():String {return titulo3_align;}
		public function getAlineacionTexto1():String {return texto1_align;}
		public function getAlineacionTexto2():String {return texto2_align;}
		public function getAlineacionTexto3():String {return texto3_align;}
		public function getAlineacionPie():String {return pie_align;}
		public function getNegritaCabecera():Boolean {return cabecera_negrita;} //NEGRITA
		public function getNegritaTituloP():Boolean {return tituloP_negrita;}
		public function getNegritaTitulo1():Boolean {return titulo1_negrita;}
		public function getNegritaTitulo2():Boolean {return titulo2_negrita;}
		public function getNegritaTitulo3():Boolean {return titulo3_negrita;}
		public function getNegritaTexto1():Boolean {return texto1_negrita;}
		public function getNegritaTexto2():Boolean {return texto2_negrita;}
		public function getNegritaTexto3():Boolean {return texto3_negrita;}
		public function getNegritaPie():Boolean {return pie_negrita;}
		public function getCursivaCabecera():Boolean {return cabecera_cursiva;} //CURSIVA
		public function getCursivaTituloP():Boolean {return tituloP_cursiva;}
		public function getCursivaTitulo1():Boolean {return titulo1_cursiva;}
		public function getCursivaTitulo2():Boolean {return titulo2_cursiva;}
		public function getCursivaTitulo3():Boolean {return titulo3_cursiva;}
		public function getCursivaTexto1():Boolean {return texto1_cursiva;}
		public function getCursivaTexto2():Boolean {return texto2_cursiva;}
		public function getCursivaTexto3():Boolean {return texto3_cursiva;}
		public function getCursivaPie():Boolean {return pie_cursiva;}
		public function getSubrayadoCabecera():Boolean {return cabecera_subrayado;} //SUBRAYADO
		public function getSubrayadoTituloP():Boolean {return tituloP_subrayado;}
		public function getSubrayadoTitulo1():Boolean {return titulo1_subrayado;}
		public function getSubrayadoTitulo2():Boolean {return titulo2_subrayado;}
		public function getSubrayadoTitulo3():Boolean {return titulo3_subrayado;}
		public function getSubrayadoTexto1():Boolean {return texto1_subrayado;}
		public function getSubrayadoTexto2():Boolean {return texto2_subrayado;}
		public function getSubrayadoTexto3():Boolean {return texto3_subrayado;}
		public function getSubrayadoPie():Boolean {return pie_subrayado;}
		public function getBulletsCabecera():Boolean {return cabecera_bullet;} //VIÑETAS
		public function getBulletsTituloP():Boolean {return tituloP_bullet;}
		public function getBulletsTitulo1():Boolean {return titulo1_bullet;}
		public function getBulletsTitulo2():Boolean {return titulo2_bullet;}
		public function getBulletsTitulo3():Boolean {return titulo3_bullet;}
		public function getBulletsTexto1():Boolean {return texto1_bullet;}
		public function getBulletsTexto2():Boolean {return texto2_bullet;}
		public function getBulletsTexto3():Boolean {return texto3_bullet;}
		public function getBulletsPie():Boolean {return pie_bullet;}
			
		
		public function setNombreEstilo(val:String) {nombreEstilo = val;}
		public function setUrlFondo(val:String) {fondo_url = val;}
		public function setColorFondo(val:uint) {fondo_color = val;}
		public function setHayColorFondo(val:Boolean) {hayColorFondo = val;}
		public function setExisteFondo(val:Boolean) {existe_fondo = val;}
		public function setTxtCabecera(val:String) {cabecera_txt = val;}	//TEXTOS
		public function setTxtTituloP(val:String) {tituloP_txt = val;}
		public function setTxtTitulo1(val:String) {titulo1_txt = val;}
		public function setTxtTitulo2(val:String) {titulo2_txt = val;}
		public function setTxtTitulo3(val:String) {titulo3_txt = val;}
		public function setTxtTexto1(val:String) {texto1_txt = val;}
		public function setTxtTexto2(val:String) {texto2_txt = val;}
		public function setTxtTexto3(val:String) {texto3_txt = val;}
		public function setTxtPie(val:String) {pie_txt = val;}
		public function setVisibleCabecera(val:Boolean) {cabecera_visible = val;} //VISIBILIDAD
		public function setVisibleTituloP(val:Boolean) {tituloP_visible = val;}
		public function setVisibleTitulo1(val:Boolean) {titulo1_visible = val;}
		public function setVisibleTitulo2(val:Boolean) {titulo2_visible = val;}
		public function setVisibleTitulo3(val:Boolean) {titulo3_visible = val;}
		public function setVisibleTexto1(val:Boolean) {texto1_visible = val;}
		public function setVisibleTexto2(val:Boolean) {texto2_visible = val;}
		public function setVisibleTexto3(val:Boolean) {texto3_visible = val;}
		public function setVisiblePie(val:Boolean) {pie_visible = val;}
		public function setColorCabecera(val:uint) {cabecera_color = val;}	//COLOR
		public function setColorTituloP(val:uint) {tituloP_color = val;}
		public function setColorTitulo1(val:uint) {titulo1_color = val;}
		public function setColorTitulo2(val:uint) {titulo2_color = val;}
		public function setColorTitulo3(val:uint) {titulo3_color = val;}
		public function setColorTexto1(val:uint) {texto1_color = val;}
		public function setColorTexto2(val:uint) {texto2_color = val;}
		public function setColorTexto3(val:uint) {texto3_color = val;}
		public function setColorPie(val:uint) {pie_color = val;}
		public function setFuenteCabecera(val:String) {cabecera_fuente = val;}	//FUENTE
		public function setFuenteTituloP(val:String) {tituloP_fuente = val;}
		public function setFuenteTitulo1(val:String) {titulo1_fuente = val;}
		public function setFuenteTitulo2(val:String) {titulo2_fuente = val;}
		public function setFuenteTitulo3(val:String) {titulo3_fuente = val;}
		public function setFuenteTexto1(val:String) {texto1_fuente = val;}
		public function setFuenteTexto2(val:String) {texto2_fuente = val;}
		public function setFuenteTexto3(val:String) {texto3_fuente = val;}
		public function setFuentePie(val:String) {pie_fuente = val;}
		public function setTamañoCabecera(val:int) {cabecera_size = val;}	//TAMAÑO
		public function setTamañoTituloP(val:int) {tituloP_size = val;}
		public function setTamañoTitulo1(val:int) {titulo1_size = val;}
		public function setTamañoTitulo2(val:int) {titulo2_size = val;}
		public function setTamañoTitulo3(val:int) {titulo3_size = val;}
		public function setTamañoTexto1(val:int) {texto1_size = val;}
		public function setTamañoTexto2(val:int) {texto2_size = val;}
		public function setTamañoTexto3(val:int) {texto3_size = val;}
		public function setTamañoPie(val:int) {pie_size = val;}
		public function setAlineacionCabecera(val:String) {cabecera_align = val;}	//ALINEACIÓN
		public function setAlineacionTituloP(val:String) {tituloP_align = val;}
		public function setAlineacionTitulo1(val:String) {titulo1_align = val;}
		public function setAlineacionTitulo2(val:String) {titulo2_align = val;}
		public function setAlineacionTitulo3(val:String) {titulo3_align = val;}
		public function setAlineacionTexto1(val:String) {texto1_align = val;}
		public function setAlineacionTexto2(val:String) {texto2_align = val;}
		public function setAlineacionTexto3(val:String) {texto3_align = val;}
		public function setAlineacionPie(val:String) {pie_align = val;}
		public function setNegritaCabecera(val:Boolean) {cabecera_negrita = val;} //NEGRITA
		public function setNegritaTituloP(val:Boolean) {tituloP_negrita = val;}
		public function setNegritaTitulo1(val:Boolean) {titulo1_negrita = val;}
		public function setNegritaTitulo2(val:Boolean) {titulo2_negrita = val;}
		public function setNegritaTitulo3(val:Boolean) {titulo3_negrita = val;}
		public function setNegritaTexto1(val:Boolean) {texto1_negrita = val;}
		public function setNegritaTexto2(val:Boolean) {texto2_negrita = val;}
		public function setNegritaTexto3(val:Boolean) {texto3_negrita = val;}
		public function setNegritaPie(val:Boolean) {pie_negrita = val;}
		public function setCursivaCabecera(val:Boolean) {cabecera_cursiva = val;} //CURSIVA
		public function setCursivaTituloP(val:Boolean) {tituloP_cursiva = val;}
		public function setCursivaTitulo1(val:Boolean) {titulo1_cursiva = val;}
		public function setCursivaTitulo2(val:Boolean) {titulo2_cursiva = val;}
		public function setCursivaTitulo3(val:Boolean) {titulo3_cursiva = val;}
		public function setCursivaTexto1(val:Boolean) {texto1_cursiva = val;}
		public function setCursivaTexto2(val:Boolean) {texto2_cursiva = val;}
		public function setCursivaTexto3(val:Boolean) {texto3_cursiva = val;}
		public function setCursivaPie(val:Boolean) {pie_cursiva = val;}
		public function setSubrayadoCabecera(val:Boolean) {cabecera_subrayado = val;} //SUBRAYADO
		public function setSubrayadoTituloP(val:Boolean) {tituloP_subrayado = val;}
		public function setSubrayadoTitulo1(val:Boolean) {titulo1_subrayado = val;}
		public function setSubrayadoTitulo2(val:Boolean) {titulo2_subrayado = val;}
		public function setSubrayadoTitulo3(val:Boolean) {titulo3_subrayado = val;}
		public function setSubrayadoTexto1(val:Boolean) {texto1_subrayado = val;}
		public function setSubrayadoTexto2(val:Boolean) {texto2_subrayado = val;}
		public function setSubrayadoTexto3(val:Boolean) {texto3_subrayado = val;}
		public function setSubrayadoPie(val:Boolean) {pie_subrayado = val;}
		public function setBulletsCabecera(val:Boolean) {cabecera_bullet = val;} //VIÑETAS
		public function setBulletsTituloP(val:Boolean) {tituloP_bullet = val;}
		public function setBulletsTitulo1(val:Boolean) {titulo1_bullet = val;}
		public function setBulletsTitulo2(val:Boolean) {titulo2_bullet = val;}
		public function setBulletsTitulo3(val:Boolean) {titulo3_bullet = val;}
		public function setBulletsTexto1(val:Boolean) {texto1_bullet = val;}
		public function setBulletsTexto2(val:Boolean) {texto2_bullet = val;}
		public function setBulletsTexto3(val:Boolean) {texto3_bullet = val;}
		public function setBulletsPie(val:Boolean) {pie_bullet = val;}
		/***********************************************************************************/
		
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CElementoControlMenu(aita:MovieClip) 
		{
			super(aita);
		}

		override public function load():int
		{
			return 0;
		}
		
		
		public function getFormatoTexto(instancia:String):TextFormat {return getPadre().getFormato_texto(instancia);}
		public function getInvisible(instancia:String):Boolean {return getPadre().getInvisible(instancia);}
		
		///<summary>
		///Función que guarda los textos cuando estamos editando los contenidos
		///y entra en el swf a editarlos
		///</summary>
		public function editContenido(texto:String,instancia:String) 
		{
			//Guardamos en la variable correspondiente
			switch(instancia)
			{
				case "txtCabecera": cabecera_txt = texto; break;
				case "txtTitulo": tituloP_txt = texto; break;
				case "txtSubtitulo1": titulo1_txt = texto; break;
				case "txtSubtitulo2": titulo2_txt = texto; break;
				case "txtSubtitulo3": titulo3_txt = texto; break;
				case "txt1": texto1_txt = texto; break;
				case "txt2": texto2_txt = texto; break;
				case "txt3": texto3_txt = texto; break;
				case "txtPie": pie_txt = texto; break;
				default: break;
			}
			getPadre().editar_texto(texto,instancia);
		}
		
		///<summary>
		///Función que guarda la alineación de los textos 
		///y entra en el swf a editarlo
		///</summary>
		public function editAlineacion(val:String,instancia:String) 
		{
			//Guardamos en la variable correspondiente
			switch(instancia)
			{
				case "txtCabecera": cabecera_align = val; break;
				case "txtTitulo": tituloP_align = val; break;
				case "txtSubtitulo1": titulo1_align = val; break;
				case "txtSubtitulo2": titulo2_align = val; break;
				case "txtSubtitulo3": titulo3_align = val; break;
				case "txt1": texto1_align = val; break;
				case "txt2": texto2_align = val; break;
				case "txt3": texto3_align = val; break;
				case "txtPie": pie_align = val; break;
				default: break;
			}
			getPadre().editar_alineacion(val,instancia);
		}
		
		///<summary>
		///Función que guarda la fuente de los textos 
		///y entra en el swf a editarla
		///</summary>
		public function editFuente(val:String,instancia:String) 
		{
			//Guardamos en la variable correspondiente
			switch(instancia)
			{
				case "txtCabecera": cabecera_fuente = val; break;
				case "txtTitulo": tituloP_fuente = val; break;
				case "txtSubtitulo1": titulo1_fuente = val; break;
				case "txtSubtitulo2": titulo2_fuente = val; break;
				case "txtSubtitulo3": titulo3_fuente = val; break;
				case "txt1": texto1_fuente = val; break;
				case "txt2": texto2_fuente = val; break;
				case "txt3": texto3_fuente = val; break;
				case "txtPie": pie_fuente = val; break;
				default: break;
			}
			getPadre().editar_fuente(val,instancia);
		}
		
		///<summary>
		///Función que guarda el tamaño de la fuente de los textos 
		///y entra en el swf a editarlo
		///</summary>
		public function editTamaño(val:String,instancia:String) 
		{
			//Guardamos en la variable correspondiente
			switch(instancia)
			{
				case "txtCabecera": cabecera_size = int(val); break;
				case "txtTitulo": tituloP_size = int(val); break;
				case "txtSubtitulo1": titulo1_size = int(val); break;
				case "txtSubtitulo2": titulo2_size = int(val); break;
				case "txtSubtitulo3": titulo3_size = int(val); break;
				case "txt1": texto1_size = int(val); break;
				case "txt2": texto2_size = int(val); break;
				case "txt3": texto3_size = int(val); break;
				case "txtPie": pie_size = int(val); break;
				default: break;
			}
			getPadre().editar_tamaño(val,instancia);
		}
		
		///<summary>
		///Función que guarda la negrita de los textos 
		///y entra en el swf a editarla
		///</summary>
		public function editNegrita(op:Boolean,instancia:String) 
		{
			//Guardamos en la variable correspondiente
			switch(instancia)
			{
				case "txtCabecera": cabecera_negrita = op; break;
				case "txtTitulo": tituloP_negrita = op; break;
				case "txtSubtitulo1": titulo1_negrita = op; break;
				case "txtSubtitulo2": titulo2_negrita = op; break;
				case "txtSubtitulo3": titulo3_negrita = op; break;
				case "txt1": texto1_negrita = op; break;
				case "txt2": texto2_negrita = op; break;
				case "txt3": texto3_negrita = op; break;
				case "txtPie": pie_negrita = op; break;
				default: break;
			}
			getPadre().editar_negrita(op,instancia);
		}
		
		///<summary>
		///Función que guarda la cursiva de los textos 
		///y entra en el swf a editarla
		///</summary>
		public function editCursiva(op:Boolean,instancia:String) 
		{
			//Guardamos en la variable correspondiente
			switch(instancia)
			{
				case "txtCabecera": cabecera_cursiva = op; break;
				case "txtTitulo": tituloP_cursiva = op; break;
				case "txtSubtitulo1": titulo1_cursiva = op; break;
				case "txtSubtitulo2": titulo2_cursiva = op; break;
				case "txtSubtitulo3": titulo3_cursiva = op; break;
				case "txt1": texto1_cursiva = op; break;
				case "txt2": texto2_cursiva = op; break;
				case "txt3": texto3_cursiva = op; break;
				case "txtPie": pie_cursiva = op; break;
				default: break;
			}
			getPadre().editar_cursiva(op,instancia);
		}
		
		///<summary>
		///Función que guarda el subrayado de los textos 
		///y entra en el swf a editarlo
		///</summary>
		public function editSubrayado(op:Boolean,instancia:String) 
		{
			//Guardamos en la variable correspondiente
			switch(instancia)
			{
				case "txtCabecera": cabecera_subrayado = op; break;
				case "txtTitulo": tituloP_subrayado = op; break;
				case "txtSubtitulo1": titulo1_subrayado = op; break;
				case "txtSubtitulo2": titulo2_subrayado = op; break;
				case "txtSubtitulo3": titulo3_subrayado = op; break;
				case "txt1": texto1_subrayado = op; break;
				case "txt2": texto2_subrayado = op; break;
				case "txt3": texto3_subrayado = op; break;
				case "txtPie": pie_subrayado = op; break;
				default: break;
			}
			getPadre().editar_subrayado(op,instancia);
		}
		
		///<summary>
		///Función que guarda las viñetas de los textos 
		///y entra en el swf a editarlo
		///</summary>
		public function editViñetas(op:Boolean,instancia:String) 
		{
			//Guardamos en la variable correspondiente
			switch(instancia)
			{
				case "txtCabecera": cabecera_bullet = op; break;
				case "txtTitulo": tituloP_bullet = op; break;
				case "txtSubtitulo1": titulo1_bullet = op; break;
				case "txtSubtitulo2": titulo2_bullet = op; break;
				case "txtSubtitulo3": titulo3_bullet = op; break;
				case "txt1": texto1_bullet = op; break;
				case "txt2": texto2_bullet = op; break;
				case "txt3": texto3_bullet = op; break;
				case "txtPie": pie_bullet = op; break;
				default: break;
			}
			getPadre().insertar_viñetas(op,instancia);
		}
		
		///<summary>
		///Función que define si un texto es visible
		///y entra en el swf a editarlo
		///</summary>
		public function editInvisible(op:Boolean,instancia:String) 
		{
			//Guardamos en la variable correspondiente
			switch(instancia)
			{
				case "txtCabecera": cabecera_visible = op; break;
				case "txtTitulo": tituloP_visible = op; break;
				case "txtSubtitulo1": titulo1_visible = op; break;
				case "txtSubtitulo2": titulo2_visible = op; break;
				case "txtSubtitulo3": titulo3_visible = op; break;
				case "txt1": texto1_visible = op; break;
				case "txt2": texto2_visible = op; break;
				case "txt3": texto3_visible = op; break;
				case "txtPie": pie_visible = op; break;
				default: break;
			}
			getPadre().editar_invisible(op,instancia);
		}
		
		///<summary>
		///Función que coloca una nueva imagen de fondo
		///		-> Si tuviéramos un color, lo borramos
		///</summary>
		public function editFondo(imagen:MovieClip,url_imagen:String) 
		{
			fondo_url = url_imagen;
			
			//Cuando el usuario selecciona un estilo para el menú, la variable existe_fondo
			//indica si mantenemos el fondo por defecto de ese estilo
			existe_fondo = false;
			
			//Quitamos el color
			fondo_color = 0xffffff;
			hayColorFondo = false;
			getPadre().eliminar_color_fondo();
			
			//Colocamos la nueva imagen de fondo
			getPadre().cambiar_fondo(imagen);
		}
		
		///<summary>
		///Función que llama a borrar_fondo()
		///</summary>
		public function borrarFondo() 
		{	
			getPadre().borrar_fondo();
			fondo_url = "";
		}
		
		///<summary>
		///Función que elimina el color del fondo del menú, dejándolo en blanco
		///</summary>
		public function borrarColorFondo() 
		{
			fondo_color = 0xffffff;
			hayColorFondo = false;
			getPadre().eliminar_color_fondo();
		}
		
		///<summary>
		///Función que cambia el estilo del menú
		///</summary>
		public function editEstilo(nombre_estilo:String) 
		{
			getPadre().cambiar_estilo(nombre_estilo);
			actualizarVariables();
		}
				
		public function guardarEstilo(nombre_estilo:String) {getPadre().guardar_estilo(nombre_estilo);}
					
		///<summary>
		///Función que guarda el color de un texto
		///y entra en el swf a editarlo
		///</summary>
		public function editColor(val:String,instancia:String) 
		{
			var color_hex = displayInHex(uint(val)); //Convierte el string en hexadecimal
			color_hex = "#"+color_hex;
			
			//Guardamos en la variable correspondiente
			switch(instancia)
			{
				case "txtCabecera": cabecera_color = uint(val);	break;
				case "txtTitulo": tituloP_color = uint(val);	break;
				case "txtSubtitulo1": titulo1_color = uint(val);	break;
				case "txtSubtitulo2": titulo2_color = uint(val);	break;
				case "txtSubtitulo3": titulo3_color = uint(val);	break;
				case "txt1": texto1_color = uint(val);	break;
				case "txt2": texto2_color = uint(val);	break;
				case "txt3": texto3_color = uint(val);	break;
				case "txtPie": pie_color = uint(val);	break;
				default: break;
			}
			getPadre().editar_color(color_hex,instancia);
		}
		
		///<summary>
		///Función que edita el color de fondo
		///</summary>
		public function editColorFondo(val:String) 
		{
			var color_hex = displayInHex(uint(val));
			fondo_color = uint(val);
			hayColorFondo = true;
			color_hex = "#"+color_hex;
			getPadre().editar_colorFondo(color_hex);
		}
					
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
		
		///<summary>
		///Función que actualiza las variables según los valores recibidos del swf
		///</summary>
		public function actualizarVariables()
		{
			//trace("**************actualizarVariables*********");
			//Estilo y fondo
			fondo_url = "";
			fondo_color = 0xffffff;
			
			cabecera_visible = !getPadre().getInvisible("txtCabecera");
			tituloP_visible = !getPadre().getInvisible("txtTitulo");
			titulo1_visible = !getPadre().getInvisible("txtSubtitulo1");
			titulo2_visible = !getPadre().getInvisible("txtSubtitulo2");
			titulo3_visible = !getPadre().getInvisible("txtSubtitulo3");
			texto1_visible = !getPadre().getInvisible("txt1");
			texto2_visible = !getPadre().getInvisible("txt2");
			texto3_visible = !getPadre().getInvisible("txt3");
			pie_visible = !getPadre().getInvisible("txtPie");
			
			//Cabecera
			var aux_formato:TextFormat = getPadre().getFormato_texto("txtCabecera");
			cabecera_color = uint(aux_formato.color);
			cabecera_fuente = aux_formato.font;
			cabecera_size = int(aux_formato.size);
			cabecera_align = aux_formato.align;
			cabecera_negrita = aux_formato.bold;
			cabecera_cursiva = aux_formato.italic;
			cabecera_subrayado = aux_formato.underline;
			cabecera_bullet = aux_formato.bullet;
			
			//Titulo principal
			aux_formato = getPadre().getFormato_texto("txtTitulo");
			tituloP_color = uint(aux_formato.color);
			tituloP_fuente = aux_formato.font;
			tituloP_size = int(aux_formato.size);
			tituloP_align = aux_formato.align;
			tituloP_negrita = aux_formato.bold;
			tituloP_cursiva = aux_formato.italic;
			tituloP_subrayado = aux_formato.underline;
			tituloP_bullet = aux_formato.bullet;
			
			//Titulo 1
			aux_formato = getPadre().getFormato_texto("txtSubtitulo1");
			titulo1_color = uint(aux_formato.color);
			titulo1_fuente = aux_formato.font;
			titulo1_size = int(aux_formato.size);
			titulo1_align = aux_formato.align;
			titulo1_negrita = aux_formato.bold;
			titulo1_cursiva = aux_formato.italic;
			titulo1_subrayado = aux_formato.underline;
			titulo1_bullet = aux_formato.bullet;
			
			//Titulo 2
			aux_formato = getPadre().getFormato_texto("txtSubtitulo2");
			titulo2_color = uint(aux_formato.color);
			titulo2_fuente = aux_formato.font;
			titulo2_size = int(aux_formato.size);
			titulo2_align = aux_formato.align;
			titulo2_negrita = aux_formato.bold;
			titulo2_cursiva = aux_formato.italic;
			titulo2_subrayado = aux_formato.underline;
			titulo2_bullet = aux_formato.bullet;
			
			//Titulo 3
			aux_formato = getPadre().getFormato_texto("txtSubtitulo3");
			titulo3_color = uint(aux_formato.color);
			titulo3_fuente = aux_formato.font;
			titulo3_size = int(aux_formato.size);
			titulo3_align = aux_formato.align;
			titulo3_negrita = aux_formato.bold;
			titulo3_cursiva = aux_formato.italic;
			titulo3_subrayado = aux_formato.underline;
			titulo3_bullet = aux_formato.bullet;
			
			//Texto 1
			aux_formato = getPadre().getFormato_texto("txt1");
			texto1_color = uint(aux_formato.color);
			texto1_fuente = aux_formato.font;
			texto1_size = int(aux_formato.size);
			texto1_align = aux_formato.align;
			texto1_negrita = aux_formato.bold;
			texto1_cursiva = aux_formato.italic;
			texto1_subrayado = aux_formato.underline;
			texto1_bullet = aux_formato.bullet;
			
			//Texto 2
			aux_formato = getPadre().getFormato_texto("txt2");
			texto2_color = uint(aux_formato.color);
			texto2_fuente = aux_formato.font;
			texto2_size = int(aux_formato.size);
			texto2_align = aux_formato.align;
			texto2_negrita = aux_formato.bold;
			texto2_cursiva = aux_formato.italic;
			texto2_subrayado = aux_formato.underline;
			texto2_bullet = aux_formato.bullet;
			
			//Texto 3
			aux_formato = getPadre().getFormato_texto("txt3");
			texto3_color = uint(aux_formato.color);
			texto3_fuente = aux_formato.font;
			texto3_size = int(aux_formato.size);
			texto3_align = aux_formato.align;
			texto3_negrita = aux_formato.bold;
			texto3_cursiva = aux_formato.italic;
			texto3_subrayado = aux_formato.underline;
			texto3_bullet = aux_formato.bullet;
			
			//Pie
			aux_formato = getPadre().getFormato_texto("txtPie");
			pie_color = uint(aux_formato.color);
			pie_fuente = aux_formato.font;
			pie_size = int(aux_formato.size);
			pie_align = aux_formato.align;
			pie_negrita = aux_formato.bold;
			pie_cursiva = aux_formato.italic;
			pie_subrayado = aux_formato.underline;
			pie_bullet = aux_formato.bullet;
			
		}
	}
	
}
