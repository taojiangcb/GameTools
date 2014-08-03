package com.gameabc.ipad.proto.movie {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gameabc.ipad.proto.movie.BatchImageVO;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class BatchFrameVO extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const IMAGE:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gameabc.ipad.proto.movie.BatchFrameVO.image", "image", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gameabc.ipad.proto.movie.BatchImageVO; });

		[ArrayElementType("com.gameabc.ipad.proto.movie.BatchImageVO")]
		public var image:Array = [];

		/**
		 *  @private
		 */
		public static const BEATTACK:RepeatedFieldDescriptor$TYPE_INT32 = new RepeatedFieldDescriptor$TYPE_INT32("com.gameabc.ipad.proto.movie.BatchFrameVO.beAttack", "beAttack", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		[ArrayElementType("int")]
		public var beAttack:Array = [];

		/**
		 *  @private
		 */
		public static const SOUND:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gameabc.ipad.proto.movie.BatchFrameVO.sound", "sound", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var sound$field:String;

		public function clearSound():void {
			sound$field = null;
		}

		public function get hasSound():Boolean {
			return sound$field != null;
		}

		public function set sound(value:String):void {
			sound$field = value;
		}

		public function get sound():String {
			return sound$field;
		}

		/**
		 *  @private
		 */
		public static const SHOCK:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gameabc.ipad.proto.movie.BatchFrameVO.shock", "shock", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var shock$field:Boolean;

		private var hasField$0:uint = 0;

		public function clearShock():void {
			hasField$0 &= 0xfffffffe;
			shock$field = new Boolean();
		}

		public function get hasShock():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set shock(value:Boolean):void {
			hasField$0 |= 0x1;
			shock$field = value;
		}

		public function get shock():Boolean {
			return shock$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var image$index:uint = 0; image$index < this.image.length; ++image$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.image[image$index]);
			}
			for (var beAttack$index:uint = 0; beAttack$index < this.beAttack.length; ++beAttack$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.beAttack[beAttack$index]);
			}
			if (hasSound) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, sound$field);
			}
			if (hasShock) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, shock$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var sound$count:uint = 0;
			var shock$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					this.image.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gameabc.ipad.proto.movie.BatchImageVO()));
					break;
				case 2:
					if ((tag & 7) == com.netease.protobuf.WireType.LENGTH_DELIMITED) {
						com.netease.protobuf.ReadUtils.readPackedRepeated(input, com.netease.protobuf.ReadUtils.read$TYPE_INT32, this.beAttack);
						break;
					}
					this.beAttack.push(com.netease.protobuf.ReadUtils.read$TYPE_INT32(input));
					break;
				case 3:
					if (sound$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchFrameVO.sound cannot be set twice.');
					}
					++sound$count;
					this.sound = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 4:
					if (shock$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchFrameVO.shock cannot be set twice.');
					}
					++shock$count;
					this.shock = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
