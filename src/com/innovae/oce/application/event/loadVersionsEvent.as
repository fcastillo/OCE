package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_version;
	
	import flash.events.Event;
	
	public class loadVersionsEvent extends CairngormEvent
	{

		public static const LOAD_VERSIONS:String = "load_versions";
		
		private var _user:T_authorization;
		
		public function loadVersionsEvent(type:String, user:T_authorization)
		{
			super(LOAD_VERSIONS);
			this._user = user;
		}
		
		public function user():T_authorization
		{
			return this._user;
		}
		
	}	
}