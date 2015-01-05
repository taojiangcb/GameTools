package starling.extensions.graphicPack.materials
{
	import starling.extensions.shaders.fragment.TextureVertexColorFragmentShader;
	import starling.extensions.shaders.vertex.StandardVertexShader;
	import starling.textures.Texture;
	
	public class TextureMaterial extends StandardMaterial
	{
		public function TextureMaterial(texture:Texture, color:uint = 0xFFFFFF)
		{
			super(new StandardVertexShader(), new TextureVertexColorFragmentShader());
			textures[0] = texture;
			this.color = color;
		}
	}
}