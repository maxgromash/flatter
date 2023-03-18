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
