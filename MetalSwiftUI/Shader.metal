#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 circleFill(float2 position, half4 color, float4 rect) {
    // Set the center of the semicircle to the top center of the rect
    float2 center = float2(rect[2] * 0.5f, rect[3]);

    // Compute the distance from the current position to the center
    float distanceToCenter = length(position - center);

    // The maximum distance will be half the width of the rectangle (radius of the half-circle)
    float maxDistance = rect[2] * 0.5f;

    // Normalize the distance to the range [0, 1]
    float normalizedDistance = clamp(distanceToCenter / maxDistance, 0.0f, 1.0f);

    // If the position is below the diameter of the circle, make it transparent
    half alpha = position.y > center.y - maxDistance ? 1.0h : 0.0h;

    // Apply the gradient: Using normalizedDistance as the blue component for the gradient
    return half4(0.1h, 0.5h, half(normalizedDistance), alpha);
}
