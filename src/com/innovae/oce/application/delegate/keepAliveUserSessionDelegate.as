package com.innovae.oce.application.delegate 
{
    import com.adobe.cairngorm.business.ServiceLocator;
    import com.innovae.services.orona.evolutio.type.T_authorization;
    import com.innovae.oce.infraestructure.services.Webservice_oce;
    
    import mx.controls.Alert;
    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.http.HTTPService;
    
    public class keepAliveUserSessionDelegate  //updated
    {
        private var responder : IResponder; //updated
        private var service : Webservice_oce;  //updated
        
        public function keepAliveUserSessionDelegate( responder : IResponder )
        {
			this.service = new Webservice_oce();
            this.responder = responder;
        }
        
        public function keepAliveUserSession(user:T_authorization): void
        {
    		trace("(delegating) -> keepAliveUserSession");
    		var servicecall:AsyncToken = service.keepAliveUserSession(user);
			servicecall.addResponder(this.responder);
        }
    }
}
