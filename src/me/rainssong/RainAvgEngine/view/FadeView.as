package me.rainssong.RainAvgEngine.view 
{
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import me.rainssong.events.GameEvent;
	import me.rainssong.manager.SingletonManager;
	import me.rainssong.RainAvgEngine.manager.Singleton;
	import me.rainui.components.Container;
	
	/**
	 * @date 2015/3/2 23:11
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class FadeView extends Container 
	{
		//public var bmp:Bitmap = new Bitmap(new BitmapData(100, 100, false, 0));
		public function FadeView(dataSource:Object=null) 
		{
			super(dataSource);
			
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		
		override protected function createChildren():void 
		{
			bgSkin=new Bitmap(new BitmapData(100, 100, false, 0));
			super.createChildren();
			//addChild(bmp);
		}
		
		public function fadeout(duration:Number=0.5):void
		{
			TweenLite.to(this, duration, { alpha:1,onComplete:fadeComp } );
			
		}
		
		public function fadein(duration:Number=0.5):void
		{
			TweenLite.to(this, duration, { alpha:0,onComplete:fadeComp } );
		}
		
		public function fadeoutin(duration:Number=1):void
		{
			TweenLite.to(this, duration*0.5, { alpha:1 } );
			TweenLite.to(this, duration*0.5, { alpha:0,delay:duration*0.5,onComplete:fadeComp } );
		}
		
		private function fadeComp():void 
		{
			dispatchEvent(new GameEvent("fadeComplete"));
		}
		
	}

}