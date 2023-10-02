import SwiftUI

struct ShaderUse_Snippet: View {
    @State private var stripeSpacing: Float = 10.0
    @State private var stripeAngle: Float = 0.0

    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "rainbow")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .colorEffect(gradient)
                
            Spacer()
            controls
        }
        .padding()
    }

    var stripes: Shader {
        ShaderLibrary.angledFill(
            .float(stripeSpacing),
            .float(stripeAngle),
            .color(.blue)
        )
    }
    
    var gradient: Shader {
        ShaderLibrary.circleFill(.boundingRect)
    }

    @ViewBuilder
    var controls: some View {
        Grid(alignment: .trailing) {
            GridRow {
                spacingSlider
                ZStack(alignment: .trailing) {
                    Text("50.0 PX").hidden() // maintains size
                    Text("""
                        \(stripeSpacing,
                        format: .number.precision(.fractionLength(1))) \
                        \(Text("PX").textScale(.secondary))
                        """)
                        .foregroundStyle(.secondary)
                }
            }
            GridRow {
                angleSlider
                ZStack(alignment: .trailing) {
                    Text("-0.09π RAD").hidden() // maintains size
                    Text("""
                        \(stripeAngle / .pi,
                        format: .number.precision(.fractionLength(2)))π \
                        \(Text("RAD").textScale(.secondary))
                        """)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .labelsHidden()
    }

    @ViewBuilder
    var spacingSlider: some View {
        Slider(
            value: $stripeSpacing, in: Float(10.0)...50.0) {
                Text("Spacing")
            } minimumValueLabel: {
                Image(
                    systemName:
                        "arrow.down.forward.and.arrow.up.backward")
            } maximumValueLabel: {
                Image(
                    systemName:
                        "arrow.up.backward.and.arrow.down.forward")
            }
    }

    @ViewBuilder
    var angleSlider: some View {
        Slider(
            value: $stripeAngle, in: (-.pi / 2)...(.pi / 2)) {
                Text("Angle")
            } minimumValueLabel: {
                Image(
                    systemName: "arrow.clockwise")
            } maximumValueLabel: {
                Image(
                    systemName: "arrow.counterclockwise")
            }
    }
}

#Preview {
    ShaderUse_Snippet()
}
