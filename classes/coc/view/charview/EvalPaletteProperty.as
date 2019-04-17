/**
 * Coded by aimozg on 28.07.2017.
 */
package coc.view.charview {
import coc.script.Eval;

public class EvalPaletteProperty extends PaletteProperty{
	private var srcfn:Eval;

	public function EvalPaletteProperty(palette:Palette, name:String, defaultt:uint, lookupNames:/*String*/Array, expr:String) {
		super(palette,name,defaultt,lookupNames);
		this.srcfn = Eval.compile(expr);
	}

	public override function colorName(layerName:String, src:Object):* {
		return srcfn.call(src);
	}
}
}
