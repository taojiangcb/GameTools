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
	public dynamic final class FrameLabelData extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const FRAME:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.coffeebean.swf.typeData.FrameLabelData.frame", "frame", (300000 << 3) | com.netease.protobuf.WireType.VARINT);

		private var frame$field:int;

		private var hasField$0:uint = 0;

		public function clearFrame():void {
			hasField$0 &= 0xfffffffe;
			frame$field = new int();
		}

		public function get hasFrame():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set frame(value:int):void {
			hasField$0 |= 0x1;
			frame$field = value;
		}

		public function get frame():int {
			return frame$field;
		}

		/**
		 *  @private
		 */
		public static const NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.FrameLabelData.name", "name", (300001 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var name$field:String;

		public function clearName():void {
			name$field = null;
		}

		public function get hasName():Boolean {
			return name$field != null;
		}

		public function set name(value:String):void {
			name$field = value;
		}

		public function get name():String {
			return name$field;
		}

		/**
		 *  @private
		 */
		public static const ENDFRAME:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.coffeebean.swf.typeData.FrameLabelData.endFrame", "endFrame", (300002 << 3) | com.netease.protobuf.WireType.VARINT);

		private var endFrame$field:int;

		public function clearEndFrame():void {
			hasField$0 &= 0xfffffffd;
			endFrame$field = new int();
		}

		public function get hasEndFrame():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set endFrame(value:int):void {
			hasField$0 |= 0x2;
			endFrame$field = value;
		}

		public function get endFrame():int {
			return endFrame$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasFrame) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 300000);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, frame$field);
			}
			if (hasName) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 300001);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, name$field);
			}
			if (hasEndFrame) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 300002);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, endFrame$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var frame$count:uint = 0;
			var name$count:uint = 0;
			var endFrame$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 300000:
					if (frame$count != 0) {
						throw new flash.errors.IOError('Bad data format: FrameLabelData.frame cannot be set twice.');
					}
					++frame$count;
					this.frame = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 300001:
					if (name$count != 0) {
						throw new flash.errors.IOError('Bad data format: FrameLabelData.name cannot be set twice.');
					}
					++name$count;
					this.name = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 300002:
					if (endFrame$count != 0) {
						throw new flash.errors.IOError('Bad data format: FrameLabelData.endFrame cannot be set twice.');
					}
					++endFrame$count;
					this.endFrame = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
