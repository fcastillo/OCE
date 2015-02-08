package com.innovae.oce.application.delegate 
{
    import com.adobe.cairngorm.business.ServiceLocator;
    import com.innovae.services.orona.evolutio.type.T_area;
    import com.innovae.services.orona.evolutio.type.T_authorization;
    import com.innovae.services.orona.evolutio.type.T_version;
    import com.innovae.oce.domain.datamodel.Base;
    import com.innovae.oce.infraestructure.services.Webservice_oce;
    
    import mx.controls.Alert;
    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.http.HTTPService;
    
    public class getIslaDetailedVersionFromAreaDelegate  //updated
    {
        private var responder : IResponder; //updated
        private var service : Webservice_oce;  //updated
        
        public function getIslaDetailedVersionFromAreaDelegate( responder : IResponder )
        {
			this.service = new Webservice_oce();
            this.responder = responder;
        }
        
        public function getdetailedversion(user:T_authorization, area:T_area): void
        {
    		trace("(delegating) -> getIslaDetailedVersionFromArea");
    		var servicecall:AsyncToken = service.getIslaDetailedVersionFromArea(user,area);
			servicecall.addResponder(this.responder);
        }
    }
}
