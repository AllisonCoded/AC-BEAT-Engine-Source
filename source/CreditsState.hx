package;

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
import flixel.tweens.FlxTween;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;
	var descBox:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Reading the Credits", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);

		bg.scale.x = bg.scale.y = scaleRatio;
		bg.screenCenter();

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		#if MODS_ALLOWED
		// trace("finding mod shit");
		for (folder in Paths.getModDirectories())
		{
			var creditsFile:String = Paths.mods(folder + '/data/credits.txt');
			if (FileSystem.exists(creditsFile))
			{
				var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
				for (i in firstarray)
				{
					var arr:Array<String> = i.replace('\\n', '\n').split("::");
					if (arr.length >= 5)
						arr.push(folder);
					creditsStuff.push(arr);
				}
				creditsStuff.push(['']);
			}
		};
		var folder = "";
		var creditsFile:String = Paths.mods('data/credits.txt');
		if (FileSystem.exists(creditsFile))
		{
			var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
			for (i in firstarray)
			{
				var arr:Array<String> = i.replace('\\n', '\n').split("::");
				if (arr.length >= 5)
					arr.push(folder);
				creditsStuff.push(arr);
			}
			creditsStuff.push(['']);
		}
		#end

		var pisspoop:Array<Array<String>> = [
			// Name - Icon name - Description - Link - HEX BG Color
			['Directors'],
			[
				'ACodedGuy',
				'acodedguy',
				'Owner & Main Director, Coder, Background Maker and Theme Composer',
				'https://twitter.com/ACodedGuy',
				'4B0082'
			],
			[
				'Nekonite',
				'nekonite',
				'Co-Director',
				'https://twitter.com/nekonitee',
				'9400D3'
			],
			[
				'John_Daily',
				'johndaily',
				'Co-Director, Charter & VA',
				'https://twitter.com/JohnDai17259703',
				'00008B'
			],
			[''],
			['The Team'],
			[
				'TheSpriterOne',
				'thespriterone',
				'First Icon Artist since the beginning of the mod (icon looks awesome)',
				'https://twitter.com/TheSpriterOne',
				'4B0082'
			],
			[
				'Z11Gaming',
				'z11gaming',
				'Coder for some things that he did, helped the mod with coding.',
				'https://github.com/Z11Coding',
				'4B0082'
			],
			[
				'MrFlamin',
				'mrflamin',
				'Funni man who composed some songs, really amazing',
				'https://twitter.com/FlaminWasTaken',
				'4B0082'
			],
			[
				'TiagoFuzionPoco',
				'tiagofuzionpoco',
				'The guy who does icons for the characters, really neat guy (send him mr krabs in dms)',
				'https://twitter.com/FuzionPoco',
				'4B0082'
			],
			[
				'Bem W',
				'placeholder',
				'Funni man who voice acted for Scuffled Couples',
				'',
				'4B0082'
			],
			[
				'Ralsi',
				'ralsin',
				'The person who actually does goofy coding (hi ralsi sorry for calling u goofy)',
				'https://twitter.com/Ralsin1',
				'4B0082'
			],
			[
				'JDST',
				'jdst',
				'The man himself who composes and loves the funni lore (he composed the main menu)',
				'https://twitter.com/JDSTtwt',
				'4B0082'
			],
			[
				'Lemmeo',
				'lemmeo',
				'The person who does goofy ahh charts (lemmon lets send mr krabs in tiagos dms)',
				'https://twitter.com/Lemmeoo',
				'4B0082'
			],
			[
				'Doge_NotDetected',
				'placeholder',
				'The another charter which he is doge, thats all',
				'',
				'4B0082'
			],
			[
				'Teserex',
				'teserex',
				'Funni dog that composed for some songs (hello you)',
				'https://twitter.com/teserex_exe',
				'4B0082'
			],
			[
				'CritVA',
				'placeholder',
				'The man himself, who voice acted for the Questioner (chad)',
				'https://twitter.com/CritVA70',
				'4B0082'
			],
			[''],
			['BEAT!Engine Team'],
			[
				'Luis Com S',
				'luis',
				'Main Programmer',
				'https://www.youtube.com/channel/UCLmft4rF9cIyLbGGg1EHRHg',
				'00FFFF'
			],
			[
				'Gui iago',
				'gui',
				'Additional Programmer',
				'https://github.com/Gui-iago',
				'8344CC'
			],
			[
				'AquaStrikr',
				'aqua',
				'Director / Artist',
				'https://twitter.com/aqua_strikr',
				'737BCB'
			],
			['NoobZiito', 'noobziito', "Artist", 'https://twitter.com/NooBZiiTo1', '013220'],
			[
				'Cranile',
				'saltforsomereason',
				'Logo',
				'https://twitter.com/7saltybro',
				'FFFFFF'
			],
			['Cyaan', 'cyaan', "Guns Mania Chart", 'https://twitter.com/El_Cyaan', '2596be'],
			[
				'asho',
				'asho',
				'Rich Presence Header Design',
				'https://twitter.com/ashomoment',
				'FFCCCB'
			],
			['Lenineth', 'lenineth', 'Menu Remix', 'https://twitter.com/LeNineth', '00FF00'],
			[''],
			['Psych Engine Extra Keys'],
			['tposejank', 'tposejank', 'Extra Keys', 'https://github.com/tposejank', '013220'],
			[''],
			['Psych Engine Team'],
			[
				'Shadow Mario',
				'shadowmario',
				'Main Programmer of Psych Engine',
				'https://twitter.com/Shadow_Mario_',
				'444444'
			],
			[
				'RiverOaken',
				'riveroaken',
				'Main Artist/Animator of Psych Engine',
				'https://twitter.com/river_oaken',
				'C30085'
			],
			[
				'bb-panzu',
				'bb-panzu',
				'Additional Programmer of Psych Engine',
				'https://twitter.com/bbsub3',
				'389A58'
			],
			[''],
			['Psych Engine Contributors'],
			[
				'shubs',
				'shubs',
				'New Input System Programmer',
				'https://twitter.com/yoshubs',
				'4494E6'
			],
			[
				'SqirraRNG',
				'gedehari',
				'Chart Editor\'s Sound Waveform base',
				'https://twitter.com/gedehari',
				'FF9300'
			],
			[
				'iFlicky',
				'iflicky',
				'Delay/Combo Menu Song Composer\nand Dialogue Sounds',
				'https://twitter.com/flicky_i',
				'C549DB'
			],
			[
				'PolybiusProxy',
				'polybiusproxy',
				'.MP4 Video Loader Extension',
				'https://twitter.com/polybiusproxy',
				'FFEAA6'
			],
			[
				'Keoiki',
				'keoiki',
				'Note Splash Animations',
				'https://twitter.com/Keoiki_',
				'FFFFFF'
			],
			[
				'Smokey',
				'smokey',
				'Spritemap Texture Support',
				'https://twitter.com/Smokey_5_',
				'0033CC'
			],
			[''],
			["Funkin' Crew"],
			[
				'ninjamuffin99',
				'ninjamuffin99',
				"Programmer of Friday Night Funkin'",
				'https://twitter.com/ninja_muffin99',
				'F73838'
			],
			[
				'PhantomArcade',
				'phantomarcade',
				"Animator of Friday Night Funkin'",
				'https://twitter.com/PhantomArcade3K',
				'FFBB1B'
			],
			[
				'evilsk8r',
				'evilsk8r',
				"Artist of Friday Night Funkin'",
				'https://twitter.com/evilsk8r',
				'53E52C'
			],
			[
				'kawaisprite',
				'kawaisprite',
				"Composer of Friday Night Funkin'",
				'https://twitter.com/kawaisprite',
				'6475F3'
			]
		];

		for (i in pisspoop)
		{
			creditsStuff.push(i);
		}

		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			optionText.yAdd -= 70;
			if (isSelectable)
			{
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			// optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if (isSelectable)
			{
				if (creditsStuff[i][5] != null)
				{
					Paths.currentModDirectory = creditsStuff[i][5];
				}

				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;

				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
				Paths.currentModDirectory = '';

				if (curSelected == -1)
					curSelected = i;
			}
		}

		descBox = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
		descBox.alpha = 0.6;
		add(descBox);

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		bg.color = getCurrentBGColor();
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			if (colorTween != null)
			{
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if (ClientPrefs.lowEndMode)
				MusicBeatState.switchState(new SimpleMenuState());
			else
				MusicBeatState.switchState(new MainMenuState());
		}
		if (controls.ACCEPT)
		{
			CoolUtil.browserLoad(creditsStuff[curSelected][3]);
		}
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do
		{
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		}
		while (unselectableCheck(curSelected));

		var newColor:Int = getCurrentBGColor();
		if (newColor != intendedColor)
		{
			if (colorTween != null)
			{
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween)
				{
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if (!unselectableCheck(bullShit - 1))
			{
				item.alpha = 0.6;
				if (item.targetY == 0)
				{
					item.alpha = 1;
				}
			}
		}

		descText.text = creditsStuff[curSelected][2];
		descText.screenCenter(Y);
		descText.y += 270;

		descBox.setPosition(descText.x - 10, descText.y - 10);
		descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
		descBox.updateHitbox();
	}

	function getCurrentBGColor()
	{
		var bgColor:String = creditsStuff[curSelected][4];
		if (!bgColor.startsWith('0x'))
		{
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool
	{
		return creditsStuff[num].length <= 1;
	}
}
