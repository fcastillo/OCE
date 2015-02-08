package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.oce.domain.datamodel.Base;
	
	import flash.events.Event;
	
	public class loginEvent extends CairngormEvent
	{
		public static const LOGIN:String = "login";
		
		private var _user:T_authorization;
		private var _tool:String;

		public function loginEvent(type:String, username:String, password:String, tool:String)
		{
			super(type);
			this._user = new T_authorization();
			this._user.username = username;
			this._user.password = password;
			Base.getinstance().user = this._user;
			this._tool = tool;
			trace("loginEvent("+username+","+password+","+tool+")");
		}
		
		
		public function username():String
		{
			return this._user.username;
		}
		
		public function password():String
		{
			return this._user.password;
		}
		public function license_id():int
		{
			return this._user.license_id;
		}
		public function user():T_authorization
		{
			return this._user;
		}
		public function tool():String
		{
			return this._tool;
		}
		
	}	
}