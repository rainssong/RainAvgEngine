package me.rainssong.RainAvgEngine.manager
{
	import com.adobe.images.JPGEncoder;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import me.rainui.components.Label;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class TextFieldAnimation
	{
		public var interval:int;
		private var _timer:Timer=new Timer(20);
		private var _textArr:Array = [];
		private var _targetText:String;
		public var tf:Label;
		private var _finished:Boolean = false;
		
		public function TextFieldAnimation(tf:Label)
		{
			
			this.tf = tf;
			
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			
		}
		
		private function onTimer(e:TimerEvent):void
		{
		
			if (_textArr.length == 0) _timer.stop();
			tf.appendText(_textArr[_timer.currentCount - 1]);
		}
		
		public function finish():void
		{
			//powerTrace("textArr:" + _textArr);
			tf.text = _targetText;
			//textArr.length = 0;
			_timer.stop();
			//_finished = true;
		}
		
		public function get isFinished():Boolean
		{
			var text:String=tf.text.replace(/\n/g,"\r")
			var text2:String=_targetText.replace(/\n/g,"\r")
			//powerTrace("_targetText:" + _targetText);
			//powerTrace( "tf.text：" + text );
			//powerTrace( "==:" + text == _targetText);
			
			return text == text2;
		}
		
		public function set textArr(value:Array):void 
		{
			_textArr = value;
		}
		
		
		public function reset(vars:Object=null):void
		{
			vars = vars || {};
			interval = vars["interval"] || 20;
			
			if (vars["htmlText"] != null)
			{
				_targetText = vars["htmlText"];
				_textArr = String(vars["htmlText"]).split("");
			}
			else if (vars["text"] != null)
			{
				_targetText = vars["text"];
				_textArr = vars["text"].split("");
			}
			else
			{
				_targetText = tf.text;
				_textArr = tf.text.split("");
			}
			
			tf.text = "";
			
			if (_textArr.length <= 0)
				return;
			
			_timer.reset();
			_timer.delay = interval;
			_timer.repeatCount = _textArr.length;
			
			_timer.start();
			
			//powerTrace(_textArr);
		}
		
		public function destroy():void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);
			_timer = null;
			tf = null;
		}
		
		/* DELEGATE flash.utils.Timer */
		
		public function get delay():Number 
		{
			return _timer.delay;
		}
		
		public function set delay(value:Number):void 
		{
			_timer.delay = value;
		}
	
	}

}