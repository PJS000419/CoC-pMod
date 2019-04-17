/**
 * Coded by aimozg on 06.07.2018.
 */
package coc.xlogic {
public class CallStmt extends Statement{
	private var fn:Function;
	private var passContext:Boolean;
	public function CallStmt(fn:Function, passContext:Boolean =false) {
		this.fn = fn;
		this.passContext = passContext;
	}
	
	override public function execute(context:ExecContext):void {
		if (passContext) fn(context);
		else fn();
	}
}
}
