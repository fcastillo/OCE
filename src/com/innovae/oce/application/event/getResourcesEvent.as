package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_resource_type;
	import com.innovae.services.orona.evolutio.type.T_version;
	
	import flash.events.Event;
	
	public class getResourcesEvent extends CairngormEvent
	{
		
		public static const GET_RESOURCES:String = "get_resources";
		
		private var _user:T_authorization;
		private var _type:T_resource_type;
		private var _previous_resource_id:int;
		
		public function getResourcesEvent(type:String, user:T_authorization, resource_type:T_resource_type, previous_resource_id:int = -1)
		{
			super(GET_RESOURCES);
			this._user = user;
			this._type = resource_type;
			this._previous_resource_id = previous_resource_id; 
			trace("getResourcesEvent("+user.username+","+user.password+","+user.license_id+","+resource_type+")");
		}
		
		public function user():T_authorization
		{
			return this._user;
		}
		
		public function resource_type():T_resource_type
		{
			return this._type;
		}
		
		public function previous_resource_id():int
		{
			return this._previous_resource_id;
		}
		
	}	
}