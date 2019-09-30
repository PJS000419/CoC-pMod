package classes.Scenes 
{
	import classes.Creature;
	/**
	 * Interface for vaginal pregnancy.
	 * The class must at least implement a birth scene.
	 */
	public interface VaginalSecondPregnancy 
	{
		/**
		 * Progresses a active pregnancy. Updates should eventually lead to birth.
		 * @return true if the display output needs to be updated.
		 */
		function updateVaginalSecondPregnancy(): Boolean;
		
		/**
		 * Give birth. Should outout a birth scene and clean up the pregnancy.
		 */
		function vaginalSecondBirth(): void;
	}
}
