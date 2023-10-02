import SwiftUI

struct ShaderUse_Snippet: View {
    var body: some View {
        VStack {
            Image(systemName: "rainbow")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .colorEffect(gradient)
                .mask {
                    Image(systemName: "rainbow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
        }
    }

    var gradient: Shader {
        ShaderLibrary.circleFill(.boundingRect)
    }
}

#Preview {
    ShaderUse_Snippet()
}
