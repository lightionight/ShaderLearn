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
            #include "UnityCG.cginc"
            #include "UnityShaderVariables.cginc"
            fixed4 _FragColor;
            fixed4 _vertexColor;
            float _vertexSize;

            struct vsIn
            {
                float4 pos : POSITION;
                float4 txCd : TEXCOORD0;
            };
            struct fsIn
            {
                float4 pos : SV_POSITION;
                float4 texCd :TEXCOORD0;
                float4 screenPos : TEXCOORD1;
            };

            fsIn vert(vsIn v)
            {
                fsIn o;
                o.pos = UnityObjectToClipPos(v.pos);
                o.texCd = v.txCd;
                o.screenPos = mul(UNITY_MATRIX_M, v.pos);
                o.screenPos.y = -o.screenPos.y;
                //o.screenPos.xy = ((o.screenPos.xy / o.screenPos.w) + 1.0) * 0.5 * _ScreenParams.xy;      
                return o;
            }
            

            fixed4 frag(fsIn o) : SV_TARGET
            {
                // float vertexRange = distance(o.screenPos.xy, float2(200, 500));
                // if(vertexRange < _vertexSize)
                // {
                //     return _vertexColor;
                // }
                // else
                // {
                //     return _FragColor;
                // }
                //return float4((vertexRange / 768), 0.0, 0.0, 1.0);
                //o.screenPos.xyz 是每个像素点在世界坐标下胡坐标值,进行了插值
                return float4(o.screenPos.xyz, 1.0f);
            }
            ENDCG
        }
        
    }
    Fallback Off
}