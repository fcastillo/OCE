package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_version;
	import com.innovae.services.orona.evolutio.type.T_resource_type;
	
	import flash.events.Event;
	
	public class getVersionStyleTemplatesEvent extends CairngormEvent
	{
		
		public static const GET_VERSION_STYLE_TEMPLATES:String = "get_version_style_templates";
		
		private var _user:T_authorization;
		
		public function getVersionStyleTemplatesEvent(type:String, user:T_authorization)
		{
			super(GET_VERSION_STYLE_TEMPLATES);
			this._user = user;
			trace("getVersionStyleTemplatesEvent("+user.username+","+user.password+","+user.license_id+")");
		}
		
		public function user():T_authorization
		{
			return this._user;
		}
		
		
	}	
}