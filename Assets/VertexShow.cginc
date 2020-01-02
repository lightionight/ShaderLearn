#ifndef VERTEXSHOW
#define VERTEXSHOW
uniform float _PointSize = 5.0;
uniform fixed4 _PointColor = float4(1.0, 0.0, 0.0, 1.0);
uniform fixed4 _FragColor = float4(0.0, 0.0, 0.0, 0.0);

struct v2f
{
    float4 pos : SV_POSITION;
};

v2f vert(float4 inPos : POSITION)
{
    v2f o;
    o.pos = UnityObjectToClipPos(inPos);
}

fixed4 frag(v2f i) : SV_TARGET
{
    
}
#endif