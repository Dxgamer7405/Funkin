package mobile;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import funkin.ui.mainmenu.MainMenuState;
import flixel.FlxSprite;
import funkin.Paths;
import funkin.ui.AtlasText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.input.mouse.FlxMouseEvent;

class CreditsMobileState extends FlxState { //is was ai generated before ??????????????????????????????????????? :skull:
    override public function create():Void {
        super.create();

        var bg:FlxSprite = new FlxSprite(0, 0);
        bg.loadGraphic(Paths.image("menuBG"));
        add(bg);

        var title:FlxText = new FlxText(0, 20, FlxG.width, "Android Port Credits");
        title.setFormat(null, 32, FlxColor.WHITE, "center", OUTLINE, FlxColor.BLACK);
        add(title);

        var btext:FlxText = new FlxText(0, 0, FlxG.width / 2, "Tap a Porter name to view their Youtube Channel");
        btext.setFormat(null, 15, FlxColor.WHITE, "center", OUTLINE, FlxColor.BLACK);
        btext.y = FlxG.height - btext.height;
        add(btext);

        var btext2:FlxText = new FlxText(0, 0, FlxG.width / 2, "Tap the BACK MOBILE button to return to the main menu");
        btext2.setFormat(null, 15, FlxColor.WHITE, "center", OUTLINE, FlxColor.BLACK);
        btext2.x = FlxG.width - btext2.width;
        btext2.y = FlxG.height - btext2.height;
        add(btext2);

        var androidPorters:Array<{name:String, url:String}> = [
            {name: "Dxgamer", url: "https://www.youtube.com/@Dxgamer7405"},
            {name: "MarioMaster", url: "https://www.youtube.com/@MarioMaster39"}, //omg soy yo
            {name: "MaysLastPlay", url: "https://www.youtube.com/@MaysLastPlay"},
            {name: "Matheus Silver", url: "https://www.youtube.com/@MatheusSilver"},
            {name: "Mateusx02", url: "https://www.youtube.com/@mateusx02"},
            {name: "Pietro", url: "https://www.youtube.com/@pietro420"}
        ];

        for (i in 0...androidPorters.length) {
            var texto:AtlasText = new AtlasText(0, 70 + i * 100, androidPorters[i].name, DEFAULT);
            texto.screenCenter(X);
            add(texto);

            texto.x = texto.x - 1000;

            FlxMouseEvent.add(texto, function onMouseDown(texto:AtlasText)
            {
                FlxG.openURL(androidPorters[i].url);
            }, null, null, null);

            FlxTween.tween(texto, { x: texto.x + 1000}, 1.0, { startDelay: i * 0.1, ease: FlxEase.quadOut}); //twinsito
        }
    }

    override function update(elapsed){
        super.update(elapsed);

        if(FlxG.keys.pressed.SPACE #if mobile || FlxG.android.justReleased.BACK #end) FlxG.switchState(new MainMenuState()); //pa tras
    }

}
