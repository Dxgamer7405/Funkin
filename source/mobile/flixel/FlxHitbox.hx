package mobile.flixel;

import flash.display.BitmapData;
import flash.display.Shape;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import mobile.flixel.FlxButton;
import funkin.play.notes.NoteDirection;
import funkin.input.PreciseInputManager;
import funkin.play.PlayState;
import haxe.Int64;
import funkin.util.tools.Int64Tools;

/**
 * A zone with 4 hint's (A hitbox).
 * It's really easy to customize the layout.
 *
 * @author Mihai Alexandru (M.A. Jigsaw)
 * modified by @MatheusSilver
 */
class FlxHitbox extends FlxSpriteGroup
{
  private final noteDirection:Array<NoteDirection> = [NoteDirection.LEFT, NoteDirection.DOWN, NoteDirection.UP, NoteDirection.RIGHT];

  public var buttonsArray:Array<FlxButton>;

  private final colorsArray:Array<Int> = [0xFF00FF, 0x00FFFF, 0x00FF00, 0xFF0000];

  private function generateHitbox(numberOfHitbox:Int = 4):Array<FlxButton>
  {
    buttonsArray = [];
    for (i in 0...numberOfHitbox)
    {
      var hitbox:FlxButton = createHint((FlxG.width / numberOfHitbox) * i, 0, Std.int((FlxG.width / numberOfHitbox)), FlxG.height, i);
      buttonsArray.push(hitbox);
    }
    return buttonsArray;
  }

  /**
   * Create the zone.
   */
  public function new()
  {
    super();

    var hitboxArray:Array<FlxButton> = generateHitbox();
    for (hitbox in hitboxArray)
    {
      add(hitbox);
    }
    scrollFactor.set();
  }

  /**
   * Clean up memory.
   */
  override function destroy()
  {
    super.destroy();
    funkin.util.Utils.clearArray(buttonsArray);
  }

  private function createHintGraphic(Width:Int, Height:Int, Color:Int = 0xFFFFFF):BitmapData
  {
    var shape:Shape = new Shape();
    shape.graphics.beginFill(Color);
    shape.graphics.lineStyle(10, Color, 1);
    shape.graphics.drawRect(0, 0, Width, Height);
    shape.graphics.endFill();

    var bitmap:BitmapData = new BitmapData(Width, Height, true, 0);
    bitmap.draw(shape);
    return bitmap;
  }

  private function createHint(X:Float, Y:Float, Width:Int, Height:Int, direction:Int):FlxButton
  {
    var hint:FlxButton = new FlxButton(X, Y);
    hint.loadGraphic(createHintGraphic(Width, Height, colorsArray[direction]));
    hint.solid = false;
    hint.immovable = true;
    hint.scrollFactor.set();
    hint.alpha = 0.00001;
    hint.ID = direction;

    var direction:Int = direction; // É aqui que usaremos pra saber pra onde a hitbox está apontada.

    hint.onDown.callback = function() {
      if (hint.alpha != 0.2) hint.alpha = 0.2;

      if (PlayState.instance != null) funkin.play.PlayState.instance.onHitboxPress(formatHit(hint.ID));
    }
    hint.onUp.callback = function() {
      if (hint.alpha != 0.00001) hint.alpha = 0.00001;

      if (PlayState.instance != null) funkin.play.PlayState.instance.onHitboxRelease(formatHit(hint.ID));
    }

    hint.onOut.callback = hint.onUp.callback;
    hint.onOver.callback = hint.onDown.callback;
    #if FLX_DEBUG
    hint.ignoreDrawDebug = true;
    #end
    return hint;
  }

  private function formatHit(direction:Int):PreciseInputEvent
  {
    return {
      timestamp: PreciseInputManager.getCurrentTimestamp(),
      noteDirection: noteDirection[direction]
    };
  }
}
