package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.oce.domain.datamodel.Base;
	
	import flash.events.Event;
	
	public class keepAliveUserSessionEvent extends CairngormEvent
	{
		public static const KEEP_ALIVE:String = "keep_alive";
		
		private var _user:T_authorization;

		public function keepAliveUserSessionEvent(type:String, user:T_authorization)
		{
			super(type);
			this._user = user;
			trace("keepAliveUserSessionEvent("+user.username+","+user.password+","+user.license_id+","+user.user_id+")");
		}
		
		
		public function user():T_authorization
		{
			return this._user;
		}
		
	}	
}