package classes.Scenes.Monsters.pregnancies 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.VaginaClass;
	import classes.StatusEffects;
	import classes.internals.GuiOutput;
	import classes.internals.PregnancyUtils;
	import classes.internals.Utils;
	
	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by an Imp.
	 */
	public class PlayerImpHordePregnancy implements VaginalPregnancy
	{
		private var output:GuiOutput;
		
		//TODO inject player, once the new Player calls have been removed. Currently it would break on new game or load (reference changed)
		
		/**
		 * Create a new imp pregnancy for the player.
		 * @param	pregnancyProgression instance used for registering pregnancy scenes
		 * @param	output instance for gui output
		 */
		public function PlayerImpHordePregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput) 
		{
			this.output = output;
			
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_IMP_HORDE, this);
		}
		
		/**
		 * @inheritDoc
		 */		
		public function updateVaginalPregnancy():Boolean 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			var displayedUpdate:Boolean = false;
			
			if (player.pregnancyIncubation === 1152) {
				output.text("\n<b>Your belly is still quite large, long after getting plugged full by Ceraph and Vapula.  During a “normal” pregnancy one might think you were 7-9 months along, but in this strange place, who knows?.</b>\n");
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 1008) {
				output.text("<b>Your belly has distended noticeably, beyond that of a normal nine-month pregnancy, but you still have a long way to go.</b>");
				kGAMECLASS.dynStats("tou", -5, "spe", -5, "lib", 1, "sen", .5, "cor", 0);
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 864) {
				output.text("<b>The brood in your womb continues to grow and along with it your entire abdomen making normal functions more difficult.  </b>");
				player.createStatusEffect(StatusEffects.ImpHordeBrood, 0, 0, 0, 0);
				
				if (player.cor < 40) {
					output.text("You are distressed by your unwanted pregnancy, and your inability to move normally has you equally worried.</b>");
				}
				
				if (player.cor >= 40 && player.cor < 75) {
					output.text("Considering the size of the creatures you've fucked, you hope it doesn't hurt when it comes out.</b>");
				}
				
				if (player.cor >= 75) {
					output.text("You think dreamily about the monstrous cocks that have recently been fucking you, and hope that your offspring inherit such a pleasure tool.</b>");
				}
				
				kGAMECLASS.dynStats("tou", -10, "spe", -15, "lib", 1, "sen", .5, "cor", 0);
				output.text("\n");
				displayedUpdate = true;
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 576) {
				output.text("<b>Your belly has yet to betray the sheer size of your expected offspring, but it's certainly making an attempt.  At this rate, you might not be able to even move.</b>");
				kGAMECLASS.dynStats("tou", -5, "spe", -15, "lib", 1, "sen", .5, "cor", 0);
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 288) {
				output.text("<b>Your belly is absurdly large making you nearly immobile; you hope you'll give birth soon.</b>");
				kGAMECLASS.dynStats("tou", -5, "spe", -25, "lib", 1, "sen", .5, "cor", 0);
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 1024 || player.pregnancyIncubation === 768 || player.pregnancyIncubation === 512 || player.pregnancyIncubation === 256) {
				//Increase lactation!
				if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1) {
					output.text("\nYour breasts feel swollen with all the extra milk they're accumulating.  You hope it'll be enough for the coming birth.\n");
					player.boostLactation(.5);
				}
				
				if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
					output.text("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
					player.boostLactation(.5);
				}
				
				//Lactate if large && not lactating
				if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() === 0) {
					output.text("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
					player.boostLactation(1);
				}
				
				//Enlarge if too small for lactation
				if (player.biggestTitSize() === 2 && player.mostBreastsPerRow() > 1) {
					output.text("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
					player.growTits(1, 1, false, 3);
				}
				
				//Enlarge if really small!
				if (player.biggestTitSize() === 1 && player.mostBreastsPerRow() > 1) {
					output.text("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
					player.growTits(1, 1, false, 3);
				}
			}
			
			return displayedUpdate;
		}
		
		public function vaginalBirth():void 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			
			output.text(kGAMECLASS.images.showImage("birth-imp-horde"));
			
			//Add imp birth status - used to control frequency of night imp gangbag
			if (player.hasStatusEffect(StatusEffects.BirthedImps)) {
				for (var i:int = Utils.rand(3) + 3; i > 0; i--) {
				player.addStatusValue(StatusEffects.BirthedImps, 1, 1);
				}
			}
			
			else {					
				for (var j:int = Utils.rand(3) + 3; j > 0; j--) {
					player.createStatusEffect(StatusEffects.BirthedImps,1,0,0,0);				
				}
			}
			
			PregnancyUtils.createVaginaIfMissing(output,player);
			output.text("A sudden gush of fluids erupts from your vagina - your water just broke.  You grunt painfully as you feel wriggling and squirming inside your belly, muscle contractions forcing it downwards.  ");
			
			if (player.cor < 50) {
				output.text("You rue the day you encountered that hateful imp.  ");
			}
			
			output.text("\nYou wake up suddenly to strong pains and pressures in your gut. As your eyes shoot wide open, you look down to see your belly absurdly full and distended. You can feel movement underneath the skin, and watch as it bulges and shifts as another living being moves independently inside you. Instinctively, you spread your legs as you feel the creature press outward, parting your cervix.\n\nYou try to push with your vaginal muscles, but you feel the creature moving more of its own volition. Your lips part as a pair of red hands grip your vulva and begin to spread them and pull. You cry out in agony as your hips are widened forcefully by the passing mass of the being exiting your womb. An impish face appears, mercifully lacking in horns. Shoulders follow, adult-like muscles already assisting the newborn's form.\n\n  He stumbles around your legs and over to your upper body, and takes hold of one of your milk-swollen breasts. He wraps his lips around your nipple and begins to suckle, relieving the pressure on the milk-swollen jug.\n\n");
			
			output.text("He suckles and suckles and suckles, leaving you to wonder just how much milk you were actually holding, but even as you wonder this, your eyes grow wide as another contraction hits you with an ensuing orgasm.  You realize you aren't done yet. The pain begins to subside as your delivery continues... replaced with a building sensation of pleasure.  Arousal spikes through you as the contractions intensify, and as you feel something pass you have a tiny orgasm.\n\nYet you feel more within you, and the contractions spike again, pushing you to orgasm as you pass something else.  Another imp appears from your spread lips, making his way to your unoccupied teat.\n\n");
			
			output.text("Belly still swollen, you now know you were carrying a whole brood of imps.  As the labor continues, you continue to struggle with the contractions and orgasms they cause, but are now subjected to new sensations as the already birthed imps continue to suckle. ");
				if (player.cor < 40) {
					output.text("Disgusted, you attempt to block the pleasure sensations eminating from your nipples.");
				}
				
				if (player.cor >= 40) {
					output.text("You embrace the newest pleasure enveloping your body and send yourself over the edge with another small orgasm.");
				}

			
			output.text("\n\nAs the third imp-spawn begins to descend your birth canal, you notice the others growing rapidly. They gain inches at a time, horns starting to grow from their skulls, bodies strengthening, cocks lengthening, and balls swelling. They reach two feet tall, but keep growing, soon then four feet tall, starting to resemble more and more the monsters like them.  As moments pass, the birthed imps continue to grip tighter and tighter on to your swollen breasts.  Sucking out milk at a faster and faster pace.  Shockingly, you see their cocks beginning to harden as they roughly handle your breasts and respond to the moans of pleasure escaping your lips."); 
			
			output.text("\n\nFinally, the first one pulls off your breasts, and finishes his milk - looking practically full grown you know he's not yet through.  Unsurprisingly, the young imp grabs you by your head and stuffs his whole cock into your mouth.  You have the honor of being his first of many orgasms as he quickly mouth fucks you and cums down your throat.  Gasping for breath, he releases you and grabs one of your spread legs to help his brethren.  Another push, and another imp escapes your confines.  You're not sure how much longer this will take, but you are in no position to resist.  You swiftly pass out.\n\n");
			
			if (player.vaginas[0].vaginalLooseness === VaginaClass.LOOSENESS_TIGHT) {
				player.vaginas[0].vaginalLooseness++;
			}
			
			//50% chance
			if (player.vaginas[0].vaginalLooseness < VaginaClass.LOOSENESS_GAPING_WIDE && Utils.rand(2) === 0) {
				player.vaginas[0].vaginalLooseness++;
				output.text("\n\n<b>Your cunt is painfully stretched from the ordeal, permanently enlarged.</b>");
			}

			output.text("\n\nWhen you wake you find a large number of imp tracks... and a spattering of cum on your clothes and body. ");
			
			if (player.averageLactation() > 0 && player.averageLactation() < 5) {
				output.text("  Your breasts won't seem to stop dribbling milk, lactating more heavily than before.");
				player.boostLactation(.5);
			}
			
			//Lactate if large && not lactating
			if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.averageLactation() === 0) {
				output.text("  As you ponder the implications, <b>you realize your breasts have been slowly lactating</b>.  You wonder how much longer it will be before they stop.");
				player.boostLactation(1);
			}
			
			player.boostLactation(.01);
			
			//Enlarge if too small for lactation
			if (player.biggestTitSize() === 2 && player.mostBreastsPerRow() > 1) {
				output.text("  <b>Your breasts have grown to C-cups!</b>");
				player.growTits(1, 1, false, 3);
			}
			
			//Enlarge if really small!
			if (player.biggestTitSize() === 1 && player.mostBreastsPerRow() > 1) {
				output.text("  <b>Your breasts have grown to B-cups!</b>");
				player.growTits(1, 1, false, 3);
			}
			
			if (player.vaginas[0].vaginalWetness === VaginaClass.WETNESS_DRY) {
				player.vaginas[0].vaginalWetness++;
			}
			
			player.orgasm('Vaginal');
			player.removeStatusEffect(StatusEffects.ImpHordeBrood);
			kGAMECLASS.dynStats("tou", 25, "spe", 62, "lib", 1, "sen", .5, "cor", 7);
			
			if (player.butt.rating < 10 && Utils.rand(2) === 0) {
				player.butt.rating++;
				output.text("\n\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.");
			}
			else if (player.hips.rating < 10) {
				player.hips.rating++;
				output.text("\n\nAfter the birth your " + player.armorName + " fits a bit more snugly about your " + player.hipDescript() + ".");
			}
			output.text("\n");
		}
	}
}
