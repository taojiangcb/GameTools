package starling.extensions.graphicPack 
{
	import flash.geom.Matrix;
	
	import starling.extensions.graphicPack.materials.IMaterial;
	
	/**
	 * ...
	 * @author Henrik Jonsson
	 */
	public class GraphicsMaterialFill implements IGraphicsData 
	{
		protected var mMaterial:IMaterial;
		protected var mMatrix:Matrix;
		
		public function GraphicsMaterialFill(material:IMaterial, uvMatrix:Matrix = null ) 
		{
			mMaterial = material;
			mMatrix = uvMatrix;
		}
		
		public function get material() : IMaterial
		{
			return mMaterial;
		}
		
		public function get matrix() : Matrix
		{
			return mMatrix;
		}
	}

}