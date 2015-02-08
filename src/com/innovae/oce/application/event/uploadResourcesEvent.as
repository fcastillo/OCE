
package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_resource_type;
	import com.innovae.services.orona.evolutio.type.T_version;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	public class uploadResourcesEvent extends CairngormEvent
	{
		
		public static const UPLOAD_RESOURCE:String = "upload_resource";
		
		private var _user:T_authorization;
		private var _file:ByteArray;
		private var _filename:String;
		private var _type:T_resource_type;
		
		public function uploadResourcesEvent(type:String, user:T_authorization, file:ByteArray, filename:String, resource_type:T_resource_type)
		{
			super(UPLOAD_RESOURCE);
			this._user = user;
			this._file = file;
			this._filename = filename;
			this._type = resource_type;
			trace("uploadResourcesEvent("+user.username+","+user.password+","+user.license_id+","+file.length+","+filename+","+resource_type.id+","+resource_type.type_name+")");
		}
		
		public function user():T_authorization
		{
			return this._user;
		}
		
		public function file():ByteArray
		{
			return this._file;
		}
		
		public function filename():String
		{
			return this._filename;
		}
		
		public function resource_type():T_resource_type
		{
			return this._type;
		}
	}	
}