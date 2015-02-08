package  cod
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.Font;
	import flash.text.TextFormat;
	
	import com.hybrid.ui.ToolTip;

	public class CTooltip extends CElementoBase
	{
		//variables
		private var label:String;
		private var textField:TextField;
		private var dropShadow:Sprite;
		
		private var _tf:TextField;
		private var _reusableTip:ToolTip;
  
  		//**************************GETTERS/SETTERS*********************/
  		public function getLabel():String {return label;}
		public function getTip():ToolTip {return _reusableTip;}
		
		public function setLabel(val:String){label = val;}
		public function setTooltipWidth(val:Number) { _reusableTip.tipWidth = val; }
		public function setTooltipAlign(val:String) { _reusableTip.align = val; }
		public function setAutoSize(val:Boolean) { _reusableTip.autoSize = val;}
		//**************************************************************/
				
		///<summary>
		///Constructor; define el padre
		///</summary>
		public function CTooltip(aita:MovieClip) 
		{
			super(aita);
		}
		
		///<summary>
		///Crea una instancia del elemento Tooltip
		///</summary>
		override public function load():int
		{
			_reusableTip = new ToolTip();
			_reusableTip.hook = false;
			_reusableTip.cornerRadius = 6;
			_reusableTip.tipWidth = 260; 
			_reusableTip.align = "center";
			_reusableTip.borderSize = 3;
			
			return 0;
		}
		
		///<summary>
		///Función para descargar el tooltip
		///</summary>
		override public function unload():void
		{
		}

	}
	
}
