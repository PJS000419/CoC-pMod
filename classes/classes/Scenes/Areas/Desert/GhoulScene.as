// By Foxwells
// Ghouls! Their lore is that they look like hyenas and lure people to places and then eat them
// Apparently also they live in deserts and graveyards

package classes.Scenes.Areas.Desert {

	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class GhoulScene extends BaseContent {
	
		public function GhoulScene() {
			
		}
		
		public function ghoulEncounter():void {
			clearOutput();
			credits.authorText = "Foxwells";
			outputText(images.showImage("event-hyena"));
			outputText("As you wander the bizarrely unfinished zone, your eyes catch something moving. You look in its direction. It's a hyena. Not a hyena-morph, but a literal hyena. If that wasn't weird enough, you're pretty certain anything hyena would be found ");
				if (flags[kFLAGS.TIMES_EXPLORED_PLAINS] > 0) {
					outputText("at the Plains.");
				} else {
					outputText("elsewhere.");
				}
			outputText(" But it hardly matters. The hyena has spotted you and is charging at you, ruining any more contemplation. Instead, you prep yourself for a fight.");
			startCombat(new Ghoul());
		}
		
		public function ghoulWon():void {
			combat.cleanupAfterCombat();
			clearOutput();
			credits.authorText = "Foxwells";
			outputText(images.showImage("monster-ghoul"));
			if (player.HP <= 0) {
				outputText("You fall into the sand, your wounds too great. ");
			}
			else { //lust loss I guess
				outputText("You fall into the sand, your lust too overpowering. ");
			}

			outputText("The ghoul wastes no time and lunges forward at you. The last thing you see before you pass out is the ghoul's outstretched jaws.\n\nYou have no idea what time it is when you wake up. Bite marks and other wounds cover your body, and pain wracks you with every breath you take. The sand is red with your blood and the metallic smell makes your stomach churn, but at the very least, you don't seem to be bleeding anymore. With great effort, you heave yourself up and stagger your way back to camp.");

			dynStats("str", -2);
			dynStats("tou", -3);
			dynStats("sens", 3);
			doNext(camp.returnToCampUseFourHours);
		}
		
		public function ghoulGetsSome(): void {						
			clearOutput();
			credits.authorText = "MirandaKeyes858";
			if (player.isVisiblyPregnant()) outputText(images.showImage("ghoul-fuck-female-preg"));
			else outputText(images.showImage("ghoul-fuck-female"));
			outputText("You sink to the ground, falling forward your " + player.allBreastsDescript() + " " + ((player.isVisiblyPregnant()) ? "and heavily pregnant belly " : "") +  "land on the hot sand below.  Too overcome by lust and desire to fight.  The ghoul leans over your widely spread legs and bends down, long, powerful forked tongue slipping between your firm buttocks and slowly dragging his tongue up between your ass cheeks, over your" + player.assholeDescript() + "then slowly up thru your swollen parted labia, causing you to moan deliriously in your sleep.");
			outputText("\n\nBetween it's legs, an immensely thick cock stretches out to a full thirteen inches long, the head bulging out twice the width of its wide shaft, his testicles the size of grapefruit.  It makes a facial gesture that could only be taken as a smile and presses his cock against your " + player.vaginaDescript(0) + ".  Sinking it's forelimbs in beside your " + ((player.isVisiblyPregnant()) ? "pregnant gut" : "thighs") + ", it mounts you like mating dog.  The ghoul begins pushing its hips forward, probing your nether regions looking for an entrance before finally popping into your opening.");
			outputText("\n\nNow embedded, the ghoul begins to rapidly increase the pace of it's humping, the bulging head of it's demon cock stretching your vaginal dimensions.  The ghoul's cock continuous to bump into your slowly, dialating cervix before ramming the head of his phallus through the opening.  Still unconcious, the pain and pleasure generated in tandem only serves to further lubricate your " + player.vaginaDescript(0) +".");
			outputText("\n\nFeeling the tip of it's cock sliding through your cervix,  the ghoul's saliva drips from its mouth and falls on to your bare back.  The ghould begins thrusting harder, faster, tightening the grip on your " + ((player.isVisiblyPregnant()) ? "impregnated belly " : "thighs ") + "sending shockwaves through your titflesh " + ((player.isVisiblyPregnant()) ? "and swollen gut " : "") + "with each impact of its hips against your backside.");
			outputText("\n\nEach pounding thrust slaps it's grapefruit-size balls against your belly. Loud squishing sucking noises can be heard for some distance in this open space as his inhuman pace continues to mash deep into your insides.  The ghoul plunges deeply, and painfully as an immense quantity of hot cum volcanically erupts almost instantly filling your womb with an almost unbearable pressure.  Your" + ((player.isVisiblyPregnant()) ? " already impregnated belly beings to swell obscenely" : " abdomen begins to swell and bulge") +  " as he pumps liters of semen into you.");
			outputText("\n\nFinally, as he finishes you look like a" + ((player.isVisiblyPregnant()) ? " heavily pregnant woman carrying triplets" : " pregnant woman in her second trimester") +  " The creatureb slowly starts pulling its thick, long sinuous cock, from your abused pussy with a loud prolonged slurping noise.  The swollen bulbous head of his cock momentarily hangs up in your vaginal entrance before painfully tugging it out.  The cock head slowly edges out of your entrance and then with a loud “POP!” suddenly emerges, squirting copious white semen on your heaving body and releasing a gusher of cum out of your pussy.");
			
			player.orgasm('Vaginal')
			dynStats("str", -2);
			dynStats("tou", -3);
			dynStats("sens", 3);
			combat.cleanupAfterCombat();
			doNext(camp.returnToCampUseFourHours);
		}
	}
}
