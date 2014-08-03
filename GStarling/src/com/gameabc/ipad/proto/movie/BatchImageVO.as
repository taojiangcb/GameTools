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
	public dynamic final class BatchImageVO extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gameabc.ipad.proto.movie.BatchImageVO.name", "name", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
		public static const ALPHA:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.gameabc.ipad.proto.movie.BatchImageVO.alpha", "alpha", (2 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var alpha$field:Number;

		private var hasField$0:uint = 0;

		public function clearAlpha():void {
			hasField$0 &= 0xfffffffe;
			alpha$field = new Number();
		}

		public function get hasAlpha():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set alpha(value:Number):void {
			hasField$0 |= 0x1;
			alpha$field = value;
		}

		public function get alpha():Number {
			return alpha$field;
		}

		/**
		 *  @private
		 */
		public static const COLOR:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gameabc.ipad.proto.movie.BatchImageVO.color", "color", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var color$field:int;

		public function clearColor():void {
			hasField$0 &= 0xfffffffd;
			color$field = new int();
		}

		public function get hasColor():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set color(value:int):void {
			hasField$0 |= 0x2;
			color$field = value;
		}

		public function get color():int {
			return color$field;
		}

		/**
		 *  @private
		 */
		public static const HEIGHT:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.gameabc.ipad.proto.movie.BatchImageVO.height", "height", (4 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var height$field:Number;

		public function clearHeight():void {
			hasField$0 &= 0xfffffffb;
			height$field = new Number();
		}

		public function get hasHeight():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set height(value:Number):void {
			hasField$0 |= 0x4;
			height$field = value;
		}

		public function get height():Number {
			return height$field;
		}

		/**
		 *  @private
		 */
		public static const WIDTH:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.gameabc.ipad.proto.movie.BatchImageVO.width", "width", (5 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var width$field:Number;

		public function clearWidth():void {
			hasField$0 &= 0xfffffff7;
			width$field = new Number();
		}

		public function get hasWidth():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set width(value:Number):void {
			hasField$0 |= 0x8;
			width$field = value;
		}

		public function get width():Number {
			return width$field;
		}

		/**
		 *  @private
		 */
		public static const X:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.gameabc.ipad.proto.movie.BatchImageVO.x", "x", (6 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var x$field:Number;

		public function clearX():void {
			hasField$0 &= 0xffffffef;
			x$field = new Number();
		}

		public function get hasX():Boolean {
			return (hasField$0 & 0x10) != 0;
		}

		public function set x(value:Number):void {
			hasField$0 |= 0x10;
			x$field = value;
		}

		public function get x():Number {
			return x$field;
		}

		/**
		 *  @private
		 */
		public static const Y:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.gameabc.ipad.proto.movie.BatchImageVO.y", "y", (7 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var y$field:Number;

		public function clearY():void {
			hasField$0 &= 0xffffffdf;
			y$field = new Number();
		}

		public function get hasY():Boolean {
			return (hasField$0 & 0x20) != 0;
		}

		public function set y(value:Number):void {
			hasField$0 |= 0x20;
			y$field = value;
		}

		public function get y():Number {
			return y$field;
		}

		/**
		 *  @private
		 */
		public static const PIVOTX:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.gameabc.ipad.proto.movie.BatchImageVO.pivotX", "pivotX", (8 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var pivotX$field:Number;

		public function clearPivotX():void {
			hasField$0 &= 0xffffffbf;
			pivotX$field = new Number();
		}

		public function get hasPivotX():Boolean {
			return (hasField$0 & 0x40) != 0;
		}

		public function set pivotX(value:Number):void {
			hasField$0 |= 0x40;
			pivotX$field = value;
		}

		public function get pivotX():Number {
			return pivotX$field;
		}

		/**
		 *  @private
		 */
		public static const PIVOTY:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.gameabc.ipad.proto.movie.BatchImageVO.pivotY", "pivotY", (9 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var pivotY$field:Number;

		public function clearPivotY():void {
			hasField$0 &= 0xffffff7f;
			pivotY$field = new Number();
		}

		public function get hasPivotY():Boolean {
			return (hasField$0 & 0x80) != 0;
		}

		public function set pivotY(value:Number):void {
			hasField$0 |= 0x80;
			pivotY$field = value;
		}

		public function get pivotY():Number {
			return pivotY$field;
		}

		/**
		 *  @private
		 */
		public static const SCALEX:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.gameabc.ipad.proto.movie.BatchImageVO.scaleX", "scaleX", (10 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var scaleX$field:Number;

		public function clearScaleX():void {
			hasField$0 &= 0xfffffeff;
			scaleX$field = new Number();
		}

		public function get hasScaleX():Boolean {
			return (hasField$0 & 0x100) != 0;
		}

		public function set scaleX(value:Number):void {
			hasField$0 |= 0x100;
			scaleX$field = value;
		}

		public function get scaleX():Number {
			return scaleX$field;
		}

		/**
		 *  @private
		 */
		public static const SCALEY:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.gameabc.ipad.proto.movie.BatchImageVO.scaleY", "scaleY", (11 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var scaleY$field:Number;

		public function clearScaleY():void {
			hasField$0 &= 0xfffffdff;
			scaleY$field = new Number();
		}

		public function get hasScaleY():Boolean {
			return (hasField$0 & 0x200) != 0;
		}

		public function set scaleY(value:Number):void {
			hasField$0 |= 0x200;
			scaleY$field = value;
		}

		public function get scaleY():Number {
			return scaleY$field;
		}

		/**
		 *  @private
		 */
		public static const SKEWX:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.gameabc.ipad.proto.movie.BatchImageVO.skewX", "skewX", (12 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var skewX$field:Number;

		public function clearSkewX():void {
			hasField$0 &= 0xfffffbff;
			skewX$field = new Number();
		}

		public function get hasSkewX():Boolean {
			return (hasField$0 & 0x400) != 0;
		}

		public function set skewX(value:Number):void {
			hasField$0 |= 0x400;
			skewX$field = value;
		}

		public function get skewX():Number {
			return skewX$field;
		}

		/**
		 *  @private
		 */
		public static const SKEWY:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.gameabc.ipad.proto.movie.BatchImageVO.skewY", "skewY", (13 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var skewY$field:Number;

		public function clearSkewY():void {
			hasField$0 &= 0xfffff7ff;
			skewY$field = new Number();
		}

		public function get hasSkewY():Boolean {
			return (hasField$0 & 0x800) != 0;
		}

		public function set skewY(value:Number):void {
			hasField$0 |= 0x800;
			skewY$field = value;
		}

		public function get skewY():Number {
			return skewY$field;
		}

		/**
		 *  @private
		 */
		public static const ROTATION:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.gameabc.ipad.proto.movie.BatchImageVO.rotation", "rotation", (14 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		private var rotation$field:Number;

		public function clearRotation():void {
			hasField$0 &= 0xffffefff;
			rotation$field = new Number();
		}

		public function get hasRotation():Boolean {
			return (hasField$0 & 0x1000) != 0;
		}

		public function set rotation(value:Number):void {
			hasField$0 |= 0x1000;
			rotation$field = value;
		}

		public function get rotation():Number {
			return rotation$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasName) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, name$field);
			}
			if (hasAlpha) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, alpha$field);
			}
			if (hasColor) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, color$field);
			}
			if (hasHeight) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, height$field);
			}
			if (hasWidth) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, width$field);
			}
			if (hasX) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, x$field);
			}
			if (hasY) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 7);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, y$field);
			}
			if (hasPivotX) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 8);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, pivotX$field);
			}
			if (hasPivotY) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 9);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, pivotY$field);
			}
			if (hasScaleX) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 10);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, scaleX$field);
			}
			if (hasScaleY) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, scaleY$field);
			}
			if (hasSkewX) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 12);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, skewX$field);
			}
			if (hasSkewY) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 13);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, skewY$field);
			}
			if (hasRotation) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 14);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, rotation$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var name$count:uint = 0;
			var alpha$count:uint = 0;
			var color$count:uint = 0;
			var height$count:uint = 0;
			var width$count:uint = 0;
			var x$count:uint = 0;
			var y$count:uint = 0;
			var pivotX$count:uint = 0;
			var pivotY$count:uint = 0;
			var scaleX$count:uint = 0;
			var scaleY$count:uint = 0;
			var skewX$count:uint = 0;
			var skewY$count:uint = 0;
			var rotation$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (name$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchImageVO.name cannot be set twice.');
					}
					++name$count;
					this.name = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 2:
					if (alpha$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchImageVO.alpha cannot be set twice.');
					}
					++alpha$count;
					this.alpha = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 3:
					if (color$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchImageVO.color cannot be set twice.');
					}
					++color$count;
					this.color = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 4:
					if (height$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchImageVO.height cannot be set twice.');
					}
					++height$count;
					this.height = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 5:
					if (width$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchImageVO.width cannot be set twice.');
					}
					++width$count;
					this.width = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 6:
					if (x$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchImageVO.x cannot be set twice.');
					}
					++x$count;
					this.x = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 7:
					if (y$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchImageVO.y cannot be set twice.');
					}
					++y$count;
					this.y = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 8:
					if (pivotX$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchImageVO.pivotX cannot be set twice.');
					}
					++pivotX$count;
					this.pivotX = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 9:
					if (pivotY$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchImageVO.pivotY cannot be set twice.');
					}
					++pivotY$count;
					this.pivotY = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 10:
					if (scaleX$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchImageVO.scaleX cannot be set twice.');
					}
					++scaleX$count;
					this.scaleX = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11:
					if (scaleY$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchImageVO.scaleY cannot be set twice.');
					}
					++scaleY$count;
					this.scaleY = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 12:
					if (skewX$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchImageVO.skewX cannot be set twice.');
					}
					++skewX$count;
					this.skewX = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 13:
					if (skewY$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchImageVO.skewY cannot be set twice.');
					}
					++skewY$count;
					this.skewY = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 14:
					if (rotation$count != 0) {
						throw new flash.errors.IOError('Bad data format: BatchImageVO.rotation cannot be set twice.');
					}
					++rotation$count;
					this.rotation = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
