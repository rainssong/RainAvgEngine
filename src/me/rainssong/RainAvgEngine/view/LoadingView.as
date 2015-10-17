package me.rainssong.RainAvgEngine.view 
{
	import me.rainui.components.Container;
	import me.rainui.components.Label;
	import me.rainui.components.Page;
	
	
	/**
	 * @date 2015/1/10 18:17
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class LoadingView extends Page 
	{
		public var title:Label = new Label("loading...");
		public function LoadingView() 
		{
			super();
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			addChild(title);
			title.centerX = 0;
			title.centerY = 0;
		}
		
		override public function resize():void 
		{
			super.resize();
		}
		
	}

}