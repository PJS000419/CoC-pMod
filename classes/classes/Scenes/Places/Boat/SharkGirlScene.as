package classes.Scenes.Places.Boat{
	import classes.*;
	import classes.Scenes.Monsters.pregnancies.PlayerSharkPregnancy;
	import classes.GlobalFlags.kFLAGS;
	import classes.display.SpriteDb;
	import classes.internals.*;
	import classes.Scenes.PregnancyProgression;


	public class SharkGirlScene extends AbstractBoatContent implements TimeAwareInterface {
		

	public function SharkGirlScene(pregnancyProgression:PregnancyProgression, output:GuiOutput)
	{
		new PlayerSharkPregnancy(pregnancyProgression, output);
		CoC.timeAwareClassAdd(this);
	}
	
	
			//Implementation of TimeAwareInterface
		public function timeChange():Boolean {
			//326 Number of sharkgirls grown
			//327 Number of sharkgirls pending
			//328 growup countdown
			//If it gets glitched somehow
			if (flags[kFLAGS.SHARKGIRL_DAUGHTERS_GROWUP_COUNTER] > 30) flags[kFLAGS.SHARKGIRL_DAUGHTERS_GROWUP_COUNTER] = 30;
			if (flags[kFLAGS.SHARKGIRL_DAUGHTERS_GROWUP_COUNTER] < 0) flags[kFLAGS.SHARKGIRL_DAUGHTERS_GROWUP_COUNTER] = 0;
			//Countdown for son growing up
			if (flags[kFLAGS.SHARKGIRL_DAUGHTERS_GROWUP_COUNTER] > 0) {
				flags[kFLAGS.SHARKGIRL_DAUGHTERS_GROWUP_COUNTER]--;
				//Hit zero, move kid to grown up pile!
				if (flags[kFLAGS.SHARKGIRL_DAUGHTERS_GROWUP_COUNTER] <= 0 && flags[kFLAGS.SHARKGIRL_DAUGHTERS_PENDING] > 0) {
					flags[kFLAGS.SHARKGIRL_DAUGHTERS_PENDING]--;
					flags[kFLAGS.ADULT_SHARKGIRL_OFFSPRINGS]++;
				}
			}
			//NEXT KID!
			if (flags[kFLAGS.SHARKGIRL_DAUGHTERS_PENDING] > 0 && flags[kFLAGS.SHARKGIRL_DAUGHTERS_GROWUP_COUNTER] == 0)
				flags[kFLAGS.SHARKGIRL_DAUGHTERS_GROWUP_COUNTER] = 30;
			return false;
		}
		
		public function timeChangeLarge():Boolean { return false; }
		//End of Interface Implementation

	
	/*Codex: Shark girls and tiger shark girls

Gender: Mostly female, though there are males and herms. Due to the nature of their conception, the vast majority of tiger sharks are herms.

Height: 5-6 feet tall. Tiger sharks are primarily in the 6 foot region.
Build: Well-toned and athletic.
Skin tone: Grey. Light orange with stripes for tiger sharks.
Hair color: Silver and in rare cases, Black. 
Eye color: Red for both species.

Typical dress: Ridiculously skimpy swimwear, which they use to entice victims. Some tiger shark girls will wear grass hula skirts when on land to hide their endowments.

Weaponry: Fangs, tail and their bare hands.
Notable features: Retractable shark teeth, a large fin between their shoulders and a shark tail dangling off of their backsides. 

Sexual characteristics: Despite their slutty nature, shark girls have rather modest endowments in comparison to other such creatures; the majority of them are C-cups, D-cups at most. Though, their hips and buttocks are nice and curvy. Tiger shark girls possess wildly varying bustlines that are larger than their 'sisters', and usually are hyper-endowed with male genitalia.

Loot:
Shark Tooth
T.Shark Tooth (Tiger shark girls only)
Slutty Swimwear
L.Draft

History: Before the corruption truly began, the Shark people were a normal fishing community that lived by the lake. They respected and admired marine life so much that they used magic to morph their forms, allowing them to live both under the sea and on dry land. As the demons began to take control, the Shark people retreated into the lake water to avoid the taint. It was only through sheer bad luck that they wound up as they are now; when the factory was constructed, the chemical run-off was funnelled into the lake, causing a drastic change to the mindset of the Shark people and making them near-constantly horny. Those who swam too close to the pollutants found their bodies morphed in unexpected ways, becoming what are now known as tiger shark girls. Even if the factory were to be destroyed, it would take generations for the shark girls to fully lose the effects.

Social Structure: Most shark girls travel in small groups, ruled over by one tiger shark girl. However, there are larger communities that can be found in the lake. Males are generally kept chained up, being abnormally aggressive even for sharks. But as they are more virile and fertile than tiger sharks girls, every once in a while they are unchained to help with reproduction. The Shark people spend most of their time either hunting for food or hunting for sex. 

Sex Life: The shark girls treat sex like a game or a sport, constantly battling for dominance against their opponents and using them as sex toys if they win. As they're horny most of the time, shark girls often look for 'playmates', regardless if their victims want to 'play' or not!
----------------------------------
*/
//[Explore Lake]
public function sharkGirlEncounter(exploreLoc:Number = 0):void {
	//Set 'PC met Sharkgirls' for Izma stuff
	if (flags[kFLAGS.IZMA_ENCOUNTER_COUNTER] == 0) flags[kFLAGS.IZMA_ENCOUNTER_COUNTER] = 1;

	if (!player.hasStatusEffect(StatusEffects.SharkGirl)) player.createStatusEffect(StatusEffects.SharkGirl, 0, 0, 0, 0);
	else if (flags[kFLAGS.ADULT_SHARKGIRL_OFFSPRINGS] >= 10 && player.hasVagina()) {
		spriteSelect(SpriteDb.s_sharkgirl);
		sharkFemaleBadEnd();
		return;
	}
	else if (player.statusEffectv1(StatusEffects.SharkGirl) >= 7 && player.totalCocks() > 0) {
		spriteSelect(SpriteDb.s_sharkgirl);
		sharkBadEnd();
		return;
	}
	//exploreLoc = 0 for lake, 1 for boat
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	//Rowboat
	if (exploreLoc == 1) {
		outputText("While rowing the boat across the lake you spy a shark fin heading your way.  Worried it might damage the small boat, you hastily row back to shore, jumping out of the boat.  The shark shows no signs of slowing, and the fin disappears just before coming ashore.  ");
	}
	//Lake
	else {
		outputText("You wander around the sandy shores of the lake before raising your eyebrow at a strange sight: A solitary fin, circling around in the water. You take a step back in surprise when the fin suddenly starts barrelling toward the shore at inhuman speeds.  ");
	}
	outputText("A grey blur bursts from the water and lands on the ground a few feet away from you.\n\n");
	outputText("It's a woman – a peculiarly corrupted woman, with shiny grey skin, silver hair, and a fin positioned between her shoulder blades. She's wearing some rather revealing black swimwear. The girl looks up at you and grins widely, showing rows of knife-like teeth. \"<i>Wanna play? Heads up though, I play 'rough'!</i>\"\n\n");
	unlockCodexEntry("Shark-girls & Tigershark-girls", kFLAGS.CODEX_ENTRY_SHARKGIRLS, false, true);
	if (rand(3) == 0){
		outputText("You're fighting a tiger shark girl!");
		startCombat(new TigerSharkGirl());
	}
	else{
		outputText("You're fighting a shark girl!");
		startCombat(new SharkGirl());
	}
	spriteSelect(SpriteDb.s_sharkgirl);
}



//Victory Sex. Herms should get a choice between the two scenes:
internal function sharkWinChoices():void {
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	
	if (flags[kFLAGS.SFW_MODE] > 0) {
		clearOutput();
		outputText("You smile in satisfaction as the " + monster.short + " collapses, unable to continue fighting.");
		combat.cleanupAfterCombat();
		return;
	}
	
	//HP Win
	if (monster.HP < 1) {
		outputText("The shark-girl falls, clearly defeated.");
	}
	//Lust win
	else {
		outputText("The shark-girl begins masturbating, giving up on dominating you.  The sight is truly entrancing.");
		dynStats("lus", 15);
	}
	
	menu();
	addDisabledButton(0, "Use Dick", "This scene requires you to have cock and sufficient arousal.");
	addDisabledButton(1, "Pussy Oral", "This scene requires you to have vagina and sufficient arousal.");
	addDisabledButton(2, "Dildo Rape", "This scene requires you to have the Deluxe Dildo.");
	
	if (player.lust >= 33) {
		if (!player.isGenderless())
			outputText("  Do you have your way with her or leave?");
		if (player.hasCock()) addButton(0, "Use Dick", sharkgirlDickFuck);
		if (player.hasVagina()) addButton(1, (player.isNaga() ? "Pussy Oral" : "Pussy w/69"), sharkgirlSixtyNine);
		if (player.hasKeyItem("Deluxe Dildo") >= 0) addButton(2, "Dildo Rape", sharkGirlGetsDildoed);
	}
	
	addButton(14, "Leave", combat.cleanupAfterCombat);
}

//Male and Herm: 
private function sharkgirlDickFuck():void {
	player.addStatusValue(StatusEffects.SharkGirl,1,1);
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	//Naga get a different version of this scene.
	if (player.isNaga()) {
		var x:Number = player.cockThatFits(monster.analCapacity());
		if (x < 0) x = player.smallestCockIndex();
		//[if (monster.lust >= monster.eMaxLust())
		if (monster.lust >= monster.maxLust()) outputText("You slither towards the furiously masturbating shark-girl. She lies on her back, desperately trying to relieve herself of her lust. She eyes you for a second, but her focus quickly returns to your own sex, moaning and sighing loudly. You admire the scene for a moment, but decide that she must be punished for her attempt to rape you.\n\n");
		else outputText("You slither towards the defeated shark-girl. She lies on her back, clearly weakened and in pain from the fight. You pity the poor girl for a moment, but you quickly remember that she just tried to rape you. Overcome by the need for revenge and the need to sate your lusts, you decide to punish her for her painful advances on you.\n\n");

		outputText("You grab the shark-girl by her hips and lift them up.  Before she can reach out to steady herself, you twist her around and thrust her front side into the ground.  She groans and makes a weak attempt to push herself back up, but her arms quickly give out under her weight and she falls back into the sand.  Your tail deftly snaps out and snatches the bikini she is wearing, and rips it off.  She looks back at you and gives an indignant \"<i>hmph</i>\" before laying her head back down, resigning herself to whatever fate you have planned for her.  Looking down at her pussy, you can see that it's grown moist with anticipation.  You have other plans for her, however, and you coil your tail around hers tightly and grab her hips in your hands.  She yelps in surprise as you lift her lower half up a bit, easily supporting her weight with your tail's considerable strength.  Her feet are still touching the ground, but her legs are not supporting her.  You lift her tail up a bit more, exposing her tight anus.  Your intentions dawn on her quickly, and you see her eyes begin to water.  \"<i>No,</i>\" she begs, \"<i>not like that...</i>\"  The tiniest of sobs escapes her, and you roll your eyes at the pitiful display.  You don't really want to see her cry, so you decide on something of a compromise.\n\n");

		outputText("Her soft crying ceases suspiciously quickly when you push her tail off to the side and uncoil your own, holding her in the same position with your arms. A bit annoyed that you let her manipulate you even after you defeated her, you are determined to take complete charge.  With a grunt you heft her up a bit, and bring the tip of your tail under her and up to her slick pussy.  You slide your scales up and down along her lips, coating your tail in her lubricant. You hear her voice her appreciation loudly, and see a wide smile come to her face.  Too wide, you think.  You continue your stroking as you pull her up, positioning her ass directly in front of your erect member. You quickly work your " + player.cockDescript(x) + " into her tight anus, and she turns back towards you, yelling in anger and surprise. Your tail quickly pulls away from her dripping pussy, and ignoring her protests, you turn it and thrust deep into her wide cunt.  Her shouting begins to lose coherency and devolves back into loud grunts and moans as pleasure starts to overtake her; her face contorts as she adjusts to the new feelings.  You slam into her ass again and again, thrusting your hips against her and pulling her back into you in a quickening rhythm, all the while pumping her widening pussy with your tail, pushing deeper into it each time, probing the sides with the thin tip.  Her ass is amazingly tight; clearly you are introducing her to something new.  By the look on her face, you can tell she's enjoying it much more than she thought she would.\n\n");

		outputText("You keep up the motion, pushing deeper into her with each thrust of your " + player.cockDescript(x) + " and tail.  The widening circumference of your tapered tail spreads her already loose vagina until you're sure it will gape when you pull out. You're amazed at how deep she is able to take you, but never more so than when your tail begins to bump against the ground through her belly.  Her moans grow louder beneath you, and you find that the pleasure building in your own " + player.cockDescript(x) + " is rapidly bringing you towards your own climax.  You thrust into her one final time and hold her ass against you, pushing your tail in as far as it will go.  As you fill her ass with your load of hot cum, you see her eyes roll back and her mouth open wide as she reaches orgasm.  She pushes back against you now, using her arms for leverage, before finally going limp beneath you.  When your member begins to soften, you pull it and your tail out of her, and leave her in a tired heap in the sand.  You think you notice a sly smile creep to her face as she looks back at you just before she blacks out.  You slither off, shaking your head at the thought of the slutty creature.");
	}
	//Non-nagaz
	else {
		outputText("You sneer at the fallen shark girl, making up your mind to have your way with her. You tear her bikini off as you whip out your " + player.cockDescript(0) + " and start to order, \"<i>Get to i--!</i>\" But you're cut short by the shark girl suddenly taking the entirety of your cock into her mouth, forcing it as deep into her mouth as possible. Quite a slutty creature, that's for sure. What surprises you more is that those sharp fangs of hers appear to be retractable, and she has a more human-like set hidden behind them.\n\n");
		//[if herm] 
		if (player.gender == 3) outputText("While sucking you off, her hand steadily snakes its way between your legs. Without warning, she shoves three fingers into your " + player.vaginaDescript(0) + ", pushing in and stretching the moist passage out.\n\n");
		outputText("You abruptly pull your cock from her mouth, causing the shark girl to gasp in surprise. She looks up at you, tears welling up in her eyes, \"<i>Please let me finish! I need this!</i>\" You smirk and order the shark girl onto her hands and knees. Her expression brightens and she obediently complies, getting down and raising her ass towards you. Taking a firm grip on her well-toned buttocks, you quickly shove your " + player.cockDescript(0) + " into her damp pussy and the shark girl squeals in excitement. You find yourself surprised by its texture; while it looks human enough on the outside, the inside is actually filled with strange feeler-like structures that wriggle and massage your cock as it pushes through.");
		//[if herm]
		if (player.gender == 3) outputText("  The sensation is incredible, and you find yourself massaging your " + player.biggestBreastSizeDescript() + " and tweaking your " + player.nippleDescript(0) + "s in an attempt to bring your pleasure to even greater heights.");
		outputText("\n\n");
	
		outputText("The shark girl cries out in orgasm, her pussy tightening as the feelers wrap around your cock. The pleasure drives you over the edge, and you pump your load of cum into her needy pussy, the feelers milking you for every drop you have. You pull out, satisfied, and as you turn to leave you see the shark girl rubbing cum into her cunt and winking at you.");
	}
	combat.cleanupAfterCombat();
	player.orgasm('Dick');
	dynStats("sen", -1);
	if (player.cor < 33) dynStats("cor", 1);
}

private function sharkgirlSixtyNine():void {
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	//Nagas don't actually get to 69!
	if (player.isNaga()) {
		outputText("The shark-girl reels and trips, falling onto her back.  You slide quickly towards her as she sits up, bringing a look of sheer terror to her face.  Clearly she is not accustomed to being 'prey' in any sense of the word.  You decide to change that.  Grabbing her by the shoulders, you push her back down a bit.  Clearly weakened by the fight, she goes limp in your hands, still scared and shaking ever so slightly with fear, but unable to resist.  You take a moment to admire the smooth curves of her body and meditate on how fine a catch you have before you.\n\n");

		outputText("The shark-girl begins to stir slightly under you, and you hear a slight annoyance with the delay beneath the obvious fear as she stammers out, \"<i>W-what are you waiting for?</i>\"  A smile nearly creeps to your face as you muse over her demanding attitude toward someone who just defeated her. Instead, you snap your head up and lock your gaze to her eyes, maintaining a fearsomely expressionless look.  She quickly winces back, clearly expecting something painful to come from you.  After a moment of being frozen in terror, she slowly turns her head back to you.  Her anger is more palpable this time as she says, \"<i>Well, get on with whatever it is you're doing!</i>\"  She opens her eyes, and looks to yours expectantly.  You enjoy the show of her face turning strangely from an expression of anger and fear to one of total confusion as her thoughts begin to cloud, draining as your hypnotizing gaze affects her mind.  She weakly begins, \"<i>Why... what are you...</i>\" but she's unable to complete her sentence or break your spell over her.  Her questions trail off quietly, and her face loses expression, but maintains a blank, slack-jawed stare back at you.  Her muscles relax and you see her limbs slowly go limp as her body seems to forget the situation it's in.\n\n");

		outputText("You lower her gently back down to the ground, keeping up your expressionless, insistent stare.  You slowly move your hand towards her breasts along her rough skin, and trace one of her nipples lightly with your outstretched finger.  Every bit of her face save for her empty eyes betray the lust building within her body, though she makes no move to relieve herself of it.  You lean down and grab her arm by the wrist, and are glad to see her eyes following yours on their own.  Placing her hand beneath her bikini on her own quickly slickening sex, you slip a few of her fingers inside and guide her hand into a slow rocking motion.  As you begin to speed up the pace, her body seems to take note and moves on its own.  You remove your hand, and she is very soon sighing and moaning with uninhibited pleasure.  You watch her as her masturbation grows less and less mechanical and her hand grows swifter.  Pleased to be the one to cause her vocalizations, you find your own hands parting the folds of your " + player.vaginaDescript(0) + ". You slowly slide up her side, your " + player.allBreastsDescript() + " rubbing against her body, stimulated by her rough skin.  Eventually your head is over and slightly behind hers, forcing her to tilt her own head back to maintain your mutual stare.  All the while, she has been pumping more and more of her hand into her loose cunt and moaning rather loudly.  This, along with her blank stare, makes for an odd but arousing sight.\n\n");

		outputText("You raise up from her and move your " + player.vaginaDescript(0) + " close to her face.  She doesn't appear to notice this or take the hint.  At first you are angered by her thoughtless insolence, but you then remember that you are the one bringing that about.  You point towards your vagina with one hand and reach close to her ear with the other.  As you snap your fingers, she immediately acts as you wish, pushing her face roughly into your crotch and rolling her eyes up in their sockets to maintain eye contact.  Her long tongue slips inside your " + player.vaginaDescript(0) + ", the sensation of it pushing far into your depths arousing you and making the pleasurable heat in your sex grow almost unbearable.  You reach behind her head and grind her face into you hard, muffling her moans, though they are soon replaced by your own.  You push her into you, thinking only of how deeply she is able to stimulate you and the pleasure the mindless shark-girl is bringing you.  You feel almost as though you are floating, and you want to stay like this forever, wishing the heat inside you would never stop building.  As you approach your climax, her moans into you grow louder, signaling hers.  The thought is too much and it pushes you over the edge; clenching the shark-girl's face into your " + player.vaginaDescript(0) + " you are drawn to orgasm as she is beneath you.  You cry out loudly and she gives a final grunt into your scaly tail.\n\n");

		outputText("Pleasure robbing you of thought, you look up, breaking your spell over the shark-girl.  Quickly realizing your mistake, you glance back down to see her paralyzed with confusion, apparently having been dropped back into her own body during her orgasm.  She doesn't dare to move a muscle, her hand still inside her bikini and her mouth still pressed to your " + player.vaginaDescript(0) + ".  You smile down at her, and she smiles a shier, more confused smile back at you for a moment before shaking her head and pulling her hand out.  You giggle as she struggles awkwardly to get out from beneath your coils.  She finally does, and begins to stagger back towards the water.  You head back to camp, feeling satisfied with the encounter.");
	}
	else {
		outputText("Making up your mind to rape the shark girl, you remove your " + player.armorName + " and approach the slut before taking a firm grip on her silver hair. \"<i>You know what to do, bitch,</i>\" you sneer, pulling her head into your damp cunt. The shark girl needs no encouragement, eagerly probing your pussy with her long tongue");
		//[if female] 
		if (player.gender == 2) outputText(", pulling out every few minutes to lick your " + player.clitDescript() + ".");
		//[if herm]
		if (player.gender == 3) outputText(". You remind her not to neglect your " + player.cockDescript(0) + ", and the shark girl responds by thoroughly licking your hard erection and sucking at your " + player.ballsDescriptLight() + ".");
		outputText("\n\n");
		outputText("You shove the shark girl down onto the ground and quickly plant your crotch on her face, ordering the shark girl to continue. She complies enthusiastically, licking with a greater intensity and clearly loving the sensation of being dominated. You have to admit, you are enjoying your role as master.\n\n");
		outputText("To reward your little slut for her efforts, your hand reaches back between her legs and slips under her skimpy black thong. You get to work fingering her moist cunt and you soon hear a series of muffled moans coming from beneath your legs. But she's smart enough to know not to stop licking, and you smirk at the effect you're having on the shark girl.  A cute little cry escapes from your little slave's mouth, and you pull your hand from her cunt before licking her sweet juices from your fingers. Shortly after, you cry out in orgasm");
		if (player.gender == 2) outputText(", juices spraying from your sex and coating the girl's face.");
		//[if herm]  
		else outputText(" and stand up, gripping your " + player.cockDescript(0) + " and splattering thick jets of cum onto her face.");
		outputText("  The shark slut licks up your fluids hungrily.\n\n");
	
		outputText("Thoroughly satisfied, you leave the shark girl on the ground covered in your fluids and depart for your camp.");
	}
	combat.cleanupAfterCombat();
	player.orgasm('Lips');
	dynStats("sen", -1);
	if (player.cor < 33) dynStats("cor", 1);
}

//RAEP SOME FUKKIN SHARKGIRLZ NIGGA WITH DILDO!
public function sharkGirlGetsDildoed():void {
	clearOutput();
	outputText("You grin from ear to ear, revealing enough teeth to make even the defeated shark-girl shiver.  Advancing upon the prone monster-woman, you ");
	if (player.weaponName != "fists") outputText("put away your " + player.weaponName + " and ");
	outputText("draw out a glistening pink dildo from your pouches, as if it were a weapon.   She looks up at you, at once knowing your intent.  ");
	if (monster.lust >= monster.maxLust()) outputText("Her legs spread invitingly wide and she tears off her bikini bottom in a lusty frenzy.  You hold the dildo over her and give it a tiny squeeze, wringing out a few drops of pink fluid from the special dildo.  They land on her exposed cunt and in seconds she's writhing underneath you, humping the air.");
	else outputText("She holds her legs together defiantly, but you pry them open, tear off her bikini bottom and expose her bald nether-lips.   You hold the dildo over her and squeeze, squirting a gush of pink fluid onto her exposed cunt.  The effect is immediate, and in moments she's humping the air and wet with her own fluids.");
	outputText("\n\n");
	
	outputText("'<i>What a wonderful toy</i>,' you muse as you kneel between your ");
	if (player.cor > 50) outputText("latest ");
	outputText("victim's legs, inhaling her scent.  It smells surprisingly salty, reminding you of the sea.   Sand-papery skin brushes against your ankle.  You don't even have to look down to recognize the feeling of her tail curling around your leg and thigh.  Before she can use it to her advantage, you gently part her outer folds with one hand and insert the artificial member with the other.  The shark-girl's tail immediately drops away as her body shivers and relaxes, barely managing a few twitches.\n\n");
	
	outputText("The sea-smell from her groin intensifies and you feel the dildo bloat up in your hand.  She's orgasmed already!\n\n");
	
	outputText("You slap her left ass-cheek hard, the rough texture of her skin giving the perfect *crack* of skin on skin as you scold her, \"<i>You're not supposed to cum so hard!  Now you're really going to get stretched, skank!</i>\"\n\n");
	
	outputText("The aquatic monster-woman whimpers, feeling herself getting stretched wider and wider by the growing toy.   Intent on punishing her for trying to rape you AND for cumming too soon, you grab the dildo in a double-handed grip and force it in to the hilt.   Her tail flops and thrashes as the dildo sinks in until you bottom out.  She flops about like a dying fish, though perhaps the only thing about her 'dying' is a few brain cells from the bliss her cunny's feeling.  Satisfied with the degree of penetration, you grab it around the base and yank back on it, struggling with how tightly it's lodged in her cunt.\n\n");
	
	outputText("You wiggle it back and forth, working it partway out before ramming it back in.  Moaning and rocking underneath you, the shark-girl's eyes cross as she tries to fuck your hands.  Both her hands climb up under the thin black fabric of her top and wrap around her modest breasts, squeezing and caressing them.  She gasps when her fingers find her nipples, and starts drooling down her chin.\n\n");
	outputText("Her salty pussy clamps down hard, but the slick juices pouring from her hole makes it easier and easier to work the bloated sex-toy in and out of her love-hole.   Tired of the slut's moans and gasps of pleasure, you decide to finish her off.   You pull the dildo out, and let out a gasp of surprise when her twitching cunt gapes open obscenely, allowing you to see the entire depth of her love-tunnel, all the way to her cervix.   She groans at the sudden loss of sensation, but before she has a chance to jam a finger into her needy hole, you squeeze the perverted toy HARD, wringing a thick gush of pinkish fluid directly into her baby-maker.\n\n");
	
	outputText("You plunge the jiggling sex-toy back into her stretched cunt, pistoning the fluid directly into her womb and setting off an orgiastic cry with enough volume to make you cringe.  She trembles madly and you have to sit down on her tail to keep the tip of it from cracking you upside your head.  The dildo in your hands puffs up wider and wider until it pops itself out, exposing the pink-coated inner flesh of the shark-woman's cunt.  You can watch the muscles rippling and squeezing, though thanks to her stretching, you don't think she'll be able to squeeze anything smaller than a minotaur.  After a few more seconds her body goes still, save for the occasional twitch, and you realize she's passed out.\n\n");
	
	outputText("Damn that was hot!  You'll need to sate yourself once you get back to camp for sure.  Maybe you should give this dildo a whirl?  It still smells of your victim.");
	
	dynStats("lus", (20 + player.lib / 5 + player.cor / 10));
	combat.cleanupAfterCombat();
}

//Shark girl Bad End.
//Requirements: Have vaginal sex with 7 Shark girls in one day (Loss rape for males also counts toward this)
//Scene triggers automatically after the seventh Shark girl
private function sharkBadEnd():void {
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	outputText("Several weeks pass by and you once again find yourself at the lake, your loins aching for another shark girl to swim by. Just thinking of their incredible sexual organs and the sense of domination you get from them makes you feel aroused. Sadly though, there's no sign of one, so you instead decide to take a nap.\n\n");
	outputText("You're awoken a short time later by something warm wriggling around inside your mouth. Your eyes pop open, worried that you might've swallowed a bug or something. However, when your vision swims back into focus, you become quite aware that it is actually someone's tongue probing around your mouth. It seems to be a young shark girl in her early teens, judging by her modest measurements and short stature. She pulls her head back and grins at you before exclaiming, \"<i>Hi, daddy!</i>\" You raise an eyebrow at that. Then you turn and you see several more teenage shark girls, each pinning your arms and legs down.\n\n");
	outputText("They are surprisingly strong given their stature, and even a Minotaur would have trouble prying them all off. Combined with a strong wave of arousal flooding your body, you find it rather hard to focus on anything. They must've funnelled a few Lust Drafts down your throat while you were sleeping.\n\n");
	outputText("\"<i>Wh-what's going on?</i>\" you ask, your voice shifting between arousal and fear. The young girl straddling your chest giggles while drawing circles on your skin with her finger, \"<i>Aw daddy, don't be scared. You're gonna play with your kids! Doesn't that sound fun?</i>\" Another adds, \"<i>Since you seem to love knocking up us shark girls, we figured you'd like to make a living out of it...</i>\" Your eyes widen slightly and you ask her, \"<i>What do you mean by that?</i>\"\n\n");

	outputText("The girls look at each other and grin before the one straddling you pulls out an odd-looking Shark's Tooth. \"<i>Oh you'll see. Open wide...!</i>\"\n\n");
	outputText("<b>Do you let the shark-girl put the odd-looking tooth into your mouth? You suspect it might end your adventures...</b>");
	doYesNo(sharkBadEnd2, rejectSharkBadEnd);
}

//[Next]
private function sharkBadEnd2():void {
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	outputText("Several months and mutations later...\n\n");
	outputText("You plunge your cock into yet another shark girl, the third one in the past hour, and finger two others at the same time. You've been fucking without stop for weeks now. Ever since you were morphed into a shark man, sex is almost the only thing you can think about. At one point you recalled that you had a name, and you vaguely remember having to do something important... Not as important as this, though. Not as important as breeding your harem.\n\n");
	outputText("\"<i>My, he's... certainly a virile creature, isn't he?</i>\" a tiger shark asks, taking a seat on a nearby rock. Another shark girl chuckles in response, \"<i>Oh I know. Our numbers have practically doubled because of him.</i>\" She gestures to several heavily pregnant shark girls lazing on the sands, caressing their bumps happily.\n\n");
	outputText("\"<i>Wow. When I heard rumors of your pack getting a new male, I had to check it out for myself. But I didn't think he'd be anything like this...</i>\" the tiger shark says, rubbing her own genitalia. You blow your load inside the shark girl before pausing a moment to catch your breath, your quad of cantaloupe-sized balls churning with more cum. You look up, ready to start on another girl, and catch sight of a human moving across the shoreline. A grin spreads across your face at the sight and you direct the girls' attention to the lone human.\n\n");
	outputText("\"<i>Fresh meat!</i>\"");
	getGame().gameOver();
}

private function rejectSharkBadEnd():void {
	clearOutput();
	outputText("A thought flares up in your mind and you scowl at the shark-girls before you shove the shark-girl as hard as you can before making a dash for safety! One of the shark-girls begins to sniffle and contemplates what's with the sudden rejection.\n\n");
	outputText("The last you hear is a series of indistinct shouts before fading with the growing distance. Crisis averted!");
	player.addStatusValue(StatusEffects.SharkGirl, 1, -1);
	doNext(camp.returnToCampUseOneHour);
}

//Shark girl Bad End.
//Requirements: Give birth to 7 shark girls that aren't Izma's 
//Scene triggers automatically after the seventh Shark girl
private function sharkFemaleBadEnd():void {
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	outputText("Several weeks pass by and you once again find yourself at the lake, your loins aching for another tiger shark girl to swim by. Just thinking of their incredible sexual organs and the sense of domination you get from them makes you feel aroused. Sadly though, there's no sign of one, so you instead decide to take a nap.\n\n");
	outputText("You're awoken a short time later by something warm wriggling around inside your mouth. Your eyes pop open, worried that you might've swallowed a bug or something. However, when your vision swims back into focus, you become quite aware that it is actually someone's tongue probing around your mouth. It seems to be a young shark girl in her early teens, judging by her modest measurements and short stature. She pulls her head back and grins at you before exclaiming, \"<i>Hi, mommy!</i>\" You raise an eyebrow at that. Then you turn and you see several more teenage shark girls, each pinning your arms and legs down.\n\n");
	outputText("They are surprisingly strong given their stature, and even a Minotaur would have trouble prying them all off. Combined with a strong wave of arousal flooding your body, you find it rather hard to focus on anything. They must've funnelled a few Lust Drafts down your throat while you were sleeping.\n\n");
	outputText("\"<i>Wh-what's going on?</i>\" you ask, your voice shifting between arousal and fear. The young girl straddling your chest giggles while drawing circles on your skin with her finger, \"<i>Aw don't be scared. You're gonna play with your kids! Doesn't that sound fun?</i>\" Another adds, \"<i>Since you seem to love getting knocked up by us shark girls, we figured you'd like to make a living out of it...</i>\" Your eyes widen slightly and you ask her, \"<i>What do you mean by that?</i>\"\n\n");
	outputText("The girls look at each other and grin before the one straddling you pulls out an odd-looking Shark's Tooth. \"<i>Oh you'll see. Open wide...!</i>\"");
	doNext(sharkFemaleBadEnd2);
}

//[Next]
private function sharkFemaleBadEnd2():void {
	clearOutput();
	spriteSelect(SpriteDb.s_sharkgirl);
	outputText("Several months and mutations later...\n\n");
	outputText("Yet another cock plunges into your gaping pussy, the third shark girl to do so in the past hour, as another fingers your asshole while waiting for her turn. You're barely able to keep track of who went in where as your huge belly, swimming with another brood, impedes your vision.  You've been fucking without stop for weeks now and pregnancy doesn't seem to deter these girls in the slightest. Ever since you were morphed into a shark brood-mother, sex is almost the only thing you're allowed to do. At one point you recalled that you had a name, and you vaguely remember having to do something important... Not as important as this, though. Not as important as being bred.\n\n");
	outputText("\"<i>My, she's... certainly a fertile creature, isn't she?</i>\" a tiger shark asks, taking a seat on a nearby rock. Another shark girl chuckles in response, \"<i>Oh I know. Our numbers have practically doubled because of her.</i>\" She gestures to several new shark girls lazing on the sands.\n\n");
	outputText("\"<i>Wow. When I heard rumors of your pack getting a new brood-mother, I had to check it out for myself. But I didn't think she'd be anything like this...</i>\" the tiger shark says, rubbing her own genitalia. Another tiger shark girl blows her load inside your already cum-filled pussy displacing gluts of her other sister's cum.  You pause a moment to catch your breath, your heavy brood-gut churning with a whole litter of your progeny.\n\n"); 
	
	outputText("\"<i>How can she do it?</i>\" the tiger shark inquires, her hardening cock an obvious sign of arousal. The other shark girl, nonchalantly playing with her own junk, replies, \"<i>She's a goddess.  Or at least has the power of one.</i>\"  The tiger shark remains silent, but looks puzzled, \"<i>She has a gift</i>\" the other shark girl continues, a wicked grin capturing her face, \"<i>The more she's bred the faster she gives birth.  Getting her pregnant is just the start of it.</i>\"");  
	
	outputText("\n\nThe tiger shark girl looks surprised, but the realization quickly morphs her expression into a devilish smile of her own.  Rising from her seat she begins sauntering toward you, \"<i> Well I guess I'd better do my part.</i>\".\n\n");
	("You look up just as the tiger shark's cock plunges into your cum-sloppy pussy, motherly tits and pregnant gut swaying pendulously with each thrust into you. You catch sight of a human moving across the shoreline. A grin spreads across your face at the sight and you direct the girls' attention to the lone human.\n\n");
	outputText("\"<i>Fresh meat!</i>\"");
	getGame().gameOver();
}

//PC gives birth (alone): used if PC gets pregnant from vaginal and refusing herbs before recruiting Izma or possibly later if a way to force her out is written
public function pcPopsOutASharkTot():void {
	outputText("\n");
	//If Izma is NOT a follower
	if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] != 1) {
		if (player.vaginas.length == 0) {
			outputText("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  You look down and behold a vagina.  ");
			player.createVagina();
		}
		outputText("You crumple suddenly; strong pains and pressures pulverize the nerves in your gut.  As your eyes shoot wide open, you look down to see your belly absurdly full and distended.  You can feel movement underneath the skin, and watch as its bulges and shifts reflect another living being moving independently inside you.  Instinctively, you spread your legs as you feel the creature press outward, parting your cervix and allowing a gush of water to spill forth - far more water than you thought you were holding.\n\n");
 
		outputText("You cry out as the first wrenching labor pain begins in earnest, unthinkingly hoping for somebody to come and help you.  Much to your despair, no one does, leaving you alone to deliver the baby.  You double your focus, set on pushing in time with its own frantic attempts to escape.  Squeezing over and over, you try to force out the child before the pain robs you of consciousness; luckily it seems to oblige, sliding out of you legs-first after a few more pushes.  The shark-skin rasps your inflamed pussy, drawing gasps of shock from you as she squeezes past your lips in fits and starts.");
		player.cuntChange(100,true,true,false);
		outputText("\n\n");

		outputText("Finally, she's out; you quiver weakly as she crawls over to you and it takes all your effort to lift your " + player.armorName + " and expose your " + player.nippleDescript(0) + "s to her.  As she sucks greedily at them, the haze begins to clear from your vision.  For the first time, you can actually make out distinct features on your new daughter; she's a ");
		if (rand(100) <= 59) {
			outputText("shark-girl");
		}
		else outputText("tigershark");
		outputText(", quickly growing and filling out as she takes in milk.  She finishes up, looking rather like a pre-teen already, and glances around nervously.  The amniotic fluid is evaporating rapidly, and she's scratching idly at her gills as more and more of her skin is exposed directly to the dry air.\n\n");

		outputText("As she turns scared eyes on you, a spark of understanding lances through the fog of pain.  You look around, getting your bearings within the camp, and then, using a limp arm, point in the direction of the stream.  Her face lights with understanding and gratitude, and she leans forward and places her head over your heart, to listen to it one last time.  You let the arm down, draping it over her, intent on making this one moment of love and affection last as long as possible before she's dumped into the inferno of shark-girl society.  The two of you remain like that for almost five minutes before she gives a small cough.  Lifting your arm gingerly, she kisses you on the cheek and takes off for the vital waterway.\n\n");

		outputText("After making a quiet wish for your child, you slip into a doze.\n");
		//(Take some fucking melancholy. TAKE IT. -Z)
	}
	else {
		spriteSelect(SpriteDb.s_izma);
		//Player Gives Birth (Izma in camp): (For the reason given above, this scene currently has a very high chance of being useless, so I wouldn't waste time on it yet. Also, it's a bit of a turd. Orgasm despite the pain of childbirth exists but the clumsy handling here wouldn't convince you even if you'd already seen it live. Oh, the pain is so intense I can't walk... but wait, she's touching my junk over and over in a vague manner so it becomes pretty great. Thank you, Shark Herm Jesus! I advise cutting the 'sexual' content and keeping a normal childbirth unless you want it rewritten from the foundations. But you've got time to decide. -Z)
		outputText("You wake up suddenly to strong pains and pressures in your gut.  As your eyes shoot wide open, you look down to see your belly absurdly full and distended.  ");
		if (player.vaginas.length == 0) {
			outputText("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  You look down and behold a vagina.  ");
			player.createVagina();
		}
		outputText("You can feel movement underneath the skin, and watch as it bulges and shifts as another living being moves independently inside you.  Instinctively, you spread your legs as you feel the creature press outward, parting your cervix and allowing a gush of water to spill forth - far more water than you thought you were holding.\n\n");
 
		outputText("You cry out as the first wrenching labor pain begins in earnest, unthinkingly hoping for somebody to come and help you.  To your relief, Izma comes running over to you from out of the gloom.  \"<i>" + player.short + "!  You've gone into labor?</i>\" she asks; something of a stupid question, but she's evidently as off-guard as you are.\n\n");
 
		outputText("\"<i>Do you think you can walk?  Make it to the stream?</i>\" she asks.\n\n");
 
		outputText("You throw her a dirty look, and make it quite emphatically clear that with how strong these contractions are, you don't think you could stand, never mind walk that way.\n\n");
 
		outputText("\"<i>Right, sorry.</i>\" She has the courtesy to look chagrined, at least.\n\n");
 
		outputText("She unhesitatingly steps up and kneels before you, one hand reaching out to stroke your swollen orb of a belly, the other trailing around the edges of your " + player.vaginaDescript(0) + " in a manner at once sensual and professional. \"<i>Don't worry, " + player.short + "; I'm going to help you get through this.</i>\" The tigershark promises you.\n\n");
 
		outputText("You point out it's the least she can do, seeing as how she's the one who put this thing in you in the first place, then turn your attention back fully to the task of bringing your offspring into the world.\n\n");
 
		outputText("Time slips away; you're too overwhelmed by the pain of your womb contracting and the pleasure as Izma ministers to your " + player.vaginaDescript());
		if (player.hasCock()) outputText(" and " + player.multiCockDescriptLight());
		outputText(", which makes the birth pangs become less painful and more orgasmic. You lose yourself in the haze to the point you're barely aware when the birth finally comes to an end; you feel a great pressure welling up inside you, an overwhelming urge to push, and then, the next thing you know, relief washes over you as your stomach deflates.");
		player.cuntChange(100,true,true,false);
		outputText("\n\n");
 
		outputText("\"<i>We've got her, " + player.short + "! Whoa- hold still, you slippery little girl! Stop wriggling so much, you're out now, it's me, your daddy!</i>\" Izma cries out. As you regain your strength and your vision clears, you are presented with the sight of Izma trying desperately to wrangle a squirming baby shark-morph; from her ");
		var type:Number = 0;
		if (rand(100) <= 59) {
			outputText("grey");
			type = 0;
			flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS]++;
		}
		else {
			outputText("black-striped orange");
			type = 1;
			flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS]++;
		}
		outputText(" skin, it's obvious she's a baby ");
		if (type == 0) outputText("shark-girl");
		else outputText("tigershark");
		outputText(". Finally, she calms down in her \"<i>daddy's</i>\" arms, looking around with surprising alacrity for a newborn. She sees you and holds her arms out, making strange babbling noises; she has no teeth at all, from what you can see. Izma walks over to you, smiling proudly, and lets you hold your new baby girl, who nuzzles against you and then immediately turns her attention towards your milky breasts.\n\n");
 
		outputText("She latches onto the " + player.nippleDescript(0) + " and starts to suckle for all she's worth, waves of pleasure both sexual and maternal filling you, overwhelming you with bliss. Oblivious to everything else, you hold her against your breast, allowing her to sate her incredible appetite. She drinks your breast dry, and then immediately latches onto the next one.");
		if (player.breastRows.length > 1) outputText("  She then starts on your third breast, and while she slows down at the fourth breast, she still finishes it off.");
		//(If player has six breasts: 
		if (player.breastRows.length > 2) outputText("  She seems to almost be struggling to finish off your third pair, but she manages to suck all six of your breasts dry.");
		outputText("  Once she is done, she lets go with a wet popping sound, then starts to gasp for breath before letting out a surprisingly loud, deep belch for such a little thing.\n\n");
 
		outputText("...Okay, maybe not so little. Before, she was the size of a human baby. Now, you're holding a fairly grown young ");
		if (type == 0) outputText("shark-girl");
		else outputText("tigershark");
		outputText("; physically, you'd have to say she was anywhere from ten to thirteen years old. She grins at you, displaying both rows of teeth, and then kisses you on the lips. \"<i>Mama.</i>\" She states, clearly and contentedly, then visibly relaxes, nuzzling into your arms and closing her eyes, clearly intent on drifting off to sleep.\n\n");
 
		outputText("You look up at the tigershark who fathered her for support, but she just smiles and flops down beside you as well. With a soft sigh, you simply lay back and enjoy your strange new family being there with you. When you wake in the morning, Izma will have taken your daughter to stay at the stream with her; it's important for young shark-folk to be moist, constantly.\n");
		player.orgasm('Vaginal');
		dynStats("lib", 1, "sen", 1);
	}
	player.boostLactation(.01);
}

