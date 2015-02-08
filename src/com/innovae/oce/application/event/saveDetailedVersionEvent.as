package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_detailedversion;
	import com.innovae.services.orona.evolutio.type.T_version;
	
	import flash.events.Event;
	
	public class saveDetailedVersionEvent extends CairngormEvent
	{

		public static const SAVE_DETAILED_VERSION:String = "save_detailed_version";
		
		private var _user:T_authorization;
		private var _version:T_detailedversion;
		private var _newVersion:Boolean;
		
		public function saveDetailedVersionEvent(type:String, user:T_authorization, version:T_detailedversion, newVersion:Boolean)
		{
			super(SAVE_DETAILED_VERSION);
			this._user = user;
			this._version = version;
			this._newVersion = newVersion;
		}
		
		public function user():T_authorization
		{
			return this._user;
		}
		
		public function version():T_detailedversion
		{
			return this._version;
		}
		
		public function newVersion():Boolean
		{
			return this._newVersion;
		}
		
	}	
}