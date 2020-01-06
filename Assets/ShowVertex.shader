// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Vertex/Show Vertex"
{
    Properties
    {
        _FragColor("片段颜色", Color) = (1.0, 0.0, 0.0, 1.0)
        _vertexSize("点的大小", range(0.0, 500.0)) = 0.2
    }
    SubShader
    {
        pass
        {
            //lend SrcAlpha OneMinusSrcAlpha
            //Cull Front
            Cull Back
            ZWrite Off
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
                //o.worldNormal = 
                
                return o;
            }

            fixed4 frag(psIn o, float4 vertInScreenPos : SV_POSITION) : SV_TARGET
            {
                float4 screenPos = o.screenPos;
                screenPos.xy *= _ScreenParams.xy; 
                float vertexRange = distance(vertInScreenPos.xy, screenPos.xy);
                if(vertexRange >= _vertexSize)
                {
                    return _FragColor;
                }
                else{
                    return fixed4(0.0, 1.0, 0.0, 1.0);
                }
            }
            ENDCG
        }
        
    }
    Fallback Off
}