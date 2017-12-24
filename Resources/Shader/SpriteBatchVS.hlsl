//  hlsl�̍s��͊i�[�������ȗ�����Ɨ�D��ɂȂ�
//  XMFLOAT4x�͍s�D��Ȃ̂ł����Ŋi�[�������w�肷�邩
//  CPU�œ]�u�s����쐬����
//  row_major    !<  �s�x�N�g���Ŋi�[
//  column_major !<  ��x�N�g���Ŋi�[
cbuffer cbGlobal : register(b0)
{
    row_major matrix World;
    row_major matrix Projection;
};

cbuffer cbTextureInfo : register(b1)
{
    float2 UVPos;
    float2 UVSize;
    float4 Color;
};

struct VS_INPUT
{
    float3 Pos : POSITION;
    float2 UV : TEXCOORD;
};

struct VS_OUTPUT
{
    float4 Pos : SV_POSITION;
    float2 UV : TEXCOORD;
    float4 Color : COLOR;
};

VS_OUTPUT main(VS_INPUT input)
{
    VS_OUTPUT output = (VS_OUTPUT)0;

    output.Pos = mul(float4(input.Pos, 1.f), World);
    output.Pos = mul(output.Pos, Projection);
    output.UV = input.UV * UVSize + UVPos;
    output.Color = Color;

    return output;
}