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
            struct psIn
            {
                float4 fPos : SV_POSITION;
                float4 screenPos : TEXCOORD1;
            };

            psIn vert(vsIn v)
            {
                psIn o;
                float4 worldPos = float4(mul(unity_ObjectToWorld, v.pos));
                float4 viewPos = (mul(UNITY_MATRIX_V, worldPos));
                float4 clipPos = mul(UNITY_MATRIX_P, viewPos);
                o.fPos = clipPos;
                o.screenPos = ComputeScreenPos(o.fPos);
                
                return o;
            }

            fixed4 frag(psIn o) : SV_TARGET
            {
                o.screenPos /= o.screenPos.w;
                
                float vertexRange = distance(o.screenPos.xy, o.fPos.xy);
                clip((_vertexSize-vertexRange) - 0.0 );
                return _FragColor;
            }
            ENDCG
        }
        
    }
    Fallback Off
}