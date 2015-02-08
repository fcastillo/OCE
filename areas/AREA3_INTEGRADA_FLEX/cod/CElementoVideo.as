package cod
{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	//Video
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.display.LoaderInfo;
	import flash.media.SoundTransform;
	
	public class CElementoVideo extends CElementoBase
	{
		//VARIABLES
		public var redimensionado : Boolean = false;
		public var redimW : int = -1;
		public var redimH : int = -1
		public var padre:MovieClip
		private var video:Video;
		private var ns:NetStream;
		private var nc:NetConnection;
		private var bucle:Boolean = true;
		var videoPlaying:Boolean = true;
		var muted:Boolean = false;
		private var videoCargado : Boolean = false;
		
		/********************************GETTERS/SETTERS***********************************/
		public function getBucle():Boolean { return bucle; }
		public function getNS():NetStream {return ns;}
		public function getNC():NetConnection {return nc;}
		public function getVideo():Video {return video;}
		public function getVideoPlaying():Boolean {return videoPlaying;}
		public function getVideoMuted():Boolean {return muted;}
					
		public function setBucle(val:Boolean) { bucle = val; }
		public function setNS(val:NetStream) { ns = val; }
		public function setNC(val:NetConnection) { nc = val; }
		public function setVideo(val:Video) { video = val; }
		public function setVideoPlaying(val:Boolean) { videoPlaying = val; }
		public function videoRedimensionado(w:int,h:int) :void//el video está cargado de una versión anterior y ya está redimensionado
		{
			redimensionado = true;
			redimW = w;
			redimH = h;
		}
		
		
		
	/*************************************************************************************/
				
		///<summary>
		///Constructor; define el padre e inicializa variables
		///</summary>
		public function CElementoVideo(aita:MovieClip) 
		{
			super(aita);
			padre = aita;
			video = new Video();
			setAncho(video.width);
			setAlto(video.height);
			setTransparencia(1);
		}
				
		///<summary>
		///Carga el video según el path definido en UrlDatos
		///</summary>
		override public function load():int
		{
			trace("[Flash] video - load(), url = ",getUrlDatos());
			this.addChild(video);
			this.width = getAncho();
			this.height = getAlto();
			this.alpha = getTransparencia();
						
			nc = new NetConnection();
			nc.connect(null);
			ns = new NetStream(nc);			
			ns.client = {onMetaData:ns_onMetaData, onCuePoint:ns_onCuePoint};
			video.attachNetStream(ns);
			ns.play(getUrlDatos());
			ns.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			return 0;
		}
		
		///<summary>
		///Descarga el vídeo
		///</summary>
		override public function unload():void
		{
			ns.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			ns.close();
			nc.close();
			video.clear();
			video = null;
		}
		
		///<summary>
		///Pausa o reproduce el vídeo
		///</summary>
		public function pausarReproducirVideo()
		{
			ns.togglePause();
		}
		
		///<summary>
		///Silencia el vídeo
		///</summary>
		public function mute()
		{
			ns.soundTransform = new SoundTransform(0);
			muted = true;
		}
		
		///<summary>
		///Activa el sonido el vídeo
		///</summary>
		public function unmute()
		{
			ns.soundTransform = new SoundTransform(1);
			muted = false;
		}
		
		///<summary>
		///Gestione los eventos de estado
		///</summary>
		function netStatusHandler(e:NetStatusEvent):void 
		{
			switch (e.info.code) 
			{
				case "NetStream.Play.StreamNotFound":
					trace("Video Stream not found");
					break;
				case "NetStream.Play.Stop":
					if (bucle) ns.play(getUrlDatos()); //Hemos llegado al final del vídeo
					else ns.pause();
					break;
			}
		}
		//funcion de escucha lanzada cuando se carga el video
		function ns_onMetaData(item:Object):void 
		{
			// trace(video.width);
			//if(getPadre().datos_elemento.contains(this)){trace("kakota");return;}
			if(videoCargado)return; //solo hacemos el resize la primera vez que lo cargamos
			trace("video on metadata -> "+item.width+", "+item.height);
			if(redimensionado)
			{
				trace("Ajustando video a contenedor...");
				this.width = redimW;
				this.height = redimH;
			}
			else
			{
				trace("Ajustando contenedor a video...");
				this.width = item.width;
				this.height = item.height;
				if(item.width > getPadre().getPadre().anL || item.height > getPadre().getPadre().alL)
				{
					trace("nos salimos del lienzo");
					if(item.width > item.height)
					{
						trace("ajustando a ancho");
						var r_alto = getPadre().getPadre().anL/item.width;
						this.width = getPadre().getPadre().anL;
						this.height = item.height * r_alto;
						this.x = 0;
						this.y = 0;
					}
					else
					{
						trace("ajustando a alto");
						var r_ancho = getPadre().getPadre().alL/item.height;
						this.height = getPadre().getPadre().alL;
						this.width = item.width * r_ancho;
						this.x = 0;
						this.y = 0;
					}
				}
			}
			padre.getPadre().desactivarAnterior();
			padre.getPadre().borrarLista();
			padre.activarElemento();
			padre.getPadre().zMax = 0;
			padre.getPadre().IDelemento_seleccionado = padre.ID;
			padre.getPadre().elemento_seleccionado = padre;
			padre.getPadre().getPanelPropiedades().btnRelacion.selected = true;
			padre.setCandado(true);
			
			getPadre().datos_elemento.fondo.alpha = 0;
			getPadre().datos_elemento.fondo.height = this.height;
			getPadre().datos_elemento.fondo.width = this.width;
			videoCargado = true;
		}
		
		//funcion de escucha lanzada cuando el video llega a un cuePoint
		function ns_onCuePoint(item:Object):void 
		{
			 ////trace(item.name + "\t" + item.time);
		}

	}
	
}
