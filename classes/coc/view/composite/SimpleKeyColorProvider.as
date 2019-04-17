/**
 * Coded by aimozg on 06.01.2019.
 */
package coc.view.composite {
public class SimpleKeyColorProvider implements IKeyColorProvider {
	private var _keyColors:Object;
	
	/**
	 * @param keyColors uint color24 -> uint color24
	 */
	public function SimpleKeyColorProvider(keyColors:Object) {
		_keyColors = keyColors;
	}
	public function allKeyColorsFor(layerName:String):Object {
		return _keyColors;
	}
}
}
