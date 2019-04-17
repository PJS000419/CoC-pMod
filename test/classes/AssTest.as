package classes{
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	
	import classes.Ass;
	import classes.internals.SerializationUtils;
	
	public class AssTest {
		private static const TEST_WETTNESS:int = 1;
		private static const TEST_LOOSENESS:int = 2;
		private static const TEST_FULLNESS:int = 3;

		
		private var cut:Ass;
		private var deserialized:Ass;
		
		private var serializedClass:*;
		
		[Before]
		public function runBeforeEveryTest():void {
			cut = new Ass();
			cut.analWetness = TEST_WETTNESS;
			cut.analLooseness = TEST_LOOSENESS;
			cut.fullness = TEST_FULLNESS;
			
			deserialized = new Ass();
			
			serializedClass = [];
			
			SerializationUtils.serialize(serializedClass, cut);
			SerializationUtils.deserialize(serializedClass, deserialized);
		}
		
		[Test]
		public function serializeWetness():void
		{
			assertThat(serializedClass, hasProperty("analWetness", TEST_WETTNESS));
		}
		
		[Test]
		public function serializeLooseness():void
		{
			assertThat(serializedClass, hasProperty("analLooseness", TEST_LOOSENESS));
		}
		
		[Test]
		public function serializeFullness():void
		{
			assertThat(serializedClass, hasProperty("fullness", TEST_FULLNESS));
		}
		
		[Test]
		public function deserializeWetness():void
		{
			assertThat(deserialized.analWetness, equalTo(TEST_WETTNESS));
		}
		
		[Test]
		public function deserializeLooseness():void
		{
			assertThat(deserialized.analLooseness, equalTo(TEST_LOOSENESS));
		}
		
		[Test]
		public function deserializeFullness():void
		{
			assertThat(deserialized.fullness, equalTo(TEST_FULLNESS));
		}
	}
}
