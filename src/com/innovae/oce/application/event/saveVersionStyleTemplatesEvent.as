package com.innovae.oce.application.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_resource_type;
	import com.innovae.services.orona.evolutio.type.T_version;
	import com.innovae.services.orona.evolutio.type.T_version_style;
	
	import flash.events.Event;
	
	public class saveVersionStyleTemplatesEvent extends CairngormEvent
	{
		
		public static const SAVE_VERSION_STYLE_TEMPLATES:String = "save_version_style_templates";
		
		private var _user:T_authorization;
		private var _version_style:T_version_style;
		
		public function saveVersionStyleTemplatesEvent(type:String, user:T_authorization, style:T_version_style)
		{
			super(SAVE_VERSION_STYLE_TEMPLATES);
			this._user = user;
			this._version_style = style;
			trace("saveVersionStyleTemplatesEvent("+user.username+","+user.password+","+user.license_id+","+style.id+","+style.name+","+style.text_font+","+style.text_size+","+style.text_color+","+style.background_color+","+style.border_color+","+style.anim_speed+")");
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