package  cod
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.DisplayObject;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import caurina.transitions.Tweener;
	
	public class CElementoPasafotos extends CElementoBase
	{
		//VARIABLES
		private var arrayUrlImagenes:Array = new Array();
		private var tiempo_timer:int = 5000;
		private var sentido_trans:String;
		private var efecto_fade:String;
		private var operation_mode:String ="Ninguno";
		private var direccion:String ="toIzda";
				
		//Referencia al contenedor que tiene la imagen actual
		var currentContainer:MovieClip;
		
		var intCurrentSlide:int = -1; //Índice de la imagen actual
		var intSlideCount:int; //Número total de imágenes
		
		// timer para cambiar de imagen
		var slideTimer:Timer;
		
		// 2 contenedores para cargar las imágenes
		var container1:MovieClip;
		var container2:MovieClip;
		
		var slideLoader:Loader; // LOADER que carga las imágenes
	
		//CONSTANTES - CAMBIARÁN SEGÚN EL ÁREA EN LA QUE TRABAJEMOS
		var X_OUT_IZDA:Number = -225;
		var X_OUT_DRCHA:Number = 225;
		var Y_OUT_ABAJO:Number = 265;
		var Y_OUT_ARRIBA:Number = -265;
		
		/*var X_OUT_IZDA:Number = -375;
		var X_OUT_DRCHA:Number = 375;
		var Y_OUT_ABAJO:Number = 800;
		var Y_OUT_ARRIBA:Number = -800;
		*/
		
				
		//BASES PARA EFECTOS
		var myFadeIn:Object = {alpha:1, time:1};
		var toX0:Object = {x:0, alpha:1, time:1, transition:"easeOutSine"};
		var toY0:Object = {y:0, alpha:1, time:1, transition:"easeOutSine"};
		var toXOut:Object = {x:X_OUT_IZDA, alpha:0, time:1, transition:"linear"};
		var toYOut:Object = {y:Y_OUT_ARRIBA, alpha:0, time:1, transition:"linear"};
		
		/********************************* GETTERS / SETTERS ***************************************/
		public function getArrayUrls():Array {return arrayUrlImagenes;}
		public function getTiempoTimer():int {return tiempo_timer;}
		public function getSentidoTrans():String {return sentido_trans;}
		public function getEfectoFade():String {return efecto_fade;}
		public function getTemporizador():Timer {return slideTimer;}
		public function getNumImagenes():int {return intSlideCount;}
		public function getOperationMode():String {return operation_mode;}
		public function getDireccion():String {return direccion;}
		public function getVelocidadTransicion():Number {return toX0.time;}
		public function getEfecto():String {return toX0.transition;}
		public function getXoutIzda():Number {return X_OUT_IZDA;}
		public function getXoutDrcha():Number {return X_OUT_DRCHA;}
		public function getYoutAbajo():Number {return Y_OUT_ABAJO;}
		public function getYoutArriba():Number {return Y_OUT_ARRIBA;}
				
		public function setArrayUrls(val:Array):void {arrayUrlImagenes = val;}
		public function setTiempoTimer(val:int):void	{tiempo_timer = val; cambiarParametrosTimer(val);}
		public function setSentidoTrans(val:String):void {sentido_trans = val;}
		public function setEfectoFade(val:String):void {efecto_fade = val;}
		public function setTemporizador(val:Timer):void {slideTimer = val;}
		public function setNumImagenes(val:int):void {intSlideCount = val;}
		public function setOperationMode(val:String):void {operation_mode = val;}
		public function setDireccion(val:String):void {direccion = val;}
		public function setXoutIzda(val:Number) {X_OUT_IZDA = val;}
		public function setXoutDrcha(val:Number) {X_OUT_DRCHA = val;}
		public function setYoutAbajo(val:Number) {Y_OUT_ABAJO = val;}
		public function setYoutArriba(val:Number) {Y_OUT_ARRIBA = val;}
		/**********************************************************************************************/
		
				
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CElementoPasafotos(aita:MovieClip) 
		{
			super(aita);
		}
		
		///<summary>
		///Función que define las constantes en las que se basan los efectos
		///</summary>
		public function setConstants(xIzda:Number,xDrcha:Number,yAbajo:Number,yArriba:Number)
		{
			//trace("*************************setConstants*************************");
			X_OUT_IZDA = xIzda;
			X_OUT_DRCHA = xDrcha;
			Y_OUT_ABAJO = yAbajo;
			Y_OUT_ARRIBA = yArriba;
		}
		
		///<summary>
		///Función que carga el elemento pasafotos
		///</summary>
		override public function load():int
		{
			//Creamos el timer que controla el tiempo durante el cual la imagen estará visible
			slideTimer = new Timer(tiempo_timer); 
			slideTimer.addEventListener(TimerEvent.TIMER, switchSlide);
			
			//Creamos 2 contenedores para ir cargando las imágenes y creando los efectos
			container1 = new MovieClip();
			container2 = new MovieClip();
			container1.x = 0;
			container1.y = 0;
			container2.x = 0;
			container2.y = 0;
			
			/*container1.x = this.getXpos();
			container1.y = this.getYpos();
			container2.x = this.getXpos();
			container2.y = this.getYpos();*/
			trace("[CElementoPasafotos] - load() -> c1.x="+container1.x+", c1.y="+container1.y+" , c2.x="+container2.x+", c2.y="+container2.y);
			
			mcContenedorImagenes.addChild(container1);
			mcContenedorImagenes.addChild(container2);
			
			// Mantenemos la referencia al contenedor que esté al frente con "currentContainer"
			currentContainer = container2;
			
			intSlideCount = arrayUrlImagenes.length;
			switchSlide(null);
			
			return 0;
		}
		
		///<summary>
		///Función que descarga el elemento pasafotos
		///</summary>
		override public function unload():void
		{
			//Paramos el timer
			slideTimer.removeEventListener(TimerEvent.TIMER, switchSlide);
			
			if(slideTimer.running)
				slideTimer.stop();
		}
		
		///<summary>
		///Función que activa el cambio de imagen
		///</summary>
		public function switchSlide(e:Event):void 
		{
			// Si el timer está corriendo lo paramos
			if(slideTimer.running)
				slideTimer.stop();
			
			//Cuando lleguemos a la última imagen, volvemos a la primera
			if(intCurrentSlide + 1 < intSlideCount)
				intCurrentSlide++;
			else
				intCurrentSlide = 0;
							
			//Cambiamos de imagen segun el modo seleccionado
			if (intSlideCount > 0)
			{
				switch (operation_mode)
				{
					case "Ninguno": imageFadeIn(); break; //Fade
					case "Horizontal": imageHorizontalTranslation(); break; //Movimiento horizontal
					case "Vertical": imageVerticalTranslation(); break; //Movimiento vertical
				}
			}
		}
		
		///<summary>
		///Función que coloca una nueva imagen al frente con efecto Fade
		///</summary>
		function imageFadeIn()
		{
			//Hacemos que currentContainer apunte al contenedor que esté detrás
			if(currentContainer == container2)
				currentContainer = container1;
			else
				currentContainer = container2;
			
			//Ponemos a alpha = 0 al contenedor de fondo para que aparezca poco a poco
			currentContainer.alpha = 0;
			//Intercambiamos contenedores; el contenedor de fondo sigue en alpha = 0
			mcContenedorImagenes.swapChildren(container2, container1);
			
			//Cargamos una nueva imagen
			slideLoader = new Loader();
			slideLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, fadeSlideIn);
			slideLoader.load(new URLRequest(arrayUrlImagenes[intCurrentSlide]));
		}
		
		///<summary>
		///Función que coloca los contenedores para hacer una traslación horizontal
		///y carga la nueva imagen
		///</summary>
		function imageHorizontalTranslation()
		{
			if(currentContainer == container2) //container 2 está delante
			{
				//Depende de la dirección del movimiento, colocamos el contenedor1 a un lado o al otro
				if (direccion == "toIzda")
				{
					container1.x = X_OUT_DRCHA;
				}
				else if (direccion == "toDrcha")
				{
					container1.x -= container2.width;
					if (container1.x == 0) container1.x = X_OUT_IZDA;
					toXOut.x = currentContainer.width;
				}
				//currentContainer apunta al contendor1
				currentContainer = container1;
				Tweener.addTween(container2, {base:toXOut}); //Hacemos que desaparezca la imagen al frente
			}
			else //container 1 está delante
			{
				if (direccion == "toIzda")
				{
					container2.x = X_OUT_DRCHA;
				}
				else if (direccion == "toDrcha")
				{
					container2.x -= container1.width;
					if (container2.x == 0) container2.x = X_OUT_IZDA;
					toXOut.x = currentContainer.width;
				}
				currentContainer = container2;
				Tweener.addTween(container1, {base:toXOut}); //Hacemos que desaparezca la imagen al frente
			}
			
			mcContenedorImagenes.swapChildren(container2, container1);
			
			//Cargamos una nueva imagen
			slideLoader = new Loader();
			slideLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, horizontalMove);
			slideLoader.load(new URLRequest(arrayUrlImagenes[intCurrentSlide]));
		}
		
		///<summary>
		///Función que coloca los contenedores para hacer una traslación vertical
		///y carga la nueva imagen
		///</summary>
		function imageVerticalTranslation()
		{
			if(currentContainer == container2) //container 2 está delante
			{
				currentContainer = container1;
				if (direccion == "toDown")
				{
					container1.y -= container2.height;
					if (container1.y == 0) container1.y = Y_OUT_ARRIBA;
					toYOut.y = currentContainer.height;
				}
				else if (direccion == "toUp")
				{
					container1.y = container2.height;
					if (container1.y == 0) container1.y = Y_OUT_ABAJO;
				}
				Tweener.addTween(container2, {base:toYOut}); //Hacemos que desaparezca la imagen al frente
			}
			else
			{
				currentContainer = container2;
				if (direccion == "toDown")
				{
					container2.y -= container1.height;
					if (container2.y == 0) container2.y = Y_OUT_ARRIBA;
					toYOut.y = currentContainer.height;
				}
				else if (direccion == "toUp")
				{
					container2.y = container1.height;
					if (container2.y == 0) container2.y = Y_OUT_ABAJO;
				}
				Tweener.addTween(container1, {base:toYOut}); //Hacemos que desaparezca la imagen al frente
			}
			mcContenedorImagenes.swapChildren(container2, container1);
			
			//Cargamos una nueva imagen
			slideLoader = new Loader();
			slideLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, verticalMove);
			slideLoader.load(new URLRequest(arrayUrlImagenes[intCurrentSlide]));
		}
		
		///<summary>
		///Función que carga la imagen en currentContainer, e inicia el efecto fade
		///</summary>
		function fadeSlideIn(e:Event):void 
		{
			var loaderInfo:LoaderInfo = e.target as LoaderInfo;
			var dispObj:DisplayObject = loaderInfo.content;
			trace("Cargamos la imagen en el pasafotos -> w:"+dispObj.width+", h:"+dispObj.height+" X_OUT_DRCHA:"+X_OUT_DRCHA+" Y_OUT_ABAJO:"+Y_OUT_ABAJO);
			//Si el ancho/alto superan las dimensiones del área, ajustamos la imagen
			//proporcionalmente
			if ((dispObj.width >= dispObj.height) && (dispObj.width > X_OUT_DRCHA))
			{
				dispObj.width = X_OUT_DRCHA;
				dispObj.scaleY = dispObj.scaleX;
			}
			else if((dispObj.height > dispObj.width)&&(dispObj.height > Y_OUT_ABAJO))
			{
				dispObj.height = Y_OUT_ABAJO;
				dispObj.scaleX = dispObj.scaleY; 
			}
			trace("Tras ajustar la foto -> w:"+dispObj.width+", h:"+dispObj.height+" x:"+dispObj.x+", y:"+dispObj.y);
			//Vaciamos contenedores para que las imágenes no se queden en memoria
			vaciarContenedor();
			vaciarContenedores();
				
			currentContainer.addChild(dispObj);
						
			//Efecto fade para que la imagen aparezca poco a poco
			TweenLite.to(currentContainer, 1, {alpha:1,onUpdate:reiniciarTimer});
		}
		
		///<summary>
		///Función que carga la imagen en currentContainer, e inicia el movimiento horizontal
		///</summary>
		function horizontalMove(e:Event):void 
		{
			var loaderInfo:LoaderInfo = e.target as LoaderInfo;
			var dispObj:DisplayObject = loaderInfo.content;
			dispObj.x = 0;
			dispObj.y = 0;
			
			//Si el ancho/alto superan las dimensiones del área, ajustamos la imagen
			//proporcionalmente
			if((dispObj.width >= dispObj.height) && (dispObj.width > X_OUT_DRCHA))
			{
				dispObj.width = X_OUT_DRCHA;
				dispObj.scaleY = dispObj.scaleX;
			}
			else if((dispObj.height > dispObj.width)&&(dispObj.height > Y_OUT_ABAJO))
			{
				dispObj.height = Y_OUT_ABAJO;
				dispObj.scaleX = dispObj.scaleY; 
			}
						
			//Vaciamos el contenedor restante para que las imágenes no se queden en memoria
			if (currentContainer == container1) vaciarContenedor1();
			else vaciarContenedor2();
			
			//Colocamos currentContainer según la dirección del desplazamiento
			if (direccion == "toDrcha")
			{
				currentContainer.x = X_OUT_IZDA;
			}
			else if (direccion == "toIzda")
			{
				currentContainer.x = X_OUT_DRCHA;
			}
			
			currentContainer.addChild(dispObj);
							
			//Iniciamos movimiento
			Tweener.addTween(currentContainer, {base:toX0,onComplete:reiniciarTimer()});
		}
		
		///<summary>
		///Función que carga la imagen en currentContainer, e inicia el movimiento vertical
		///</summary>
		function verticalMove(e:Event):void 
		{
			var loaderInfo:LoaderInfo = e.target as LoaderInfo;
			var dispObj:DisplayObject = loaderInfo.content;
			
			//Si el ancho/alto superan las dimensiones del área, ajustamos la imagen
			//proporcionalmente
			if((dispObj.width >= dispObj.height) && (dispObj.width > X_OUT_DRCHA))
			{
				dispObj.width = X_OUT_DRCHA;
				dispObj.scaleY = dispObj.scaleX;
			}
			else if((dispObj.height > dispObj.width)&&(dispObj.height > Y_OUT_ABAJO))
			{
				dispObj.height = Y_OUT_ABAJO;
				dispObj.scaleX = dispObj.scaleY; 
			}
			
			//Vaciamos el contenedor restante para que las imágenes no se queden en memoria
			if (currentContainer == container1)  vaciarContenedor1();
			else vaciarContenedor2();
			
			currentContainer.addChild(dispObj);
			
			//Colocamos currentContainer según la dirección del desplazamiento
			if (direccion == "toDown")
			{
				currentContainer.y = Y_OUT_ARRIBA;
			}
			else if (direccion == "toUp")
			{
				currentContainer.y = Y_OUT_ABAJO;
			}
				
			//Iniciamos movimiento
			Tweener.addTween(currentContainer, {base:toY0,onComplete:reiniciarTimer()});
		}
		
		///<summary>
		///Función que resetea la posición de los contenedores
		///</summary>
		public function resetContenedores()
		{
			currentContainer.x = 0;
			currentContainer.y = 0;
			container1.x = 0;
			container1.y = 0;
			container2.x = 0;
			container2.y = 0;
			
			switch (direccion)
			{
				case "toIzda": toXOut.x = X_OUT_IZDA; break;
				case "toDrcha": toXOut.x = X_OUT_DRCHA; break;
				case "toUp": toYOut.y = Y_OUT_ARRIBA; break;
				case "toDown": toYOut.y = Y_OUT_ABAJO; break;
				default:break;
			}
		}
		
		///<summary>
		///Función que cambia el efecto de las transiciones (frenazo, rebote, etc)
		///</summary>
		public function cambiarTransiciones(val:String)
		{
			toX0.transition = val;
			toY0.transition = val;
			toXOut.transition = val;
			toYOut.transition = val;
		}
		
		///<summary>
		///Función que cambia la velocidad de las transiciones
		///</summary>
		public function cambiarVelocidad(val:Number)
		{
			if (val is Number)
			{
				toX0.time = val;
				toY0.time = val;
				toXOut.time = val;
				toYOut.time = val;
			}
		}
		
		///<summary>
		///Función que reinicia el timer
		///</summary>
		public function reiniciarTimer()
		{ 
			slideTimer.start(); 
		}
		
		///<summary>
		///Función que define el tiempo durante el cual se muestra la imagen
		///</summary>
		public function cambiarParametrosTimer(val:int)
		{
			if ((val != 0) && (slideTimer != null))
			{
				slideTimer.stop();
				slideTimer.removeEventListener(TimerEvent.TIMER, switchSlide);
				slideTimer = new Timer(val);
				slideTimer.addEventListener(TimerEvent.TIMER, switchSlide);
				slideTimer.start(); 
			}
		}
		
		///<summary>
		///Función que elimina el contenido de currentContainer
		///</summary>
		function vaciarContenedor()
		{
			var i:int = 0;
			var tipoItem:String;
			for(i = 0; i<currentContainer.numChildren; i++)
			{
				tipoItem = currentContainer.getChildAt(i).toString();
				if (tipoItem.indexOf("Bitmap") != -1)
				{
					currentContainer.removeChildAt(i);
					i=0;
				}
			}
		}
		
		///<summary>
		///Función que elimina el contenido de contenedor1
		///</summary>
		function vaciarContenedor1()
		{
			var i:int = 0;
			var tipoItem:String;
			for(i = 0; i<container1.numChildren; i++)
			{
				tipoItem = container1.getChildAt(i).toString();
				if (tipoItem.indexOf("Bitmap") != -1)
				{
					container1.removeChildAt(i);
					i=0;
				}
			}
		}
		
		///<summary>
		///Función que elimina el contenido de contenedor2
		///</summary>
		function vaciarContenedor2()
		{
			var i:int = 0;
			var tipoItem:String;
			for(i = 0; i<container2.numChildren; i++)
			{
				tipoItem = container2.getChildAt(i).toString();
				if (tipoItem.indexOf("Bitmap") != -1)
				{
					container2.removeChildAt(i);
					i=0;
				}
			}
		}
		
		///<summary>
		///Función que elimina el contenido de contenedor1 y contenedor2
		///</summary>
		function vaciarContenedores()
		{
			var i:int = 0;
			var tipoItem:String;
			for(i = 0; i<container1.numChildren; i++)
			{
				tipoItem = container1.getChildAt(i).toString();
				if (tipoItem.indexOf("Bitmap") != -1)
				{
					container1.removeChildAt(i);
					i=0;
				}
			}
			
			for(i = 0; i<container2.numChildren; i++)
			{
				tipoItem = container2.getChildAt(i).toString();
				if (tipoItem.indexOf("Bitmap") != -1)
				{
					container2.removeChildAt(i);
					i=0;
				}
			}
		}
	}
	
}
