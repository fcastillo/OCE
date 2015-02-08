package com.innovae.oce.application.delegate 
{
    import com.adobe.cairngorm.business.ServiceLocator;
    import com.innovae.oce.infraestructure.services.Webservice_oce;
    import com.innovae.services.orona.evolutio.type.T_area;
    import com.innovae.services.orona.evolutio.type.T_area_type;
    import com.innovae.services.orona.evolutio.type.T_authorization;
    
    import mx.controls.Alert;
    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.http.HTTPService;
    
    public class removeFloorAreaContentFromServerDelegate  //updated
    {
        private var responder : IResponder; //updated
        private var service : Webservice_oce;  //updated
        
		public function removeFloorAreaContentFromServerDelegate( responder : IResponder )
        {
			this.service = new Webservice_oce();
            this.responder = responder;
        }
        
        public function removeArea(user:T_authorization,area:T_area): void
        {
    		trace("(delegating) -> removeFloorAreaContentFromServer");
    		var servicecall:AsyncToken = service.removeFloorAreaContent(user,area);
			servicecall.addResponder(this.responder);
        }
    }
}
