package com.innovae.oce.domain.datamodel
{
	import com.innovae.services.orona.evolutio.type.*;

	public interface oceEditorProviderInterface
	{
		function getResourceURL(resource_type:int = 0, previous_resource_url:String = "-1"):void;
		//function saveContent(contentXML:String, resources:Array = null):void;
		function saveContent(contentXML:XML, resources:Array = null):void;
		function returnWithoutSaving():void;
	}
}