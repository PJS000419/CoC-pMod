/**
 * Coded by aimozg on 06.01.2019.
 */
package coc.view.charview {
import coc.view.composite.IKeyColorProvider;

public class Palette implements IKeyColorProvider {
	private var _keyColorsList:/*KeyColor*/Array = [];
	private var _lookupObjects:Object            = {}; // { dict_name => { color_name => color_string } }
	private var _paletteProps:/*PaletteProperty*/Array = [];
	private var _character:Object                      = null;
	private var _cachedKeyColors:Object                = {};
	public function addKeyColor(src:uint,base:String,tf:String):void {
		this._keyColorsList.push(new KeyColor(src,base,tf));
	}
	public function addLookups(name:String,lookup:Object):void {
		_lookupObjects[name] = lookup;
	}
	public function addPaletteProperty(pp:PaletteProperty):void {
		this._paletteProps.push(pp);
	}
	/**
	 * @param propToColor { prop_name -> color_value }
	 * @return { key_color -> actual_color }
	 */
	protected function keyColorsFromProperties(propToColor:Object):Object {
		var keyColorsMap:Object = {};
		for each (var color:KeyColor in _keyColorsList) {
			keyColorsMap[color.src] = color.transform(propToColor[color.base]);
		}
		return keyColorsMap;
	}
	public function set character(value:Object):void {
		_character       = value;
		_cachedKeyColors = {};
	}
	public function get keyColorsList():Array {
		return _keyColorsList;
	}
	public function get lookupObjects():Object {
		return _lookupObjects;
	}
	// { key_color -> actual_color }
	public function allKeyColorsFor(layerName:String):Object {
		if (!_cachedKeyColors[layerName]) {
			var props:Object = {};
			for each (var property:PaletteProperty in _paletteProps) {
				props[property.name] = property.colorValue(layerName, _character);
			}
			_cachedKeyColors[layerName] = keyColorsFromProperties(props);
		}
		return _cachedKeyColors[layerName];
	}
	public function lookupColor(layername:String, propname:String, colorname:String):uint {
		for each (var property:PaletteProperty in _paletteProps) {
			if (property.name == propname) return property.lookup(layername, colorname);
		}
		return 0xfff000e0;
	}
}
}
