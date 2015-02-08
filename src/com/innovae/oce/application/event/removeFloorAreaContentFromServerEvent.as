package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.services.orona.evolutio.type.T_area;
	import com.innovae.services.orona.evolutio.type.T_area_type;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_resource_type;
	import com.innovae.services.orona.evolutio.type.T_version;
	
	import flash.events.Event;
	
	public class removeFloorAreaContentFromServerEvent extends CairngormEvent
	{
		
		public static const REMOVE_AREA_FROM_SERVER:String = "remove_area_from_server";
		
		private var _user:T_authorization;
		private var _area:T_area;
		
		public function removeFloorAreaContentFromServerEvent(type:String, user:T_authorization,area:T_area)
		{
			super(REMOVE_AREA_FROM_SERVER);
			this._user = user;
			this._area = area;
			trace("removeFloorAreaContentFromServer("+user.username+","+user.password+","+user.license_id+","+area.id+","+area.name+")");
		}
		public function user():T_authorization
		{
			return this._user;
		}
		public function area():T_area
		{
			return this._area;
		}
	}	
}