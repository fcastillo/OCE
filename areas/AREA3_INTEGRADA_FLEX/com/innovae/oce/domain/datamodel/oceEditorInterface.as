package com.innovae.oce.domain.datamodel 
{
	
	public interface oceEditorInterface 
	{
		function loadXML(xml:String):int;
		function setResourceLibrary(resourceLibrary:Object):void;
		function setSelectedResource(resource:Object):void;
	}
	
}
