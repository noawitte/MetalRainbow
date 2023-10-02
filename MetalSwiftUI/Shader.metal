#include <metal_stdlib>
using namespace metal;

half3 hsl2rgb(half3 hsl) {
    half l = hsl.z;
    half s = hsl.y;
    half c = (1.0 - abs(2.0 * l - 1.0)) * s;
    float h = float(hsl.x * 6.0h);
    half x = c * (1.0 - abs(fmod(h, 2.0f) - 1.0));
    half3 result;

    if (h < 1.0) {
        result = half3(c, x, 0);
    } else if (h < 2.0) {
        result = half3(x, c, 0);
    } else if (h < 3.0) {
        result = half3(0, c, x);
    } else if (h < 4.0) {
        result = half3(0, x, c);
    } else if (h < 5.0) {
        result = half3(x, 0, c);
    } else {
        result = half3(c, 0, x);
    }

    return result + l - c * 0.5;
}


[[ stitchable ]] half4 circleGradient(float2 position, half4 color, float4 rect, float time) {
    float2 center = float2(rect[2] * 0.5f, rect[3]);
    float distanceToCenter = length(position - center);
    float maxDistance = rect[2] * 0.5f;
    float normalizedDistance = clamp(distanceToCenter / maxDistance, 0.0f, 1.0f);

    // Incorporate time into hue calculation to animate the gradient.
    float hue = fract(normalizedDistance + time);
    half3 rainbowColor = hsl2rgb(half3(hue, 0.6h, 0.5h));

    half alpha = position.y > center.y - maxDistance ? 1.0h : 0.0h;

    return half4(rainbowColor, alpha);
}
