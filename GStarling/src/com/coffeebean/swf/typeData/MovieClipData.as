package com.coffeebean.swf.typeData {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.coffeebean.swf.typeData.FrameChildData;
	import com.coffeebean.swf.typeData.FrameLabelData;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class MovieClipData extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const CHILDCLASSNAMES:RepeatedFieldDescriptor$TYPE_STRING = new RepeatedFieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.MovieClipData.childClassNames", "childClassNames", (310000 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		[ArrayElementType("String")]
		public var childClassNames:Array = [];

		/**
		 *  @private
		 */
		public static const CHILDCLASSNAMECOUNT:RepeatedFieldDescriptor$TYPE_INT32 = new RepeatedFieldDescriptor$TYPE_INT32("com.coffeebean.swf.typeData.MovieClipData.childClassNameCount", "childClassNameCount", (310001 << 3) | com.netease.protobuf.WireType.VARINT);

		[ArrayElementType("int")]
		public var childClassNameCount:Array = [];

		/**
		 *  @private
		 */
		public static const TYPENAMES:RepeatedFieldDescriptor$TYPE_STRING = new RepeatedFieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.MovieClipData.typeNames", "typeNames", (310002 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		[ArrayElementType("String")]
		public var typeNames:Array = [];

		/**
		 *  @private
		 */
		public static const TYPECOUNT:RepeatedFieldDescriptor$TYPE_INT32 = new RepeatedFieldDescriptor$TYPE_INT32("com.coffeebean.swf.typeData.MovieClipData.typeCount", "typeCount", (310003 << 3) | com.netease.protobuf.WireType.VARINT);

		[ArrayElementType("int")]
		public var typeCount:Array = [];

		/**
		 *  @private
		 */
		public static const FRAMESIZE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.coffeebean.swf.typeData.MovieClipData.frameSize", "frameSize", (310004 << 3) | com.netease.protobuf.WireType.VARINT);

		private var frameSize$field:int;

		private var hasField$0:uint = 0;

		public function clearFrameSize():void {
			hasField$0 &= 0xfffffffe;
			frameSize$field = new int();
		}

		public function get hasFrameSize():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set frameSize(value:int):void {
			hasField$0 |= 0x1;
			frameSize$field = value;
		}

		public function get frameSize():int {
			return frameSize$field;
		}

		/**
		 *  @private
		 */
		public static const FRAMES:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.coffeebean.swf.typeData.MovieClipData.frames", "frames", (310005 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.coffeebean.swf.typeData.FrameChildData; });

		[ArrayElementType("com.coffeebean.swf.typeData.FrameChildData")]
		public var frames:Array = [];

		/**
		 *  @private
		 */
		public static const LABELS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.coffeebean.swf.typeData.MovieClipData.labels", "labels", (310006 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.coffeebean.swf.typeData.FrameLabelData; });

		[ArrayElementType("com.coffeebean.swf.typeData.FrameLabelData")]
		public var labels:Array = [];

		/**
		 *  @private
		 */
		public static const LOOP:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.coffeebean.swf.typeData.MovieClipData.loop", "loop", (310007 << 3) | com.netease.protobuf.WireType.VARINT);

		private var loop$field:Boolean;

		public function clearLoop():void {
			hasField$0 &= 0xfffffffd;
			loop$field = new Boolean();
		}

		public function get hasLoop():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set loop(value:Boolean):void {
			hasField$0 |= 0x2;
			loop$field = value;
		}

		public function get loop():Boolean {
			return loop$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var childClassNames$index:uint = 0; childClassNames$index < this.childClassNames.length; ++childClassNames$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 310000);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.childClassNames[childClassNames$index]);
			}
			for (var childClassNameCount$index:uint = 0; childClassNameCount$index < this.childClassNameCount.length; ++childClassNameCount$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 310001);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.childClassNameCount[childClassNameCount$index]);
			}
			for (var typeNames$index:uint = 0; typeNames$index < this.typeNames.length; ++typeNames$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 310002);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.typeNames[typeNames$index]);
			}
			for (var typeCount$index:uint = 0; typeCount$index < this.typeCount.length; ++typeCount$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 310003);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.typeCount[typeCount$index]);
			}
			if (hasFrameSize) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 310004);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, frameSize$field);
			}
			for (var frames$index:uint = 0; frames$index < this.frames.length; ++frames$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 310005);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.frames[frames$index]);
			}
			for (var labels$index:uint = 0; labels$index < this.labels.length; ++labels$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 310006);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.labels[labels$index]);
			}
			if (hasLoop) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 310007);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, loop$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var frameSize$count:uint = 0;
			var loop$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 310000:
					this.childClassNames.push(com.netease.protobuf.ReadUtils.read$TYPE_STRING(input));
					break;
				case 310001:
					if ((tag & 7) == com.netease.protobuf.WireType.LENGTH_DELIMITED) {
						com.netease.protobuf.ReadUtils.readPackedRepeated(input, com.netease.protobuf.ReadUtils.read$TYPE_INT32, this.childClassNameCount);
						break;
					}
					this.childClassNameCount.push(com.netease.protobuf.ReadUtils.read$TYPE_INT32(input));
					break;
				case 310002:
					this.typeNames.push(com.netease.protobuf.ReadUtils.read$TYPE_STRING(input));
					break;
				case 310003:
					if ((tag & 7) == com.netease.protobuf.WireType.LENGTH_DELIMITED) {
						com.netease.protobuf.ReadUtils.readPackedRepeated(input, com.netease.protobuf.ReadUtils.read$TYPE_INT32, this.typeCount);
						break;
					}
					this.typeCount.push(com.netease.protobuf.ReadUtils.read$TYPE_INT32(input));
					break;
				case 310004:
					if (frameSize$count != 0) {
						throw new flash.errors.IOError('Bad data format: MovieClipData.frameSize cannot be set twice.');
					}
					++frameSize$count;
					this.frameSize = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 310005:
					this.frames.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.coffeebean.swf.typeData.FrameChildData()));
					break;
				case 310006:
					this.labels.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.coffeebean.swf.typeData.FrameLabelData()));
					break;
				case 310007:
					if (loop$count != 0) {
						throw new flash.errors.IOError('Bad data format: MovieClipData.loop cannot be set twice.');
					}
					++loop$count;
					this.loop = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
