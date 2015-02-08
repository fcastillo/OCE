package com.innovae.oce.application.delegate 
{
    import com.adobe.cairngorm.business.ServiceLocator;
    import com.innovae.services.orona.evolutio.type.T_authorization;
    import com.innovae.oce.infraestructure.services.Webservice_oce;
    
    import mx.controls.Alert;
    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.http.HTTPService;
    
    public class getDirectoryStylesDelegate  //updated
    {
        private var responder : IResponder; //updated
        private var service : Webservice_oce;  //updated
        
		public function getDirectoryStylesDelegate( responder : IResponder )
        {
			this.service = new Webservice_oce();
            this.responder = responder;
        }
        
        public function getDirectoryStyles(user:T_authorization): void
        {
    		trace("(delegating) -> getDirectoryStylesDelegate");
    		var servicecall:AsyncToken = service.getDirectoryStyles(user);
			servicecall.addResponder(this.responder);
        }
    }
}
