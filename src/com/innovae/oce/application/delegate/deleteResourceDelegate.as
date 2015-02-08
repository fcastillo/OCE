package com.innovae.oce.application.delegate 
{
    import com.adobe.cairngorm.business.ServiceLocator;
    import com.innovae.oce.domain.datamodel.Base;
    import com.innovae.oce.infraestructure.services.Webservice_oce;
    import com.innovae.services.orona.evolutio.type.T_authorization;
    import com.innovae.services.orona.evolutio.type.T_resource;
    import com.innovae.services.orona.evolutio.type.T_version;
    
    import mx.controls.Alert;
    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.http.HTTPService;
    
    public class deleteResourceDelegate  //updated
    {
        private var responder : IResponder; //updated
        private var service : Webservice_oce;  //updated
        
        public function deleteResourceDelegate( responder : IResponder )
        {
			this.service = new Webservice_oce();
            this.responder = responder;
        }
        
        public function deleteresource(user:T_authorization, resource:T_resource): void
        {
    		trace("(delegating) -> deleteresource");
    		var servicecall:AsyncToken = service.deleteResource(user,resource);
			servicecall.addResponder(this.responder);
        }
    }
}
