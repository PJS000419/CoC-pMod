package classes.Scenes 
{
	import classes.Scenes.Areas.BogSuite;
	import classes.Scenes.Areas.DeepWoodsTest;
	import classes.Scenes.Areas.ForestSuite;
	import classes.Scenes.Areas.MountainSuite;
	import classes.Scenes.Areas.SwampSuite;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AreasSuite 
	{
		public var mountainSuit:MountainSuite;
		public var forestSuit:ForestSuite;
		public var bogSuit:BogSuite;
		public var swampSuit:SwampSuite;
		
		public var deepWoodsTest:DeepWoodsTest;
	}
}
