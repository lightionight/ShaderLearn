// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "MyShader/Sprite_test"
{
    Properties
    {
        _Color("Main_color", Color) = (1, 1, 1, 1)
    }

    SubShader
    {
        Tags{"RenderType" = "Opaque"}
        LOD 100
        pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            fixed4 _Color;
            float4 vert(float4 vertex : POSITION) : SV_POSITION
            {
                return UnityObjectToClipPos(vertex);
            }
            fixed4 frag(): SV_TARGET
            {
                return _Color;
            }
            ENDCG
        }

    }
    Fallback "Sprites/diffuse"

}
