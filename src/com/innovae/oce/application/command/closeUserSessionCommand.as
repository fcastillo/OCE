package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.*;
	import com.innovae.oce.application.event.closeUserSessionEvent;
	import com.innovae.oce.application.event.keepAliveUserSessionEvent;
	import com.innovae.oce.application.event.loginEvent;
	import com.innovae.oce.domain.datamodel.Base;
	import com.innovae.oce.infraestructure.services.*;
	import com.innovae.oce.presentation.view.login;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	
	import flash.events.EventDispatcher;
	import flash.media.SoundMixer;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.CursorManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.rpc.soap.WebService;
	
	public class closeUserSessionCommand implements ICommand, IResponder
	{
		private var razon:String;
		public function execute(event:CairngormEvent):void
		{
			trace("closeUserSessionCommand -> execute.");
			CursorManager.setBusyCursor();
			this.razon = (event as closeUserSessionEvent).razon(); 
			new closeUserSessionDelegate(this).closeUserSession((event as closeUserSessionEvent).user());
		}
		
		public function result(data:Object):void
		{
			trace("closeUserSessionCommand <- result["+data.result+"]");
			CursorManager.removeBusyCursor(); 
			Base.getinstance().user.username = "";
			Base.getinstance().user.password = "";
			Base.getinstance().user.license_id = null;
			flash.media.SoundMixer.stopAll();
			Base.getinstance().stopActivityTimer();
			switch(razon)
			{
				case "max_tryout": 
					Alert.show(Base.getinstance().i18n_txt.getValue("activity_timer_max_notif_tryouts_text"),Base.getinstance().i18n_txt.getValue("activity_timer_max_notif_tryouts_title"), Alert.OK, null, Base.getinstance().reloadWebPage);	
					break;
				case "activity_timeout":
					Alert.show(Base.getinstance().i18n_txt.getValue("activity_timeout_text"),Base.getinstance().i18n_txt.getValue("activity_timeout_title"), Alert.OK, null, Base.getinstance().reloadWebPage);
					break;
				case "sessin_closed":
					trace("session_closed");
					var evt:CloseEvent = new CloseEvent(CloseEvent.CLOSE);
					Base.getinstance().reloadWebPage(evt);
					break;
				case "login_incorrect":
					Alert.show(Base.getinstance().i18n_txt.getValue("login_incorrect_notification_text"),Base.getinstance().i18n_txt.getValue("login_incorrect_notification_title"), Alert.OK, null, Base.getinstance().reloadWebPage);
					break;
				case "session_already_open":
					Alert.show(Base.getinstance().i18n_txt.getValue("login_session_already_open_notification_text"),Base.getinstance().i18n_txt.getValue("login_session_already_open_notification_title"), Alert.OK, null, Base.getinstance().reloadWebPage);
					break;
				case "app_exit":
					trace("app_exit");
					var evt:CloseEvent = new CloseEvent(CloseEvent.CLOSE);
					Base.getinstance().reloadWebPage(evt);
					break;
				case "no_license_for_this_tool":
					Alert.show(Base.getinstance().i18n_txt.getValue("no_license_for_this_tool_text"),Base.getinstance().i18n_txt.getValue("no_license_for_this_tool_title"), Alert.OK, null, Base.getinstance().reloadWebPage);
					break;
			}
		}
		
		public function fault(info:Object) : void {
			trace("keepAliveUserSessionCommand <- fault [" + info.toString()+"]");
			flash.media.SoundMixer.stopAll();
			CursorManager.removeBusyCursor(); 
			Base.getinstance().user.username = "";
			Base.getinstance().user.password = "";
			Base.getinstance().user.license_id = null;
			switch(razon)
			{
				case "max_tryout": 
					Alert.show(Base.getinstance().i18n_txt.getValue("activity_timer_max_notif_tryouts_text"),Base.getinstance().i18n_txt.getValue("activity_timer_max_notif_tryouts_title"), Alert.OK, null, Base.getinstance().reloadWebPage);	
					break;
				case "activity_timeout":
					Alert.show(Base.getinstance().i18n_txt.getValue("activity_timeout_text"),Base.getinstance().i18n_txt.getValue("activity_timeout_title"), Alert.OK, null, Base.getinstance().reloadWebPage);
					break;
				case "sessin_closed":
					trace("session_closed");
					var evt:CloseEvent = new CloseEvent(CloseEvent.CLOSE);
					Base.getinstance().reloadWebPage(evt);
					break;
				case "login_incorrect":
					Alert.show(Base.getinstance().i18n_txt.getValue("login_incorrect_notification_text"),Base.getinstance().i18n_txt.getValue("login_incorrect_notification_title"), Alert.OK, null, Base.getinstance().reloadWebPage);
					break;
				case "session_already_open":
					Alert.show(Base.getinstance().i18n_txt.getValue("login_session_already_open_notification_text"),Base.getinstance().i18n_txt.getValue("login_session_already_open_notification_title"), Alert.OK, null, Base.getinstance().reloadWebPage);
					break;
				case "app_exit":
					trace("app_exit");
					var evt:CloseEvent = new CloseEvent(CloseEvent.CLOSE);
					Base.getinstance().reloadWebPage(evt);
					break;
				case "no_license_for_this_tool":
					Alert.show(Base.getinstance().i18n_txt.getValue("no_license_for_this_tool_text"),Base.getinstance().i18n_txt.getValue("no_license_for_this_tool_title"), Alert.OK, null, Base.getinstance().reloadWebPage);
					break;
			}
		}
	}
	
}