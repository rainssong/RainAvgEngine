package  
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import me.rainssong.RainAvgEngine.GameView;
	import me.rainssong.RainAvgEngine.TestView;
	import me.rainssong.utils.Snapshot;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	import r1.deval.D;
	
	
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
			
			Snapshot.bind(stage);
			
			RainUI.init(stage,new RainTheme);
			addChild(new GameView);
			
			
		}
		
	}

}