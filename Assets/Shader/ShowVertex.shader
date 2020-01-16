Shader "Vertex/Show Vertex"
{
    Properties
    {
        
        _FragColor("片段颜色", Color) = (1.0, 0.0, 0.0, 1.0)
        _vertexColor("顶点颜色", Color) = (0.0, 1.0, 0.0, 1.0)
        _vertexSize("顶点大小", float) = 10
        _MainTex("Texture Image", 2D) = "white"{}
    }
    SubShader
    {
        pass
        {
            //Cull Front
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            //PointSpriteEnable = bool(enable);
            float4 _FragColor;
            float4 _vertexColor;
            float  _vertexSize;
            sampler2D _MainTex;

            struct a2v{
                float4 pos : POSITION;
            };
            struct v2f{
                float4 pos : SV_POSITION;
                float4 vsPos : TEXCOORD0;
            };

            v2f vert(a2v i){
                v2f o;
                o.pos = UnityObjectToClipPos(i.pos);
                o.vsPos = o.pos;
                return o;
            }
            
            float4 frag(v2f i) :SV_TARGET
            {
                if(i.pos.x < 200)
                {
                    return _FragColor;
                }
                else
                {
                    return _vertexColor;
                }
            }
            ENDCG
        }
        
    }
    Fallback Off
}