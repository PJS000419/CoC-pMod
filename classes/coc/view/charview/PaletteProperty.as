/**
 * Coded by aimozg on 06.01.2019.
 */
package coc.view.charview {
import coc.view.Color;
import coc.view.composite.IKeyColorProvider;

public class PaletteProperty {
	public var name:String;
	private var palette:Palette;
	private var defaultt:uint;
	private var lookupNames:/*String*/Array;
	public function PaletteProperty(palette:Palette, name:String, defaultt:uint, lookupNames:/*String*/Array) {
		this.palette = palette;
		this.name = name;
		this.defaultt = defaultt;
		this.lookupNames = lookupNames.slice(0);
	}
	public function colorName(layerName:String, src:Object):* {
		if (src is IColorNameProvider) return (src as IColorNameProvider).getKeyColor(layerName,name);
		if (name in src) return src[name];
		return undefined;
	}
	public function lookup(layerName:String,colorName:String):uint {
		if (colorName.charAt(0) == '$') return Color.convertColor(colorName.substr(1));
		for each (var ln:String in lookupNames) {
			var lookup:Object = palette.lookupObjects[ln];
			if (lookup && colorName in lookup) return Color.convertColor(lookup[colorName]);
		}
		return defaultt;
	}
	public function colorValue(layerName:String,src:Object):uint {
		var sv:String = String(colorName(layerName,src));
		return lookup(layerName,sv);
	}
}
}
