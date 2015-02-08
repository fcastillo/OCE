package com.innovae.oce.domain.datamodel
{
	import flash.events.Event;
	
	public class resourceReceivedEvent extends Event
	{
		public static const RESOURCE_RECEIVED:String = "RESOURCE_RECEIVED";
		//Aquí pasaremos algun dato a usar. Podemos poner la cantidad de variables que queramos
		public var resource:Object;
		public function resourceReceivedEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}