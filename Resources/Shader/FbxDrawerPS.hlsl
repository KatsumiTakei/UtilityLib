Texture2D tex : register(t0);
SamplerState samLinear : register(s0);

cbuffer cbMaterial : register(b0)
{
    float3 emissive; //  !<  ���Ȕ����F
    float3 ambient; //  !<  ����
    float3 diffuse; //  !<  �g�U���ˌ�
    float3 specular; //  !<  ���ʔ��ˌ�
    float shininess; //  !<  ���x
    float transparencyFactor; //  !<  ���ߓx
};

struct PS_INPUT
{
    float4 Pos : SV_POSITION;
    float3 Noemal : NORMAL;
	float2 UV : TEXCOORD;
};

float4 main( PS_INPUT input) : SV_Target
{
    //  ���C�g����������܂Ŏ�芸�����n�[�t�����o�[�g
    float3 normal = normalize(input.Noemal);
    float3 color = emissive + ambient + diffuse + specular;
    color = saturate(color);
    float col = dot(normal, color);

    col = col * 0.5f + 0.5f;
    col = col * col;

    return tex.Sample(samLinear, input.UV) * col;
}