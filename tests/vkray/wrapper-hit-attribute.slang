//TEST:SIMPLE(filecheck=CHECK_SPV): -std 2026 -stage closesthit -entry main -target spirv-assembly -emit-spirv-directly

struct MyHitAttr
{
    float3 normal;
};

RWStructuredBuffer<float> gOut;

void main(HitAttribute<MyHitAttr> attr)
{
    gOut[0] = attr.normal.x;
}

// CHECK_SPV: OpCapability RayTracing
// CHECK_SPV: OpEntryPoint ClosestHit{{NV|KHR}} %main
// CHECK_SPV-DAG: OpTypePointer HitAttribute{{NV|KHR}}
// CHECK_SPV-DAG: OpVariable %_ptr_HitAttribute{{NV|KHR}}_MyHitAttr HitAttribute{{NV|KHR}}
