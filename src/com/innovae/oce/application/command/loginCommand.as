package com.innovae.oce.application.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.innovae.oce.application.delegate.*;
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
	
	public class loginCommand implements ICommand, IResponder
	{
		
		public function execute(event:CairngormEvent):void
		{
			CursorManager.setBusyCursor(); 
			new loginDelegate(this).login((event as loginEvent).username(), (event as loginEvent).password(), (event as loginEvent).tool());
		}
		
		public function result(data:Object):void
		{
			CursorManager.removeBusyCursor(); 
			var result:T_resul = data.result as T_resul;
			Base.getinstance().login(result);
		}
		
		public function fault(info:Object) : void 
		{
			Alert.show("LOGIN ERROR");
			CursorManager.removeBusyCursor(); 
		}
	}
	
}