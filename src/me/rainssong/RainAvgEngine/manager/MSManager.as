package me.rainssong.RainAvgEngine.manager 
{
	import air.update.descriptors.ConfigurationDescriptor;
	import com.reintroducing.sound.SoundManager;
	import flash.media.Sound;
	import me.rainssong.manager.RainSoundManager;
	import me.rainssong.manager.SingletonManager;
	import me.rainssong.manager.SoundManager;
	
	
	/**
	 * @date 2015/10/1 4:15
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class MSManager
	{
		
		public function MSManager() 
		{
			
			
		}
		
		static public function playMusic(id:String):void 
		{
			
			//RainSoundManager.getInstance().addSoundObject( SingletonManager.bulkLoader.getSound(id, true),id);
			//RainSoundManager.getInstance().playSound(id,1,0,9999);
		}
		
		static public function playSound(id:String):void 
		{
			
			//RainSoundManager.getInstance().addSoundObject(SingletonManager.bulkLoader.getSound(id, true),id);
			//RainSoundManager.getInstance().playSound(id);
		}
	}

}