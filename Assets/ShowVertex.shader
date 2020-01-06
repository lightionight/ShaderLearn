// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Vertex/Show Vertex"
{
    Properties
    {
        _FragColor("片段颜色", Color) = (1.0, 0.0, 0.0, 1.0)
    }
    SubShader
    {
        pass
        {
            //Blend SrcAlpha OneMinusSrcAlpha
            //Cull Off
            //ZWrite Off
            CGPROGRAM
            #pragma vertex verts
            //#pragma geometry geom
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "UnityShaderVariables.cginc"
            fixed4 _FragColor;

            struct vsIn
            {
                float4 pos : POSITION;
            };
            struct psIn
            {
                float4 fPos : SV_POSITION;
            };

            psIn vert(vsIn v)
            {
                psIn o;  
                float4 viewPos = mul(UNITY_MATRIX_MV, float4(v.pos.xyz, 1.0));
                o.fPos = mul(UNITY_MATRIX_P, viewPos);
                return o;
            }

            fixed4 frag(psIn o) : SV_TARGET
            {
                return _FragColor;
            }
            ENDCG
        }
        
    }
    Fallback Off
}