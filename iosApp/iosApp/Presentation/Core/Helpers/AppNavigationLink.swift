import Foundation
import SwiftUI

struct AppNavigationLink<Router: Routing, VM: ViewModel>: AppView where Router.Route == VM.Route {
    @ObservedObject var viewModel: VM
    let router: Router

    var body: some View {
        NavigationLink(
            destination: viewModel.navigationRoute.flatMap(router.view(for:)),
            isActive: .init(
                get: { viewModel.navigationRoute != nil },
                set: {
                    if $0 == false {
                        viewModel.navigationRoute = nil
                    }
                }
            ),
            label: { EmptyView() }
        )
    }
}
