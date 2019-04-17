package classes.Scenes.Places.Boat 
{
	import classes.*;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Hips;
	import classes.display.SpriteDb;
	import classes.internals.*;

	/**
	 * ...
	 * @author ...
	 */
	public class TigerSharkGirl extends Monster
	{
		
		//Lust-based attacks:
		private function sharkTease():void {
			game.spriteSelect(SpriteDb.s_sharkgirl);
			if (rand(2) == 0) {
				outputText("You charge at the shark girl, prepared to strike again, but stop dead in your tracks when she cups her thick, four-ball sack and thursts it towards you. It distracts you long enough for her tail to swing out and smack you to the ground. She coos, \"<i>Aw... You really do like me!</i>\" ");
				//(Small health damage, medium lust build).
				player.takeDamage(4+rand(4), true);
				player.takeLustDamage(10+(player.lib/10), true);
			}
			else {
				outputText("You pull your " + player.weaponName + " back, getting a running start to land another attack. The Shark girl smirks and parts her grass skirt, lewdly wagging her foot-length cock in your direction. You stop abruptly, aroused by the sight just long enough for the shark girl to kick you across the face and knock you to the ground.  She teases, \"<i>Aw, don't worry baby, you're gonna get the full package in a moment!</i>\" ");
				//(Small health damage, medium lust build)
				player.takeDamage(4+rand(4), true);
				player.takeLustDamage(5+(player.lib/5), true);
			}
			combatRoundOver();
		}
		override public function defeated(hpVictory:Boolean):void
		{
			game.boat.sharkGirlScene.sharkWinChoices();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nYour foe doesn't seem disgusted enough to leave...");
				doNext(game.combat.endLustLoss);
			} else {
				game.boat.sharkGirlScene.sharkLossRape();
			}
		}

		public function TigerSharkGirl()
		{
			//trace("SharkGirl Constructor!");
			this.a = "the ";
			this.short = "tiger shark-girl";
			this.imageName = "sharkgirl";
			this.long = "The tiger shark girl stands just over 6'0\", with grey, horizontally striped skin shimmering from water droplets catching the sunlight and muscles thicker than the more feminine non-Tiger sharkgirl.  Her shoulder-length silver hair brushes past her pretty face and her eyes are a striking shade of red. She has rows of intimidating sharp teeth glinting in the light. A fish-like tail protrudes from her backside, wrapping around her toned legs at every opportunity. She's wearing a knee-length grass skirt and a rather skimpy black bikini, strings done in such a way that they move around her fin; though the swimwear itself barely covers her perky breasts.  Under the knee-length grass skirt, rustles her beastly foot-long penis and four-balled sack; you catch occasional glimpses of them as she moves.";
			this.race = "Shark-Morph";
			// this.plural = false;
			this.createCock(12 + rand(3),2.2);
			this.balls = 4;
			this.ballSize = 3;
			this.createVagina(false, Vagina.WETNESS_DROOLING, Vagina.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 15, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = Ass.LOOSENESS_TIGHT;
			this.ass.analWetness = Ass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,40,0,0,0);
			this.tallness = 5*12+5;
			this.hips.rating = Hips.RATING_CURVY;
			this.butt.rating = Butt.RATING_LARGE;
			this.skin.tone = "striped gray";
			this.hair.color = "silver";
			this.hair.length = 16;
			initStrTouSpeInte(80, 90, 85, 65);
			initLibSensCor(75, 25, 60);
			this.weaponName = "shark teeth";
			this.weaponVerb="bite";
			this.weaponAttack = 20;
			this.armorName = "tough skin";
			this.armorDef = 7;
			this.bonusHP = 120;
			this.lust = 20;
			this.lustVuln = .3;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 15;
			this.gems = rand(15) + 5;
			this.drop = new WeightedDrop().
					add(consumables.F_DRAFT,3).
					add(armors.S_SWMWR,1).
					add(consumables.SHARK_T,5).
					add(null,1);
			this.special1 = sharkTease;
			this.special2 = sharkTease;
			checkMonster();
		}
		
	}

}