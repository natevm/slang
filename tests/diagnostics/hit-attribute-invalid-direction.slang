//TEST:SIMPLE(filecheck=CHECK): -stage closesthit -entry chit -target spirv

// CHECK: error 39069: 

struct Attr { float2 barys; };

[shader("closesthit")]
void chit([[hit_attribute]] inout Attr attr)
{
    // no-op
}

