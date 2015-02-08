package com.innovae.oce.domain.datamodel
{
	import flash.events.Event;
	
	public class BaseEvent extends Event
	{
		public static const SHOW_PREVIEW:String = "com.innovae.oce.domain.datamodel.BaseEvent.SHOW_PREVIEW";
		
		public function BaseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}