Shader "Vertex/Show Vertex"
{
    Properties
    {
        //_Color("顶点颜色", Color) = (1, 1, 1, 0)
        //_AlphaColor("透明度", Range(0, 1)) = 0.5
        _PointSize("点的大小", Range(0.1, 5.0)) = 1.0
        _PointColor("顶点颜色", Color) = (1.0, 1.0, 1.0, 0.0)
        _FragColor("片段颜色", Color) = (1.0, 0.0, 0.0, 1.0)
        _PointX("Point_X", float) = 1.0
        _PointY("Point_Y", float) = 1.0
    }
    SubShader
    {
        pass
        {
            //Blend SrcAlpha OneMinusSrcAlpha
            //Cull Off
            //ZWrite Off
            CGPROGRAM
            #pragma vertex vert
            //#pragma geometry geom
            #pragma fragment frag
            #include "UnityCG.cginc"
            float _PointSize;
            fixed4 _PointColor;
            fixed4 _FragColor;
            float _PointX;
            float _PointY;

            struct vsIn
            {
                float4 pos : POSITION;
            };
            struct psIn
            {
                float4 finalPos : SV_POSITION;
            };

            psIn vert(vsIn v)
            {
                psIn o;
                o.finalPos = UnityViewToClipPos(v.pos);
                o.finalPos.x -= _SinTime.w * 0.5;
                o.finalPos.y -= _SinTime.w;
                return o;
            }

            fixed4 frag(psIn o) : SV_TARGET
            {
                return fixed4(_SinTime.x,_FragColor.gba);
            }
            ENDCG
        }
        
    }
    Fallback Off
}