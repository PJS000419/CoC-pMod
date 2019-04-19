package classes.Scenes.Monsters.pregnancies 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.Vagina;
	import classes.StatusEffects;
	import classes.internals.GuiOutput;
	import classes.internals.PregnancyUtils;
	import classes.internals.Utils;
	
	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by a Tiger Shark girl.
	 */
	public class PlayerSharkPregnancy implements VaginalPregnancy
	{
		private var output:GuiOutput;
		
		//TODO inject player, once the new Player calls have been removed. Currently it would break on new game or load (reference changed)
		
		/**
		 * Create a new shark-girl pregnancy for the player.
		 * @param	pregnancyProgression instance used for registering pregnancy scenes
		 * @param	output instance for gui output
		 */
		public function PlayerSharkPregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput) 
		{
			this.output = output;
			
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_SHARK_GIRL, this);
		}
		
		/**
		 * @inheritDoc
		 */
		public function updateVaginalPregnancy():Boolean 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			var displayedUpdate:Boolean = false;
			
			if (player.pregnancyIncubation === 336) {
				output.text("\n<b>You wake up feeling bloated, and your belly is actually looking a little puffy. At the same time, though, you have the oddest cravings... you could really go for some fish.</b>\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 280) {
				output.text("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 216) {
				output.text("\n<b>There is no question you're pregnant; your belly is getting bigger and for some reason, you feel thirsty ALL the time.</b>");
				
				kGAMECLASS.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 180) {
				output.text("\n<b>There is no denying your pregnancy.  Your belly bulges and occasionally squirms as your growing offspring shifts position.</b>\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 120) {
				output.text("\n<b>Your stomach is swollen and gravid; you can feel the baby inside you kicking and wriggling.  You find yourself dreaming about sinking into cool, clean water, and take many baths and swims. Whatever is inside you always seems to like it; they get so much more active when you're in the water.</b>\n");
				kGAMECLASS.dynStats("spe", -2, "lib", 1, "sen", 1, "lus", 4);
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 72) {
				output.text("\n<b>You dream of the water, of a life under the waves, where it's cool and wet and you are free. You spend as much time in the river as possible now, the baby inside you kicking and squirming impatiently, eager to be free of the confines of your womb and have much greater depths to swim and play in.  The time for delivery will probably come soon.</b>\n");
				kGAMECLASS.dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 48) {
				output.text("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  ");
				if (player.cor < 40) output.text("Afterwards you feel somewhat disgusted with yourself.</b>\n");
				if (player.cor >= 40 && player.cor < 75) output.text("You estimate you'll give birth in the next few days.</b>\n");
				if (player.cor >= 75) output.text("You find yourself daydreaming about birthing repeatedly, each time being re-impregnated by your hordes of lusty adolescent children.</b>\n");
				displayedUpdate = true;
			}
			
			return displayedUpdate;
		}
		
		public function vaginalBirth():void 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			
			kGAMECLASS.boat.sharkGirlScene.pcPopsOutASharkTot();
			
			
			player.knockUpForce(); //Clear Pregnancy
			kGAMECLASS.flags[kFLAGS.SHARKGIRL_DAUGHTERS_PENDING]++;
			
			if (kGAMECLASS.flags[kFLAGS.SHARKGIRL_DAUGHTERS_GROWUP_COUNTER] === 0) {
				kGAMECLASS.flags[kFLAGS.SHARKGIRL_DAUGHTERS_GROWUP_COUNTER] = 150;
			}
		}
	}
}
