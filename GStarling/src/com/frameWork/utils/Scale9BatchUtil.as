/*
Feathers
Copyright 2012-2013 Joshua Tynjala. All Rights Reserved.

This program is free software. You can redistribute and/or modify it in
accordance with the terms of the accompanying license agreement.
*/
package com.frameWork.utils
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.textures.TextureSmoothing;

	/**
	 * Scales an image with nine regions to maintain the aspect ratio of the
	 * corners regions. The top and bottom regions stretch horizontally, and the
	 * left and right regions scale vertically. The center region stretches in
	 * both directions to fill the remaining space.
	 */
	public class Scale9BatchUtil
	{
		/**
		 * @private
		 */
		private static const HELPER_MATRIX:Matrix = new Matrix();

		/**
		 * @private
		 */
		private static const HELPER_POINT:Point = new Point();

		/**
		 * @private
		 */
		private static var helperImage:Image;

		/**
		 * @private
		 */
		private static var _smoothing:String = TextureSmoothing.BILINEAR;

		/**
		 * The smoothing value to pass to the images.
		 *
		 * <p>In the following example, the smoothing is changed:</p>
		 *
		 * <listing version="3.0">
		 * image.smoothing = TextureSmoothing.NONE;</listing>
		 *
		 * @default starling.textures.TextureSmoothing.BILINEAR
		 *
		 * @see starling.textures.TextureSmoothing
		 */
		public static function get smoothing():String
		{
			return _smoothing;
		}

		/**
		 * @private
		 */
		public static function set smoothing(value:String):void
		{
			_smoothing = value;
		}

		/**
		 * @private
		 */
		private static var _color:uint = 0xffffff;

		/**
		 * The color value to pass to the images.
		 *
		 * <p>In the following example, the color is changed:</p>
		 *
		 * <listing version="3.0">
		 * image.color = 0xff00ff;</listing>
		 *
		 * @default 0xffffff
		 */
		public static function get color():uint
		{
			return _color;
		}

		/**
		 * @private
		 */
		public static function set color(value:uint):void
		{
			_color = value;
		}

		/**
		 * @private
		 */
		public static function getScale9Batch(_textures:Scale9Textures, _width:Number, _height:Number, _batch:QuadBatch = null, _offsetX:int = 0, _offsetY:int = 0):QuadBatch
		{
			if (_batch == null) {
				_batch = new QuadBatch();
				_batch.touchable = false;
			}
			
			if (_textures.topLeft.height > 0)
			{
				if (!helperImage)
					helperImage = new Image(_textures.topLeft);
				helperImage.smoothing = _smoothing;
				helperImage.color = _color;
			}

			var _frame:Rectangle = _textures.texture.frame;
			if(!_frame)
			{
				_frame = new Rectangle(0, 0, _textures.texture.width, _textures.texture.height);
			}
			const grid:Rectangle = _textures.scale9Grid;
			var scaledLeftWidth:Number = grid.x;
			var scaledTopHeight:Number = grid.y;
			var scaledRightWidth:Number = (_frame.width - grid.x - grid.width);
			var scaledBottomHeight:Number = (_frame.height - grid.y - grid.height);
			const scaledCenterWidth:Number = _width - scaledLeftWidth - scaledRightWidth;
			const scaledMiddleHeight:Number = _height - scaledTopHeight - scaledBottomHeight;
			if(scaledCenterWidth < 0)
			{
				var offset:Number = scaledCenterWidth / 2;
				scaledLeftWidth += offset;
				scaledRightWidth += offset;
			}
			if(scaledMiddleHeight < 0)
			{
				offset = scaledMiddleHeight / 2;
				scaledTopHeight += offset;
				scaledBottomHeight += offset;
			}

			if(scaledTopHeight > 0)
			{
				if(scaledLeftWidth > 0)
				{
					if (!helperImage)
						helperImage = new Image(_textures.topLeft);
					else
						helperImage.texture = _textures.topLeft;
					helperImage.readjustSize();
					helperImage.width = scaledLeftWidth;
					helperImage.height = scaledTopHeight;
					helperImage.x = scaledLeftWidth - helperImage.width + _offsetX;
					helperImage.y = scaledTopHeight - helperImage.height + _offsetY;
					_batch.addImage(helperImage);
				}

				if(scaledCenterWidth > 0)
				{
					if (!helperImage)
						helperImage = new Image(_textures.topCenter);
					else
					helperImage.texture = _textures.topCenter;
					helperImage.readjustSize();
					helperImage.width = scaledCenterWidth;
					helperImage.height = scaledTopHeight;
					helperImage.x = scaledLeftWidth + _offsetX;
					helperImage.y = scaledTopHeight - helperImage.height + _offsetY;
					_batch.addImage(helperImage);
				}

				if(scaledRightWidth > 0)
				{
					if (!helperImage)
						helperImage = new Image(_textures.topRight);
					else
					helperImage.texture = _textures.topRight;
					helperImage.readjustSize();
					helperImage.width = scaledRightWidth;
					helperImage.height = scaledTopHeight;
					helperImage.x = _width - scaledRightWidth + _offsetX;
					helperImage.y = scaledTopHeight - helperImage.height + _offsetY;
					_batch.addImage(helperImage);
				}
			}

			if(scaledMiddleHeight > 0)
			{
				if(scaledLeftWidth > 0)
				{
					if (!helperImage)
						helperImage = new Image(_textures.middleLeft);
					else
					helperImage.texture = _textures.middleLeft;
					helperImage.readjustSize();
					helperImage.width = scaledLeftWidth;
					helperImage.height = scaledMiddleHeight;
					helperImage.x = scaledLeftWidth - helperImage.width + _offsetX;
					helperImage.y = scaledTopHeight + _offsetY;
					_batch.addImage(helperImage);
				}

				if(scaledCenterWidth > 0)
				{
					if (!helperImage)
						helperImage = new Image(_textures.middleCenter);
					else
					helperImage.texture = _textures.middleCenter;
					helperImage.readjustSize();
					helperImage.width = scaledCenterWidth;
					helperImage.height = scaledMiddleHeight;
					helperImage.x = scaledLeftWidth + _offsetX;
					helperImage.y = scaledTopHeight + _offsetY;
					_batch.addImage(helperImage);
				}

				if(scaledRightWidth > 0)
				{
					if (!helperImage)
						helperImage = new Image(_textures.middleRight);
					else
					helperImage.texture = _textures.middleRight;
					helperImage.readjustSize();
					helperImage.width = scaledRightWidth;
					helperImage.height = scaledMiddleHeight;
					helperImage.x = _width - scaledRightWidth + _offsetX;
					helperImage.y = scaledTopHeight + _offsetY;
					_batch.addImage(helperImage);
				}
			}

			if(scaledBottomHeight > 0)
			{
				if(scaledLeftWidth > 0)
				{
					if (!helperImage)
						helperImage = new Image(_textures.bottomLeft);
					else
					helperImage.texture = _textures.bottomLeft;
					helperImage.readjustSize();
					helperImage.width = scaledLeftWidth;
					helperImage.height = scaledBottomHeight;
					helperImage.x = scaledLeftWidth - helperImage.width + _offsetX;
					helperImage.y = _height - scaledBottomHeight + _offsetY;
					_batch.addImage(helperImage);
				}

				if(scaledCenterWidth > 0)
				{
					if (!helperImage)
						helperImage = new Image(_textures.bottomCenter);
					else
					helperImage.texture = _textures.bottomCenter;
					helperImage.readjustSize();
					helperImage.width = scaledCenterWidth;
					helperImage.height = scaledBottomHeight;
					helperImage.x = scaledLeftWidth + _offsetX;
					helperImage.y = _height - scaledBottomHeight + _offsetY;
					_batch.addImage(helperImage);
				}

				if(scaledRightWidth > 0)
				{
					if (!helperImage)
						helperImage = new Image(_textures.bottomRight);
					else
					helperImage.texture = _textures.bottomRight;
					helperImage.readjustSize();
					helperImage.width = scaledRightWidth;
					helperImage.height = scaledBottomHeight;
					helperImage.x = _width - scaledRightWidth + _offsetX;
					helperImage.y = _height - scaledBottomHeight + _offsetY;
					_batch.addImage(helperImage);
				}
			}
			return _batch;
		}
	}
}