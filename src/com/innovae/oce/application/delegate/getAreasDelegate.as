package com.innovae.oce.application.delegate 
{
    import com.adobe.cairngorm.business.ServiceLocator;
    import com.innovae.services.orona.evolutio.type.T_area_type;
    import com.innovae.services.orona.evolutio.type.T_authorization;
    import com.innovae.oce.infraestructure.services.Webservice_oce;
    
    import mx.controls.Alert;
    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.http.HTTPService;
    
    public class getAreasDelegate  //updated
    {
        private var responder : IResponder; //updated
        private var service : Webservice_oce;  //updated
        
		public function getAreasDelegate( responder : IResponder )
        {
			this.service = new Webservice_oce();
            this.responder = responder;
        }
        
        public function getAreas(user:T_authorization,area_type:T_area_type): void
        {
    		trace("(delegating) -> getAreasDelegate");
    		var servicecall:AsyncToken = service.getFloorAreaContents(user,area_type);
			servicecall.addResponder(this.responder);
        }
    }
}
