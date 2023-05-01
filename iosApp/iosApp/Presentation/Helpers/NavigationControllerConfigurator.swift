import Foundation
import SwiftUI

struct NavigationControllerConfigurator: UIViewControllerRepresentable {
    var configure: (UIViewController) -> Void = { _ in }

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<NavigationControllerConfigurator>
    ) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationControllerConfigurator>) {
        self.configure(uiViewController)
    }
}

