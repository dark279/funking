package;

import flixel.FlxSubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
class ButtonRemapSubstate extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['Offset', 'DFJK Input', 'New Input', 'Play songs in Freeplay menu'];
	var selector:FlxSprite;
	var offset:Int;
	var offText:FlxText;
	var dfText:FlxText;
	var dfjk:Bool;
	var newInput:Bool;
	var playFpSongs:Bool;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<FlxText>;
	public function new()
	{
		//super();
		super();
		FlxG.save.bind('funkin', 'dark279');
		offset = FlxG.save.data.offset;
		dfjk = FlxG.save.data.dfjk;
		newInput = FlxG.save.data.newInput;
		playFpSongs = FlxG.save.data.playFpSongs;
		grpOptionsTexts = new FlxTypedGroup<FlxText>();
		add(grpOptionsTexts);
		offText = new FlxText(5, FlxG.height - 18, 0, (Std.string(offset) + ", " + dfjk), 20);
		offText.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		selector = new FlxSprite().makeGraphic(5, 5, FlxColor.RED);
		add(selector);
		add(offText);
		//add(dfText);

		for (i in 0...textMenuItems.length)
		{
			var optionText:FlxText = new FlxText(20, 20 + (i * 50), 0, textMenuItems[i], 32);
			optionText.ID = i;
			grpOptionsTexts.add(optionText);
		}
	}
	override function update(elapsed:Float)
		{
			super.update(elapsed);
			offText.text = "Offset: " + Std.string(offset) + ", DFJK input: " + dfjk + ", New input: " + newInput + ", Play songs in Freeplay menu: " + playFpSongs;
			//dfText.text = Std.string(dfjk);

			if (controls.UP_P)
				curSelected -= 1;
	
			if (controls.DOWN_P)
				curSelected += 1;
	
			if (curSelected < 0)
				curSelected = textMenuItems.length - 1;
	
			if (curSelected >= textMenuItems.length)
				curSelected = 0;
	
			grpOptionsTexts.forEach(function(txt:FlxText)
			{
				txt.color = FlxColor.WHITE;
	
				if (txt.ID == curSelected)
					txt.color = FlxColor.YELLOW;
			});
			if (controls.ACCEPT)
				{
					switch (textMenuItems[curSelected])
					{
						case "DFJK Input":
							dfjk = !dfjk;
							FlxG.save.data.dfjk = dfjk;
							FlxG.save.flush();
							PlayerSettings.reset();
							PlayerSettings.init();
						case "New Input":
							newInput = !newInput;
							FlxG.save.data.newInput = newInput;
							FlxG.save.flush();
						case "Play songs in Freeplay menu":
							playFpSongs = !playFpSongs;
							FlxG.save.data.playFpSongs = playFpSongs;
							FlxG.save.flush();

					}
				}
			if (controls.LEFT)
				{
					switch (textMenuItems[curSelected])
					{
						case "Offset":
							offset --;
							if(FlxG.save.data.offset == null)
								{
									FlxG.save.data.offset = offset;
								}
							FlxG.save.data.offset = offset;
							FlxG.save.flush();
					}
					FlxG.save.flush();
				}
			if (controls.RIGHT)
				{
					switch (textMenuItems[curSelected])
					{
						case "Offset":
							offset ++;
							if(FlxG.save.data.offset == null)
								{
									FlxG.save.data.offset = offset;
								}
							FlxG.save.data.offset = offset;
							FlxG.save.flush();
					}
					FlxG.save.flush();
				}
			if (controls.BACK)
				{
					FlxG.save.flush();

					FlxG.state.closeSubState();
					
					FlxG.state.openSubState(new ControlsSubState());
				}
		}
		
}
