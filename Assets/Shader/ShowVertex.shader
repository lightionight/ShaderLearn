Shader "Vertex/Show Vertex"
{
    Properties
    {
        _FragColor("片段颜色", Color) = (1.0, 0.0, 0.0, 1.0)
        _vertexColor("顶点颜色", Color) = (0.0, 1.0, 0.0, 1.0)
        _vertexSize("顶点大小", float) = 10
        _MainTex("Texture Image", 2D) = "black"{}
    }
    SubShader
    {
        pass
        {
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
                float4 uv : TEXCOORD0;
            };
            struct v2f{
                float4 pos : SV_POSITION;
                float size : PSIZE;
                float4 Tex0 : TEXCOORD0;
            };

            v2f vert(a2v i){
                v2f o;
                o.pos = UnityObjectToClipPos(i.pos);
                //UNITY_INITIALIZE_OUTPUT(v2f o);
                o.size = _vertexSize;
                o.Tex0 = i.uv;
                // o.pos = UnityObjectToClipPos(i.pos);
                // o.vertexScreenPos = o.pos;
                // o.vertexScreenPos.xy = ((o.vertexScreenPos.xy / o.vertexScreenPos.w) + 1) * 0.5 * _ScreenParams.xy;
                return o;
            }
            
            float4 frag(v2f i) :SV_TARGET
            {
                // if(distance(o.pos.xy, o.vertexScreenPos.xy) < _vertexSize)
                // {
                //     return _vertexColor;
                // }
                // else
                // {
                //     return _FragColor;

                // }
                //return float4(sin(i.vertexScreenPos.xy), 0.0, 1.0);
                float4 c = tex2D(_MainTex, i.Tex0);
                return c;
            }

            ENDCG
        }
        
    }
    Fallback Off
}