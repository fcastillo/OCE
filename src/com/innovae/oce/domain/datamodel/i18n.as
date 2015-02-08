package com.innovae.oce.domain.datamodel
{
	import mx.collections.ArrayCollection;

	public class i18n
	{
		public var values:Array = new Array();
		
		
		
		public function i18n()
		{
			trace("i18n");
			load();
		}
		
		public function load():void
		{
			trace("loading languajes...");
			values = new Array();
			
			var activity_timer_max_notif_tryouts_text:Array = new Array ([{key:"activity_timer_max_notif_tryouts_text", es: "Ha sido imposible contactar con el servidor y se ha cerrado la sesión de usuario."}]);
			var activity_timer_max_notif_tryouts_title:Array = new Array ([{key:"activity_timer_max_notif_tryouts_title", es: "Imposible conectar."}]);

			var activity_timeout_text:Array = new Array ([{key:"activity_timeout_text", es: "Se ha procedido a cerrar la sesión al detectar inactividad."}]);
			var activity_timeout_title:Array = new Array ([{key:"activity_timeout_title", es: "Inactividad detectada."}]);
			
			var incomplet_form_notification_text:Array = new Array ([{key:"incomplet_form_notification_text", es: "Debe llenar todos los campos."}]);
			var incomplet_form_notification_title:Array = new Array ([{key:"incomplet_form_notification_title",es: "Formulario incompleto."}]);
			var login_incorrect_notification_text:Array = new Array ([{key:"login_incorrect_notification_text", es:"Usuario no valido:\nCompruebe que el nombre de usuario y \ncontraseña indicados son correctos, \ny que su cuenta no ha caducado."}]);
			var login_incorrect_notification_title:Array = new Array([{key:"login_incorrect_notification_title", es:"Credenciales Incorrectas."}]);
			var login_session_already_open_notification_text:Array = new Array([{key:"login_session_already_open_notification_text", es:"Se encuentra abierta una sesión para este usuario."}]);
			var login_session_already_open_notification_title:Array = new Array([{key:"login_session_already_open_notification_title", es:"Sesión actualmente abierta."}]);
			
			var versionMenu_datagrid_header_title_name:Array = new Array([{key:"versionMenu_datagrid_header_title_name", es:"Nombre"}]);
			var versionMenu_datagrid_header_title_created:Array = new Array([{key:"versionMenu_datagrid_header_title_created", es:"Fecha de creación"}]);
			var versionMenu_datagrid_header_title_last_modification:Array = new Array([{key:"versionMenu_datagrid_header_title_last_modification", es:"Última modificación"}]);

			var versionMenu_datagrid_header_title_modify:Array = new Array([{key:"versionMenu_datagrid_header_title_modify", es:"Modificar"}]);
			var versionMenu_datagrid_header_title_delete:Array = new Array([{key:"versionMenu_datagrid_header_title_delete", es:"Eliminar"}]);
			var versionMenu_datagrid_header_title_new_from_existing_version:Array = new Array([{key:"versionMenu_datagrid_header_title_new_from_existing_version", es:"Crear nuevo a partir de..."}]);
			var versionMenu_datagrid_header_title_preview:Array = new Array([{key:"versionMenu_datagrid_header_title_preview", es:"Previsualizar"}]);
		
			var resourcesLibrary_addResource_text:Array = new Array([{key:"resourcesLibrary_addResource_text", es:"Importar nuevo recurso."}]);
			var resourcesLibrary_removeResource_text:Array = new Array([{key:"resourcesLibrary_removeResource_text", es:"Eliminar recurso seleccionado."}]);
			var resourcesLibrary_selectedResourceProps:Array = new Array([{key:"resourcesLibrary_selectedResourceProps", es:"Propiedades del recurso:"}]);
			var resourcesLibrary_selectedResourceName:Array = new Array([{key:"resourcesLibrary_selectedResourceName", es:"Nombre:"}]);
			var resourcesLibrary_selectedResourceDimensions:Array = new Array([{key:"resourcesLibrary_selectedResourceDimensions", es:"Dimensiones:"}]);
			var resourcesLibrary_selectedResourceSize:Array = new Array([{key:"resourcesLibrary_selectedResourceSize", es:"Tamaño:"}]);
			var resourcesLibrary_selectedResourceConfirmation_text:Array = new Array([{key:"resourcesLibrary_selectedResourceConfirmation_text", es:"Seleccionar recurso."}]);
			
			var no_license_for_this_tool_title:Array = new Array([{key:"no_license_for_this_tool_title", es:"Error de licencia."}]);
			var no_license_for_this_tool_text:Array = new Array([{key:"no_license_for_this_tool_text", es:"No cuenta con licencia de acceso a esta aplicación. Contacte con su administrador."}]);
			
			//var exists_floor_with_same_show_position_text:Array = new Array([{key:"exists_floor_with_same_show_position_text", es: "No se pueden guardar los cambios porque existe otro piso con el mismo identificador de planta."}]);
			var exists_floor_with_same_show_position_text:Array = new Array([{key:"exists_floor_with_same_show_position_text", es: "Ya existe un piso con ese número, por favor utilice otro número de piso"}]);
			var exists_floor_with_same_show_position_title:Array = new Array([{key:"exists_floor_with_same_show_position_title", es: "La operación no se puede realizar."}]);

			var sending_resource_text:Array = new Array([{key:"sending_resource_text", es: "El recurso seleccionado está siendo enviado al servidor.\nEn los próximos minutos estará disponible en su librería de recursos.\nSea paciente."}]);
			var sending_resource_title:Array = new Array([{key:"sending_resource_title", es: "Transfiriendo recurso"}]);
			
			var resource_not_avaiable_text:Array = new Array([{key:"resource_not_avaiable_text", es: "El recurso que desea asignar aún no ha sido cargado en la librería de recursos.\nUna vez se muestre su previsualización estará disponible para su asignación."}]);
			var resource_not_avaiable_title:Array = new Array([{key:"resource_not_avaiable_title", es: "Cargando recurso"}]);
			
			var resource_too_big_text:Array = new Array([{key:"resource_too_big_text", es: "El recurso seleccionado supera el tamaño máximo permitido (50MB)."}]);
			var resource_too_big_title:Array = new Array([{key:"resource_too_big_title", es: "Tamaño máximo superado"}]);
			
			
			values = [incomplet_form_notification_text, 
				incomplet_form_notification_title, 
				login_incorrect_notification_text, 
				login_incorrect_notification_title,
				versionMenu_datagrid_header_title_name,
				versionMenu_datagrid_header_title_created,
				versionMenu_datagrid_header_title_last_modification,
				versionMenu_datagrid_header_title_modify,
				versionMenu_datagrid_header_title_delete,
				versionMenu_datagrid_header_title_new_from_existing_version,
				versionMenu_datagrid_header_title_preview,
				resourcesLibrary_addResource_text,
				resourcesLibrary_removeResource_text,
				resourcesLibrary_selectedResourceProps,
				resourcesLibrary_selectedResourceName,
				resourcesLibrary_selectedResourceDimensions,
				resourcesLibrary_selectedResourceSize,
				resourcesLibrary_selectedResourceConfirmation_text,
				activity_timeout_text,
				activity_timeout_title,
				activity_timer_max_notif_tryouts_text,
				activity_timer_max_notif_tryouts_title,
				login_session_already_open_notification_text,
				login_session_already_open_notification_title,
				no_license_for_this_tool_text,
				no_license_for_this_tool_title,
				exists_floor_with_same_show_position_text,
				exists_floor_with_same_show_position_title,
				sending_resource_text,
				sending_resource_title,
				resource_not_avaiable_text,
				resource_not_avaiable_title,
				resource_too_big_text,
				resource_too_big_title
				
			];
			
			/*
			values['incomplet_form_notification_text']['es']="Debe llenar todos los campos.";
			values['incomplet_form_notification_title']['es']="Formulario incompleto.";
			
			values['login_incorrect_notification_text']['es']="El nombre de usuario o contraseña es incorrecto.";
			values['login_incorrect_notification_title']['es']="Credenciales Incorrectas.";
			*/
		}
		
		public function getValue(label:String):String
		{
			for (var i:int=0; i<this.values.length;i++)
			{
				if (label == values[i][0][0]["key"]) {
					return String(values[i][0][0][Base.getinstance().selected_lang]);
				}
			}
			return "";
		}
	}
}