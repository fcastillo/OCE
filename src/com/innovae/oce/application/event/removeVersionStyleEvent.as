package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_version;
	import com.innovae.services.orona.evolutio.type.T_version_style;
	
	import flash.events.Event;
	
	public class removeVersionStyleEvent extends CairngormEvent
	{

		public static const REMOVE_VERSION_STYLE:String = "remove_version_style";
		
		private var _user:T_authorization;
		private var _version_style:T_version_style;
		
		public function removeVersionStyleEvent(type:String, user:T_authorization, version_style:T_version_style)
		{
			super(REMOVE_VERSION_STYLE);
			this._user = user;
			this._version_style = version_style;
		}
		
		public function user():T_authorization
		{
			return this._user;
		}
		
		public function version_style():T_version_style
		{
			return this._version_style;
		}
		
	}	
}