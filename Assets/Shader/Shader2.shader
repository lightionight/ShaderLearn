
Shader "MyShader/OutLine"
{
    Properties
    {
        _outColor("Outline Color", color) = (1, 1, 1, 1)
        _MainTex("texture", 2D) = "white"{}
        _Width("width", Range(0, 0.5)) = 0.1
        

    }
    SubShader
    {
        Tags{ "RenderType" = "Opaque"}
        LOD 100
        pass
        {
            Cull Front
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
            #include "UnityCG.cginc"
            struct a2v
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct v2f
            {
                float4 pos : SV_POSITION;
            };

            fixed4 _outColor;
            float _Width;

            v2f vert(a2v v)
            {
                v2f o;
                v.vertex.xyz += v.normal * _Width;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            fixed4 frag(v2f i) : SV_TARGET
            {
                return _outColor;
            }
            ENDCG
        }
        pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct a2v
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            sampler2D _MainTex;
            float4 _MainTex_ST; 

            v2f vert(a2v v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv , _MainTex);
                return o;
            }
            fixed4  frag(v2f i) : SV_TARGET
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
    Fallback "Sprites/Diffuse"
}