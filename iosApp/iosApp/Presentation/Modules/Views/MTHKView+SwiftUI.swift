import Foundation
import SwiftUI
import MobileVLCKit

struct MTHKSwiftUiView: UIViewRepresentable {
    let view = UIView()

    @Binding var player: VLCMediaPlayer

    func makeUIView(context: Context) -> UIView {
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        player.drawable = view
    }
}
