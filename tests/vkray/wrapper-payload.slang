//TEST:SIMPLE(filecheck=CHECK_SPV): -std 2026 -stage closesthit -entry main -target spirv-assembly -emit-spirv-directly

struct MyPayload
{
    float4 color;
};

void main(Payload<MyPayload> p)
{
    // default direction is inout; write to ensure it's materialized
    p.color = float4(1, 2, 3, 4);
}

// CHECK_SPV: OpCapability RayTracing
// CHECK_SPV: OpEntryPoint ClosestHit{{NV|KHR}} %main
// CHECK_SPV-DAG: OpTypePointer IncomingRayPayload{{NV|KHR}}
// CHECK_SPV-DAG: OpVariable %_ptr_IncomingRayPayload{{NV|KHR}}_MyPayload IncomingRayPayload{{NV|KHR}}
// CHECK_SPV-DAG: Op{{.*}}AccessChain %_ptr_IncomingRayPayload{{NV|KHR}}_v4float

