import SwiftUI

struct BackgroundContainer<Content: View>: View {
    let content: Content

    init(content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        GeometryReader { reader in
            ZStack {
                ImagesProvider.buildingBackground
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(reader.size, contentMode: .fill)
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                content
            }
        }
    }
}

struct BackgroundContainer_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundContainer {
            Text("Preview")
        }
    }
}
