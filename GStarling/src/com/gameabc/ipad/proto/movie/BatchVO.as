package com.gameabc.ipad.proto.movie {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gameabc.ipad.proto.movie.BatchFrameVO;
	import com.gameabc.ipad.proto.movie.BatchFrameLabelVO;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class BatchVO extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const FRAMES:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gameabc.ipad.proto.movie.BatchVO.frames", "frames", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gameabc.ipad.proto.movie.BatchFrameVO; });

		[ArrayElementType("com.gameabc.ipad.proto.movie.BatchFrameVO")]
		public var frames:Array = [];

		/**
		 *  @private
		 */
		public static const FPS:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gameabc.ipad.proto.movie.BatchVO.fps", "fps", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var fps$field:int;

		private var hasField$0:uint = 0;

		public function clearFps():void {
			hasField$0 &= 0xfffffffe;
			fps$field = new int();
		}

		public function get hasFps():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set fps(value:int):void {
			hasField$0 |= 0x1;
			fps$field = value;
		}

		public function get fps():int {
			return fps$field;
		}

		/**
		 *  @private
		 */
		public static const SCALE:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gameabc.ipad.proto.movie.BatchVO.scale", "scale", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var scale$field:String;

		public function clearScale():void {
			scale$field = null;
		}

		public function get hasScale():Boolean {
			return scale$field != null;
		}

		public function set scale(value:String):void {
			scale$field = value;
		}

		public function get scale():String {
			return scale$field;
		}

		/**
		 *  @private
		 */
		public static const MYPARAMSTYPE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gameabc.ipad.proto.movie.BatchVO.myParamsType", "myParamsType", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var myParamsType$field:int;

		public function clearMyParamsType():void {
			hasField$0 &= 0xfffffffd;
			myParamsType$field = new int();
		}

		public function get hasMyParamsType():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set myParamsType(value:int):void {
			hasField$0 |= 0x2;
			myParamsType$field = value;
		}

		public function get myParamsType():int {
			return myParamsType$field;
		}

		/**
		 *  @private
		 */
		public static const MYPARAMS:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gameabc.ipad.proto.movie.BatchVO.myParams", "myParams", (5 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var myParams$field:String;

		public function clearMyParams():void {
			myParams$field = null;
		}

		public function get hasMyParams():Boolean {
			return myParams$field != null;
		}

		public function set myParams(value:String):void {
			myParams$field = value;
		}

		public function get myParams():String {
			return myParams$field;
		}

		/**
		 *  @private
		 */
		public static const FRAMELABELS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gameabc.ipad.proto.movie.BatchVO.frameLabels", "frameLabels", (6 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gameabc.ipad.proto.movie.BatchFrameLabelVO; });

		[ArrayElementType("com.gameabc.ipad.proto.movie.BatchFrameLabelVO")]
		public var frameLabels:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var frames$index:uint = 0; frames$index < this.frames.length; ++frames$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.frames[frames$index]);
			}
			if (hasFps) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, fps$field);
			}
			if (hasScale) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, scale$field);
			}
			if (hasMyParamsType) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, myParamsType$field);
			}
			if (hasMyParams) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, myParams$field);
			}
			for (var frameLabels$index:uint = 0; frameLabels$index < this.frameLabels.length; ++frameLabels$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.frameLabels[frameLabels$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var fps$count:uint = 0;
			var scale$count:uint = 0;
			var myParamsType$count:uint = 0;
			var myParams$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					this.frames.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gameabc.ipad.proto.movie.BatchFrameVO()));
					break;
				case 2:
					if (fps$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchVO.fps cannot be set twice.');
					}
					++fps$count;
					this.fps = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if (scale$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchVO.scale cannot be set twice.');
					}
					++scale$count;
					this.scale = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 4:
					if (myParamsType$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchVO.myParamsType cannot be set twice.');
					}
					++myParamsType$count;
					this.myParamsType = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 5:
					if (myParams$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchVO.myParams cannot be set twice.');
					}
					++myParams$count;
					this.myParams = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 6:
					this.frameLabels.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gameabc.ipad.proto.movie.BatchFrameLabelVO()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
