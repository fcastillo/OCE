package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.services.orona.evolutio.type.T_area;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_version;
	
	import flash.events.Event;
	
	public class getIslaDetailedVersionFromAreaEvent extends CairngormEvent
	{

		public static const GET_DETAILED_VERSION_FROM_AREA:String = "get_detailed_version_from_area";
		
		private var _user:T_authorization;
		private var _area:T_area;
		
		public function getIslaDetailedVersionFromAreaEvent(type:String, user:T_authorization, area:T_area)
		{
			super(GET_DETAILED_VERSION_FROM_AREA);
			this._user = user;
			this._area = area;
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