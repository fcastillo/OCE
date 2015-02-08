package com.innovae.oce.application.delegate 
{
    import com.adobe.cairngorm.business.ServiceLocator;
    import com.innovae.oce.domain.T_authorization;
    import com.innovae.oce.domain.T_version;
    import com.innovae.oce.domain.T_version_style;
    import com.innovae.oce.domain.datamodel.Base;
    import com.innovae.oce.infraestructure.services.Webservice_oce;
    
    import mx.controls.Alert;
    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.http.HTTPService;
    
    public class removeVersionStyleDelegate  //updated
    {
        private var responder : IResponder; //updated
        private var service : Webservice_oce;  //updated
        
        public function removeVersionStyleDelegate( responder : IResponder )
        {
			this.service = new Webservice_oce();
            this.responder = responder;
        }
        
        public function removeversionstyle(user:T_authorization, version_style:T_version_style): void
        {
    		trace("(delegating) -> removedetailedversion");
    		var servicecall:AsyncToken = service.removeDetailedVersion(user,version_style);
			servicecall.addResponder(this.responder);
        }
    }
}
