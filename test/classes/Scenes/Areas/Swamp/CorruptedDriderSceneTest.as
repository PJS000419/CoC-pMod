package classes.Scenes.Areas.Swamp 
{
	import classes.CoC;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.Scenes.PregnancyProgression;
	import classes.helper.DummyOutput;
	import classes.helper.StageLocator;
	import org.flexunit.Assert;
	import org.flexunit.asserts.*;
	import org.hamcrest.collection.*;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;

	public class CorruptedDriderSceneTest 
	{
		private var cut:CorruptedDriderScene;
		private var player:Player;

		public function CorruptedDriderSceneTest() 
		{
			
		}

		[BeforeClass]
		public static function setUpClass():void
		{
			kGAMECLASS = new CoC(StageLocator.stage);
		}

		[Before]
		public function setUp():void
		{
			player = new Player();

			kGAMECLASS.player = player;

			cut = new CorruptedDriderScene(new PregnancyProgression(), new DummyOutput());
		}

		[Test]
		public function checkRideOviAnalHerm():void
		{
			player.createVagina();
			player.createCock();

			try {
				cut.victoryVSDriderRideOviAnal();
			} catch (error:Error) {
				Assert.fail(error.getStackTrace());
			}
		}

		[Test]
		public function checkRideOviAnalFemale():void
		{
			player.createVagina();

			try {
				cut.victoryVSDriderRideOviAnal();
			} catch (error:Error) {
				Assert.fail(error.getStackTrace());
			}
		}

		[Test]
		public function checkRideOviAnalGenderless():void
		{
			try {
				cut.victoryVSDriderRideOviAnal();
			} catch (error:Error) {
				Assert.fail(error.getStackTrace());
			}
		}

		[Test]
		public function checkRideOviAnalMale():void
		{
			player.createCock();

			try {
				cut.victoryVSDriderRideOviAnal();
			} catch (error:Error) {
				Assert.fail(error.getStackTrace());
			}
		}
	}
}
