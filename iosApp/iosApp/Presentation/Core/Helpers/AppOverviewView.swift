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
        if let route = viewModel.overviewRoute {
            content.overlay {
                router.view(for: route)
            }
        }
        else {
            content
        }
    }
}

struct AppAlertView<Router: Routing, VM: ViewModel, Content: View>: AppView where Router.Route == VM.Route {
    @ObservedObject var viewModel: VM
    let router: Router

    let content: Content

    let title: String
    let message: String

    init(
        viewModel: VM,
        router: Router,
        title: String,
        message: String,
        @ViewBuilder content: () -> Content
    ) {
        self.viewModel = viewModel
        self.router = router
        self.title = title
        self.message = message
        self.content = content()
    }

    var body: some View {
        content
            .alert(
                title,
                isPresented: .init(
                    get: { viewModel.showAlert },
                    set: {
                        if false == $0 {
                            viewModel.showAlert = false
                        }
                    }
                ),
                actions: { viewModel.navigationRoute.flatMap(router.view(for:)) },
                message: { Text(message) }
            )
    }
}
