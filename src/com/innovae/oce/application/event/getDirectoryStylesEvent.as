package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_version;
	import com.innovae.services.orona.evolutio.type.T_resource_type;
	
	import flash.events.Event;
	
	public class getDirectoryStylesEvent extends CairngormEvent
	{
		
		public static const GET_DIRECTORYSTYLES:String = "get_directory_styles";
		
		private var _user:T_authorization;
		private var _type:T_resource_type;
		
		public function getDirectoryStylesEvent(type:String, user:T_authorization)
		{
			super(GET_DIRECTORYSTYLES);
			this._user = user;
			trace("getDirectoryStylesEvent("+user.username+","+user.password+","+user.license_id+")");
		}
		
		public function user():T_authorization
		{
			return this._user;
		}
		
		public function resource_type():T_resource_type
		{
			return this._type;
		}
		
	}	
}