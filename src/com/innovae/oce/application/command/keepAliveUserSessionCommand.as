package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.*;
	import com.innovae.oce.application.event.keepAliveUserSessionEvent;
	import com.innovae.oce.application.event.loginEvent;
	import com.innovae.oce.domain.datamodel.Base;
	import com.innovae.oce.infraestructure.services.*;
	import com.innovae.oce.presentation.view.login;
	import com.innovae.services.orona.evolutio.type.T_authorization;
	import com.innovae.services.orona.evolutio.type.T_resul;
	
	import flash.events.EventDispatcher;
	
	import mx.controls.Alert;
	import mx.managers.CursorManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.rpc.soap.WebService;
	
	public class keepAliveUserSessionCommand implements ICommand, IResponder
	{
		
		public function execute(event:CairngormEvent):void
		{
			trace("keepAliveUserSessionCommand -> execute.");
			CursorManager.setBusyCursor(); 

			new keepAliveUserSessionDelegate(this).keepAliveUserSession((event as keepAliveUserSessionEvent).user());
		}
		
		public function result(data:Object):void
		{
			trace("keepAliveUserSessionCommand <- result["+data.result.result+"]");
			CursorManager.removeBusyCursor(); 

			var result:T_resul = data.result as T_resul;
			
			if (result.result >=0)
			{
				Base.getinstance().startActivityTimer();
			}
			else
			{
				Base.getinstance().checkActivityTimerTryOuts();
			}
		}
		
		public function fault(info:Object) : void {
			trace("keepAliveUserSessionCommand <- fault [" + info.toString()+"]");
			CursorManager.removeBusyCursor(); 

			Base.getinstance().checkActivityTimerTryOuts();
		}
	}
	
}