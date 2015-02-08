package cod
{
	import flash.display.*;	
	
	public class CElementoBase extends MovieClip
	{
		private var padre:MovieClip;
		private var tipo:String;
		private var xpos:Number;
		private var ypos:Number;
		private var zpos:int;
		private var ancho:Number;
		private var alto:Number;
		private var transparencia:Number;
		private var urlDatos:String;
		
		public function CElementoBase(aita:MovieClip):void 
		{
			padre = aita;
		}
		
		public function getPadre():MovieClip { return padre; }
		public function getTipo():String { return tipo; }
		public function getXpos():Number { return xpos; }
		public function getYpos():Number { return ypos; }
		public function getProfundidad():int { return zpos; }
		public function getAncho():Number { return ancho; }
		public function getAlto():Number { return alto; }
		public function getTransparencia():Number { return transparencia; }
		public function getUrlDatos():String { return urlDatos; }
					
		public function setPadre(val:MovieClip) { padre = val; }
		public function setTipo(val:String) { tipo = val; }
		public function setXpos(val:Number) { xpos = val; }
		public function setYpos(val:Number) { ypos = val; }
		public function setProfundidad(val:int) { zpos = val; }
		public function setAncho(val:Number) { ancho = val; }
		public function setAlto(val:Number) { alto = val; }
		public function setTransparencia(val:Number) { transparencia = val; }
		public function setUrlDatos(val:String) { urlDatos = val; }
		
		public function load():int { return 0; }
		public function unload():void {}
		public function cargarDatos():void {}	
	}
	
}
