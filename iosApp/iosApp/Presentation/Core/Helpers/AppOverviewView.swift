import Foundation
import SwiftUI

struct AppOverviewView<Router: Routing, VM: ViewModel, Content: View>: AppView where Router.Route == VM.Route {
    @ObservedObject var viewModel: VM
    let router: Router

    var content: Content

    init(
        viewModel: VM,
        router: Router,
        @ViewBuilder content: () -> Content
    ) {
        self.viewModel = viewModel
        self.router = router
        self.content = content()
    }

    var body: some View {
        if let route = viewModel.overviewRoute, viewModel.navigationRoute == nil {
            content.overlay {
                router.view(for: route)
            }
        }
        else {
            content
        }
    }
}

extension View {
    func alert<VM: ViewModel>(viewModel: VM) -> some View {
        self.alert(
            Text(viewModel.alertText ?? ""),
            isPresented: .init(
                get: { viewModel.alertText != nil },
                set: {
                    if false == $0 {
                        viewModel.alertText = nil
                    }
                }
            ),
            actions: {
                Text("Ok")
            }
        )
    }
}
