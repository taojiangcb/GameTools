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
	import com.coffeebean.swf.typeData.S9ImageData;
	import com.coffeebean.swf.typeData.MovieClipData;
	import com.coffeebean.swf.typeData.ImgData;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class TypeData extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const IMAGENAMES:RepeatedFieldDescriptor$TYPE_STRING = new RepeatedFieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.TypeData.imageNames", "imageNames", (400000 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		[ArrayElementType("String")]
		public var imageNames:Array = [];

		/**
		 *  @private
		 */
		public static const SPRITENAMES:RepeatedFieldDescriptor$TYPE_STRING = new RepeatedFieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.TypeData.spriteNames", "spriteNames", (400001 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		[ArrayElementType("String")]
		public var spriteNames:Array = [];

		/**
		 *  @private
		 */
		public static const MOVIECLIPNAMES:RepeatedFieldDescriptor$TYPE_STRING = new RepeatedFieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.TypeData.movieClipNames", "movieClipNames", (400002 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		[ArrayElementType("String")]
		public var movieClipNames:Array = [];

		/**
		 *  @private
		 */
		public static const BUTTONNAMES:RepeatedFieldDescriptor$TYPE_STRING = new RepeatedFieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.TypeData.buttonNames", "buttonNames", (400003 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		[ArrayElementType("String")]
		public var buttonNames:Array = [];

		/**
		 *  @private
		 */
		public static const S9NAMES:RepeatedFieldDescriptor$TYPE_STRING = new RepeatedFieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.TypeData.s9Names", "s9Names", (400004 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		[ArrayElementType("String")]
		public var s9Names:Array = [];

		/**
		 *  @private
		 */
		public static const SHAPEIMGNAMES:RepeatedFieldDescriptor$TYPE_STRING = new RepeatedFieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.TypeData.shapeImgNames", "shapeImgNames", (400005 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		[ArrayElementType("String")]
		public var shapeImgNames:Array = [];

		/**
		 *  @private
		 */
		public static const QUADBATCHNAMES:RepeatedFieldDescriptor$TYPE_STRING = new RepeatedFieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.TypeData.quadBatchNames", "quadBatchNames", (400006 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		[ArrayElementType("String")]
		public var quadBatchNames:Array = [];

		/**
		 *  @private
		 */
		public static const COMPONENTNAMES:RepeatedFieldDescriptor$TYPE_STRING = new RepeatedFieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.TypeData.componentNames", "componentNames", (400007 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		[ArrayElementType("String")]
		public var componentNames:Array = [];

		/**
		 *  @private
		 */
		public static const IMAGEDATAS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.coffeebean.swf.typeData.TypeData.imageDatas", "imageDatas", (400008 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.coffeebean.swf.typeData.ImgData; });

		[ArrayElementType("com.coffeebean.swf.typeData.ImgData")]
		public var imageDatas:Array = [];

		/**
		 *  @private
		 */
		public static const SPRITEDATAS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.coffeebean.swf.typeData.TypeData.spriteDatas", "spriteDatas", (400009 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.coffeebean.swf.typeData.SpriteData; });

		[ArrayElementType("com.coffeebean.swf.typeData.SpriteData")]
		public var spriteDatas:Array = [];

		/**
		 *  @private
		 */
		public static const MOVIECLIPDATAS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.coffeebean.swf.typeData.TypeData.movieClipDatas", "movieClipDatas", (400010 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.coffeebean.swf.typeData.MovieClipData; });

		[ArrayElementType("com.coffeebean.swf.typeData.MovieClipData")]
		public var movieClipDatas:Array = [];

		/**
		 *  @private
		 */
		public static const BUTTONDATAS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.coffeebean.swf.typeData.TypeData.buttonDatas", "buttonDatas", (400011 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.coffeebean.swf.typeData.SpriteData; });

		[ArrayElementType("com.coffeebean.swf.typeData.SpriteData")]
		public var buttonDatas:Array = [];

		/**
		 *  @private
		 */
		public static const S9DATAS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.coffeebean.swf.typeData.TypeData.s9Datas", "s9Datas", (400012 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.coffeebean.swf.typeData.S9ImageData; });

		[ArrayElementType("com.coffeebean.swf.typeData.S9ImageData")]
		public var s9Datas:Array = [];

		/**
		 *  @private
		 */
		public static const SHAPEIMGDATAS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.coffeebean.swf.typeData.TypeData.shapeImgDatas", "shapeImgDatas", (400013 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.coffeebean.swf.typeData.ImgData; });

		[ArrayElementType("com.coffeebean.swf.typeData.ImgData")]
		public var shapeImgDatas:Array = [];

		/**
		 *  @private
		 */
		public static const QUADBATCHDATAS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.coffeebean.swf.typeData.TypeData.quadBatchDatas", "quadBatchDatas", (400014 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.coffeebean.swf.typeData.SpriteData; });

		[ArrayElementType("com.coffeebean.swf.typeData.SpriteData")]
		public var quadBatchDatas:Array = [];

		/**
		 *  @private
		 */
		public static const COMPONENTDATAS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.coffeebean.swf.typeData.TypeData.componentDatas", "componentDatas", (400015 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.coffeebean.swf.typeData.SpriteData; });

		[ArrayElementType("com.coffeebean.swf.typeData.SpriteData")]
		public var componentDatas:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var imageNames$index:uint = 0; imageNames$index < this.imageNames.length; ++imageNames$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 400000);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.imageNames[imageNames$index]);
			}
			for (var spriteNames$index:uint = 0; spriteNames$index < this.spriteNames.length; ++spriteNames$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 400001);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.spriteNames[spriteNames$index]);
			}
			for (var movieClipNames$index:uint = 0; movieClipNames$index < this.movieClipNames.length; ++movieClipNames$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 400002);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.movieClipNames[movieClipNames$index]);
			}
			for (var buttonNames$index:uint = 0; buttonNames$index < this.buttonNames.length; ++buttonNames$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 400003);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.buttonNames[buttonNames$index]);
			}
			for (var s9Names$index:uint = 0; s9Names$index < this.s9Names.length; ++s9Names$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 400004);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.s9Names[s9Names$index]);
			}
			for (var shapeImgNames$index:uint = 0; shapeImgNames$index < this.shapeImgNames.length; ++shapeImgNames$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 400005);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.shapeImgNames[shapeImgNames$index]);
			}
			for (var quadBatchNames$index:uint = 0; quadBatchNames$index < this.quadBatchNames.length; ++quadBatchNames$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 400006);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.quadBatchNames[quadBatchNames$index]);
			}
			for (var componentNames$index:uint = 0; componentNames$index < this.componentNames.length; ++componentNames$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 400007);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.componentNames[componentNames$index]);
			}
			for (var imageDatas$index:uint = 0; imageDatas$index < this.imageDatas.length; ++imageDatas$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 400008);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.imageDatas[imageDatas$index]);
			}
			for (var spriteDatas$index:uint = 0; spriteDatas$index < this.spriteDatas.length; ++spriteDatas$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 400009);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.spriteDatas[spriteDatas$index]);
			}
			for (var movieClipDatas$index:uint = 0; movieClipDatas$index < this.movieClipDatas.length; ++movieClipDatas$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 400010);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.movieClipDatas[movieClipDatas$index]);
			}
			for (var buttonDatas$index:uint = 0; buttonDatas$index < this.buttonDatas.length; ++buttonDatas$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 400011);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.buttonDatas[buttonDatas$index]);
			}
			for (var s9Datas$index:uint = 0; s9Datas$index < this.s9Datas.length; ++s9Datas$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 400012);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.s9Datas[s9Datas$index]);
			}
			for (var shapeImgDatas$index:uint = 0; shapeImgDatas$index < this.shapeImgDatas.length; ++shapeImgDatas$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 400013);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.shapeImgDatas[shapeImgDatas$index]);
			}
			for (var quadBatchDatas$index:uint = 0; quadBatchDatas$index < this.quadBatchDatas.length; ++quadBatchDatas$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 400014);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.quadBatchDatas[quadBatchDatas$index]);
			}
			for (var componentDatas$index:uint = 0; componentDatas$index < this.componentDatas.length; ++componentDatas$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 400015);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.componentDatas[componentDatas$index]);
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
				case 400000:
					this.imageNames.push(com.netease.protobuf.ReadUtils.read$TYPE_STRING(input));
					break;
				case 400001:
					this.spriteNames.push(com.netease.protobuf.ReadUtils.read$TYPE_STRING(input));
					break;
				case 400002:
					this.movieClipNames.push(com.netease.protobuf.ReadUtils.read$TYPE_STRING(input));
					break;
				case 400003:
					this.buttonNames.push(com.netease.protobuf.ReadUtils.read$TYPE_STRING(input));
					break;
				case 400004:
					this.s9Names.push(com.netease.protobuf.ReadUtils.read$TYPE_STRING(input));
					break;
				case 400005:
					this.shapeImgNames.push(com.netease.protobuf.ReadUtils.read$TYPE_STRING(input));
					break;
				case 400006:
					this.quadBatchNames.push(com.netease.protobuf.ReadUtils.read$TYPE_STRING(input));
					break;
				case 400007:
					this.componentNames.push(com.netease.protobuf.ReadUtils.read$TYPE_STRING(input));
					break;
				case 400008:
					this.imageDatas.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.coffeebean.swf.typeData.ImgData()));
					break;
				case 400009:
					this.spriteDatas.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.coffeebean.swf.typeData.SpriteData()));
					break;
				case 400010:
					this.movieClipDatas.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.coffeebean.swf.typeData.MovieClipData()));
					break;
				case 400011:
					this.buttonDatas.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.coffeebean.swf.typeData.SpriteData()));
					break;
				case 400012:
					this.s9Datas.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.coffeebean.swf.typeData.S9ImageData()));
					break;
				case 400013:
					this.shapeImgDatas.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.coffeebean.swf.typeData.ImgData()));
					break;
				case 400014:
					this.quadBatchDatas.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.coffeebean.swf.typeData.SpriteData()));
					break;
				case 400015:
					this.componentDatas.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.coffeebean.swf.typeData.SpriteData()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
