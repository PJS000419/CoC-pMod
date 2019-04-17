package classes.Scenes 
{
	import classes.ItemSlot;
	import classes.ItemType;
	import classes.Items.ConsumableLib;
	import classes.Saves;
	import classes.internals.SerializationUtils;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;
	public class InventoryTest 
	{
		private var cut:Inventory;
		
		private var serializedClass:*;
		private var deserialized:Inventory;
		
		private static var consumables:ConsumableLib;
		
		private var saveFile:*;
		
		[BeforeClass]
		public static function setUpClass():void {
			consumables = new ConsumableLib();
		}
		
		[Before]
		public function setUp():void
		{
			var dummySaves:Saves = new DummySaves();
			cut = new Inventory(dummySaves);
			
			serializedClass = [];
			deserialized = new Inventory(dummySaves);
			
			initInventory();
			
			SerializationUtils.serialize(serializedClass, cut);
			SerializationUtils.deserialize(serializedClass, deserialized);
		}
		
		private function initInventory():void
		{
			var items:Array = cut.itemStorageDirectGet();
			
			cut.createStorage();
			cut.createStorage();
			cut.createStorage();
			cut.createStorage();
			cut.createStorage();
			
			// this is completely safe, trust me!  /s
			(items[0] as ItemSlot).setItemAndQty(consumables.PURPDYE, 3);
			(items[1] as ItemSlot).setItemAndQty(consumables.PURHONY, 5);
			(items[2] as ItemSlot).setItemAndQty(ItemType.NOTHING, 0);
			(items[2] as ItemSlot).unlocked = false;
		}
		
		[Test]
		public function instanceIsCreated():void
		{
			assertThat(cut, notNullValue());
		}

		[Test]
		public function itemStorageLoaded():void
		{
			assertThat(deserialized.hasItemInStorage(consumables.PURPDYE), equalTo(true));
			assertThat(deserialized.hasItemInStorage(consumables.PURHONY), equalTo(true));
		}
		
		[Test]
		public function itemStorageQuantityLoaded():void
		{
			assertThat(deserialized.itemStorageDirectGet()[0].quantity, equalTo(3));
			assertThat(deserialized.itemStorageDirectGet()[1].quantity, equalTo(5));
		}
		
		[Test]
		public function emptyItemStorageSlotIsNull():void
		{
			assertThat(deserialized.itemStorageDirectGet()[5], nullValue());
		}
		
		[Test]
		public function itemStorageMustBeInitializedAfterLoad():void
		{
			assertThat(deserialized.itemStorageDirectGet(), notNullValue());
		}
		
		[Test]
		public function itemStorageSlotIsLocked():void
		{
			assertThat(deserialized.itemStorageDirectGet()[2].unlocked, equalTo(false));
		}
	}
}

import classes.Saves;

/**
 * A minimalistic dummy to satisfy the constructor.
 */
class DummySaves extends Saves
{
	public function DummySaves()
	{
		var noop:Function = new Function();
		
		super(noop, noop);
	}
	
	override public function linkToInventory(gearStorageDirectGet:Function):void {
		// do nothing, this is just to satisfy the dependency
	}
}
