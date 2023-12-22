package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class VisualsUISubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Visuals and UI';
		rpcTitle = 'Visuals & UI Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Hide HUD',
			'If checked, hides most HUD elements.',
			'hideHud',
			'bool',
			false);
		addOption(option); //Moved this to the top because I thought it made more sense lol

		var option:Option = new Option('Note Splashes',
			"If unchecked, hitting \"Sick!\" notes won't show particles.",
			'noteSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Opponent Note Splashes',
			"Self-explanatory, adds note splashes for the opponent",
			'oppNoteSplashes',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Smooth HP Bar',
			"Self-explanatory, makes the healthbar move smoothly.",
			'smoothHP',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Rating Display System',
			"How do you want your ratings to be displayed?",
			'ratingSystem',
			'string',
			'Psych',
			['Psych', 'Forever', 'Andromeda', 'Kade', 'Mania', 'Grafex']);
		addOption(option);
		
		var option:Option = new Option('Time Bar:',
			"What should the Time Bar display?",
			'timeBarType',
			'string',
			'Time Left',
			['Time Left', 'Time Elapsed', 'Song Name', 'Modern Time', 'Song Name + Time', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Flashing Lights',
			"Uncheck this if you're sensitive to flashing lights!",
			'flashing',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Camera Zooms',
			"If unchecked, the camera won't zoom in on a beat hit.",
			'camZooms',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Score Text Zoom on Hit',
			"If unchecked, disables the Score text zooming\neverytime you hit a note.",
			'scoreZoom',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Longer Health Bar',
			"If unchecked, the health bar will be set to the original one.",
			'longhealthbar',
			'bool',
		true);
		addOption(option);

		var option:Option = new Option('Score Type:',
			"Which score type would you like?",
			'scoreType',
			'string',
			'Default',
			["Default", "Leather Engine", "VS. Impostor", "FPS Plus"]);
		addOption(option);

		var option:Option = new Option('Time Bar Style:',
			"If timebar is on, how would you like it to look?",
			'timeBarStyle',
			'string',
			'Default',
			["Default", "Indie Cross"]);
		addOption(option);

		var option:Option = new Option('Player Healthbar-Colored Score',
			"The score and botplay texts' color will change to match that of the player's current healthbar color.",
			'playerBarColor',
			'bool',
		false);
		addOption(option);

		var option:Option = new Option('Rating Camera:',
			"What should the ratings and combo numbers be parented to?",
			'ratingCamType',
			'string',
			'camGame',
			['camGame', 'camHUD', 'camOther']);
		addOption(option);

		var option:Option = new Option('Health Bar Transparency',
			'How transparent the health bar and icons should be.', //Fixed the broken English on this one lol
			'healthBarAlpha',
			'percent',
			1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);
		
		#if !mobile
		var option:Option = new Option('FPS Counter',
			'If unchecked, hides the FPS Counter.',
			'showFPS',
			'bool',
			true);
		addOption(option);

		
		var option:Option = new Option('Memory Counter',
			'If unchecked, hides the Memory Counter.',
			'showMEM',
			'bool',
			true);
		addOption(option);
		#end
		
		var option:Option = new Option('Pause Screen Song:',
			"What song do you prefer for the Pause Screen?",
			'pauseMusic',
			'string',
			'Tea Time',
			['None', 'Breakfast', 'Tea Time']);
		addOption(option);
		option.onChange = onChangePauseMusic;
		
		#if CHECK_FOR_UPDATES
		var option:Option = new Option('Check for Updates',
			'On Release builds, turn this on to check for updates when you start the game.',
			'checkForUpdates',
			'bool',
			true);
		addOption(option);
		#end

		var option:Option = new Option('Combo Stacking',
			"If unchecked, Ratings and Combo won't stack, saving on System Memory and making them easier to read",
			'comboStacking',
			'bool',
			true);
		addOption(option);

		super();
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)));

		changedMusic = true;
	}

	override function destroy()
	{
		if(changedMusic) FlxG.sound.playMusic(Paths.music('freakyMenu'));
		super.destroy();
	}
}