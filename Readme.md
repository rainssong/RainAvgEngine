RainAvgEngine
===============

A simple, cross-platform AVG engine。

Relative libs：
D.eval,RainUI,RainsAsLib
[Download](https://github.com/rainssong/RainsAsLib)

    
Useage:

	Input script in assets/Main.xml 
	Put resources in bin/assets
    
And only 4 lines of code:

	stage.align = StageAlign.TOP_LEFT;
	stage.scaleMode = StageScaleMode.NO_SCALE;
	RainUI.init(stage,new RainTheme);
	stage.addChild(new GameView);