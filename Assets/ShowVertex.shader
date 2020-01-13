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
             #pragma enable_d3d11_debug_symbols
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
                nointerpolation float4 screenPos : TEXCOORD1;
            };

            fsIn vert(vsIn v)
            {
                fsIn o;
                o.pos = UnityObjectToClipPos(v.pos);
                o.screenPos = o.pos;
                o.screenPos.xy = ((o.screenPos.xy / o.screenPos.w) + 1.0) * 0.5 * _ScreenParams.xy;      
                o.screenPos.y = -o.screenPos.y;
                return o;
            }
            //传入的o.screenPos.xyz 是每个像素点在世界坐标下胡坐标值,进行了插值
            fixed4 frag(fsIn o) : SV_TARGET
            { 
                // float vertexSizeRange = distance(o.screenPos.xy, o.pos.xy);
                // if(vertexSizeRange <= _vertexSize)
                // {
                //     return _vertexColor;
                // }
                // else
                // {
                //     return _FragColor;
                // }
                if(o.screenPos.x < 50)
                {
                    return fixed();
                }
                else
                {
                    return _FragColor;
                }
            }
            ENDCG
        }
        
    }
    Fallback Off
}