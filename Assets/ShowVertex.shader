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
            fixed4 _FragColor;
            fixed4 _vertexColor;
            float _vertexSize;

            struct vsIn
            {
                float4 pos : POSITION;
            };
            struct fsIn
            {
                float4 pos : SV_POSITION;
                float4 screenPos[1] : TEXCOORD1;
            };

            fsIn vert(vsIn v)
            {
                fsIn o;
                o.pos = UnityObjectToClipPos(v.pos);
                // o.screenPos = mul(UNITY_MATRIX_M, v.pos);
                o.screenPos[0] = o.pos;
                o.screenPos[0].xy = ((o.screenPos[0].xy / o.screenPos[0].w) + 1.0) * 0.5 * _ScreenParams.xy;      
                o.screenPos[0].y = -o.screenPos[0].y;
                return o;
            }
            //传入的o.screenPos.xyz 是每个像素点在世界坐标下胡坐标值,进行了插值
            fixed4 frag(fsIn o) : SV_TARGET
            { 
                float vertexSizeRange = distance(o.screenPos[0].xy, o.pos.xy);
                clip(vertexSizeRange - 20.0);
                // if(vertexSizeRange <= 20.0)
                // {
                //     return _vertexColor;
                // }
                // else
                // {
                //     return _FragColor;
                // }
                return fixed4(o.screenPos[0].xyz, 1.0);
            }
            ENDCG
        }
        
    }
    Fallback Off
}