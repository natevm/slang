//TEST:SIMPLE(filecheck=CHECK): -stage closesthit -entry chit -target spirv

// CHECK: error 39071:

struct Params { int x; };

[shader("closesthit")]
void chit([[shader_record]] inout Params p)
{
    // no-op
}

