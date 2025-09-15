//TEST:SIMPLE(filecheck=CHECK): -stage compute -entry main -target spirv-assembly -emit-spirv-directly

// CHECK: error 39068: the 'compute' stage does not support

struct Attr { float2 barys_yz; };

[numthreads(1,1,1)]
void main([[hit_attribute]] in Attr attr)
{
    // no-op
}
