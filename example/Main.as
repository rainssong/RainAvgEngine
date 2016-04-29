package  
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.setTimeout;
	import me.rainssong.RainAvgEngine.GameView;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	
	/**
	 * @date 2015/2/8 3:57
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			setTimeout(init, 200);
		}
		
		private function init():void 
		{
			RainUI.init(stage,new RainTheme("none"));
			stage.addChild(new GameView);
		}
		
	}

}