/*-------------------------
Shark's Tooth

Item description: A glinting white tooth, very sharp and intimidating.

You have no idea why, but you decide to eat the pointed tooth. To your surprise, it's actually quite brittle, turning into a fishy-tasting dust. You figure it must just be a tablet made to look like a shark's tooth.

Transformations:

You firmly grasp your mouth, an intense pain racking your mouth. Your gums shift around and the bones in your jaw reset. You blink a few times wondering what just happened. You move over to a puddle to catch sight of your reflection, and you are thoroughly surprised by what you see. A set of retractable shark fangs have grown in front of your normal teeth. They even scare you a little. (Adds the 'Bite' special attack)

Attack descript: You open your mouth wide, your shark teeth extending out. Snarling with hunger, you lunge at your opponent, set to bite into right them! (Similar to the bow attack, high damage but it raises your fatigue).
+

Jets of pain shoot down your spine, causing you to gasp in surprise and fall to your hands and knees. Feeling a bulging at the end of your back, you lower your \" + armorName + \"  down just in time for a fully formed shark tail to burst through. You swish it around a few times, surprised by how flexible it is. After some modifications to your clothing, you're ready to go with your brand new shark tail.
+

You feel a tingling in your scalp and reach up to your head to investigate. To your surprise, your hair color has changed into a silvery color, just like that of a shark girl!
+

You abruptly stop moving and gasp sharply as a shudder goes up your entire frame. Your skin begins to shift and morph, growing slightly thicker and changing into a shiny grey color. Your skin now feels oddly rough too, comparable to that of a marine mammal. You smile and run your hands across your new shark skin.
+

You groan and slump down in pain, almost instantly regretting eating the tooth. You start sweating profusely and panting loudly, feeling the space between your shoulder blades shifting about. You hastily remove your \" + armorName +   just in time before a strange fin-like structure bursts from in-between your shoulders. You examine it carefully and make a few modifications to your \" + armorName +   to accommodate your new fin.
--------------------------

Stat effects:

Increase strength 1-2 points (Up to 50)
Increase toughness 2-4 points (Up to 100)
Increase Speed 1-3 points (Up to 100)
Reduce sensitivity 1-3 Points (Down to 25 points)
Increase Libido 2-4 points (Up to 75 points)
Decrease intellect 1-3 points (Down to 40 points)
---------------------------
Slutty Swimwear

Item description: An impossibly skimpy black bikini. You feel dirty just looking at it... and a little aroused, actually.

armorDef: 0
armorPerk: Greatly increases effectiveness of 'Tease' ability.
armorValue: 25 gems

Putting it on: (Lust increases)

[flat-chested]  You feel rather stupid putting the top part on like this, but you're willing to bear with it. It could certainly be good for distracting. [/]  

[breasts]  The bikini top clings tightly to your bustline, sending a shiver of pleasure through your body. It serves to turn you on quite nicely. [/]  

[no dick]  The thong moves over your smooth groin, clinging onto your buttocks nicely. [If player has balls] However, your testicles do serve as an area of discomfort, stretching the material despite their normal size. [/] [/]  

[dick]  You grunt in discomfort, your cock flopping free from the thong's confines. The tight material rubbing against your dick does manage to turn you on slightly. [/]  

[If dick is 7+ inches OR balls are apple-sized] You do your best to put the thong on, and while the material is very stretchy, it's simply far too uncomfortable to even try. Maybe if you shrunk your male parts down a little... [/]  
-------------------------------*/
//Loss Rape scenes:
	internal function sharkLossRape():void {
		if (flags[kFLAGS.SFW_MODE] > 0) {
			doSFWloss();
			combat.cleanupAfterCombat();
			return;
		}
		clearOutput();
		spriteSelect(SpriteDb.s_sharkgirl);
		//Tiger Shark Girl
		if (monster.hasCock()){
				//Genderless:
			if (player.gender == 0) {
			outputText("You slump down in defeat, too ");
			if (player.HP < 1) outputText("hurt ");
			else outputText("horny ");
			outputText("to fight on.\n\n");
			outputText("The shark girl does a little victory dance, swaying her hips to and fro before moving over to you. She quickly removes your " + player.armorName + ", but her smile fades to a blank expression when she notices you lack any genitalia. \"<i>What the...</i>\" she mumbles, poking you in the groin. Finding you completely useless, she growls in frustration and stomps on your face in anger. The sudden pain makes you pass out.");
			combat.cleanupAfterCombat();
			dynStats("tou", -2);
			return;
			}

			//Female:
			if (player.hasVagina() && (player.totalCocks() == 0 || rand(2) == 0)) {

			outputText("You slump down in defeat, too ");
			//[defeat via HP] 
			if (player.HP < 1) outputText("hurt ");
			else outputText("horny ");
			outputText("to fight on.\n\n");
		
			outputText("The shark girl giggles and moves over to you, tugging at your " + player.armorName + "  impatiently. Her tail swishes around and smacks your " + player.assDescript() + ". \"<i>You're gonna make me very happy, you hear? Otherwise...</i>\" she opens her mouth wide and you see her fangs glinting menacingly in the light. You gulp hard and nod, bringing a smile from the shark girl.\n\n"); 
			outputText("Wasting no time, she removes her grass skirt and skimpy swimwear and your own gear.  ");

			outputText("Her gaze drifts over to your " + player.vaginaDescript(0) + " ");
			
			if (player.isVisiblyPregnant()){
				outputText("and then up across the mound that is your pregnant belly.  \"<i> I guess someone else got to you first ! </i>\" she says smirking slyly. \"<i> Tell you what dear, I was going to put a pup in your belly, but let's not let this opportunity go to waste. </i>\"\n\n ");
			}
			else{
				outputText("and she licks her lips in delight.  \"<i> Now that's what I'm looking for ! I can smell it from here, your body is aching to get pupped, don't worry, I know will enjoy this too. </i>\"\n\n");
		
			}
			
			outputText("She roughly grabs you by the hair and pulls your face into her pre-leaking cock, your tongue instantly flattening under the shaft as her cock parts your lips, burying the first half into your throat. \"<i>Mmm... don't you dare stop sucking you dumb bitch, if you know what's good for you,</i>\" she orders. You reply by thoating more of the fish dick. You're a little ashamed to admit it, but her dominant command makes you feel rather hot and bothered.\n\n");
			outputText("Now fully erect, The tiger shark girl eventually sighs happily and relaxes her grip on your hair, pulling your head off her cock; a viscous strand of spit trailing from its tip to your mouth.")
			
			outputText("\"<i>Not bad bitch, not bad.</i>\" She chides, \"<i>Now " + ((player.isVisiblyPregnant()) ? "roll over" : "get on your back") + ".</i>\"  "); 
			
			outputText("You obey your mistress's command and " + ((player.isVisiblyPregnant()) ? "roll over on to your belly instinctively presenting your ass" : "flop onto your back") + ". A sense of joy takes over as " + ((player.isVisiblyPregnant()) ? "you feel several spurts of hot pre-cum splatter your " + player.assDescript() + " and trickle down your crack before the shark-girl's massive cock nestles across your back" : "she positions herself between your legs and props her bulging cock on to your tummy that reaches past your navel, foreshadowing the depths she will go.  Almost as if it has a mind of its own, the thick cock palpitates squeezing out ropes of pre-cum above her throbbing ball-sack housing two pair of balls") + ".\n\n");  
			
			outputText("The tiger shark girl grips her cock and begins slapping it against your [if(isPregnant = true)ass][if(isPregnant = false)pussy] and the cum-puddle that has collected there flinging pre in all directions.  In an instant, she plunges three fingers into your [if(isPregnant = true)" + player.assholeDescript() + "][if(isPregnant = false)" + player.vaginaDescript(0) + "] causing you to gasp at the sudden intrusion.  The rough finger-fucking causes loud slurping noises as air and pre-cum is being forced in out of your orifice only heightening your arousal.  Several minutes pass before she removes her fingers and with a taunting smirk, asks rehtorically \"<i>Are you ready?</i>\"  Stiffling a building orgasm, you are unable to reply let alone fully grasp the chain of events when suddenly the tiger shark girl presses her cockhead to your gaping " + ((player.isVisiblyPregnant()) ? "asshole and pops it in" : "pussy and slams her shaft a quarter of the way in") + ".  You can only pathetically yelp as the fish meat begins to force it's way through your insides.  On cue, the shark girl cock begins vehemently spewing pre-cum with each thrust, quickly cumlubing your " + ((player.isVisiblyPregnant()) ? "guts" : "birth canal") + ".  The shark girl grunts as her short, rapid thursts penetrate your depths inch by inch until she finally bottoms out, the tip of her cock [if(isPregnant = true)embedded deep in your bowels][if(isPregnant = false)kissing your cervix].  Fully impaled - you can only gasp for breath as the shark girl begins to withdraw her cock, now lubed and no longer impeded by your tightness, she begins relentlessly pounding you in long strokes.  Each thrust of her cock parting your [if(isPregnant = true)" + player.assholeDescript() + "][if(isPregnant = false)" + player.vaginaDescript(0) + "].\n\n"); 
			
			outputText("The shark girl quickens her pace as she continues to pump you in earnest.  Like a bushel of ripes tomatoes on the vine, her four swollen testicles slap wildly against your [if(isPregnant = true)pussy][if(isPregnant = false)asshole] with the momentum of each thrust.  Now too panting, the shark girl slows her pummeling just for a moment to regrip your " + player.hipDescript() + " and exclaiming, \"<i>Time to get bred !</i>\"  \n\n");
			
			if (player.isVisiblyPregnant()){
				outputText(images.showImage("tiger-shark-female-loss-preg"));
				outputText("From kneeling behind you, the shark girl steps out and over you to each side, cock still implanted firmly in your asshole, tugging your lower body further into the air and pushing your face into the sand.  Standing in a squat position vertically over you, the shark girl digs her fingers into your hips and drops her weight and power into your back door.  Slamming her cockmeat back and forth, the power sends shockwaves through your whole body.  Your pregnant belly and tits ripple with each thrust as she jackhammers you from above.  Your vision blurs as you begin to drool from the immense pressure and pain splitting your insides.  The hanging four-balled sack whacks into your pussy with wet slaps alerting anything nearby to the intense mating.  ")
			}
			else{
				outputText(images.showImage("tiger-shark-female-loss"));
				outputText("From kneeling between your legs, the shark girl leans up and over you pulling your legs to each side of her shoulders. Cock still implanted firmly in your pussy, it tugs your lower body into the air and up over our face.  Standing in a squat position vertically over you, the shark girl digs her fingers into your hips and drops her weight and power into your opening.  Slamming her cockmeat back and forth, the power sends shockwaves through your whole body.  Your tits ripple with each thrust as she jackhammers you from above.  Your vision blurs as you begin to drool from the immense pressure and pain splitting your insides.  The hanging four-balled sack whacks into your asshole with wet slaps alerting anything nearby to the intense mating.  ")
			}
			
			outputText("\n\nHer ravenous, rutting pace quickens yet further sending waves of pleasure to splash over you, the pain being replaced completely.  Dazed, but aware, you quickly feel the tightness inside gripping her cock strain as the throbbing cock seems to thicken even more.  Her labored breathing turns to ragged gasps as she cries out, \" <i>Here it comesssss !!!</i> \"; a torrent of molten, virile seed explodes inside you quickly overfilling your " + ((player.isVisiblyPregnant()) ? "bowels" : "vagina and womb") + ".  The thick cock sealing your entrance forces your belly to inflate from the sheer volume of cum.\n\n");
			outputText("Minutes pass before the shark cock stops pumping and begins to deflate.  By this time, however, you" + ((player.isVisiblyPregnant()) ? "r already pregnant belly has bloated to an absurd degree" : " look positively pregnant") + ".  When she finally withdraws her cock, a glut of shark girl cum flows steadily from your now vacated, gaping orifice. \n\n");
			outputText("The shark girl stands to leave and winks at you before diving back into the water. You eventually pass out from the exertion.");
			//(Corruption +2, Intelligence -4)
			if(player.isVisiblyPregnant())player.orgasm('Anal');
			else player.orgasm('Vaginal');
			player.knockUp(PregnancyStore.PREGNANCY_SHARK_GIRL, PregnancyStore.INCUBATION_SHARK_GIRL);
			if (player.cor < 30) dynStats("cor", 1);
			combat.cleanupAfterCombat();
			return;
		}
				//[if herm]
			if (player.gender == 3) {
				outputText("Seeing your " + player.cockDescript(0) + " puts a smile on the shark girl's face as she takes a firm grip on your erection. \"<i>Well, you're just full of surprises, aren't you? Maybe I'll give this bad boy a whirl sometime. For now though...</i>\"  ");
				outputText("Her gaze drifts over to your " + player.vaginaDescript(0) + " and she licks her lips in delight. \"<i>Now that's what I'm looking for! Tell you what dear, you get me wet and I might just give you some pleasure too.</i>\"\n\n");
				outputText("You feel the shark girl's bare foot press against your chest and she roughly pushes you onto your back. \"<i>Oh man, I can't even remember the last time I had an actual man...</i>\" the shark girl says, pulling your pants down to your ankles. Seeing your stiff erection, your opponent smirks and wets her lips before taking your entire " + player.cockDescript(0) + " into her mouth. The feeling is heavenly, her long tongue slithering around your shaft.\n\n");
				outputText("But before you can begin to really enjoy it, she pulls her head away, visible strands of saliva still linking her mouth and your " + player.cockDescript(0) + ". The shark girl quickly maneuvers herself so that she's straddling your cock and presses herself down, the two of you gasping sharply from the sensation. \"<i>Hmm, good boy... You make me cum first, and I won't bite you. Deal?</i>\" You nod, though given that peculiar feelers inside her cunt are massaging your cock, you don't know how long you can really hold out.\n\n");
		
				outputText("She roughly grabs you by the hair and pulls your face into her drooling cunt, your tongue instinctively probing into her. \"<i>Mmm... don't you dare stop licking you dumb bitch, if you know what's good for you,</i>\" she orders. You reply by speeding up your tongue work. You're a little ashamed to admit it, but her dominant command makes you feel rather hot and bothered.\n\n");
				outputText("The shark girl eventually sighs happily and relaxes her grip on your hair, pulling your head away a few inches. \"<i>Not bad bitch, not bad. Now get on your back.</i>\" You obey your mistress's command and flop onto your back. A sense of joy fills you as she positions her crotch in front of your face and moves her own head between your legs. You quickly resume eating her out, and this time she joins in the feast. It's not too long before the two of you orgasm, spraying girl-cum onto each other's faces.\n\n");
				outputText("The shark girl stands to leave and winks at you before diving back into the water. You eventually pass out from the exertion.");
			//(Corrupton +2, Intelligence -4)
				player.orgasm('Vaginal');
				if (player.cor < 30) dynStats("cor", 1);
				combat.cleanupAfterCombat();
				return;
			}
		//Male:
			else {
			outputText("You slump down in defeat, too ");
			//[defeat via HP] 
			if (player.HP < 1) outputText("hurt ");
			else outputText("horny ");
			outputText("to fight on.\n\n");

		
			outputText("The shark girl giggles and moves over to you, tugging at your " + player.armorName + "  impatiently. Her tail swishes around and smacks your " + player.assDescript() + ". \"<i>You're gonna make me very happy, you hear? Otherwise...</i>\" she opens her mouth wide and you see her fangs glinting menacingly in the light. You gulp hard and nod, bringing a smile from the shark girl.\n\n"); 
			outputText("Wasting no time, she removes her skimpy swimwear and your own gear.  ");
			outputText("The shark girl has no such qualms and rides you like a mechanical bull, hammering up and down your " + player.cockDescript(0) + " with incredible speed. It certainly feels nice, but the rough nature of the ride also certainly hurts. You'll be walking funny for a while after this, that's for sure.\n\n");
		
			outputText("Eventually, her vagina clamps down on your cock and she cries out in orgasm. You grunt loudly and cum a few seconds after, pumping your seed into her womb. The shark girl leans over and plants a tiny kiss on your lips. \"<i>Good boy. I'll be sure to see 	you again</i>\". She gets up again and you watch her re-enter the water before you pass out.");
			player.orgasm('Dick');
			dynStats("sen", 1);
			if (player.cor < 30) dynStats("cor", 1);
			combat.cleanupAfterCombat();
			return;
			}
		}
		//Regular Shark Girl
		else {
			//Genderless:
			if (player.gender == 0) {
		outputText("You slump down in defeat, too ");
			if (player.HP < 1) outputText("hurt ");
			else outputText("horny ");
			outputText("to fight on.\n\n");
			outputText("The shark girl does a little victory dance, swaying her hips to and fro before moving over to you. She quickly removes your " + player.armorName + ", but her smile fades to a blank expression when she notices you lack any genitalia. \"<i>What the...</i>\" she mumbles, poking you in the groin. Finding you completely useless, she growls in frustration and stomps on your face in anger. The sudden pain makes you pass out.");
			combat.cleanupAfterCombat();
			dynStats("tou", -2);
			return;
		}
			//Female:
			if (player.hasVagina() && (player.totalCocks() == 0 || rand(2) == 0)) {
		outputText("You slump down in defeat, too ");
			//[defeat via HP] 
			if (player.HP < 1) outputText("hurt ");
			else outputText("horny ");
			outputText("to fight on.\n\n");
		
			outputText("The shark girl giggles and moves over to you, tugging at your " + player.armorName + "  impatiently. Her tail swishes around and smacks your " + player.assDescript() + ". \"<i>You're gonna make me very happy, you hear? Otherwise...</i>\" she opens her mouth wide and you see her fangs glinting menacingly in the light. You gulp hard and nod, bringing a smile from the shark girl.\n\n"); 
			outputText("Wasting no time, she removes her skimpy swimwear and your own gear.  ");
			//[if herm]
			if (player.gender == 3) outputText("Seeing your " + player.cockDescript(0) + " puts a smile on the shark girl's face as she takes a firm grip on your erection. \"<i>Well, you're just full of surprises, aren't you? Maybe I'll give this bad boy a whirl sometime. For now though...</i>\"  ");
		outputText("Her gaze drifts over to your " + player.vaginaDescript(0) + " and she licks her lips in delight. \"<i>Now that's what I'm looking for! Tell you what dear, you get me wet and I might just give you some pleasure too.</i>\"\n\n");
		
			outputText("She roughly grabs you by the hair and pulls your face into her drooling cunt, your tongue instinctively probing into her. \"<i>Mmm... don't you dare stop licking you dumb bitch, if you know what's good for you,</i>\" she orders. You reply by speeding up your tongue work. You're a little ashamed to admit it, but her dominant command makes you feel rather hot and bothered.\n\n");
			outputText("The shark girl eventually sighs happily and relaxes her grip on your hair, pulling your head away a few inches. \"<i>Not bad bitch, not bad. Now get on your back.</i>\" You obey your mistress's command and flop onto your back. A sense of joy fills you as she positions her crotch in front of your face and moves her own head between your legs. You quickly resume eating her out, and this time she joins in the feast. It's not too long before the two of you orgasm, spraying girl-cum onto each other's faces.\n\n");
		outputText("The shark girl stands to leave and winks at you before diving back into the water. You eventually pass out from the exertion.");
			//(Corruption +2, Intelligence -4)
			player.orgasm('Vaginal');
			if (player.cor < 30) dynStats("cor", 1);
			combat.cleanupAfterCombat();
			return;
		}
			//Male:
			else {
			outputText("You slump down in defeat, too ");
		//[defeat via HP] 
		if (player.HP < 1) outputText("hurt ");
		else outputText("horny ");
		outputText("to fight on.\n\n");

		
		outputText("You feel the shark girl's bare foot press against your chest and she roughly pushes you onto your back. \"<i>Oh man, I can't even remember the last time I had an actual man...</i>\" the shark girl says, pulling your pants down to your ankles. Seeing your stiff erection, your opponent smirks and wets her lips before taking your entire " + player.cockDescript(0) + " into her mouth. The feeling is heavenly, her long tongue slithering around your shaft.\n\n");
		outputText("But before you can begin to really enjoy it, she pulls her head away, visible strands of saliva still linking her mouth and your " + player.cockDescript(0) + ". The shark girl quickly maneuvers herself so that she's straddling your cock and presses herself down, the two of you gasping sharply from the sensation. \"<i>Hmm, good boy... You make me cum first, and I won't bite you. Deal?</i>\" You nod, though given that peculiar feelers inside her cunt are massaging your cock, you don't know how long you can really hold out.\n\n");

		
		outputText("The shark girl has no such qualms and rides you like a mechanical bull, hammering up and down your " + player.cockDescript(0) + " with incredible speed. It certainly feels nice, but the rough nature of the ride also certainly hurts. You'll be walking funny for a while after this, that's for sure.\n\n");
		
		outputText("Eventually, her vagina clamps down on your cock and she cries out in orgasm. You grunt loudly and cum a few seconds after, pumping your seed into her womb. The shark girl leans over and plants a tiny kiss on your lips. \"<i>Good boy. I'll be sure to see you again</i>\". She gets up again and you watch her re-enter the water before you pass out.");
		player.orgasm('Dick');
		dynStats("sen", 1);
		if (player.cor < 30) dynStats("cor", 1);
		combat.cleanupAfterCombat();
		return;
		}
		}
	doNext(playerMenu);
	}
}
}