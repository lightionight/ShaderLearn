// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Vertex/Show Vertex"
{
    Properties
    {
        _FragColor("片段颜色", Color) = (1.0, 0.0, 0.0, 1.0)
        _vertexSize("顶点大小", Range(0.0, 1000)) = 1.0
    }
    SubShader
    {
        pass
        {
            CGPROGRAM
            #pragma vertex vert
            //#pragma geometry geom
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "UnityShaderVariables.cginc"
            fixed4 _FragColor;
            float _vertexSize;

            struct vsIn
            {
                float4 pos : POSITION;
            };
            struct fsIn
            {
                float4 pos : SV_POSITION;
                float4 vertexScreenPos : TEXCOORD1;
            };

            fsIn vert(vsIn v)
            {
                fsIn o;
                float4 worldPos = float4(mul(unity_ObjectToWorld, v.pos));
                float4 viewPos = (mul(UNITY_MATRIX_V, worldPos));
                o.pos = mul(UNITY_MATRIX_P, viewPos);          
                o.vertexScreenPos = o.pos;// clip Position
                o.vertexScreenPos.xy /= o.vertexScreenPos.w;//transform to NDC Position
                o.vertexScreenPos.xy = (o.vertexScreenPos.xy + 1.0) * 0.5 * _ScreenParams.xy;//transofrm to Screen pixel position
                return o;
            }

            fixed4 frag(fsIn o) : SV_TARGET
            {
                float vertexRange = distance(o.vertexScreenPos.xy, o.pos.xy);
                if(_vertexSize - vertexRange > 0)
                //clip(o.Pos.x - _vertexSize);
                {
                    return _FragColor;

                }
                else
                {
                    return fixed4(1.0, 1.0, 1.0, 1.0);
                }
            }
            ENDCG
        }
        
    }
    Fallback Off
}