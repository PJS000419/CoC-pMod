/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic {
import classes.internals.LoggerFactory;

import mx.logging.ILogger;

public class ExecContext {
	private static const LOGGER:ILogger = LoggerFactory.getLogger(ExecContext);
	
	public function ExecContext(_thiz:Array=null) {
		this._scopes = _thiz?_thiz:[];
	}
	private var _scopes:Array;
	public function get scopes():Array {
		return _scopes;
	}
	public function set scopes(value:Array):void {
		_scopes = value;
	}
	public function getObject(path:String):* {
		var p:/*String*/Array = path.split('.');
		var o:* = getValue(p[0]);
		for (var j:int = 1; j < p.length; j++) {
			if (!o) {
				LOGGER.error("[ERROR] getObject('"+path+"') -> "+o);
				return null;
			}
			o = o[p[j]];
		}
		if (!o) {
			LOGGER.error("[ERROR] getObject('"+path+"') -> "+o);
		}
		return o;
	}
	public function getValue(varname:String,inObj:String=""):* {
		if (inObj) {
			var obj:* = getObject(inObj);
			if (obj) return obj[varname];
			return undefined;
		}
		for each (var s:* in _scopes) if (varname in s) return s[varname];
		return undefined;
	}
	public function setValue(varname:String,value:*,inObj:String=""):void {
		if (inObj) {
			var obj:* = getObject(inObj);
			if (obj) {
				obj[varname] = value;
				return;
			}
			// TODO log error
			_scopes[0][varname] = value;
			return;
		}
		for each (var s:* in _scopes) {
			if (varname in s) {
				s[varname] = value;
				return;
			}
		}
		_scopes[0][varname] = value;
	}
	public function hasValue(varname:String):Boolean {
		for each (var s:* in _scopes) if (varname in s) return true;
		return false;
	}
	public function execute(stmt:Statement):void {
		stmt.execute(this);
	}
	public function executeAll(stmts:/*Statement*/Array):void {
		for each (var statement:Statement in stmts) {
			statement.execute(this);
		}
	}
	public function error(where:*,message:String):void {
		throw new Error("In "+where+": "+message);
	}
	public function pushScope(scope:Object):void {
		scopes.unshift(scope);
	}
	public function popScope():void {
		scopes.shift();
	}
	/**
	 * For debugging
	 */
	public function debug(where:*,s:String):void {
		if (DEBUG_LOG_ENABLED) {
			LOGGER.debug('' + where + ' ' + s);
		}
	}
	public static const DEBUG_LOG_ENABLED:Boolean = false;
}
}
