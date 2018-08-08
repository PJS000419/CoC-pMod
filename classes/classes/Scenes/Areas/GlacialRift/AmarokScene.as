//By Foxwells
//No wolf-fucking scenes because NO BESTIALITY. This is a WOLF and I am not having you fuck a LITERAL, NON-MORPH, ACTUAL WOLF
//Note: You get bad-ended if you lose 5 times in a row. Amarok eats you. I avoided vore fetish as best as I could (though I admit to making some miscellaneous jokes about it in commentary), did my best not to sexualise it. I don't like vore either. Shit's weird. Anyway if I crossed a line, let me know and I'll fix it
package classes.Scenes.Areas.GlacialRift {
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.display.SpriteDb;
	import classes.internals.*;

	public class AmarokScene extends BaseContent {

		public function AmarokScene() {}
		//He's not actually going to eat you. Unless you fuck up 5 times
		public function amarokChowTime():void {
			clearOutput();
			spriteSelect(SpriteDb.s_amarok);
			credits.authorText = "Foxwells";
			outputText(images.showImage("amarok-defeat"));
			flags[kFLAGS.AMAROK_LOSSES]++;
			if (player.HP <= 0) {
				outputText("Your legs give out under you and your " + player.weaponName + " falls into the snow. The Amarok has you beat. Your face crashes into the snow, a refreshing cool on the heat of your wounds. You raise your head at the sound of footsteps and find yourself staring at the Amarok's nose as it sniffs you. You let your head drop and resign yourself to fate.");
				amarokFlagCheck();
			}
			else //if you lust lost you kinda deserve it, he shouldn't tease if I did this right
				outputText("You collapse into the snow, your lust uncontrollable. As your hand reaches for your loins, you silently curse yourself for bringing yourself to this state. You raise your head at the sound of footsteps and find yourself staring at the Amarok's nose as it sniffs you. You let your head drop and resign yourself to fate.");
		}

		public function amarokFlagCheck():void {
			if (player.hasStatusEffect(StatusEffects.Infested)) amarokNoEat();
			else if (flags[kFLAGS.AMAROK_LOSSES] >= 5) amarokBadEnd();
			else if (flags[kFLAGS.AMAROK_LOSSES] < 5) amarokChompo();
		}
		//He doesn't want to eat worms
		private function amarokNoEat():void {
			clearOutput();
			spriteSelect(SpriteDb.s_amarok);
			credits.authorText = "Foxwells";
			outputText(images.showImage("area-glacialrift"));
			outputText("\n\nMuch to your surprise, however, the Amarok suddenly backs away with a low growl. It resumes sniffing you at a distance, eventually coming over to your lower half. The worms inside you wriggle about, and you let out a low groan of discomfort. As though on cue, the Amarok take a sniff of your crotch, then promptly backs off with another snarl. It must be able to detect your worm infestation, and more importantly, not like it! It turns away and kicks snow on you with one of its back back, letting out a huff of irritation. You watch it walk off as blackness washes over your vision.");
			combat.cleanupAfterCombat();
		}

		private function amarokChompo():void {
			clearOutput();
			spriteSelect(SpriteDb.s_amarok);
			credits.authorText = "Foxwells";
			if (player.lust >= player.maxLust()) outputText("Overcome by sexual desire, you submit to the powerful wolfn\n");
			else outputText("Too weak to continue fighting, you fall to your knees face in the ground.\n\n");
			
			outputText("\n\nLooking back under your spread legs, you notice the bright red tip of his crimson cock poking out from his and sheath. A thick rope of clear pre-slime dangles from the pointed tip of animal flesh. You notice a massive pair of nuts, each one could easily fill your hands and more. You watch those taut looking orbs bounce when he shifts in closer.")
			outputText(" You feel the canine tip touched your slit. For a moment, he teases the seam of your " + player.vaginaDescript(0) + " with what feels like a hot iron rod.")
			
			outputText("\n\nHe waits a moment, drooling into your exposed crack before brutally burrying his rock hard length into your slot with a primal snarl. You can only grunt as it skewers far too deeply in your passage. His hips are a blur while he savagely fucks your hole, growling into your ear from pleasure while churning his cock in your wet slot. ")
			if (player.vaginalCapacity() < monster.cockArea(0)) outputText("You feel an intense mixture of sensations in your lower body as your " + player.vaginaDescript(0) + " is filled with an intense pleasure at being filled with the beast's member.  ");
			else outputText("Your lower body explodes with pain as the wolf forces himself in too quickly for your " + player.vaginaDescript(0) + " to handle.  ");
			if (player.cuntChange(monster.cockArea(0), false)) outputText("The beast howls as your " + player.vaginaDescript(0) + " is stretched to accommodate the large shaft.  ");
			outputText("\n\nYour entire body is jolted under him with each brutal connection of his hips to your ass cheeks with a muffled whump. The raw power of each hard strike sends deep ripples racing down your curves. His heavy nuts swinging like pendulums between his legs and smacking so hard into your pussy lips and clit it makes harsh bolts of pleasure burst between your quivering legs.  You can feel his cock pushing at the walls of your passage as it expands to fill you completely.");
			outputText("You can keenly feel the numerous veins in his shaft giving his bloated cock an erratic bumpy texture while he rakes it against your slick walls. Your moans grew louder and more desperate when you feel your pussy straining to handle his growing member. You feel his thick knot spreading your already loose fuck hole");
			
			if (player.pregnancyIncubation > 0 && player.pregnancyIncubation <= 150) outputText(images.showImage("amarok-loss-vag-preg"));
			else outputText(images.showImage("amarok-loss-vag"));
			outputText("\n\nSlick with your mixed fluids, the beast forces his knot into your pussy an explosion of pain ripping through you. As it subsides you are overwhelmed by cascading pleasure to match the sensations rising from your " + player.vaginaDescript(0) + ".  You climax, hard. ")
				//Cum
			outputText("As you reach your peak, the beast howls and you begin to feel a hot throbbing coming from the beasts member as his embeded knot seals you to him.  You know what comes next.  In an instant, you feel jets of incredibly hot seed pour into you. Your belly begins to balloon as your womb is overfilled with the beast's seed, knot plugging the entrance.");
			player.orgasm('Vaginal', true);
			outputText("\n\nHe continues to pump rope after rope of beastial cum until you appear like a heavily pregnant woman.  It feels like ages before his knot deflates enough to escape your abused hole with a wet pop - followed by a flood of wolf seed.");
			outputText("\n\nThe mixture of pleasure and pain is too much and you pass out.")
			
			if ((player.pregnancyIncubation > 0 && player.pregnancyIncubation <= 150) && player.biggestTitSize() >= 3){
				doNext(amaroksBitch);
			}
			else{
				outputText("\n\nYou awaken sometime later and spot your " + player.armorName + " a bit away. It must've been ripped off you when you were passed out. You scramble to it and put it back on, then head back to camp as fast as you can.");
				combat.cleanupAfterCombat();
			}
		}
		
		private function amaroksBitch(): void {
			clearOutput();
			spriteSelect(SpriteDb.s_amarok);
			outputText("Fading in and out of conciousness, you hear him let out a soft bark as you close your eyes and skips to the other side of you. You remain still in fear of what it plans to do. He picks you by your neck. His grip isn't hard enough to even break your skin, but firm enough that it won't drop you. It then begins to drag you somewhere, leaving a trail of wolf cum behind you as it continues to seep out of your " + player.vaginaDescript(0) + ". Something in your mind tells you to struggle, but you can't seem to muster the will to try. It'd just bite through your neck and kill you anyway. The feeling of its hot breath running down your back is oddly soothing. You open your eyes long enough to make sense of your surroundings, then pass out.");
			outputText("\n\nYou awaken some time later to a chorus of yips. You've stopped moving. You're on the ground, with small paws and dull teeth prodding you all over. You push yourself up off the ground on to all fours, your " + ((player.biggestTitSize() >= 3) ? "milk undders dangling freely" : "breasts hanging below") + ", you feel sharp little teeth latch unto your " +((player.lactationQ() > 0) ? "dripping" : "") + " nipples and paws leaning against your brood-filled belly causing you to jolt out of your stupor. You focus your vision and slowly make out where you are-- the side of a short cliff, protected from snow by tall trees. You're sprawled atop of pine needles and dead leaves.")
			outputText(images.showImage("amarok-feed-litter"));
			outputText("\n\nYou finally look at the sensations coming from your body.  They're black wolf pups, likely the Amarok's. You spot three others scattered about the den. You must have been left as the brood mother to feed the pups.");
			if (player.cor < 40) outputText("You get to your feet, shaking off the pups. You don't feel like sticking around.");
			else outputText("The litter sucking at your [tits], like the breeding bitch you are, brings you a pleasure you had not expected; your tingling tits feel like they are alight with their true purpose. You rub your hands over your bulging belly, lost in the sensations of motherhood. It is an incredible experience, one that you don't think you could have had if it wasn't for the power of corruption that you've gained since you got here. Too soon, you realize that you can't stay to feed these pups");
			if (player.cor > 60) outputText(" you have your own brood to sire.")
			else outputText(" your own path to follow.")
			if (player.cor > 40) dynStats("lust", 15, "cor", 1.5);
			combat.cleanupAfterCombat();
		}
		
		//Hungry Hungry Hipp-- err, Wolves
		public function amarokBadEnd():void {
			clearOutput();
			spriteSelect(SpriteDb.s_amarok);
			credits.authorText = "Foxwells";
			outputText(images.showImage("badend-amarok"));
			outputText("You've been here before. The Amarok will carry you to its den, let its pups deal with you as they will, and it'll vanish off somewhere. You'll wake up later and flee before it returns or its pups get hungry. You close your eyes and wait for it to pick you up. You just want to get this over with.");
			outputText("\n\nThe Amarok, however, has other plans. Instead of coming behind you and picking you up, it hits you with a paw that rolls you onto your back, then puts said paw on your chest. You wheeze under its weight. It managed to step in just the right spot to knock your breath out of you. As though the air wasn't freezing enough, a wave of cold horror washes through your spine. You don't know what's going to happen, but you don't like it.");
			outputText("\n\nYou writhe under its grasp as your throat closes in terror. Your efforts are fruitless, and the Amarok watches you in mild amusement. Your blood starts to pound in your ears. You need something-- anything --that'll help you get away. You flop an arm at the leg holding you down, praying it'll knock the Amarok off. It doesn't work. You try to get a foot under it and kick it off. You can't even roll your legs up. You try to scream for help in a futile hope anyone is nearby. You instead choke on your own breath. The Amarok's cruel gaze watches you with glee.");
			outputText("\n\nYou stop thinking. You just want air.");
			outputText("\n\nLines of pain well in your abdomen and you take in the biggest breath of your life-- only to promptly release it with a screech. You instinctively curl up to try and protect yourself, but the Amarok takes a hold of one of your arms and shakes you violently. It only releases you when it accidentally rips off part of your " + player.armorName + ". You get flung a bit away and take a small tumble. Before you can get up, though, the Amarok is on you. It holds you down with one of its paws and begins to tear off the rest of your " + player.armorName + ", carelessly tossing it aside. You jerk, and roll, and rip at its leg, but it refuses to release you. Instead, it opens its jaws and snaps them shut around your neck.");
			player.takeDamage(player.HP, false);
			getGame().gameOver();
		}

		public function winAgainstAmarok():void {
			flags[kFLAGS.AMAROK_LOSSES]--; //kinda unfair to continually stack it imo
			if (flags[kFLAGS.AMAROK_LOSSES] < 0)
				flags[kFLAGS.AMAROK_LOSSES] = 0;
			clearOutput();
			credits.authorText = "Foxwells";
			outputText(images.showImage("amarok-victory"));
			outputText("The Amarok collapses, unable to withstand any more.");
			combat.cleanupAfterCombat();
		}
	}
}
