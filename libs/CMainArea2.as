package  {
	
	import flash.display.MovieClip;
	import flash.display.MovieClip;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import fl.motion.Color;
	import fl.text.TLFTextField;
	import flash.text.Font;
	
	public class CMainArea2 extends MovieClip 
	{
				
		public function CMainArea2(){}
		public function probar(){insertarNumero("AA");subiendo();bajando();}
		public function load() {	}
		
		public function setParameters() {	}
		
		public function subiendo()
		{
			arriba.gotoAndPlay(2);
		}
		
		public function bajando()
		{
			abajo.gotoAndPlay(2);
		}
		
		public function parar()
		{
			arriba.gotoAndStop(1);
			abajo.gotoAndStop(1);
		}
		
		public function insertarNumero(num:String)
		{
			piso.text = num;
		}
		
		
		public function editColor(val:Color)
		{
			piso.defaultTextFormat.color = val;
		}
		
		public function editFuente(val:String) {	}
		
		
		public function editSize(val:int) {	}
	}
	
}
