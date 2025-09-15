//TEST:SIMPLE(filecheck=CHECK): -stage compute -entry main -target spirv

// CHECK: error 39070:

struct Params { int x; };

[numthreads(1,1,1)]
void main([[shader_record]] Params p)
{
    // no-op
}
