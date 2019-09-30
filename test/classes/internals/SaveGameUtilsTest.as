package classes.internals
{
	import flash.net.SharedObject;
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	import classes.internals.Serializable;
	
	public class SaveGameUtilsTest
	{
		private static const SAVE_ROOT_DIRECTORY:String = "/";
		private static const SOURCE_FILE_NAME:String = "SAVE_UTIL_SOURCE";
		private static const DESTINATION_FILE_NAME:String = "SAVE_UTIL_DESTINATION";
		
		private static const DATA_TEXT:String = "hello world";
		
		private var sourceSave:SharedObject;
		private var destinationSave:SharedObject;
		
		[Before]
		public function setUp():void
		{
			sourceSave = SharedObject.getLocal(SOURCE_FILE_NAME, SAVE_ROOT_DIRECTORY);
			
			sourceSave.data.foo = 5;
			sourceSave.data.bar = 3.14;
			sourceSave.data.baz = DATA_TEXT;
			
			sourceSave.data.level1 = [];
			sourceSave.data.level1.level2 = "level 2";
			
			sourceSave.flush();
			
			copySaveGame();
			
			destinationSave = SharedObject.getLocal(DESTINATION_FILE_NAME, SAVE_ROOT_DIRECTORY);
		}
		
		private function copySaveGame():void
		{
			SaveGameUtils.copySaveGame(SOURCE_FILE_NAME, DESTINATION_FILE_NAME);
		}
		
		[After]
		public function tearDown():void
		{
			sourceSave.clear();
			destinationSave.clear();
		}
		
		[Test]
		public function copySaveGameDestinationContainsData():void
		{
			assertThat(destinationSave.data.baz, DATA_TEXT);
		}
		
		[Test]
		public function copySaveGameSourceUnchanged():void
		{
			assertThat(sourceSave.data.baz, DATA_TEXT);
		}
		
		[Test]
		public function copySaveGameOverWritesTarget():void
		{
			destinationSave.data.oldData = 42;
			
			copySaveGame();
			
			assertThat(destinationSave.data, not(hasProperty("oldData")));
		}
		
		[Test]
		public function saveGameIsDeleted():void
		{
			SaveGameUtils.deleteSaveGame(DESTINATION_FILE_NAME);
			
			assertThat(destinationSave.data, not(hasProperty("foo")));
		}
	}
}
