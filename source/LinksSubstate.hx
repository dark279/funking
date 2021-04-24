package;

import flixel.FlxSubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
class LinksSubstate extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['Earmint', 'A Point in Time', 'Breathe', 'Speculust (Artist)'];
	var selector:FlxSprite;
	var curSelected:Int = 0;
	private var grpSongs:FlxTypedGroup<Alphabet>;

	var grpOptionsTexts:FlxTypedGroup<FlxText>;
	public function new()
	{
		//super();
		super();
		grpOptionsTexts = new FlxTypedGroup<FlxText>();
		grpSongs = new FlxTypedGroup<Alphabet>();
        add(grpSongs);
        //add(grpOptionsTexts);
		selector = new FlxSprite().makeGraphic(20, 20, FlxColor.RED);
		add(selector);

		for (i in 0...textMenuItems.length)
		{
			var optionText:FlxText = new FlxText(20, 20 + (i * 50), 0, textMenuItems[i], 32);
            var songText:Alphabet = new Alphabet(0, (50 * i) + 20, textMenuItems[i], true, false);
			optionText.ID = i;
            songText.ID = i;
			grpOptionsTexts.add(optionText);
            grpSongs.add(songText);
			//add(songText);
        }
	}
	override function update(elapsed:Float)
		{
			super.update(elapsed);
			//dfText.text = Std.string(dfjk);
            selector.y = curSelected * 50;
			if (controls.UP_P)
				curSelected -= 1;
	
			if (controls.DOWN_P)
				curSelected += 1;
	
			if (curSelected < 0)
				curSelected = textMenuItems.length - 1;
	
			if (curSelected >= textMenuItems.length)
				curSelected = 0;
	
			grpSongs.forEach(function(me:Alphabet)
			{
				if(curSelected == me.ID)
                    {
                        me.isBold = false;
                    }
                else
                    {
                        me.isBold = true;
                    }
			});
			if (controls.ACCEPT)
				{
					switch (textMenuItems[curSelected])
					{
						case 'Speculust (Artist)':
                            #if linux
                            Sys.command('/usr/bin/xdg-open', ["https://speculust.bandcamp.com/music", "&"]);
                            #else
                            FlxG.openURL('https://speculust.bandcamp.com/music');
                            #end
                        case 'Earmint':
                            #if linux
                            Sys.command('/usr/bin/xdg-open', ["https://speculust.bandcamp.com/track/earmint-single", "&"]);
                            #else
                            FlxG.openURL('https://speculust.bandcamp.com/track/earmint-single');
                            #end
                        case 'A Point in Time':
                            #if linux
                            Sys.command('/usr/bin/xdg-open', ["https://speculust.bandcamp.com/track/a-point-in-time", "&"]);
                            #else
                            FlxG.openURL('https://speculust.bandcamp.com/track/a-point-in-time');
                            #end
                        case 'Breathe':
                            #if linux
                            Sys.command('/usr/bin/xdg-open', ["https://speculust.bandcamp.com/track/breathe-single", "&"]);
                            #else
                            FlxG.openURL('https://speculust.bandcamp.com/track/breathe-single');
                            #end
					}
				}
			if (controls.BACK)
				{
					FlxG.state.closeSubState();	
					FlxG.switchState(new MainMenuState());
				}
            
		}
		
}
