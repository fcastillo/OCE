package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.services.orona.evolutio.type.T_area_type;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_resource_type;
	import com.innovae.services.orona.evolutio.type.T_version;
	
	import flash.events.Event;
	
	public class getAreasEvent extends CairngormEvent
	{
		
		public static const GET_AREAS:String = "get_areas";
		
		private var _user:T_authorization;
		private var _type:T_area_type;
		
		public function getAreasEvent(type:String, user:T_authorization,area_type:T_area_type)
		{
			super(GET_AREAS);
			this._user = user;
			this._type = area_type;
			trace("getAreasEvent("+user.username+","+user.password+","+user.license_id+","+area_type.id+","+area_type.type_name+")");
		}
		public function user():T_authorization
		{
			return this._user;
		}
		public function area_type():T_area_type
		{
			return this._type;
		}
	}	
}