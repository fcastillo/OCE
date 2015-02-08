package cod 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class CPanelVideo extends CElementoBase
	{
		
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CPanelVideo(aita:MovieClip) 
		{
			super(aita);
		}
		
		///<summary>
		///Carga el panel de propiedades del vídeo y llama a activarListeners()
		///</summary>
		override public function load():int
		{
			this.x = getXpos();
			this.y = getYpos();
			
			activarListeners();
			return 0;
		}
		
		///<summary>
		///Activa los listeners en los botones y check boxes
		///</summary>
		private function activarListeners():void
		{
			//Reproducción en bucle
			checkBucle.addEventListener(Event.CHANGE, changeBucle);
			checkMute.addEventListener(Event.CHANGE, changeMute);
			
			//Botones play y pause
			btnPlay.buttonMode = true;
			btnPause.buttonMode = true;
			
			btnPlay.gotoAndStop(2);
			checkBucle.selected = true;
						
			btnPlay.addEventListener(MouseEvent.CLICK,onVideoPlayPause);
			btnPause.addEventListener(MouseEvent.CLICK,onVideoPlayPause);
		}
		
		///<summary>
		///Activa o desactiva la reproducción en bucle
		///</summary>
		public function changeBucle(e:Event):void
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.getVideo() != null)
				{
					getPadre().getPadre().elemento_seleccionado.getVideo().setBucle(checkBucle.selected);
					getPadre().getPadre().elemento_seleccionado.setBucle(checkBucle.selected);
				}
			}
		}
		
		///<summary>
		///Activa o desactiva el sonido del video
		///</summary>
		public function changeMute(e:Event):void
		{
			if ((getPadre().getPadre().elemento_seleccionado != null) && (getPadre().getPadre().elemento_seleccionado.getVideo() != null))
			{
				if (checkMute.selected) //Silenciamos el vídeo
				{
					getPadre().getPadre().elemento_seleccionado.getVideo().mute();
				}
				else getPadre().getPadre().elemento_seleccionado.getVideo().unmute();
				
			}
		}
		
		///<summary>
		///Reproduce o pausa el vídeo
		///</summary>
		private function onVideoPlayPause(e:MouseEvent):void
		{
			if (getPadre().getPadre().elemento_seleccionado != null)
			{
				if (getPadre().getPadre().elemento_seleccionado.getVideo() != null)
				{
					if (e.currentTarget.name == "btnPlay")
					{
						if (e.currentTarget.currentFrame == 1)
						{
							e.currentTarget.gotoAndStop(2); //Video reproduciéndose
							btnPause.gotoAndStop(1); //Botón pause habilitado para poder pausar
							getPadre().getPadre().elemento_seleccionado.getVideo().setVideoPlaying(true);
							getPadre().getPadre().elemento_seleccionado.getVideo().pausarReproducirVideo();
						}
					}
					else if (e.currentTarget.name == "btnPause")
					{
						if (e.currentTarget.currentFrame == 1)
						{
							e.currentTarget.gotoAndStop(2); //Video parado
							btnPlay.gotoAndStop(1); //Botón play habilitado para poder reproducir
							getPadre().getPadre().elemento_seleccionado.getVideo().setVideoPlaying(false);
							getPadre().getPadre().elemento_seleccionado.getVideo().pausarReproducirVideo();
						}						
					}
				}
			}
			
		}
		
	}
	
}
