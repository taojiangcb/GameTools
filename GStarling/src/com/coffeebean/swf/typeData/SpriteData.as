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
	public dynamic final class SpriteData extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const CHILDCLASSNAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.SpriteData.childClassName", "childClassName", (200001 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var childClassName$field:String;

		public function clearChildClassName():void {
			childClassName$field = null;
		}

		public function get hasChildClassName():Boolean {
			return childClassName$field != null;
		}

		public function set childClassName(value:String):void {
			childClassName$field = value;
		}

		public function get childClassName():String {
			return childClassName$field;
		}

		/**
		 *  @private
		 */
		public static const TYPE:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.SpriteData.type", "type", (200002 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var type$field:String;

		public function clearType():void {
			type$field = null;
		}

		public function get hasType():Boolean {
			return type$field != null;
		}

		public function set type(value:String):void {
			type$field = value;
		}

		public function get type():String {
			return type$field;
		}

		/**
		 *  @private
		 */
		public static const X:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.coffeebean.swf.typeData.SpriteData.x", "x", (200003 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

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
		public static const Y:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.coffeebean.swf.typeData.SpriteData.y", "y", (200004 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

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
		public static const SCALEX:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.coffeebean.swf.typeData.SpriteData.scaleX", "scaleX", (200005 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var scaleX$field:Number;

		public function clearScaleX():void {
			hasField$0 &= 0xfffffffb;
			scaleX$field = new Number();
		}

		public function get hasScaleX():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set scaleX(value:Number):void {
			hasField$0 |= 0x4;
			scaleX$field = value;
		}

		public function get scaleX():Number {
			if(!hasScaleX) {
				return 1;
			}
			return scaleX$field;
		}

		/**
		 *  @private
		 */
		public static const SCALEY:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.coffeebean.swf.typeData.SpriteData.scaleY", "scaleY", (200006 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var scaleY$field:Number;

		public function clearScaleY():void {
			hasField$0 &= 0xfffffff7;
			scaleY$field = new Number();
		}

		public function get hasScaleY():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set scaleY(value:Number):void {
			hasField$0 |= 0x8;
			scaleY$field = value;
		}

		public function get scaleY():Number {
			if(!hasScaleY) {
				return 1;
			}
			return scaleY$field;
		}

		/**
		 *  @private
		 */
		public static const SKETWX:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.coffeebean.swf.typeData.SpriteData.sketwX", "sketwX", (200007 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var sketwX$field:Number;

		public function clearSketwX():void {
			hasField$0 &= 0xffffffef;
			sketwX$field = new Number();
		}

		public function get hasSketwX():Boolean {
			return (hasField$0 & 0x10) != 0;
		}

		public function set sketwX(value:Number):void {
			hasField$0 |= 0x10;
			sketwX$field = value;
		}

		public function get sketwX():Number {
			return sketwX$field;
		}

		/**
		 *  @private
		 */
		public static const SKETWY:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.coffeebean.swf.typeData.SpriteData.sketwY", "sketwY", (200008 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var sketwY$field:Number;

		public function clearSketwY():void {
			hasField$0 &= 0xffffffdf;
			sketwY$field = new Number();
		}

		public function get hasSketwY():Boolean {
			return (hasField$0 & 0x20) != 0;
		}

		public function set sketwY(value:Number):void {
			hasField$0 |= 0x20;
			sketwY$field = value;
		}

		public function get sketwY():Number {
			return sketwY$field;
		}

		/**
		 *  @private
		 */
		public static const CHILDNAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.SpriteData.childName", "childName", (200009 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var childName$field:String;

		public function clearChildName():void {
			childName$field = null;
		}

		public function get hasChildName():Boolean {
			return childName$field != null;
		}

		public function set childName(value:String):void {
			childName$field = value;
		}

		public function get childName():String {
			return childName$field;
		}

		/**
		 *  @private
		 */
		public static const ISQUADBATCH:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.coffeebean.swf.typeData.SpriteData.isQuadBatch", "isQuadBatch", (200010 << 3) | com.netease.protobuf.WireType.VARINT);

		private var isQuadBatch$field:Boolean;

		public function clearIsQuadBatch():void {
			hasField$0 &= 0xffffffbf;
			isQuadBatch$field = new Boolean();
		}

		public function get hasIsQuadBatch():Boolean {
			return (hasField$0 & 0x40) != 0;
		}

		public function set isQuadBatch(value:Boolean):void {
			hasField$0 |= 0x40;
			isQuadBatch$field = value;
		}

		public function get isQuadBatch():Boolean {
			return isQuadBatch$field;
		}

		/**
		 *  @private
		 */
		public static const OWNERNAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.SpriteData.ownerName", "ownerName", (200011 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var ownerName$field:String;

		public function clearOwnerName():void {
			ownerName$field = null;
		}

		public function get hasOwnerName():Boolean {
			return ownerName$field != null;
		}

		public function set ownerName(value:String):void {
			ownerName$field = value;
		}

		public function get ownerName():String {
			return ownerName$field;
		}

		/**
		 *  @private
		 */
		public static const WIDTH:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.coffeebean.swf.typeData.SpriteData.width", "width", (200012 << 3) | com.netease.protobuf.WireType.VARINT);

		private var width$field:int;

		public function clearWidth():void {
			hasField$0 &= 0xffffff7f;
			width$field = new int();
		}

		public function get hasWidth():Boolean {
			return (hasField$0 & 0x80) != 0;
		}

		public function set width(value:int):void {
			hasField$0 |= 0x80;
			width$field = value;
		}

		public function get width():int {
			return width$field;
		}

		/**
		 *  @private
		 */
		public static const HEIGHT:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.coffeebean.swf.typeData.SpriteData.height", "height", (200013 << 3) | com.netease.protobuf.WireType.VARINT);

		private var height$field:int;

		public function clearHeight():void {
			hasField$0 &= 0xfffffeff;
			height$field = new int();
		}

		public function get hasHeight():Boolean {
			return (hasField$0 & 0x100) != 0;
		}

		public function set height(value:int):void {
			hasField$0 |= 0x100;
			height$field = value;
		}

		public function get height():int {
			return height$field;
		}

		/**
		 *  @private
		 */
		public static const FONT:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.SpriteData.font", "font", (200014 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var font$field:String;

		public function clearFont():void {
			font$field = null;
		}

		public function get hasFont():Boolean {
			return font$field != null;
		}

		public function set font(value:String):void {
			font$field = value;
		}

		public function get font():String {
			return font$field;
		}

		/**
		 *  @private
		 */
		public static const COLOR:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.coffeebean.swf.typeData.SpriteData.color", "color", (200015 << 3) | com.netease.protobuf.WireType.VARINT);

		private var color$field:uint;

		public function clearColor():void {
			hasField$0 &= 0xfffffdff;
			color$field = new uint();
		}

		public function get hasColor():Boolean {
			return (hasField$0 & 0x200) != 0;
		}

		public function set color(value:uint):void {
			hasField$0 |= 0x200;
			color$field = value;
		}

		public function get color():uint {
			return color$field;
		}

		/**
		 *  @private
		 */
		public static const SIZE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.coffeebean.swf.typeData.SpriteData.size", "size", (200016 << 3) | com.netease.protobuf.WireType.VARINT);

		private var size$field:int;

		public function clearSize():void {
			hasField$0 &= 0xfffffbff;
			size$field = new int();
		}

		public function get hasSize():Boolean {
			return (hasField$0 & 0x400) != 0;
		}

		public function set size(value:int):void {
			hasField$0 |= 0x400;
			size$field = value;
		}

		public function get size():int {
			return size$field;
		}

		/**
		 *  @private
		 */
		public static const ALIGN:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.SpriteData.align", "align", (200017 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var align$field:String;

		public function clearAlign():void {
			align$field = null;
		}

		public function get hasAlign():Boolean {
			return align$field != null;
		}

		public function set align(value:String):void {
			align$field = value;
		}

		public function get align():String {
			return align$field;
		}

		/**
		 *  @private
		 */
		public static const ITALIC:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.coffeebean.swf.typeData.SpriteData.italic", "italic", (200018 << 3) | com.netease.protobuf.WireType.VARINT);

		private var italic$field:Boolean;

		public function clearItalic():void {
			hasField$0 &= 0xfffff7ff;
			italic$field = new Boolean();
		}

		public function get hasItalic():Boolean {
			return (hasField$0 & 0x800) != 0;
		}

		public function set italic(value:Boolean):void {
			hasField$0 |= 0x800;
			italic$field = value;
		}

		public function get italic():Boolean {
			return italic$field;
		}

		/**
		 *  @private
		 */
		public static const BOLD:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.coffeebean.swf.typeData.SpriteData.bold", "bold", (200019 << 3) | com.netease.protobuf.WireType.VARINT);

		private var bold$field:Boolean;

		public function clearBold():void {
			hasField$0 &= 0xffffefff;
			bold$field = new Boolean();
		}

		public function get hasBold():Boolean {
			return (hasField$0 & 0x1000) != 0;
		}

		public function set bold(value:Boolean):void {
			hasField$0 |= 0x1000;
			bold$field = value;
		}

		public function get bold():Boolean {
			return bold$field;
		}

		/**
		 *  @private
		 */
		public static const TEXT:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.SpriteData.text", "text", (200020 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var text$field:String;

		public function clearText():void {
			text$field = null;
		}

		public function get hasText():Boolean {
			return text$field != null;
		}

		public function set text(value:String):void {
			text$field = value;
		}

		public function get text():String {
			return text$field;
		}

		/**
		 *  @private
		 */
		public static const COMPDATA:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.coffeebean.swf.typeData.SpriteData.compData", "compData", (200021 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var compData$field:String;

		public function clearCompData():void {
			compData$field = null;
		}

		public function get hasCompData():Boolean {
			return compData$field != null;
		}

		public function set compData(value:String):void {
			compData$field = value;
		}

		public function get compData():String {
			return compData$field;
		}

		/**
		 *  @private
		 */
		public static const ALPHA:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.coffeebean.swf.typeData.SpriteData.alpha", "alpha", (200022 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var alpha$field:Number;

		public function clearAlpha():void {
			hasField$0 &= 0xffffdfff;
			alpha$field = new Number();
		}

		public function get hasAlpha():Boolean {
			return (hasField$0 & 0x2000) != 0;
		}

		public function set alpha(value:Number):void {
			hasField$0 |= 0x2000;
			alpha$field = value;
		}

		public function get alpha():Number {
			if(!hasAlpha) {
				return 1;
			}
			return alpha$field;
		}

		/**
		 *  @private
		 */
		public static const INDEX:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.coffeebean.swf.typeData.SpriteData.index", "index", (200023 << 3) | com.netease.protobuf.WireType.VARINT);

		private var index$field:int;

		public function clearIndex():void {
			hasField$0 &= 0xffffbfff;
			index$field = new int();
		}

		public function get hasIndex():Boolean {
			return (hasField$0 & 0x4000) != 0;
		}

		public function set index(value:int):void {
			hasField$0 |= 0x4000;
			index$field = value;
		}

		public function get index():int {
			return index$field;
		}

		/**
		 *  @private
		 */
		public static const SPRITECHILDSDATA:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.coffeebean.swf.typeData.SpriteData.spriteChildsData", "spriteChildsData", (200024 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return SpriteData; });

		[ArrayElementType("SpriteData")]
		public var spriteChildsData:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasChildClassName) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 200001);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, childClassName$field);
			}
			if (hasType) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 200002);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, type$field);
			}
			if (hasX) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 200003);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, x$field);
			}
			if (hasY) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 200004);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, y$field);
			}
			if (hasScaleX) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 200005);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, scaleX$field);
			}
			if (hasScaleY) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 200006);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, scaleY$field);
			}
			if (hasSketwX) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 200007);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, sketwX$field);
			}
			if (hasSketwY) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 200008);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, sketwY$field);
			}
			if (hasChildName) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 200009);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, childName$field);
			}
			if (hasIsQuadBatch) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 200010);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, isQuadBatch$field);
			}
			if (hasOwnerName) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 200011);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, ownerName$field);
			}
			if (hasWidth) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 200012);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, width$field);
			}
			if (hasHeight) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 200013);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, height$field);
			}
			if (hasFont) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 200014);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, font$field);
			}
			if (hasColor) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 200015);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, color$field);
			}
			if (hasSize) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 200016);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, size$field);
			}
			if (hasAlign) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 200017);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, align$field);
			}
			if (hasItalic) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 200018);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, italic$field);
			}
			if (hasBold) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 200019);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, bold$field);
			}
			if (hasText) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 200020);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, text$field);
			}
			if (hasCompData) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 200021);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, compData$field);
			}
			if (hasAlpha) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 200022);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, alpha$field);
			}
			if (hasIndex) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 200023);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, index$field);
			}
			for (var spriteChildsData$index:uint = 0; spriteChildsData$index < this.spriteChildsData.length; ++spriteChildsData$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 200024);
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
			var childClassName$count:uint = 0;
			var type$count:uint = 0;
			var x$count:uint = 0;
			var y$count:uint = 0;
			var scaleX$count:uint = 0;
			var scaleY$count:uint = 0;
			var sketwX$count:uint = 0;
			var sketwY$count:uint = 0;
			var childName$count:uint = 0;
			var isQuadBatch$count:uint = 0;
			var ownerName$count:uint = 0;
			var width$count:uint = 0;
			var height$count:uint = 0;
			var font$count:uint = 0;
			var color$count:uint = 0;
			var size$count:uint = 0;
			var align$count:uint = 0;
			var italic$count:uint = 0;
			var bold$count:uint = 0;
			var text$count:uint = 0;
			var compData$count:uint = 0;
			var alpha$count:uint = 0;
			var index$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 200001:
					if (childClassName$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.childClassName cannot be set twice.');
					}
					++childClassName$count;
					this.childClassName = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 200002:
					if (type$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.type cannot be set twice.');
					}
					++type$count;
					this.type = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 200003:
					if (x$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.x cannot be set twice.');
					}
					++x$count;
					this.x = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 200004:
					if (y$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.y cannot be set twice.');
					}
					++y$count;
					this.y = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 200005:
					if (scaleX$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.scaleX cannot be set twice.');
					}
					++scaleX$count;
					this.scaleX = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 200006:
					if (scaleY$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.scaleY cannot be set twice.');
					}
					++scaleY$count;
					this.scaleY = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 200007:
					if (sketwX$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.sketwX cannot be set twice.');
					}
					++sketwX$count;
					this.sketwX = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 200008:
					if (sketwY$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.sketwY cannot be set twice.');
					}
					++sketwY$count;
					this.sketwY = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 200009:
					if (childName$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.childName cannot be set twice.');
					}
					++childName$count;
					this.childName = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 200010:
					if (isQuadBatch$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.isQuadBatch cannot be set twice.');
					}
					++isQuadBatch$count;
					this.isQuadBatch = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 200011:
					if (ownerName$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.ownerName cannot be set twice.');
					}
					++ownerName$count;
					this.ownerName = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 200012:
					if (width$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.width cannot be set twice.');
					}
					++width$count;
					this.width = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 200013:
					if (height$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.height cannot be set twice.');
					}
					++height$count;
					this.height = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 200014:
					if (font$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.font cannot be set twice.');
					}
					++font$count;
					this.font = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 200015:
					if (color$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.color cannot be set twice.');
					}
					++color$count;
					this.color = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 200016:
					if (size$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.size cannot be set twice.');
					}
					++size$count;
					this.size = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 200017:
					if (align$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.align cannot be set twice.');
					}
					++align$count;
					this.align = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 200018:
					if (italic$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.italic cannot be set twice.');
					}
					++italic$count;
					this.italic = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 200019:
					if (bold$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.bold cannot be set twice.');
					}
					++bold$count;
					this.bold = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 200020:
					if (text$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.text cannot be set twice.');
					}
					++text$count;
					this.text = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 200021:
					if (compData$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.compData cannot be set twice.');
					}
					++compData$count;
					this.compData = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 200022:
					if (alpha$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.alpha cannot be set twice.');
					}
					++alpha$count;
					this.alpha = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 200023:
					if (index$count != 0) {
						throw new flash.errors.IOError('Bad data format: SpriteData.index cannot be set twice.');
					}
					++index$count;
					this.index = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 200024:
					this.spriteChildsData.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new SpriteData()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
