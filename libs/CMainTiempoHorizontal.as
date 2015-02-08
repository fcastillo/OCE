package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
		
	public class CMainTiempoHorizontal extends MovieClip 
	{
		var cod = "SPXX0052";//málaga
		var cod2 = "SPXX0061";//mallorca
				
		var weatherCod:String;
		var xmlLoader:URLLoader;
		var Dia:String = "hoy"; //hoy,mañana,pasado,siguiente
		var Ciudad:String = "SPXX0052";
		var fenomeno:MovieClip;
		var estilo:String = "cartoon";
		var fecha_num:String;
		var fecha_mesIng:String;
		var fecha_mesEsp:String;
		
		var actualizarFormato:Boolean = false;
		var actualizarTextos:Boolean = false;
		var formato:String = "dd/mm";
		
		var txtFecha:TextField;
		var txtTemperatura:TextField;
		var formato_fecha:TextFormat;
		var formato_temp:TextFormat;
		var fechaCreada:Boolean = false;
		var tempCreada:Boolean = false;
		
		//Formato
		var fuente_fecha:String = "Arial";
		var fuente_temp:String = "Arial";
		var size_fecha:int = 18;
		var size_temp:int = 18;
		var color_fecha:uint = 0x5D5D5D;
		var color_temp:uint = 0x5D5D5D;
		var align_fecha:String = "left";
		var align_temp:String = "left";
		var negrita_fecha:Boolean = true;
		var negrita_temp:Boolean = true;
		var cursiva_fecha:Boolean = false;
		var cursiva_temp:Boolean = false;
		var subrayado_fecha:Boolean = false;
		var subrayado_temp:Boolean = false;
		var ordenFecha : String = "";
				
		//actualización timer refresco
		var last_update:Date;
		var update_timer: Timer;
		var update_cycle: Number = 60*60*1000; //1 hora.
		
		//---------Función CMainTiempoHorizontal---------//
		//-- Constructor
		//--------------------------------------//
		public function CMainTiempoHorizontal() 
		{
			//PARA PROBAR EN LOCAL
			//getToday("SPXX0087");
			//get2DaysAfterTomorrow("SPXX0087");
			//get2DaysAfterTomorrow(cod2);
			//loadXML(new XML('<ELEMENTO fecha_fuente="Modern" temp_fuente="Modern" dia="Hoy" ciudad="SPXX0087" pais="España" estilo="cartoon" posicion_textos="Derecha" fecha_formato="dd/mm"  fecha_color="6118749" fecha_negrita="true" fecha_cursiva="false" fecha_subrayado="false"  temp_color="6118749" temp_negrita="true" temp_cursiva="false" temp_subrayado="false" profundidad="1" transparencia="1" cY="0" cX="0.07555555555555556" path="tiempoAS3_horizontal.swf" orden_fecha="MM-DD-YY"/>'));
			//addEventListener(Event.ENTER_FRAME, enterframe);
		}
		
		public function enterframe(e:Event)
		{
			//trace("ESCENARIO ("+stage.stageWidth+", "+stage.stageHeight+")");
			trace("THIS ("+this.width+", "+this.height+")");
		}
		
		//---------Función loadXML---------//
		//-- Edita el control según los atributos leídos en el dpe
		//-- Variables de entrada:
			//--datos: nodo xml del dpe
		//--------------------------------------//
		public function loadXML(datos:XML)
		{		
			color_fecha = datos.@fecha_color;
			fuente_fecha = datos.@fecha_fuente;trace("fuente para fecha : "+datos.@fecha_fuente);
			datos.@fecha_negrita == "true" ? negrita_fecha = true : negrita_fecha = false;
			datos.@fecha_cursiva == "true" ? cursiva_fecha = false : cursiva_fecha = false;
			datos.@fecha_subrayado == "true" ? subrayado_fecha = true : subrayado_fecha = false;
			
			color_temp = datos.@temp_color;
			fuente_temp = datos.@temp_fuente;trace("fuente para temp : "+datos.@temp_fuente);
			datos.@temp_negrita == "true" ? negrita_temp = true : negrita_temp = false;
			datos.@temp_cursiva == "true" ? cursiva_temp = false : cursiva_temp = false;
			datos.@temp_subrayado == "true" ? subrayado_temp = true : subrayado_temp = false;
			if(datos.@fecha_formato != null && datos.@fecha_formato != "") ordenFecha = datos.@fecha_formato;

			var dia:String = datos.@dia;
			var ciudad:String = datos.@ciudad;
			estilo = datos.@estilo;
			formato = datos.@fecha_formato;
			
			crearFormatos();
			
			if (dia == "Hoy")
			{
				getToday(ciudad);
			}
			else if (dia == "Mañana")
			{
				getTomorrow(ciudad);
			}
			else if (dia == "Pasado")
			{
				getDayAfterTomorrow(ciudad);
			}
			else if (dia == "Siguiente")
			{
				get2DaysAfterTomorrow(ciudad);
			}
			else
			{
				getTomorrow(ciudad);
			}
		}
		
		//---------Función crearFormatos---------//
		//-- Crea los formatos para los textos de la fecha y temperatura
		//--------------------------------------//
		public function crearFormatos()
		{
			try
			{
				formato_fecha = new TextFormat();
				formato_fecha.align = align_fecha;
				formato_fecha.bold = negrita_fecha;
				formato_fecha.color = color_fecha;
				formato_fecha.font = fuente_fecha;
				formato_fecha.italic = cursiva_fecha;
				//trace("<<"+formato_fecha.font+">>");
				switch(formato_fecha.font)
				{
					case "Arial":
						formato_fecha.size = 16;
						break;
					case "Arial Black":
						formato_fecha.size = 13;
						break;
					case "Comic Sans MS":
						formato_fecha.size = 13;
						break;
					case "Courier":
						formato_fecha.font = "Courier Normal";
						formato_fecha.size = 17;
						break;
					case "Courier New":
						formato_fecha.size = 14;
						break;
					case "Georgia":
						formato_fecha.size = 11;
						break;
					case "Impact":
						//formato_fecha.font = "Impact Normal";
						formato_fecha.size = 12;
						break;
					case "Lucida Console": 
						formato_fecha.size = 12;
						break;
					case "Lucida Sans": 
						formato_fecha.size = 13;
						break;
					case "Microsoft Sans Serif": 
						formato_fecha.size = 14;
						break;
					case "Modern": 
						formato_fecha.size = 14;
						break;
					case "Symbol": 
						formato_fecha.size = 14;
						break;
					case "Tahoma": 
						formato_fecha.size = 13;
						break;
					case "Times New Roman": 
						formato_fecha.size = 18;
						break;
					case "Trebuchet MS": 
						formato_fecha.size = 14;
						break;
					case "Verdana": 
						formato_fecha.size = 11;
						break
					default:
						formato_fecha.size = 14;
						break;
				}
				trace("formato_fecha.size "+formato_fecha.size);
				formato_fecha.underline = subrayado_fecha;
				
				formato_temp = new TextFormat();
				formato_temp.align = align_temp;
				formato_temp.bold = negrita_temp;
				formato_temp.color = color_temp;
				formato_temp.font = fuente_temp;
				formato_temp.italic = cursiva_temp;
				switch(formato_temp.font)
				{
					case "Arial":
						formato_temp.size = 18;
						break;
					case "Arial Black":
						formato_temp.size = 16;
						break;
					case "Comic Sans":
						formato_temp.size = 18;
						break;
					case "Courier":
						formato_temp.font = "Courier Normal";
						formato_temp.size = 18;
						break;
					case "Courier New":
						formato_temp.size = 14;
						break;
					case "Georgia":
						formato_temp.size = 14;
						break;
					case "Impact":
						formato_temp.size = 16;
						break;
					case "Lucida Console": 
						formato_temp.size = 12;
						break;
					case "Lucida Sans": 
						formato_temp.size = 16;
						break;
					case "Microsoft Sans Serif": 
						formato_temp.size = 16;
						break;
					case "Modern": 
						formato_temp.size = 15;
						break;
					case "Symbol": 
						formato_temp.size = 16;
						break;
					case "Tahoma": 
						formato_temp.size = 14;
						break;
					case "Times New Roman": 
						formato_temp.size = 18;
						break;
					case "Trebuchet MS": 
						formato_temp.size = 16;
						break;
					case "Verdana": 
						formato_temp.size = 12;
						break
					default:
						formato_temp.size = 18;
						break;
				}
				//trace("formato_temp.size "+formato_temp.size);
				formato_temp.underline = subrayado_temp;
			}
			catch(e:Error)
			{
				trace("Error = ", e.message);
			}
		}
		
		//---------Función getToday---------//
		//-- Llama a yahoo mediante cargapaginas.php, pidiendo el tiempo de hoy para una ciudad
		//-- Variables de entrada:
		//		- codigo: el código de la ciudad
		//--------------------------------------//
		public function getToday(codigo):void
		{
			Dia = "hoy";
			var final_url = escape("http://xml.weather.yahoo.com/forecastrss/"+codigo+'&d=5.xml'); //cambio: el API de yahoo ha sido modificado
			var now:Date = new Date();
			var url = "http://5.9.137.10/orona/backend/api/cargapaginas.php?url="+final_url+"&t="+now.getTime();

			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, showXML);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);		
			xmlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			xmlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			
			xmlLoader.load(new URLRequest(url));	
		}
		
		//---------Función getTomorrow---------//
		//-- Llama a yahoo mediante cargapaginas.php, pidiendo el tiempo de mañana para una ciudad
		//-- Variables de entrada:
		//		- codigo: el código de la ciudad
		//--------------------------------------//
		public function getTomorrow(codigo):void
		{
			Dia = "mañana";
			var final_url = escape("http://xml.weather.yahoo.com/forecastrss/"+codigo+'&d=5.xml'); //cambio: el API de yahoo ha sido modificado
			var now:Date = new Date();
			var url = "http://5.9.137.10/orona/backend/api/cargapaginas.php?url="+final_url+"&t="+now.getTime();
			
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, showXML);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			xmlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			xmlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			
			xmlLoader.load(new URLRequest(url));	
		}
		
		//---------Función getDayAfterTomorrow---------//
		//-- Llama a yahoo mediante cargapaginas.php, pidiendo el tiempo de pasado mañana para una ciudad
		//-- Variables de entrada:
		//		- codigo: el código de la ciudad
		//--------------------------------------//
		public function getDayAfterTomorrow(codigo):void
		{
			Dia = "pasado";
			var final_url = escape("http://xml.weather.yahoo.com/forecastrss/"+codigo+'&d=5.xml'); //cambio: el API de yahoo ha sido modificado
			var now:Date = new Date();
			var url = "http://5.9.137.10/orona/backend/api/cargapaginas.php?url="+final_url+"&t="+now.getTime();
			
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, showXML);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			xmlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			xmlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			
			xmlLoader.load(new URLRequest(url));	
		}
		
		//---------Función get2DaysAfterTomorrow---------//
		//-- Llama a yahoo mediante cargapaginas.php, pidiendo el tiempo a 3 días vista para una ciudad
		//-- Variables de entrada:
		//		- codigo: el código de la ciudad
		//--------------------------------------//
		public function get2DaysAfterTomorrow(codigo):void
		{
			Dia = "siguiente";
			var final_url = escape("http://xml.weather.yahoo.com/forecastrss/"+codigo+'&d=5.xml'); //cambio: el API de yahoo ha sido modificado
			var now:Date = new Date();
			var url = "http://5.9.137.10/orona/backend/api/cargapaginas.php?url="+final_url+"&t="+now.getTime();
			
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, showXML);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			xmlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			xmlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			
			xmlLoader.load(new URLRequest(url));	
		}
		
		//---------Función ioErrorHandler---------//
		//-- Si hay algún error traceamos
		//--------------------------------------//
		function ioErrorHandler(event:IOErrorEvent):void 
		{
			trace("Error I/O cargando tiempo = ", event.text);
			checkVisibility();
		}
		
		//---------Función securityErrorHandler---------//
		//-- Si hay algún error traceamos
		//--------------------------------------//
		function securityErrorHandler(event:SecurityErrorEvent):void 
		{
			trace("Error de seguridad cargando tiempo = ", event.text);
			checkVisibility();
		}
		
		//---------Función httpStatusHandler---------//
		//-- Si hay algún error traceamos
		//--------------------------------------//
		function httpStatusHandler(event:HTTPStatusEvent):void 
		{
			trace("http status = ", event.status);
			checkVisibility();
		}
		
		
		//---------Función showXML---------//
		//-- Llamamos a crearFormatos()
		//-- Parseamos el nodo del xml del día que nos interesa
		//-- Creamos las cajas de texto e insertamos datos
		//--------------------------------------//
		function showXML(e:Event):void 
		{
			try { removeChild(txtFecha); 		} catch (erro:Error) {}
			try { removeChild(txtTemperatura);  } catch (erro:Error) {}
			try { icono.removeChild(fenomeno);  } catch (erro:Error) {}
			
			
			XML.ignoreWhitespace = true; 
			var weather:XML = new XML(e.target.data);						
			var nodo:XML;
						
			switch (Dia)
			{
				case "hoy":
					nodo = weather.channel.item.children()[7];
					break;
				case "mañana":
					nodo = weather.channel.item.children()[8];
					break;
				case "pasado":
					nodo = weather.channel.item.children()[9];
					break;
				case "siguiente":
					nodo = weather.channel.item.children()[10];
					break;
				default:
					nodo = weather.channel.item.children()[7];
					break;
				
			}
					
			parseWeatherCode(nodo.@code);
			
			if(fenomeno != null)
			{
				if (estilo != "cartoon")
				{
					fenomeno.x = 12;
					fenomeno.y = 12;
				}		
				icono.addChild(fenomeno);	
				
			}
					
			//Creamos cajas de texto
			txtFecha = new TextField();
			//txtFecha.background = true;
			txtTemperatura = new TextField();
			//txtTemperatura.background = true;
			//txtFecha.border = true;
			//txtTemperatura.border = true;
			
			var fecha:String = nodo.@date.substr(0, nodo.@date.length - 5);
			
			//Guardamos fecha en variables
			fecha_num = fecha.substr(0, fecha.length - 4);
			fecha_mesIng = fecha.substr(fecha.length-3,3);
			fecha_mesEsp = traducirMes(fecha.substr(fecha.length-3,3));
			fecha = fecha.substr(0, fecha.length - 4)+" "+traducirMes(fecha.substr(fecha.length-3,3));
			
			//Insertamos textos
			/*if (formato == "mm/dd") txtFecha.text = fecha_mesIng+" "+fecha_num;
			else if (formato == "dd/mm") txtFecha.text = fecha_num+" "+fecha_mesEsp;*/
			var now : Date = new Date();
			var dia : String = now.getDate()<10 ?"0"+String(now.getDate()):String(now.getDate());// .toString(); if(dia.length == 1) dia = "0"+dia;
			var mes : String = (now.getMonth()+1)<10 ? "0"+String(now.getMonth()+1):String(now.getMonth()+1);//.toString(); if(mes.length == 1) mes = "0"+dia;
			var anio : String = now.getFullYear().toString().substring(now.getFullYear().toString().length-2,now.getFullYear().toString().length);
			trace(dia+"-"+mes+"-"+anio);
			var strFecha:String = "";
			if(ordenFecha == "DD-MM-YY")
			{
				strFecha = dia+"/"+mes+"/"+anio;
			}
			else if(ordenFecha == "YY-MM-DD")
			{
				strFecha = anio+"/"+mes+"/"+dia;
			}
			else if(ordenFecha == "MM-DD-YY")
			{
				strFecha = mes+"/"+dia+"/"+anio;
			}
			else
			{
				strFecha = dia+"/"+mes+"/"+anio;
			}
			txtFecha.text = strFecha;
			//txtFecha.text = "00/00/00";
			txtTemperatura.text = Math.round((Number(nodo.@low)-32)/1.8)+"/"+Math.round((Number(nodo.@high)-32)/1.8)+" ºC";
			//txtTemperatura.text ="-88/-88 ºC";
			crearFormatos();
			txtFecha.setTextFormat(formato_fecha);
			txtTemperatura.setTextFormat(formato_temp);
			trace(formato_fecha.font+"("+formato_fecha.size+") - "+formato_temp.font+"("+formato_temp.size+")");
			
			
			//txtFecha.height = 37;
			//txtFecha.width = txtFecha.textWidth * 1.7;
			//txtFecha.width = this.width - txtFecha.x;
			txtFecha.autoSize = "none";
			txtFecha.selectable = false;
			
			//txtTemperatura.height = 37;
			txtTemperatura.selectable = false;
			
			
			/*
			var w = txtFecha.width+5;
			//var w2 = txtTemperatura.width+39;
			var w2 = 139;
			
			txtTemperatura.autoSize = "none";
			txtFecha.width = w;
			txtTemperatura.width = w2;
			*/
			
			//updateSizePosition();
			//fenomeno.x = 12;
				//fenomeno.y = 12;
				fenomeno.width  = 245;
				fenomeno.height = 160;
				//icono.x = -10;
				icono.y = 15;
				icono.width  = 125;
				icono.height = 85;
				txtFecha.x = 160;
				txtFecha.y = 42;
				txtTemperatura.x = 160;
				txtTemperatura.y = 75;
				
				txtTemperatura.width = 274-txtTemperatura.x;
			txtTemperatura.height = 150-txtTemperatura.y;
				//txtTemperatura.width += 50;
			
			addChild(txtFecha);
			addChild(txtTemperatura);

			trace("last_update -> UPDATED!!!!");
			last_update = new Date();
			checkVisibility();
		}
		
		public function updateSizePosition():void
		{
			try
			{
				//fenomeno.x = 12;
				//fenomeno.y = 12;
				//fenomeno.width  = 245;
				//fenomeno.height = 160;
				//icono.x = -10;
				//icono.y = 15;
				//icono.width  = 125;
				//icono.height = 85;
				crearFormatos();
				txtFecha.x = 160;
				txtFecha.y = 42;
				txtTemperatura.x = 160;
				txtTemperatura.y = 75;
				txtFecha.width = 140;
				txtTemperatura.width = 140;
				txtFecha.setTextFormat(formato_fecha);
				txtTemperatura.setTextFormat(formato_temp);
	
			}
			catch ( error:Error) {trace("error en updateSizePosition: "+error.message);}
		}
		
		//---------Función traducirMes---------//
		//-- Devuelve el mes en castellano
		//-- Variables de entrada:
		//		- mesIng: el mes en inglés
		//--------------------------------------//
		public function traducirMes(mesIng)
		{
			var mes = mesIng;
			if(mesIng == "Jan")mes = "Ene";
			else if(mesIng == "Apr")mes = "Abr";
			else if(mesIng == "Aug")mes = "Ago";
			else if(mesIng == "Dec")mes = "Dic";
			return mes;
		}
		
		//---------Función parseWeatherCode---------//
		//-- Parsea el código de tiempo devuelto por yahoo y elige el icono correspondiente
		//--------------------------------------//
		public function parseWeatherCode(cod)
		{		
			switch (estilo)
			{
				case "simple":
					switch (cod.toString())
					{
						case "0": fenomeno= new tornado_simple();break;
						case "1": fenomeno= new tornado_simple();break;
						case "2": fenomeno= new tornado_simple();break;
						case "3": fenomeno=new tormentaElectrica_simple();break;
						case "4": fenomeno=new tormentaElectrica_simple();break;
						case "37": fenomeno=new tormentaElectrica_simple();break;
						case "38": fenomeno=new tormentaElectrica_simple();break;
						case "39": fenomeno=new tormentaElectrica_simple();break;
						case "5": fenomeno=new aguanieve_simple();break;
						case "6": fenomeno=new aguanieve_simple();break;
						case "7": fenomeno=new aguanieve_simple();break;
						case "8": fenomeno=new aguanieve_simple();break;
						case "10": fenomeno=new aguanieve_simple();break;
						case "18": fenomeno=new aguanieve_simple();break;
						case "9": fenomeno=new llovizna_simple();break;
						case "11": fenomeno=new lluvia_simple();break;
						case "12": fenomeno=new lluvia_simple();break;
						case "13": fenomeno=new nieve_simple();break;
						case "14": fenomeno=new nieve_simple();break;
						case "15": fenomeno=new nieve_simple();break;
						case "16": fenomeno=new nieve_simple();break;
						case "41": fenomeno=new nieve_simple();break;
						case "42": fenomeno=new nieve_simple();break;
						case "43": fenomeno=new nieve_simple();break;
						case "46": fenomeno=new nieve_simple();break;
						case "17": fenomeno=new granizo_simple();break;
						case "35": fenomeno=new granizo_simple();break;
						case "19": fenomeno=new polvo_simple();break;
						case "20": fenomeno=new niebla_simple();break;
						case "21": fenomeno=new niebla_simple();break;
						case "22": fenomeno=new cargadoDeHumo_simple();break;
						case "23": fenomeno=new nublado_simple();break;
						case "26": fenomeno=new nublado_simple();break;
						case "27": fenomeno=new nublado_simple();break;
						case "28": fenomeno=new nublado_simple();break;
						case "24": fenomeno=new viento_simple();break;
						case "25": fenomeno=new frio_simple();break;
						case "29": fenomeno=new parcialmenteNublado_simple();break;
						case "30": fenomeno=new parcialmenteNublado_simple();break;
						case "44": fenomeno=new parcialmenteNublado_simple();break;
						case "31": fenomeno=new soleado_simple();break;
						case "32": fenomeno=new soleado_simple();break;
						case "33": fenomeno=new soleado_simple();break;
						case "34": fenomeno=new soleado_simple();break;
						case "36": fenomeno=new caliente_simple();break;
						case "45": fenomeno=new tormenta_simple();break;
						case "47": fenomeno=new tormenta_simple();break;
						default : fenomeno=null;break;		
					}		
					break;
				case "clasico":
					switch (cod.toString())
					{
						case "0": fenomeno= new tornado_clasico();break;
						case "1": fenomeno= new tornado_clasico();break;
						case "2": fenomeno= new tornado_clasico();break;
						case "3": fenomeno=new tormentaElectrica_clasico();break;
						case "4": fenomeno=new tormentaElectrica_clasico();break;
						case "37": fenomeno=new tormentaElectrica_clasico();break;
						case "38": fenomeno=new tormentaElectrica_clasico();break;
						case "39": fenomeno=new tormentaElectrica_clasico();break;
						case "5": fenomeno=new aguanieve_clasico();break;
						case "6": fenomeno=new aguanieve_clasico();break;
						case "7": fenomeno=new aguanieve_clasico();break;
						case "8": fenomeno=new aguanieve_clasico();break;
						case "10": fenomeno=new aguanieve_clasico();break;
						case "18": fenomeno=new aguanieve_clasico();break;
						case "9": fenomeno=new llovizna_clasico();break;
						case "11": fenomeno=new lluvia_clasico();break;
						case "12": fenomeno=new lluvia_clasico();break;
						case "13": fenomeno=new nieve_clasico();break;
						case "14": fenomeno=new nieve_clasico();break;
						case "15": fenomeno=new nieve_clasico();break;
						case "16": fenomeno=new nieve_clasico();break;
						case "41": fenomeno=new nieve_clasico();break;
						case "42": fenomeno=new nieve_clasico();break;
						case "43": fenomeno=new nieve_clasico();break;
						case "46": fenomeno=new nieve_clasico();break;
						case "17": fenomeno=new granizo_clasico();break;
						case "35": fenomeno=new granizo_clasico();break;
						case "19": fenomeno=new polvo_clasico();break;
						case "20": fenomeno=new niebla_clasico();break;
						case "21": fenomeno=new niebla_clasico();break;
						case "22": fenomeno=new cargadoDeHumo_clasico();break;
						case "23": fenomeno=new nublado_clasico();break;
						case "26": fenomeno=new nublado_clasico();break;
						case "27": fenomeno=new nublado_clasico();break;
						case "28": fenomeno=new nublado_clasico();break;
						case "24": fenomeno=new viento_clasico();break;
						case "25": fenomeno=new frio_clasico();break;
						case "29": fenomeno=new parcialmenteNublado_clasico();break;
						case "30": fenomeno=new parcialmenteNublado_clasico();break;
						case "44": fenomeno=new parcialmenteNublado_clasico();break;
						case "31": fenomeno=new soleado_clasico();break;
						case "32": fenomeno=new soleado_clasico();break;
						case "33": fenomeno=new soleado_clasico();break;
						case "34": fenomeno=new soleado_clasico();break;
						case "36": fenomeno=new caliente_clasico();break;
						case "45": fenomeno=new tormenta_clasico();break;
						case "47": fenomeno=new tormenta_clasico();break;
						default : fenomeno=null;break;		
					}		
					break;
				default:
					switch (cod.toString())
					{
						case "0": fenomeno= new tornado();break;
						case "1": fenomeno= new tornado();break;
						case "2": fenomeno= new tornado();break;
						case "3": fenomeno=new tormentaElectrica();break;
						case "4": fenomeno=new tormentaElectrica();break;
						case "37": fenomeno=new tormentaElectrica();break;
						case "38": fenomeno=new tormentaElectrica();break;
						case "39": fenomeno=new tormentaElectrica();break;
						case "5": fenomeno=new aguanieve();break;
						case "6": fenomeno=new aguanieve();break;
						case "7": fenomeno=new aguanieve();break;
						case "8": fenomeno=new aguanieve();break;
						case "10": fenomeno=new aguanieve();break;
						case "18": fenomeno=new aguanieve();break;
						case "9": fenomeno=new llovizna();break;
						case "11": fenomeno=new lluvia();break;
						case "12": fenomeno=new lluvia();break;
						case "13": fenomeno=new nieve();break;
						case "14": fenomeno=new nieve();break;
						case "15": fenomeno=new nieve();break;
						case "16": fenomeno=new nieve();break;
						case "41": fenomeno=new nieve();break;
						case "42": fenomeno=new nieve();break;
						case "43": fenomeno=new nieve();break;
						case "46": fenomeno=new nieve();break;
						case "17": fenomeno=new granizo();break;
						case "35": fenomeno=new granizo();break;
						case "19": fenomeno=new polvo();break;
						case "20": fenomeno=new niebla();break;
						case "21": fenomeno=new niebla();break;
						case "22": fenomeno=new cargadoDeHumo();break;
						case "23": fenomeno=new nublado();break;
						case "26": fenomeno=new nublado();break;
						case "27": fenomeno=new nublado();break;
						case "28": fenomeno=new nublado();break;
						case "24": fenomeno=new viento();break;
						case "25": fenomeno=new frio();break;
						case "29": fenomeno=new parcialmenteNublado();break;
						case "30": fenomeno=new parcialmenteNublado();break;
						case "44": fenomeno=new parcialmenteNublado();break;
						case "31": fenomeno=new soleado();break;
						case "32": fenomeno=new soleado();break;
						case "33": fenomeno=new soleado();break;
						case "34": fenomeno=new soleado();break;
						case "36": fenomeno=new caliente();break;
						case "45": fenomeno=new tormenta();break;
						case "47": fenomeno=new tormenta();break;
						default : fenomeno=null;break;		
					}		
					break;
			}
			
		}
		
		/***************************** STYLE ***************************************/
		//-- GETTERS Y SETTERS PARA LOS FORMATOS Y ESTILO DE LOS TEXTOS Y EL ICONO
		
		public function setEstiloImagenes(op:String):void
		{
			estilo = op;
		}
		public function getEstiloImagenes():String
		{
			return(estilo);
		}
		
		public function negritaTexto(instancia:int,op:Boolean):void
		{
			if (instancia == 1) negrita_fecha = op;
			else if (instancia == 2) negrita_temp = op;
			updateSizePosition();
		}
		
		public function cursivaTexto(instancia:int,op:Boolean):void
		{
			if (instancia == 1) cursiva_fecha = op;
			else cursiva_temp = op;
			updateSizePosition();
		}
		
		public function subrayadoTexto(instancia:int,op:Boolean):void
		{
			if (instancia == 1) subrayado_fecha = op;
			else subrayado_temp = op;
			updateSizePosition();
		}
		
		public function colorTexto1(instancia:int,col):void
		{
			if(col.charAt(0)=="#")
			{
				col = "0x"+col.substring(1,7);
			}
			if (instancia == 1) color_fecha = col;
			else if (instancia == 2) color_temp = col;
			updateSizePosition();
		}
		
		public function fuenteTexto(instancia:int,f):void
		{
			if (instancia == 1) fuente_fecha = f; 
			else if (instancia == 2) fuente_temp = f;
			
			updateSizePosition();
		}
		
		public function cambiarFormatoFecha(nuevo_formato:String)
		{
			if (nuevo_formato != ordenFecha) 
			{
				ordenFecha = nuevo_formato;
				
				if (txtFecha != null)
				{
					var now : Date = new Date();
					var dia : String = now.getDate()<10 ? "0"+String(now.getDate()):String(now.getDate());// .toString(); if(dia.length == 1) dia = "0"+dia;
					var mes : String = (now.getMonth()+1)<10?"0"+String(now.getMonth()+1):String(now.getMonth()+1);// if(mes.length == 1) mes = "0"+dia;
					var anio : String = now.getFullYear().toString().substring(now.getFullYear().toString().length-2,now.getFullYear().toString().length);
					trace(dia+"-"+mes+"-"+anio);
					var strFecha:String = "";
					if(ordenFecha == "DD-MM-YY")
					{
						strFecha = dia+"/"+mes+"/"+anio;
					}
					else if(ordenFecha == "YY-MM-DD")
					{
						strFecha = anio+"/"+mes+"/"+dia;
					}
					else if(ordenFecha == "MM-DD-YY")
					{
						strFecha = mes+"/"+dia+"/"+anio;
					}
					else
					{
						strFecha = dia+"/"+mes+"/"+anio;
					}
					txtFecha.text = strFecha;
				}
			}
			updateSizePosition();
		}
		
		public function actualizarFormatoTextos(f_fecha:TextFormat,f_temp:TextFormat)
		{
			formato_fecha = f_fecha;
			formato_temp = f_temp;
			if (txtFecha != null) txtFecha.setTextFormat(f_fecha);
			if (txtTemperatura != null) txtTemperatura.setTextFormat(f_temp);
			updateSizePosition();
		}
		
		public function unload():void
		{
			removeTimer();
			xmlLoader.removeEventListener(Event.COMPLETE, showXML);
			xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		function restartTimerControl()
		{
			trace("restartTimerControl()");
			removeTimer();
			trace("starTimer");
			update_timer = new Timer(update_cycle,0);
			update_timer.addEventListener(TimerEvent.TIMER, reloadControlFromTimer);
			update_timer.start();
		}
		
		function removeTimer()
		{
			if (update_timer != null)
			{
				trace("removeTimer");
				update_timer.stop();
				update_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,reloadControlFromTimer);
			}
		}
		
		function reloadControlFromTimer(e:TimerEvent){
			trace("reloadControlFromTimer");
			update_timer.stop();
			update_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,reloadControlFromTimer);
			if (Dia == "hoy") getToday(Ciudad);
			else if (Dia == "mañana") getTomorrow(Ciudad);
			else if (Dia == "pasado") getDayAfterTomorrow(Ciudad);
			else if (Dia == "siguiente") get2DaysAfterTomorrow(Ciudad);
			else getTomorrow(Ciudad);
		}
		
		function checkVisibility()
		{
			var oneDay:Number = 24*60*60*1000;
			if(last_update == null){last_update = new Date();}
			var last_update_milliseconds:Number = last_update.getTime();
			var now:Date = new Date();
			var now_milliseconds:Number = now.getTime();
			var difference_milliseconds:Number = Math.abs( now_milliseconds - last_update_milliseconds);
			if (Math.round(difference_milliseconds/oneDay) > 0) this.visible = false;
			else this.visible = true;
			trace("checkVisibility() "+last_update+" -> "+Math.round(difference_milliseconds/oneDay));
			restartTimerControl();
		}
	}
	
}
