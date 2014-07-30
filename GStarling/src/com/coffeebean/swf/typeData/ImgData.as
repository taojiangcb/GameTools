package com.coffeebean.swf.typeData {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class ImgData extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const PIVOTX:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.coffeebean.swf.typeData.ImgData.pivotX", "pivotX", (100001 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var pivotX$field:Number;

		private var hasField$0:uint = 0;

		public function clearPivotX():void {
			hasField$0 &= 0xfffffffe;
			pivotX$field = new Number();
		}

		public function get hasPivotX():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set pivotX(value:Number):void {
			hasField$0 |= 0x1;
			pivotX$field = value;
		}

		public function get pivotX():Number {
			return pivotX$field;
		}

		/**
		 *  @private
		 */
		public static const PIVOTY:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.coffeebean.swf.typeData.ImgData.pivotY", "pivotY", (100002 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var pivotY$field:Number;

		public function clearPivotY():void {
			hasField$0 &= 0xfffffffd;
			pivotY$field = new Number();
		}

		public function get hasPivotY():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set pivotY(value:Number):void {
			hasField$0 |= 0x2;
			pivotY$field = value;
		}

		public function get pivotY():Number {
			return pivotY$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasPivotX) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 100001);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, pivotX$field);
			}
			if (hasPivotY) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 100002);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, pivotY$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var pivotX$count:uint = 0;
			var pivotY$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 100001:
					if (pivotX$count != 0) {
						throw new flash.errors.IOError('Bad data format: ImgData.pivotX cannot be set twice.');
					}
					++pivotX$count;
					this.pivotX = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 100002:
					if (pivotY$count != 0) {
						throw new flash.errors.IOError('Bad data format: ImgData.pivotY cannot be set twice.');
					}
					++pivotY$count;
					this.pivotY = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
