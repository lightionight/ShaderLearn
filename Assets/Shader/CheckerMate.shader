Shader "MyShader/Checkmate"
{
    Properties
    {
        _Color ("棋盘颜色", Color) = (1, 0, 1, 1)
    }
    SubShader
    {
        pass
        {
            Name "CHECKMATE"
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            half _Color;
            
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos: SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;

            }

            fixed checker(float2 uv)
            {
                float2 repeatUV = uv * 2;
                float2 c = floor(repeatUV) /2;
                float checker = frac(c.x + c.y) * 2;
                return checker;
            }
            
            fixed4 frag(v2f i) : SV_TARGET
            {                
                return checker(i.uv);
            }
            ENDCG




        }
    }
}