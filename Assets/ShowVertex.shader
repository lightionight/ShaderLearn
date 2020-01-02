Shader "Vertex/Show Vertex"
{
    Properties
    {
        //_Color("顶点颜色", Color) = (1, 1, 1, 0)
        //_AlphaColor("透明度", Range(0, 1)) = 0.5
        _PointSize("点的大小", Range(0.1, 5.0)) = 1.0
        _PointColor("顶点颜色", Color) = (1.0, 1.0, 1.0, 0.0)
        _FragColor("片段颜色", Color) = (0.0, 0.0, 0.0, 0.0)
    }
    SubShader
    {
        pass
        {
            //Blend SrcAlpha OneMinusSrcAlpha
            //Cull Off
            ZWrite Off
            CGPROGRAM
            #pragma vertex vert
            //#pragma geometry geom
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "VertexShow.cginc"

            ENDCG
        }
        
    }
    Fallback Off
}