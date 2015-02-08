package com.innovae.oce.domain.datamodel
{
	public interface oceEditorProviderInterface 
	{
		function getResourceURL(resource_type:int = 0,default_resource:String = ""):void;
		function saveContent(contentXML:XML, resources:Array = null):void;
		function returnWithoutSaving():void;
	}
	
}
