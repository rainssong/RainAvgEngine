package me.rainssong.RainAvgEngine.view 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import me.rainssong.events.GameEvent;
	import me.rainui.components.Button;
	import me.rainui.components.Container;
	import me.rainui.RainUI;
	
	
	/**
	 * @date 2015/2/8 3:20
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class OptionsPanel extends Container 
	{
		public var btns:Vector.<Button> = new Vector.<Button>();
		public function OptionsPanel(dataSource:Object=null) 
		{
			super(dataSource);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			//this.autoSize = true;
		}
		
		override protected function createChildren():void 
		{
			for (var i:int = 0; i < 8; i++) 
			{
				var btn:Button = new Button();
				btns.push(btn);
				addChild(btn);
				btn.visible = false;
				
				btn.addEventListener(MouseEvent.CLICK, onClick);
				btn.percentWidth = 1;
				btn.height = RainUI.stageHeight * 0.08;
				btn.y = i * btn.height + 10 * i;
			}
			
			super.createChildren();
		}
		
		private function onClick(e:MouseEvent):void 
		{
			var btn:Button = e.target as Button;
			//this.visible = false;
			//this.disabled = true;
			dispatchEvent(new GameEvent(Event.SELECT, { text:btn.text, index:btns.indexOf(btn) } ));
		}
		
		public function showOptions(arr:Array.<String>):void
		{
			for (var i:int = 0; i < btns.length; i++) 
			{
				if (i < arr.length)
				{
					btns[i].text = arr[i];
					btns[i].visible = true;
				}
				else
				{
					btns[i].visible = false;
				}
			}
		}
		
	}

}