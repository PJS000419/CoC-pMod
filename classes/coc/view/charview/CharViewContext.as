/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.view.charview {
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Beard;
import classes.BodyParts.Butt;
import classes.BodyParts.Claws;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Neck;
import classes.BodyParts.Piercing;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.UnderBody;
import classes.BodyParts.Wings;
import classes.Creature;
import classes.lists.BreastCup;
import classes.lists.Gender;

import coc.view.*;
import coc.xlogic.ExecContext;

/**
 * Evaluation context
 */
public class CharViewContext extends ExecContext {
	private var charview:CharView;
	public function CharViewContext(charview:CharView, character:*) {
		this.charview = charview;
		pushScope(character);
		// Globals used in model.xml
		pushScope({
			Antennae : Antennae,
			Arms     : Arms,
			Beard    : Beard,
			BreastCup: BreastCup,
			Butt     : Butt,
			Claws    : Claws,
			Ears     : Ears,
			Eyes     : Eyes,
			Face     : Face,
			Gender   : Gender,
			Gills    : Gills,
			Hair     : Hair,
			Hips     : Hips,
			Horns    : Horns,
			LowerBody: LowerBody,
			Neck     : Neck,
			Pattern  : Pattern,
			Piercing : Piercing,
			RearBody : RearBody,
			Skin     : Skin,
			Tail     : Tail,
			Tongue   : Tongue,
			UnderBody: UnderBody,
			Wings    : Wings
		});
		// Intermod compatibility layer
		// - objects not present in character but required in model.xml scripts should be listed here
		var creature:Creature = character as Creature;
		if (creature) {
			pushScope({
				hairLength: creature.hair.length,
				hairType: creature.hair.type,
				faceType: creature.face.type,
				lowerBody: creature.lowerBody.type,
				legCount: creature.lowerBody.legCount,
				tailType: creature.tail.type,
				tailCount: creature.tail.venom,
				skin: {
					type: creature.skin.type,
					base: {
						type: creature.skin.type,
						pattern: 0
					},
					coat: {
						type: creature.skin.type,
						pattern: 0
					}
				},
				hasPartialCoat: function():Boolean {
					return false;
				},
				hasPartialCoatOfType: function(...types):Boolean {
					return false;
				},
				hasFullCoatOfType: function(...types):Boolean {
					return types.indexOf(creature.skin.type) >= 0;
				}
			});
		}
	}
}
}

// EJ compatibility layer
class Pattern {
	public static const NONE:int                    = 0;
	public static const MAGICAL_TATTOO:int          = 1;
	public static const ORCA_UNDERBODY:int          = 2;
	public static const BEE_STRIPES:int             = 3;
	public static const TIGER_STRIPES:int           = 4;
	public static const BATTLE_TATTOO:int           = 5;
	public static const SPOTTED:int                 = 6;
	public static const LIGHTNING_SHAPED_TATTOO:int = 7;
}