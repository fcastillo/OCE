package com.innovae.oce.application.delegate 
{
    import com.adobe.cairngorm.business.ServiceLocator;
    import com.innovae.services.orona.evolutio.type.T_authorization;
    import com.innovae.services.orona.evolutio.type.T_detailedversion;
    import com.innovae.services.orona.evolutio.type.T_version;
    import com.innovae.oce.domain.datamodel.Base;
    import com.innovae.oce.infraestructure.services.Webservice_oce;
    
    import mx.controls.Alert;
    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.http.HTTPService;
    
    public class saveDetailedVersionDelegate  //updated
    {
        private var responder : IResponder; //updated
        private var service : Webservice_oce;  //updated
        
        public function saveDetailedVersionDelegate( responder : IResponder )
        {
			this.service = new Webservice_oce();
            this.responder = responder;
        }
        
        public function saveDetailedVersion(user:T_authorization, version:T_detailedversion, newVersion:Boolean): void
        {
    		trace("(delegating) -> saveDetailedVersion version.name["+version.version.name+"]new?["+newVersion+"]");
    		var servicecall:AsyncToken = service.saveDetailedVersion(user,version, newVersion);
			servicecall.addResponder(this.responder);
        }
    }
}
