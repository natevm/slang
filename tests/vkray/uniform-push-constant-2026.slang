//TEST:SIMPLE(filecheck=CHECK_SPV): -std 2026 -target spirv-assembly -emit-spirv-directly -stage raygeneration -entry main

struct SR
{
    float test;
};

RWStructuredBuffer<float> gOut;

void main(uniform float u, ShaderRecord<SR> rec1, uniform float v)
{
    gOut[0] = u + rec1.test + v;
}

// CHECK_SPV: OpCapability RayTracing
// CHECK_SPV: OpExtension "SPV_KHR_ray_tracing"
// CHECK_SPV: OpEntryPoint RayGeneration{{NV|KHR}} %main
// CHECK_SPV-DAG: OpTypePointer PushConstant
// CHECK_SPV-DAG: OpVariable %{{.*}} PushConstant

