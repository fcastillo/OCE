package com.innovae.oce.application.delegate 
{
    import com.adobe.cairngorm.business.ServiceLocator;
    import com.innovae.services.orona.evolutio.type.T_authorization;
    import com.innovae.services.orona.evolutio.type.T_detailedversion;
    import com.innovae.services.orona.evolutio.type.T_version_style;
    import com.innovae.oce.infraestructure.services.Webservice_oce;
    
    import mx.controls.Alert;
    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.http.HTTPService;
    
    public class saveVersionStyleTemplatesDelegate  //updated
    {
        private var responder : IResponder; //updated
        private var service : Webservice_oce;  //updated
        
		public function saveVersionStyleTemplatesDelegate( responder : IResponder )
        {
			this.service = new Webservice_oce();
            this.responder = responder;
        }
        
        public function saveVersionStyleTemplates(user:T_authorization,style:T_version_style): void
        {
    		trace("(delegating) -> saveVersionStyleTemplates");
    		var servicecall:AsyncToken = service.saveVersionStyle(user,style);
			servicecall.addResponder(this.responder);
        }
    }
}
