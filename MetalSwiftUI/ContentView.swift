import SwiftUI

struct ShaderUse_Snippet: View {
    let startDate = Date()
    var time: Float {
        Float(startDate.timeIntervalSinceNow / 5)
    }

    var body: some View {
        TimelineView(.animation) { context in
            Image(systemName: "rainbow")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .colorEffect(gradient)
                .mask {
                    Image(systemName: "rainbow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 20)
                }
        }
    }

    var gradient: Shader {
        ShaderLibrary.circleGradient(
            .boundingRect,
            .float(time)
        )
    }
}

#Preview {
    ShaderUse_Snippet()
}
