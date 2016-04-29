package me.rainssong.RainAvgEngine.view
{
	import com.greensock.TweenLite;
	import com.reintroducing.sound.SoundManager;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	import me.rainssong.events.GameEvent;
	import me.rainssong.manager.SingletonManager;
	import me.rainssong.RainAvgEngine.manager.Singleton;
	import me.rainssong.RainAvgEngine.manager.TextFieldAnimation;
	import me.rainssong.RainAvgEngine.manager.TextFieldCore;
	import me.rainssong.RainAvgEngine.utils.ShakeManager;
	import me.rainssong.sound.SoundPlayer;
	import me.rainssong.tween.AnimationCore;
	import me.rainssong.utils.Align;
	import me.rainssong.utils.Draw;
	import me.rainssong.utils.ObjectCore;
	import me.rainssong.utils.RevDictionary;
	import me.rainssong.utils.ScaleMode;
	import me.rainui.components.Button;
	import me.rainui.components.Container;
	import me.rainui.components.DisplayResizer;
	import me.rainui.components.Label;
	import me.rainui.components.Page;
	import me.rainui.components.TextArea;
	import me.rainui.events.RainUIEvent;
	import me.rainui.managers.PopUpManager;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	import r1.deval.D;
	
	/**
	 * @date 2015/1/14 15:40
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class PlayView extends Page
	{
		private var _lastSelect:String;
		private var _clickNext:Boolean = true;
		
		public var picView:DisplayResizer = new DisplayResizer();
		public var nameLable:Label = new Label();
		public var dialogText:TextArea = new TextArea();
		public var bg:DisplayResizer = new DisplayResizer();
		public var charView:DisplayResizer = new DisplayResizer();
		public var optionsPanel:OptionsPanel = new OptionsPanel();
		public var fadeView:FadeView = new FadeView();
		public var shakeManager:ShakeManager = new ShakeManager();
		public var pauseBtn:Button = new Button();
		public var saveTipLabel:Label = new Label();
		//public var soundBtn:Button = new Button();
		public var pauseMenuView:PauseMenuView = new PauseMenuView();
		
		private var _statusData:Object = new Object();
		private var _userValues:Object = new Object();
		private var _isLoading:Boolean = false;
		private var _isFading:Boolean = false;
		
		public function PlayView()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			addChild(bg);
			addChild(dialogText);
			addChild(charView);
			addChild(nameLable);
			addChild(fadeView);
			addChild(picView);
			addChild(pauseBtn);
			addChild(saveTipLabel);
			addChild(optionsPanel);
			//addChild(pauseMenuView);
			pauseMenuView.destroyOnRemove = false;
			
			shakeManager.target = this;
			
			fadeView.alpha = 0;
			fadeView.percentWidth = 1;
			fadeView.percentHeight = 1;
			
			dialogText.left = 10;
			dialogText.right = 10;
			dialogText.percentHeight = 0.3;
			dialogText.bottom = 10;
			dialogText.text = "文字测试\n文字测试";
			dialogText.align = Align.TOP_LEFT;
			dialogText.selectable = false;
			dialogText.type = TextFieldType.DYNAMIC;
			dialogText.color = RainTheme.WHITE;
			dialogText.bgSkin = RainUI.getSkin("darkBlueRoundFlatSkin");
			dialogText.bgSkin.alpha = 0.7;
			
			bg.percentWidth = 1;
			bg.percentHeight = 1;
			bg.contentScaleMode = ScaleMode.FULL_FILL;
			bg.mouseEnabled = true;
			
			charView.left = 10;
			charView.percentHeight = 0.5;
			charView.percentWidth = 0.4;
			charView.contentScaleMode = ScaleMode.SHOW_ALL;
			charView.contentAlign = Align.BOTTOM_LEFT;
			charView.mouseChildren = charView.mouseEnabled = false;
			//charView.borderVisible = true;
			
			nameLable.left = 10;
			nameLable.percentWidth = 0.2;
			nameLable.percentHeight = 0.08;
			nameLable.color = RainTheme.WHITE;
			nameLable.align = Align.CENTER;
			nameLable.bgSkin = RainUI.getSkin("darkBlueRoundFlatSkin");
			nameLable.alpha = 0.8;
			
			optionsPanel.centerX = 0;
			optionsPanel.percentCenterY = -0.15;
			optionsPanel.percentHeight = 0.4;
			optionsPanel.percentWidth = 0.6;
			optionsPanel.addEventListener(Event.SELECT, onSelect);
			
			picView.centerX = 0;
			picView.percentCenterY = -0.1;
			picView.percentWidth = 0.4;
			picView.percentHeight = 0.5;
			picView.contentScaleMode = ScaleMode.SHOW_ALL;
			picView.mouseChildren = false;
			picView.mouseEnabled = false;
			
			pauseBtn.width = RainUI.stageHeight * 0.16+10;
			pauseBtn.height = RainUI.stageHeight * 0.08;
			pauseBtn.right = 10;
			pauseBtn.top = 10;
			pauseBtn.text = "菜单";
			pauseBtn.addEventListener(MouseEvent.CLICK, onPauseBtn);
			
			//pauseMenuView.visible = false;
			pauseMenuView.addEventListener(RainUIEvent.SELECT, onPauseMenuView);
			
			saveTipLabel.width = RainUI.stageHeight * 0.16 + 10;
			saveTipLabel.height = RainUI.stageHeight * 0.08;
			saveTipLabel.text = "已保存!";
			saveTipLabel.alpha = 0;
			saveTipLabel.left = 10;
			saveTipLabel.top = 10;
			saveTipLabel.color = RainTheme.WHITE;
			saveTipLabel.bgSkin = RainUI.theme.getSkin("darkBlueRoundFlatSkin")
			
			//fadeView.addEventListener("fadeComplete", onFadeComplete);
			
			bg.addEventListener(MouseEvent.CLICK, onNext);
			dialogText.addEventListener(MouseEvent.CLICK, onNext);
			
			D.importFunction("talk", talk);
			D.importFunction("changeBg", changeBg);
			D.importFunction("showChar", showChar);
			D.importFunction("hideChar", hideChar);
			D.importFunction("showOptions", showOptions);
			D.importFunction("hideTalk", hideTalk);
			D.importFunction("showPic", showPic);
			D.importFunction("hidePic", hidePic);
			D.importFunction("fadeIn", fadeIn);
			D.importFunction("fadeOut", fadeOut);
			D.importFunction("fadeOutIn", fadeOutIn);
			D.importFunction("startShake", startShake);
			D.importFunction("playMusic", playMusic);
			D.importFunction("playSound", playSound);
			D.importFunction("stopMusic", stopMusic);
			D.importFunction("stopAllSounds", stopAllSounds);
			D.importFunction("getValue", getValue);
			D.importFunction("setValue", setValue);
			D.importFunction("gameOver", gameOver);
		}
		
		public function reset():void
		{
			hidePauseMenu();
			hideOptions();
		}
		
		private function onPauseMenuView(e:GameEvent):void
		{
			switch (e.data.text)
			{
				case "继续": 
					hidePauseMenu();
					break;
				case "保存": 
					hidePauseMenu();
					save();
					break;
				case "读取": 
					hidePauseMenu();
					load();
					break;
				case "退出": 
					hidePauseMenu();
					gameOver();
					break;
				default: 
			}
		}
		
		private function onPauseBtn(e:MouseEvent):void
		{
			showPauseMenu();
		}
		
		public function hidePauseMenu():void
		{
			pauseMenuView.remove();
		}
		
		public function showPauseMenu():void
		{
			//pauseMenuView.visible = true;
			//pauseMenuView.disabled = false;
			
			PopUpManager.addPopUp(pauseMenuView);
		}
		
		private function onFadeComplete(e:Event=null):void
		{
			_isFading = false;
			if (_isLoading)
				_isLoading = false;
			else
				Singleton.scriptManager.runScript();
		}
		
		private function onSelect(e:GameEvent):void
		{
			hideOptions();
			_lastSelect = e.data.text as String;
			Singleton.scriptManager.context = {"lastSelect": lastSelect};
			Singleton.scriptManager.runScript();
		}
		
		private function onNext(e:MouseEvent):void
		{
			if (_isFading)
				return;
			
			var anim:TextFieldAnimation = TextFieldCore.getAnimation(dialogText);
			if (anim.isFinished)
			{
				if (_clickNext)
					Singleton.scriptManager.runScript();
			}
			else
			{
				anim.finish();
			}
		}
		
		////////////
		//story
		////////////
		
		public function talk(charName:String = "", content:String = "", clickNext:Boolean = true):void
		{
			_statusData["talkName"] = charName;
			_statusData["talkContent"] = content;
			_statusData["talkClickNext"] = clickNext;
			_statusData["talkVisible"] = true;
			dialogText.text = "";
			dialogText.redraw();
			dialogText.visible = true;
			nameLable.visible = charName.length > 0;
			if( charName.length > 0)
				nameLable.text = charName;
			_clickNext = clickNext;
			
			var anim:TextFieldAnimation = TextFieldCore.getAnimation(dialogText);
			anim.reset({text: content, interval: 50});
		}
		
		public function hideTalk():void
		{
			_statusData["talkVisible"] = false;
			dialogText.visible = false;
			nameLable.visible = false;
		}
		
		public function showOptions(opts:Array.<String> = null, clickNext:Boolean = false):void
		{
			optionsPanel.visible = true;
			optionsPanel.disabled = false;
			optionsPanel.showOptions(opts);
			_clickNext = clickNext;
			optionsPanel.resize();
		}
		
		public function hideOptions():void
		{
			optionsPanel.visible = false;
			optionsPanel.disabled = true;
		}
		
		/////////
		//functions
		/////////
		public function gameOver():void
		{
			stopAllSounds();
			SingletonManager.eventBus.dispatchEvent(new GameEvent(GameEvent.GAME_OVER));
		}
		
		public function start(script:String="assets/Script/Main.xml"):void
		{
			Singleton.scriptManager.runScript(0, script);
		}
		
		public function save():void
		{
			_statusData["musicTime"] = SoundManager.getInstance().getSoundPosition(_statusData["musicUrl"]);
			SingletonManager.sharedObject.data.count = Singleton.scriptManager.count;
			SingletonManager.sharedObject.data.xmlName = Singleton.scriptManager.xmlName;
			SingletonManager.sharedObject.data.statusData = ObjectCore.clone(_statusData);
			SingletonManager.sharedObject.data.userValues = ObjectCore.clone(_userValues);
			SingletonManager.sharedObject.data.userValues = ObjectCore.clone(_userValues);
			SingletonManager.sharedObject.flush();
			
			TweenLite.to(saveTipLabel, 0.5, {alpha: 1});
			TweenLite.to(saveTipLabel, 0.5, { alpha: 0, delay: 1 } );
			
			SingletonManager.eventBus.dispatchEvent(new GameEvent(GameEvent.SAVE_COMPLETE, null));
		}
		
		public function load():void
		{
			if (SingletonManager.sharedObject.data.count == null)
			{
				reset();
				start();
				return;
			}
			_isLoading = true;
			
			fadeOutIn();
			
			setTimeout(loadScene, 500)
		}
		
		private function loadScene():void
		{
			hideOptions();
			hidePic();
			hideTalk();
			hideChar();
			stopAllSounds();
			
			_statusData = ObjectCore.clone(SingletonManager.sharedObject.data.statusData);
			_userValues = ObjectCore.clone(SingletonManager.sharedObject.data.userValues);
			
			if (_statusData.picVisible)
				showPic(_statusData.picUrl);
			if (_statusData.bgUrl)
				changeBg(_statusData.bgUrl);
			if (_statusData.charVisible)
				showChar(_statusData.charUrl);
			if (_statusData.talkVisible)
				talk(_statusData["talkName"], _statusData["talkContent"], _statusData["talkClickNext"]);
			if (_statusData.musicPlay)
				playMusic(_statusData.musicUrl, 1, _statusData.musicTime);
			
			var count:int = SingletonManager.sharedObject.data.count || 0;
			var xmlName:String = SingletonManager.sharedObject.data.xmlName || "";
			
			Singleton.scriptManager.runScript(count, xmlName);
			
			SingletonManager.eventBus.dispatchEvent(new GameEvent(GameEvent.LOAD_COMPLETE, null, true));
		}
		
		////////////
		//logic
		////////////
		public function getValue(key:String):*
		{
			return _userValues[key];
		}
		
		public function setValue(key:String, value:*):void
		{
			_userValues[key] = value;
		}
		
		////////////
		//visual
		////////////
		
		public function changeBg(name:String = ""):void
		{
			_statusData["bgUrl"] = name;
			bg.content = SingletonManager.bulkLoader.getBitmap(name);
			bg.redraw();
		}
		
		public function showChar(name:String = ""):void
		{
			if (name != "")
			{
				_statusData["charUrl"] = name;
				charView.content = SingletonManager.bulkLoader.getBitmap(name);
				charView.redraw();
			}
			_statusData["charVisible"] = true;
			charView.visible = true;
		}
		
		public function hideChar():void
		{
			_statusData["charVisible"] = false;
			charView.visible = false;
		}
		
		public function showPic(name:String = ""):void
		{
			_statusData["picUrl"] = name;
			_statusData["picVisible"] = true;
			picView.content = SingletonManager.bulkLoader.getBitmap(name);
			picView.redraw();
			picView.visible = true;
		}
		
		public function hidePic():void
		{
			_statusData["picVisible"] = false;
			picView.visible = false;
		}
		
		////////////
		//sound
		////////////
		
		public function playMusic(url:String = "", volume:Number = 1, startTime:Number = 0):void
		{
			_statusData["musicUrl"] = url;
			_statusData["musicPlay"] = true;
			SoundManager.getInstance().playSound(url, volume, startTime, 9999);
		}
		
		public function playSound(url:String = ""):void
		{
			SoundManager.getInstance().playSound(url, 1, 0, 1);
		}
		
		public function stopMusic(url:String = ""):void
		{
			_statusData["musicPlay"] = false;
			SoundManager.getInstance().stopSound(url);
		}
		
		public function stopAllSounds():void
		{
			_statusData["musicPlay"] = false;
			SoundManager.getInstance().stopAllSounds();
		}
		
		override public function calcSize():void
		{
			super.calcSize();
			
			dialogText.calcSize();
			nameLable.calcSize();
			nameLable.y = dialogText.y - nameLable.height;
			
			charView.calcSize();
			charView.y = dialogText.y - charView.height;
		}
		
		public function get lastSelect():String
		{
			return _lastSelect;
		}
		
		public function getLastSelect():String
		{
			return _lastSelect;
		}
		
		/* DELEGATE me.rainssong.RainAvgEngine.view.FadeView */
		
		public function fadeIn(duration:Number = 0.5):void
		{
			AnimationCore.fadeFromBlack(this, duration, { onComplete:onFadeComplete } );
		}
		
		public function fadeOut(duration:Number = 0.5):void
		{
			AnimationCore.fadeToBlack(this, duration, { onComplete:onFadeComplete } );
		}
		
		public function fadeOutIn(duration:Number = 1):void
		{
			AnimationCore.fadeToBlack(this, duration*0.5 );
			AnimationCore.fadeFromBlack(this, duration*0.5, {delay:duration, onComplete:onFadeComplete } );
		}
		
		/* DELEGATE me.rainssong.RainAvgEngine.utils.ShakeManager */
		
		public function startShake(value:Number = 10, delay:Number = 50, repeatCount:Number = 5):void
		{
			shakeManager.startShake(value, delay, repeatCount);
		}
		
		public function set lastSelect(value:String):void
		{
			_lastSelect = value;
		}
	
	}

}