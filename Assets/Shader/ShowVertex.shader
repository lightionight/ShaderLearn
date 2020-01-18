/*

[reference]
https://forum.unity.com/threads/program-a-shader-that-only-displays-the-visible-edges.773534/#post-5151950
Q:
1. TexCoord UV ?
*/
Shader "Vertex/Show Vertex"
{
    Properties
    {
        
        _FragColor("片段颜色", Color) = (1.0, 0.0, 0.0, 1.0)
        _vertexColor("顶点颜色", Color) = (0.0, 1.0, 0.0, 1.0)
        _vertexSize("顶点大小", float) = 10
        _offset("偏移值", float) = 1.0
    }
    SubShader
    {
        pass
        {
            //Cull Front
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex vert
            //#pragma geometry geom
            #pragma fragment frag
            //PointSpriteEnable = bool(enable);
            float4 _FragColor;
            float4 _vertexColor;
            float  _vertexSize;
            sampler2D _MainTex;
            float _offset;
            
            struct VSIN{
                float4 pos : POSITION;
            };

            struct VSOUT{
                float4 pos : SV_POSITION;
                nointerpolation float4 result : TEXCOORD0;
            };

            VSOUT vert(VSIN i){
                VSOUT o;
                o.pos =UnityObjectToClipPos(i.pos);
                o.result = UnityObjectToClipPos(i.pos);
                o.result.xy /= o.result.w;
                o.result.x = (1 + o.result.x) * 0.5 * _ScreenParams.x;
                o.result.y = (1 - o.result.y) * 0.5 * _ScreenParams.y;
                return o;

            }

            fixed4 frag(VSOUT i): SV_TARGET{
                float dis = distance(i.pos.xy, i.result.xy);
                if(dis > _vertexSize / 2)
                {
                   return _FragColor;
                }
                else{
                    return _vertexColor;
                }
                // clip (dis - (_vertexSize /2));
                // return _vertexColor;
            }

            ENDCG
        }
        
    }
    Fallback Off
}

