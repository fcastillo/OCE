package com.innovae.oce.application.delegate 
{
    import com.adobe.cairngorm.business.ServiceLocator;
    import com.innovae.services.orona.evolutio.type.T_authorization;
    import com.innovae.services.orona.evolutio.type.T_version;
    import com.innovae.oce.domain.datamodel.Base;
    import com.innovae.oce.infraestructure.services.Webservice_oce;
    
    import mx.controls.Alert;
    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.http.HTTPService;
    
    public class removeDetailedVersionDelegate  //updated
    {
        private var responder : IResponder; //updated
        private var service : Webservice_oce;  //updated
        
        public function removeDetailedVersionDelegate( responder : IResponder )
        {
			this.service = new Webservice_oce();
            this.responder = responder;
        }
        
        public function removedetailedversion(user:T_authorization, version:T_version): void
        {
    		trace("(delegating) -> removedetailedversion");
    		var servicecall:AsyncToken = service.removeDetailedVersion(user,version);
			servicecall.addResponder(this.responder);
        }
    }
}
