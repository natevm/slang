//TEST:SIMPLE(filecheck=CHECK_SPV): -std 2026 -fvk-use-entrypoint-name -target spirv-assembly -emit-spirv-directly
//TEST:SIMPLE(filecheck=CHECK_SPV): -std 2025 -fvk-use-entrypoint-name -target spirv-assembly -emit-spirv-directly

struct TriHitAttr
{
    float2 bc;
};

struct LSSHitAttr
{
    float u;
};

struct TrianglesGeomData {
    float3 color; // unused for now
};

struct LSSGeomData {
    float3 color; // unused for now
};

struct ColorPayload {
    float scale;
    float3 color;
};

struct Constants
{
    float scale;
};

[shader("closesthit")]
void TrianglesGeom( ShaderRecord<TrianglesGeomData> record, PushConstant<Constants> pc, PayloadState<ColorPayload> payload, HitAttribute<TriHitAttr> tri) {
    payload.color = record.color * pc.scale * float3(tri.bc.x, tri.bc.y, 1.0 - (tri.bc.x + tri.bc.y));
}

[shader("closesthit")]
void LSSGeom( ShaderRecord<LSSGeomData> record, PushConstant<Constants> pc, PayloadState<ColorPayload> payload, HitAttribute<LSSHitAttr> lss) {
    payload.color = record.color * pc.scale * float3(lss.u, 0.f, 1.0 - lss.u);
}

// CHECK_SPV: OpCapability RayTracing
// CHECK_SPV: OpEntryPoint ClosestHit{{NV|KHR}} %TrianglesGeom
// ShaderRecord wrapper produces a ShaderRecordBuffer pointer + variable
// CHECK_SPV-DAG: OpTypePointer ShaderRecordBuffer{{NV|KHR}}
// CHECK_SPV-DAG: OpVariable %{{.*}} ShaderRecordBuffer{{NV|KHR}}
// And we should index into it as a v3float
// CHECK_SPV-DAG: Op{{.*}}AccessChain %_ptr_ShaderRecordBuffer{{NV|KHR}}_v3float
// Payload wrapper produces an IncomingRayPayload pointer + variable for ColorPayload
// CHECK_SPV-DAG: OpTypePointer IncomingRayPayload{{NV|KHR}}
// CHECK_SPV-DAG: OpVariable %_ptr_IncomingRayPayload{{NV|KHR}}_ColorPayload IncomingRayPayload{{NV|KHR}}
// And we should index into it as v3float at least once
// CHECK_SPV-DAG: Op{{.*}}AccessChain %_ptr_IncomingRayPayload{{NV|KHR}}_v3float
// HitAttribute wrapper produces a HitAttribute pointer + variable for TriHitAttr
// CHECK_SPV-DAG: OpTypePointer HitAttribute{{NV|KHR}}
// CHECK_SPV-DAG: OpVariable %_ptr_HitAttribute{{NV|KHR}}_TriHitAttr HitAttribute{{NV|KHR}}
// PushConstant wrapper should produce a PushConstant pointer + variable
// CHECK_SPV-DAG: OpTypePointer PushConstant
// CHECK_SPV-DAG: OpVariable %{{.*}} PushConstant
