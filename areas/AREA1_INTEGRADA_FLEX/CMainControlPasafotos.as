package  
{
	
	import flash.display.MovieClip;
	import cod.CElementoPasafotos;
	
	
	public class CMainControlPasafotos extends MovieClip 
	{
		var mascara:MovieMaskMC;
		private var contenedor:CElementoPasafotos;
		
		public function getContenedor():CElementoPasafotos {return contenedor;}
		public function setContenedor(val:CElementoPasafotos) {contenedor = val;}
		
		public function CMainControlPasafotos() 
		{
			init();
		}
		
		public function init()
		{
			contenedor = new CElementoPasafotos(this);
			contenedor.load();
			contenedor.x = 0;
			contenedor.y = 0;
			
			//Máscara
			mascara = new MovieMaskMC()
			mascara.x = 0;
			mascara.y = 0;
			contenedor.mask = mascara;
			
			fondo.addChild(mascara);
			fondo.addChild(contenedor);
		}
		
		public function pararTemporizador()
		{
			trace("*******padre - pararTemporizador*********");
			contenedor.getTemporizador().stop();
		}
		
		public function reanudarTemporizador()
		{
			trace("*******padre - reanudarTemporizador*********");
			contenedor.getTemporizador().start();
			contenedor.switchSlide(null);
		}
		
		public function guardarNumImagenes(num:int)
		{
			trace("*******padre - guardarNumImagenes*********");
			contenedor.setNumImagenes(num);
		}
		
		public function guardarArrayImagenes(array:Array)
		{
			trace("*******padre - guardarArrayImagenes*********");
			contenedor.setArrayUrls(array);
		}	
	}
	
}
