Shader "Vertex/Show Vertex"
{
    Properties
    {
        _FragColor("片段颜色", Color) = (1.0, 0.0, 0.0, 1.0)
        _vertexColor("顶点颜色", Color) = (0.0, 1.0, 0.0, 1.0)
        _vertexSize("顶点大小", Range(0.0, 1000)) = 1.0
    }
    SubShader
    {
        pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            float4 _FragColor;
            float4 _vertexColor;
            float  _vertexSize;

            struct a2v{
                float4 pos : POSITION;
            };
            struct v2f{
                float4 pos : SV_POSITION;
                nointerpolation float4 vertexScreenPos : TEXCOORD1;
            };

            v2f vert(a2v i){
                v2f o;
                o.pos = UnityObjectToClipPos(i.pos);
                o.vertexScreenPos = o.pos;
                o.vertexScreenPos.xy = ((o.vertexScreenPos.xy / o.vertexScreenPos.w) + 1) * 0.5 * _ScreenParams.xy;
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
                return float4(sin(i.vertexScreenPos.xy), 0.0, 1.0);
            }

            ENDCG
        }
        
    }
    Fallback Off
}