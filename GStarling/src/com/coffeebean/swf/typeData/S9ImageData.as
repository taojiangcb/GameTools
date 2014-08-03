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
	public dynamic final class S9ImageData extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const X:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.coffeebean.swf.typeData.S9ImageData.x", "x", (320000 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var x$field:Number;

		private var hasField$0:uint = 0;

		public function clearX():void {
			hasField$0 &= 0xfffffffe;
			x$field = new Number();
		}

		public function get hasX():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set x(value:Number):void {
			hasField$0 |= 0x1;
			x$field = value;
		}

		public function get x():Number {
			return x$field;
		}

		/**
		 *  @private
		 */
		public static const Y:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.coffeebean.swf.typeData.S9ImageData.y", "y", (320001 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var y$field:Number;

		public function clearY():void {
			hasField$0 &= 0xfffffffd;
			y$field = new Number();
		}

		public function get hasY():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set y(value:Number):void {
			hasField$0 |= 0x2;
			y$field = value;
		}

		public function get y():Number {
			return y$field;
		}

		/**
		 *  @private
		 */
		public static const WIDTH:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.coffeebean.swf.typeData.S9ImageData.width", "width", (320002 << 3) | com.netease.protobuf.WireType.VARINT);

		private var width$field:int;

		public function clearWidth():void {
			hasField$0 &= 0xfffffffb;
			width$field = new int();
		}

		public function get hasWidth():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set width(value:int):void {
			hasField$0 |= 0x4;
			width$field = value;
		}

		public function get width():int {
			return width$field;
		}

		/**
		 *  @private
		 */
		public static const HEIGHT:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.coffeebean.swf.typeData.S9ImageData.height", "height", (320003 << 3) | com.netease.protobuf.WireType.VARINT);

		private var height$field:int;

		public function clearHeight():void {
			hasField$0 &= 0xfffffff7;
			height$field = new int();
		}

		public function get hasHeight():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set height(value:int):void {
			hasField$0 |= 0x8;
			height$field = value;
		}

		public function get height():int {
			return height$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasX) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 320000);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, x$field);
			}
			if (hasY) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 320001);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, y$field);
			}
			if (hasWidth) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 320002);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, width$field);
			}
			if (hasHeight) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 320003);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, height$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var x$count:uint = 0;
			var y$count:uint = 0;
			var width$count:uint = 0;
			var height$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 320000:
					if (x$count != 0) {
						throw new flash.errors.IOError('Bad data format: S9ImageData.x cannot be set twice.');
					}
					++x$count;
					this.x = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 320001:
					if (y$count != 0) {
						throw new flash.errors.IOError('Bad data format: S9ImageData.y cannot be set twice.');
					}
					++y$count;
					this.y = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 320002:
					if (width$count != 0) {
						throw new flash.errors.IOError('Bad data format: S9ImageData.width cannot be set twice.');
					}
					++width$count;
					this.width = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 320003:
					if (height$count != 0) {
						throw new flash.errors.IOError('Bad data format: S9ImageData.height cannot be set twice.');
					}
					++height$count;
					this.height = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
