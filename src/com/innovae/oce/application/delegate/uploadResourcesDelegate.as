package com.innovae.oce.application.delegate 
{
    import com.adobe.cairngorm.business.ServiceLocator;
    import com.innovae.oce.infraestructure.services.Webservice_oce;
    import com.innovae.services.orona.evolutio.type.T_authorization;
    import com.innovae.services.orona.evolutio.type.T_resource_type;
    
    import flash.events.Event;
    import flash.utils.ByteArray;
    
    import mx.controls.Alert;
    import mx.events.PropertyChangeEvent;
    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.http.HTTPService;
    
    public class uploadResourcesDelegate  //updated
    {
        private var responder : IResponder; //updated
        private var service : Webservice_oce;  //updated
        
        public function uploadResourcesDelegate( responder : IResponder )
        {
			this.service = new Webservice_oce();
            this.responder = responder;
        }
        
        public function uploadResources(user:T_authorization, file:ByteArray, filename:String, resource_type:T_resource_type): void
        {
    		trace("(delegating) -> uploadResources");
    		var servicecall:AsyncToken = service.uploadResource(user, file, filename, resource_type);
			
			servicecall.addResponder(this.responder);
        }
    }
}
