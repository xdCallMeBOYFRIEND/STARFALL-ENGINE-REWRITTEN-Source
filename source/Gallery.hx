package;
import flixel.*;
import flixel.FlxSprite;
import flixel.text.FlxText;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import sys.FileSystem;
import flixel.addons.ui.FlxInputText;

class Gallery extends MusicBeatState
{
    var background:FlxSprite;
    var imagePaths:Array<String>;
    var imageDescriptions:Array<String>;
    var imageTitle:Array<String>;
    var currentIndex:Int = 0;
    var imageSprite:FlxSprite;
    var descriptionText:FlxText;
    var titleText:FlxText;
    var bg:FlxSprite;

    override public function create():Void
    {
        // Set up background
        background = new FlxSprite(10, 50).loadGraphic(Paths.image("menuBG"));
        background.setGraphicSize(Std.int(background.width * 1));
        background.screenCenter();
        add(background);

        // Set up image paths and descriptions
        imagePaths = ["gallery/wtf", "gallery/downscrollmybehated", "gallery/no"];
        imageDescriptions = ["An accurate depiction of me while making this engine.", "Fuck downscroll. All my homies love upscroll.", "Because I don't wanna get sent into cardiac arrest."];
        imageTitle = ["What the fuck am I doing?!", "Shots Fired.", "I do not like."];

        // Set up initial image and description text
        imageSprite = new FlxSprite(50, 50).loadGraphic(Paths.image("gallery/wtf"));
        imageSprite.screenCenter();
        add(imageSprite);

        descriptionText = new FlxText(50, -100, FlxG.width - 100, imageDescriptions[currentIndex]);
        descriptionText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        descriptionText.screenCenter();
        descriptionText.y += 250;
        descriptionText.setFormat(Paths.font("vcr.ttf"), 32);
        descriptionText.borderSize = 1.25;
        add(descriptionText);

        titleText = new FlxText(50, 50, FlxG.width - 100, imageTitle[currentIndex]);
        titleText.screenCenter(X);
        titleText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        titleText.setFormat(Paths.font("vcr.ttf"), 32);
        titleText.borderSize = 1.25;
        add(titleText);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        // Handle left and right arrow keys to scroll through images
        if (FlxG.keys.justPressed.LEFT)
        {
            currentIndex--;
            if (currentIndex < 0)
            {
                currentIndex = imagePaths.length - 1;
            }
            remove(imageSprite);
            imageSprite = new FlxSprite(50, 50).loadGraphic(Paths.image(imagePaths[currentIndex]));
            add(imageSprite);
            descriptionText.text = imageDescriptions[currentIndex];
            titleText.text = imageTitle[currentIndex];
            imageSprite.screenCenter();

        }
        else if (FlxG.keys.justPressed.RIGHT)
        {
            currentIndex++;
            if (currentIndex >= imagePaths.length)
            {
                currentIndex = 0;
            }
            remove(imageSprite);
            imageSprite = new FlxSprite(50, 50).loadGraphic(Paths.image(imagePaths[currentIndex]));
            add(imageSprite);
            descriptionText.text = imageDescriptions[currentIndex];
            titleText.text = imageTitle[currentIndex];      
            imageSprite.screenCenter();
    
        }
        if (controls.BACK)
            {
                FlxG.sound.play(Paths.sound('cancelMenu'));
                MusicBeatState.switchState(new MainMenuState());
            }
        }
    }