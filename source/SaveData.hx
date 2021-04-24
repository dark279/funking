import openfl.Lib;
import flixel.FlxG;

class SaveData
{
    public static function initSave()
    {
		if (FlxG.save.data.offset == null)
			FlxG.save.data.offset = 0;

		if (FlxG.save.data.offset == null)
			FlxG.save.data.offset = 0;

		//Conductor.recalculateTimings();

		//Main.watermarks = FlxG.save.data.watermark;
	}
}