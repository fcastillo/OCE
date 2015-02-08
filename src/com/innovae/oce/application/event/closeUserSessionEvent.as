package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.domain.datamodel.Base;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	
	import flash.events.Event;
	
	public class closeUserSessionEvent extends CairngormEvent
	{
		public static const CLOSE_SESSION:String = "close_session";
		
		private var _user:T_authorization;
		private var _razon:String;

		public function closeUserSessionEvent(type:String, user:T_authorization, razon:String)
		{
			super(type);
			this._user = user;
			this._razon = razon;
			trace("closeUserSessionEvent("+user.username+","+user.password+","+user.license_id+","+user.user_id+")");
		}
		
		
		public function user():T_authorization
		{
			return this._user;
		}
		
		public function razon():String
		{
			return this._razon;
		}
		
	}	
}