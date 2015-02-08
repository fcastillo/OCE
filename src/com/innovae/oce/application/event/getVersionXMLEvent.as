package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_version;
	
	import flash.events.Event;
	
	public class getVersionXMLEvent extends CairngormEvent
	{

		public static const GET_VERSION_XML:String = "get_version_xml";
		
		private var _user:T_authorization;
		private var _version:T_version;
		
		public function getVersionXMLEvent(type:String, user:T_authorization, version:T_version)
		{
			super(GET_VERSION_XML);
			this._user = user;
			this._version = version;
		}
		
		public function user():T_authorization
		{
			return this._user;
		}
		
		public function version():T_version
		{
			return this._version;
		}
		
	}	
}