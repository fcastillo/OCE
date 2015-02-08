package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.services.orona.evolutio.type.T_area;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_detailedversion;
	import com.innovae.services.orona.evolutio.type.T_version;
	
	import flash.events.Event;
	
	public class saveContentAreaEvent extends CairngormEvent
	{

		public static const SAVE_CONTENT_AREA:String = "save_content_area";
		
		private var _user:T_authorization;
		private var _area:T_area;
		
		public function saveContentAreaEvent(type:String, user:T_authorization, area:T_area)
		{
			super(SAVE_CONTENT_AREA);
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