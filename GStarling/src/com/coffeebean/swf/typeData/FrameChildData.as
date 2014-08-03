package com.coffeebean.swf.typeData {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.coffeebean.swf.typeData.SpriteData;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class FrameChildData extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const SPRITECHILDSDATA:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.coffeebean.swf.typeData.FrameChildData.spriteChildsData", "spriteChildsData", (220000 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.coffeebean.swf.typeData.SpriteData; });

		[ArrayElementType("com.coffeebean.swf.typeData.SpriteData")]
		public var spriteChildsData:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var spriteChildsData$index:uint = 0; spriteChildsData$index < this.spriteChildsData.length; ++spriteChildsData$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 220000);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.spriteChildsData[spriteChildsData$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 220000:
					this.spriteChildsData.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.coffeebean.swf.typeData.SpriteData()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
