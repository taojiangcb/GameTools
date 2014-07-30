package com.gameabc.ipad.proto.movie {
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
	public dynamic final class BatchFrameLabelVO extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const BEGINFRAME:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gameabc.ipad.proto.movie.BatchFrameLabelVO.beginFrame", "beginFrame", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var beginFrame$field:int;

		private var hasField$0:uint = 0;

		public function clearBeginFrame():void {
			hasField$0 &= 0xfffffffe;
			beginFrame$field = new int();
		}

		public function get hasBeginFrame():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set beginFrame(value:int):void {
			hasField$0 |= 0x1;
			beginFrame$field = value;
		}

		public function get beginFrame():int {
			return beginFrame$field;
		}

		/**
		 *  @private
		 */
		public static const LABEL:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gameabc.ipad.proto.movie.BatchFrameLabelVO.label", "label", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var label$field:String;

		public function clearLabel():void {
			label$field = null;
		}

		public function get hasLabel():Boolean {
			return label$field != null;
		}

		public function set label(value:String):void {
			label$field = value;
		}

		public function get label():String {
			return label$field;
		}

		/**
		 *  @private
		 */
		public static const ENDFRAME:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gameabc.ipad.proto.movie.BatchFrameLabelVO.endFrame", "endFrame", (3 << 3) | com.netease.protobuf.WireType.VARINT);

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
			if (hasBeginFrame) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, beginFrame$field);
			}
			if (hasLabel) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, label$field);
			}
			if (hasEndFrame) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
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
			var beginFrame$count:uint = 0;
			var label$count:uint = 0;
			var endFrame$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (beginFrame$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchFrameLabelVO.beginFrame cannot be set twice.');
					}
					++beginFrame$count;
					this.beginFrame = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (label$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchFrameLabelVO.label cannot be set twice.');
					}
					++label$count;
					this.label = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 3:
					if (endFrame$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchFrameLabelVO.endFrame cannot be set twice.');
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
