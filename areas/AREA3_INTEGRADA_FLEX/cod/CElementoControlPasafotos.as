package cod 
{
	import flash.display.MovieClip;
	
	public class CElementoControlPasafotos extends CElementoBase
	{		
		public function CElementoControlPasafotos(aita:MovieClip) 
		{
			// constructor code
			super(aita);
		}
		
		override public function load():int
		{
			return 0;
		}
		
		public function pararTemporizador()
		{
			getPadre().pararTemporizador();
		}
		
		public function reanudarTemporizador()
		{
			getPadre().reanudarTemporizador();
		}
		
		public function guardarNumImagenes(num:int)
		{
			getPadre().guardarNumImagenes(num);
		}
		
		public function guardarArrayImagenes(array:Array)
		{
			getPadre().guardarArrayImagenes(array);
		}	

	}
	
}
