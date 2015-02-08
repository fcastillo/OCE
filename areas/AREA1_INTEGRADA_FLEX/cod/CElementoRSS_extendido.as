package cod
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	public class CElementoRSS_extendido extends CElementoBase
	{				
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CElementoRSS_extendido(aita) 
		{
			super(aita);
		}
		
		///<summary>
		///Llama a la función Carga del swf para que cargue la url del RSS
		///</summary>
		override public function load():int
		{
			getPadre().Carga(this.getUrlDatos());
			return 0;
		}
		
		//***************************************GETTERS/SETTERS********************************************/
		//Entramos en el swf del control para editar sus características o para obtener los valores actuales
		public function getTiempoTransicion():int {return getPadre().getTiempoEntreTransiciones();}
		public function getVelocidad():int {return getPadre().getVelocidadTexto();}
		public function getColorBarraSuperior():uint {return getPadre().color_sup;}
		public function getColorBarraInferior():uint {return getPadre().color_inf;}
		public function getColorTitulos():uint {return getPadre().color_titulo;}
		public function getColorTextos():uint {return getPadre().color_texto;}
		public function getFuenteTitulos():String {return getPadre().fuente_titulo;}
		public function getFuenteTextos():String {return getPadre().fuente_texto;}
		public function getTamañoTitulos():int {return getPadre().size_titulo;}
		public function getTamañoTextos():int {return getPadre().size_texto;}
		public function getAlineacionTitulos():String {return getPadre().align_titulo;}
		public function getAlineacionTextos():String {return getPadre().align_texto;}
		public function getNegritaTitulos():Boolean {return getPadre().negrita_titulo;}
		public function getNegritaTextos():Boolean {return getPadre().negrita_texto;}
		public function getCursivaTitulos():Boolean {return getPadre().cursiva_titulo;}
		public function getCursivaTextos():Boolean {return getPadre().cursiva_texto;}
		public function getSubrayadoTitulos():Boolean {return getPadre().subrayado_titulo;}
		public function getSubrayadoTextos():Boolean {return getPadre().subrayado_texto;}
		public function getSizeTitulos():int {return getPadre().size_titulo;}
		public function getSizeTextos():int {return getPadre().size_texto;}
		public function getRSSUrl():String {return getPadre().rssurl;}
			
		public function setTiempoTransicion(val:int):void {getPadre().setTiempoEntreTransiciones(val);}
		public function setVelocidad(val:int):void { getPadre().setVelocidadTexto(val);}
		public function configScroll(op:Boolean) {getPadre().controlScrollAutomatico(op);}
		public function editNegrita(val:Boolean,instancia:String) {getPadre().editNegritaTextos(instancia,val);}
		public function editSubrayado(val:Boolean,instancia:String)	{getPadre().editSubrayadoTextos(instancia,val);}
		public function editCursiva(val:Boolean,instancia:String) {getPadre().editCursivaTextos(instancia,val);}
		public function editAlineacion(val:String,instancia:String) {getPadre().editAlignTextos(instancia,val);}
		public function editFuente(val:String,instancia:String) {getPadre().editFuenteTextos(instancia,val);}		
		public function editColor(val:String,instancia:String) {getPadre().editColorTextos(instancia,uint(val));}
		public function editColorFondos(val:String,valor_alpha:Number,instancia:String) {getPadre().editColorBarras(instancia,uint(val),valor_alpha);}
		public function editSize(val:int,instancia:String) {getPadre().editSizeTextos(instancia,val);}
		public function descargar(){getPadre().descargarElementos();}
		//********************************************************************************************************************************************************//
	}
	
}
