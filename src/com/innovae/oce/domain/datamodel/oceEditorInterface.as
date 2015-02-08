package com.innovae.oce.domain.datamodel
{
	import com.innovae.oce.domain.T_resource;

	public interface oceEditorInterface
	{
		function loadXML(xml:String):int;
		function setResourceLibrary(resourceLibrary:Object):void;
		function setSelectedResource(resource:Object):void;
	}
}