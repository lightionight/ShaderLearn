Shader "MyShader/ChangeColor"
{
    Properties
    {
        _Color("主要颜色", color) = (1, 1, 1, 1)
    }
    SubShader
    {
        pass
        {
            Cull Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            fixed4 _Color;
            float4 vert(float4 vertex : POSITION) : SV_POSITION
            {
                return UnityObjectToClipPos(vertex);
            }
            
            fixed4 frag() : SV_TARGET
            {
                return _Color;
            }
            ENDCG
        }
    }
}