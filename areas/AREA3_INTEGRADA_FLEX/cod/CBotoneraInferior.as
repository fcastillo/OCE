package cod
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class CBotoneraInferior extends CElementoBase
	{
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CBotoneraInferior(aita:MovieClip)
		{
			super(aita);
		}

		//<summary>
		///Inicializa lal pestaña inferior
		///		-> Según el tipo de elemento, definimos si el botón para abrir la librería de
		///		   recursos está habilitado o no
		///</summary>
		override public function load():int
		{
			switch(this.getTipo())
			{
				case "texto":
					btnAbrir.buttonMode = false;
					btnAbrir.gotoAndStop("disabled");
					break;
				case "pasafotos":
					btnAbrir.buttonMode = false;
					btnAbrir.gotoAndStop("disabled");
					break;
				case "ticker":
					btnAbrir.buttonMode = false;
					btnAbrir.gotoAndStop("disabled");
					break;
				case "menu":
					btnAbrir.buttonMode = false;
					btnAbrir.gotoAndStop("disabled");
					break;
				case "tiempo":
					btnAbrir.buttonMode = false;
					btnAbrir.gotoAndStop("disabled");
					break;
				case "rss":
					btnAbrir.buttonMode = false;
					btnAbrir.gotoAndStop("disabled");
					break;
				case "reloj":
					btnAbrir.buttonMode = false;
					btnAbrir.gotoAndStop("disabled");
					break;
				default:
					btnAbrir.buttonMode = true;
					btnAbrir.gotoAndStop("enabled");
					btnAbrir.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
					btnAbrir.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
					btnAbrir.addEventListener(MouseEvent.MOUSE_UP,getPadre().loadData);
					break;
			}
			
			btnCerrar.buttonMode = true;
			btnCerrar.gotoAndStop("enabled");
			btnCerrar.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			btnCerrar.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
			btnCerrar.addEventListener(MouseEvent.MOUSE_UP,getPadre().eliminarElemento);
			return 0;
		}
		
		///<summary>
		///	Evento que envía el botón al estado "over"
		///</summary>
		private function onMouseOver(e:MouseEvent):void
		{
			e.currentTarget.gotoAndStop("over");
		}
		
		///<summary>
		///	Evento que envía el botón al estado "enabled"
		///</summary>
		private function onMouseOut(e:MouseEvent):void
		{
			e.currentTarget.gotoAndStop("enabled");
		}

	}
	
}
