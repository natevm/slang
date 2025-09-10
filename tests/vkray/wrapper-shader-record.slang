//TEST:SIMPLE(filecheck=CHECK_SPV): -std 2026 -stage closesthit -entry main -target spirv-assembly -emit-spirv-directly

struct SR
{
    uint id;
};

RWStructuredBuffer<float> gOut;

void main(BuiltInTriangleIntersectionAttributes attr, ShaderRecord<SR> rec)
{
    gOut[0] = float(rec.id);
}

// CHECK_SPV: OpCapability RayTracing
// CHECK_SPV: OpEntryPoint ClosestHit{{NV|KHR}} %main
// CHECK_SPV-DAG: OpTypePointer ShaderRecordBuffer{{NV|KHR}}
// CHECK_SPV-DAG: OpVariable %{{.*}} ShaderRecordBuffer{{NV|KHR}}
