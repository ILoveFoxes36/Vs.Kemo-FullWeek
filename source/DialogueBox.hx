package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitNew:FlxSprite;
	var portraitKemon:FlxSprite;
	var portraitGf:FlxSprite;
	var portraitKemoh:FlxSprite;
	var portraitDiegoa:FlxSprite;
	var portraitDiegon:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'kitsune':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'desert':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'on fire':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'nine tails':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			case 'kitsune':
			    box = new FlxSprite(0, 390);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24, true);

			case 'desert':
			    box = new FlxSprite(0, 390);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24, true);
			case 'on fire':
			    box = new FlxSprite(0, 390);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24, true);
			case 'nine tails':
			    box = new FlxSprite(0, 390);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24, true);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns'){


		portraitLeft = new FlxSprite(20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);

	}   if (PlayState.SONG.song.toLowerCase()=='kitsune'){
	
	    portraitLeft = new FlxSprite(20, 60);
		portraitLeft.frames = Paths.getSparrowAtlas('kemoPortraitBack');
		portraitLeft.animation.addByPrefix('enter', 'kemoPortBack Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 60);
		portraitRight.frames = Paths.getSparrowAtlas('bfnormalPortrait');
		portraitRight.animation.addByPrefix('enter', 'bfPortNormal Enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		portraitNew = new FlxSprite(0, 60);
		portraitNew.frames = Paths.getSparrowAtlas('diegoPortraitWatchingBFlol');
		portraitNew.animation.addByPrefix('enter', 'diegoPortWatchingdown Enter', 24, false);
		portraitNew.setGraphicSize(Std.int(portraitNew.width * PlayState.daPixelZoom * 0.9));
		portraitNew.updateHitbox();
		portraitNew.scrollFactor.set();
		add(portraitNew);
		portraitNew.visible = false;

		portraitKemon = new FlxSprite(0, 60);
		portraitKemon.frames = Paths.getSparrowAtlas('kemoPortraitGlad');
		portraitKemon.animation.addByPrefix('enter', 'kemoPortraitGlad Enter', 24, false);
		portraitKemon.setGraphicSize(Std.int(portraitKemon.width * PlayState.daPixelZoom * 0.9));
		portraitKemon.updateHitbox();
		portraitKemon.scrollFactor.set();
		add(portraitKemon);
		portraitKemon.visible = false;

		portraitGf = new FlxSprite(0, 60);
		portraitGf.frames = Paths.getSparrowAtlas('gfPortraitNormal');
		portraitGf.animation.addByPrefix('enter', 'gfPortNormal Enter', 24, false);
		portraitGf.setGraphicSize(Std.int(portraitGf.width * PlayState.daPixelZoom * 0.9));
		portraitGf.updateHitbox();
		portraitGf.scrollFactor.set();
		add(portraitGf);
		portraitGf.visible = false;

		portraitKemoh = new FlxSprite(0, 60);
		portraitKemoh.frames = Paths.getSparrowAtlas('kemoPortraitHappy');
		portraitKemoh.animation.addByPrefix('enter', 'kemoPortraitHappy Enter', 24, false);
		portraitKemoh.setGraphicSize(Std.int(portraitKemoh.width * PlayState.daPixelZoom * 0.9));
		portraitKemoh.updateHitbox();
		portraitKemoh.scrollFactor.set();
		add(portraitKemoh);
		portraitKemoh.visible = false;

		portraitDiegon = new FlxSprite(0, 60);
		portraitDiegon.frames = Paths.getSparrowAtlas('adriannePortraitWorried');
		portraitDiegon.animation.addByPrefix('enter', 'adriannePortWorried Enter', 24, false);
		portraitDiegon.setGraphicSize(Std.int(portraitDiegon.width * PlayState.daPixelZoom * 0.9));
		portraitDiegon.updateHitbox();
		portraitDiegon.scrollFactor.set();
		add(portraitDiegon);
		portraitDiegon.visible = false;

		portraitDiegoa = new FlxSprite(0, 60);
		portraitDiegoa.frames = Paths.getSparrowAtlas('diegoPortraitApologize');
		portraitDiegoa.animation.addByPrefix('enter', 'diegoPortApologize Enter', 24, false);
		portraitDiegoa.setGraphicSize(Std.int(portraitDiegoa.width * PlayState.daPixelZoom * 0.9));
		portraitDiegoa.updateHitbox();
		portraitDiegoa.scrollFactor.set();
		add(portraitDiegoa);
		portraitDiegoa.visible = false;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.15));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

	}   if (PlayState.SONG.song.toLowerCase()=='desert'){
	
	    portraitLeft = new FlxSprite(20, 60);
		portraitLeft.frames = Paths.getSparrowAtlas('kemoPortraitHappy');
		portraitLeft.animation.addByPrefix('enter', 'kemoPortraitHappy Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 60);
		portraitRight.frames = Paths.getSparrowAtlas('bfMissPortrait');
		portraitRight.animation.addByPrefix('enter', 'bfPortMiss Enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		portraitNew = new FlxSprite(0, 60);
		portraitNew.frames = Paths.getSparrowAtlas('diegoPortraitRelax');
		portraitNew.animation.addByPrefix('enter', 'diegoPortRelax Enter', 24, false);
		portraitNew.setGraphicSize(Std.int(portraitNew.width * PlayState.daPixelZoom * 0.9));
		portraitNew.updateHitbox();
		portraitNew.scrollFactor.set();
		add(portraitNew);
		portraitNew.visible = false;

		portraitKemon = new FlxSprite(0, 60);
		portraitKemon.frames = Paths.getSparrowAtlas('diegoPortraitReady');
		portraitKemon.animation.addByPrefix('enter', 'diegoPortReady Enter', 24, false);
		portraitKemon.setGraphicSize(Std.int(portraitKemon.width * PlayState.daPixelZoom * 0.9));
		portraitKemon.updateHitbox();
		portraitKemon.scrollFactor.set();
		add(portraitKemon);
		portraitKemon.visible = false;

		portraitGf = new FlxSprite(0, 60);
		portraitGf.frames = Paths.getSparrowAtlas('gfPortraitNormal');
		portraitGf.animation.addByPrefix('enter', 'gfPortNormal Enter', 24, false);
		portraitGf.setGraphicSize(Std.int(portraitGf.width * PlayState.daPixelZoom * 0.9));
		portraitGf.updateHitbox();
		portraitGf.scrollFactor.set();
		add(portraitGf);
		portraitGf.visible = false;

		portraitKemoh = new FlxSprite(0, 60);
		portraitKemoh.frames = Paths.getSparrowAtlas('adriannePortraitWorried');
		portraitKemoh.animation.addByPrefix('enter', 'adriannePortWorried Enter', 24, false);
		portraitKemoh.setGraphicSize(Std.int(portraitKemoh.width * PlayState.daPixelZoom * 0.9));
		portraitKemoh.updateHitbox();
		portraitKemoh.scrollFactor.set();
		add(portraitKemoh);
		portraitKemoh.visible = false;

		portraitDiegoa = new FlxSprite(0, 60);
		portraitDiegoa.frames = Paths.getSparrowAtlas('diegoPortraitApologize');
		portraitDiegoa.animation.addByPrefix('enter', 'diegoPortApologize Enter', 24, false);
		portraitDiegoa.setGraphicSize(Std.int(portraitDiegoa.width * PlayState.daPixelZoom * 0.9));
		portraitDiegoa.updateHitbox();
		portraitDiegoa.scrollFactor.set();
		add(portraitDiegoa);
		portraitDiegoa.visible = false;

		portraitDiegon = new FlxSprite(0, 60);
		portraitDiegon.frames = Paths.getSparrowAtlas('diegoPortraitNervous');
		portraitDiegon.animation.addByPrefix('enter', 'diegoPortNervous Enter', 24, false);
		portraitDiegon.setGraphicSize(Std.int(portraitDiegon.width * PlayState.daPixelZoom * 0.9));
		portraitDiegon.updateHitbox();
		portraitDiegon.scrollFactor.set();
		add(portraitDiegon);
		portraitDiegon.visible = false;

		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.15));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

	}   if (PlayState.SONG.song.toLowerCase()=='on fire'){
	
	    portraitLeft = new FlxSprite(20, 60);
		portraitLeft.frames = Paths.getSparrowAtlas('kemoPortraitHappy');
		portraitLeft.animation.addByPrefix('enter', 'kemoPortraitHappy Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 60);
		portraitRight.frames = Paths.getSparrowAtlas('bfnormalPortrait');
		portraitRight.animation.addByPrefix('enter', 'bfPortNormal Enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		portraitNew = new FlxSprite(0, 60);
		portraitNew.frames = Paths.getSparrowAtlas('adriannePortraitReady');
		portraitNew.animation.addByPrefix('enter', 'adriannePortReady Enter', 24, false);
		portraitNew.setGraphicSize(Std.int(portraitNew.width * PlayState.daPixelZoom * 0.9));
		portraitNew.updateHitbox();
		portraitNew.scrollFactor.set();
		add(portraitNew);
		portraitNew.visible = false;

		portraitKemon = new FlxSprite(0, 60);
		portraitKemon.frames = Paths.getSparrowAtlas('diegoPortraitRelax');
		portraitKemon.animation.addByPrefix('enter', 'diegoPortRelax Enter', 24, false);
		portraitKemon.setGraphicSize(Std.int(portraitKemon.width * PlayState.daPixelZoom * 0.9));
		portraitKemon.updateHitbox();
		portraitKemon.scrollFactor.set();
		add(portraitKemon);
		portraitKemon.visible = false;

		portraitGf = new FlxSprite(0, 60);
		portraitGf.frames = Paths.getSparrowAtlas('gfPortraitNormal');
		portraitGf.animation.addByPrefix('enter', 'gfPortNormal Enter', 24, false);
		portraitGf.setGraphicSize(Std.int(portraitGf.width * PlayState.daPixelZoom * 0.9));
		portraitGf.updateHitbox();
		portraitGf.scrollFactor.set();
		add(portraitGf);
		portraitGf.visible = false;

		portraitKemoh = new FlxSprite(0, 60);
		portraitKemoh.frames = Paths.getSparrowAtlas('adriannePortraitWorried');
		portraitKemoh.animation.addByPrefix('enter', 'adriannePortWorried Enter', 24, false);
		portraitKemoh.setGraphicSize(Std.int(portraitKemoh.width * PlayState.daPixelZoom * 0.9));
		portraitKemoh.updateHitbox();
		portraitKemoh.scrollFactor.set();
		add(portraitKemoh);
		portraitKemoh.visible = false;

		portraitDiegoa = new FlxSprite(0, 60);
		portraitDiegoa.frames = Paths.getSparrowAtlas('diegoPortraitApologize');
		portraitDiegoa.animation.addByPrefix('enter', 'diegoPortApologize Enter', 24, false);
		portraitDiegoa.setGraphicSize(Std.int(portraitDiegoa.width * PlayState.daPixelZoom * 0.9));
		portraitDiegoa.updateHitbox();
		portraitDiegoa.scrollFactor.set();
		add(portraitDiegoa);
		portraitDiegoa.visible = false;

		portraitDiegon = new FlxSprite(0, 60);
		portraitDiegon.frames = Paths.getSparrowAtlas('diegoPortraitNervous');
		portraitDiegon.animation.addByPrefix('enter', 'diegoPortNervous Enter', 24, false);
		portraitDiegon.setGraphicSize(Std.int(portraitDiegon.width * PlayState.daPixelZoom * 0.9));
		portraitDiegon.updateHitbox();
		portraitDiegon.scrollFactor.set();
		add(portraitDiegon);
		portraitDiegon.visible = false;

		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.15));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

	}   if (PlayState.SONG.song.toLowerCase()=='nine tails'){
	
	    portraitLeft = new FlxSprite(20, 60);
		portraitLeft.frames = Paths.getSparrowAtlas('kemoPortraitMad');
		portraitLeft.animation.addByPrefix('enter', 'kemoPortraitMad Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 60);
		portraitRight.frames = Paths.getSparrowAtlas('bfnormalPortrait');
		portraitRight.animation.addByPrefix('enter', 'bfPortNormal Enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		portraitNew = new FlxSprite(0, 60);
		portraitNew.frames = Paths.getSparrowAtlas('adriannePortraitTense');
		portraitNew.animation.addByPrefix('enter', 'adriannePortTense Enter', 24, false);
		portraitNew.setGraphicSize(Std.int(portraitNew.width * PlayState.daPixelZoom * 0.9));
		portraitNew.updateHitbox();
		portraitNew.scrollFactor.set();
		add(portraitNew);
		portraitNew.visible = false;

		portraitKemon = new FlxSprite(0, 60);
		portraitKemon.frames = Paths.getSparrowAtlas('diegoPortraitNervous');
		portraitKemon.animation.addByPrefix('enter', 'diegoPortNervous Enter', 24, false);
		portraitKemon.setGraphicSize(Std.int(portraitKemon.width * PlayState.daPixelZoom * 0.9));
		portraitKemon.updateHitbox();
		portraitKemon.scrollFactor.set();
		add(portraitKemon);
		portraitKemon.visible = false;

		portraitGf = new FlxSprite(0, 60);
		portraitGf.frames = Paths.getSparrowAtlas('gfPortraitNormal');
		portraitGf.animation.addByPrefix('enter', 'gfPortNormal Enter', 24, false);
		portraitGf.setGraphicSize(Std.int(portraitGf.width * PlayState.daPixelZoom * 0.9));
		portraitGf.updateHitbox();
		portraitGf.scrollFactor.set();
		add(portraitGf);
		portraitGf.visible = false;

		portraitKemoh = new FlxSprite(0, 60);
		portraitKemoh.frames = Paths.getSparrowAtlas('kemoPortraitAngry');
		portraitKemoh.animation.addByPrefix('enter', 'kemoPortAngry Enter', 24, false);
		portraitKemoh.setGraphicSize(Std.int(portraitKemoh.width * PlayState.daPixelZoom * 0.9));
		portraitKemoh.updateHitbox();
		portraitKemoh.scrollFactor.set();
		add(portraitKemoh);
		portraitKemoh.visible = false;

		portraitDiegoa = new FlxSprite(0, 60);
		portraitDiegoa.frames = Paths.getSparrowAtlas('diegoPortraitApologize');
		portraitDiegoa.animation.addByPrefix('enter', 'diegoPortApologize Enter', 24, false);
		portraitDiegoa.setGraphicSize(Std.int(portraitDiegoa.width * PlayState.daPixelZoom * 0.9));
		portraitDiegoa.updateHitbox();
		portraitDiegoa.scrollFactor.set();
		add(portraitDiegoa);
		portraitDiegoa.visible = false;

		portraitDiegon = new FlxSprite(0, 60);
		portraitDiegon.frames = Paths.getSparrowAtlas('diegoPortraitNervous');
		portraitDiegon.animation.addByPrefix('enter', 'diegoPortNervous Enter', 24, false);
		portraitDiegon.setGraphicSize(Std.int(portraitDiegon.width * PlayState.daPixelZoom * 0.9));
		portraitDiegon.updateHitbox();
		portraitDiegon.scrollFactor.set();
		add(portraitDiegon);
		portraitDiegon.visible = false;

		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.15));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);
	}



		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'kemoback':
				portraitRight.visible = false;
				portraitNew.visible = false;
				portraitKemon.visible = false;
				portraitGf.visible = false;
				portraitKemoh.visible = false;
				portraitDiegoa.visible = false;
				portraitDiegon.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf-new':
				portraitLeft.visible = false;
				portraitNew.visible = false;
				portraitKemon.visible = false;
				portraitGf.visible = false;
				portraitKemoh.visible = false;
			    portraitDiegoa.visible = false;
				portraitDiegon.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'new':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitKemon.visible = false;
				portraitGf.visible = false;
				portraitKemoh.visible = false;
				portraitDiegoa.visible = false;
				portraitDiegon.visible = false;
				if (!portraitNew.visible)
				{
					portraitNew.visible = true;
					portraitNew.animation.play('enter');
				}
			case 'kemon':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitNew.visible = false;
				portraitGf.visible = false;
				portraitKemoh.visible = false;
			    portraitDiegoa.visible = false;
				portraitDiegon.visible = false;
				if (!portraitKemon.visible)
				{
					portraitKemon.visible = true;
					portraitKemon.animation.play('enter');
			   	}
			case 'gf':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitNew.visible = false;
				portraitKemon.visible = false;
				portraitKemoh.visible = false;
				portraitDiegoa.visible = false;
				portraitDiegon.visible = false;
				if (!portraitGf.visible)
				{
					portraitGf.visible = true;
					portraitGf.animation.play('enter');
				}
			case 'kemoh':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitNew.visible = false;
				portraitKemon.visible = false;
				portraitGf.visible = false;
				portraitDiegoa.visible = false;
				portraitDiegon.visible = false;
				if (!portraitKemoh.visible)
				{
					portraitKemoh.visible = true;
					portraitKemoh.animation.play('enter');
				}
				case 'diegoa':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitNew.visible = false;
				portraitKemon.visible = false;
				portraitGf.visible = false;
				portraitDiegon.visible = false;
				if (!portraitDiegoa.visible)
				{
					portraitDiegoa.visible = true;
					portraitDiegoa.animation.play('enter');
				}
				case 'diegon':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitNew.visible = false;
				portraitKemon.visible = false;
				portraitGf.visible = false;
				portraitKemoh.visible = false;
				portraitDiegoa.visible = false;
				if (!portraitDiegon.visible)
				{
					portraitDiegon.visible = true;
					portraitDiegon.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}