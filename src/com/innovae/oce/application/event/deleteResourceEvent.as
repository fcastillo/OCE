package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_resource;
	import com.innovae.services.orona.evolutio.type.T_version;
	
	import flash.events.Event;
	
	public class deleteResourceEvent extends CairngormEvent
	{

		public static const REMOVE_RESOURCE:String = "remove_resource";
		
		private var _user:T_authorization;
		private var _resource:T_resource;
		
		public function deleteResourceEvent(type:String, user:T_authorization, resource:T_resource)
		{
			super(REMOVE_RESOURCE);
			this._user = user;
			this._resource = resource;
		}
		
		public function user():T_authorization
		{
			return this._user;
		}
		
		public function resource():T_resource
		{
			return this._resource;
		}
		
	}	
}