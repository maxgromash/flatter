import Foundation
import SwiftUI

struct AuthorizationView<
    Router: Routing,
    VM: AuthorizationViewModel
>: AppView where Router.Route == AuthorizationRoute {
    @ObservedObject var viewModel: VM
    let router: Router

    var body: some View {
        VStack {
            Button(
                "Move to registration",
                action: {
                    viewModel.userDidTapRegistration()
                }
            )
            AppNavigationLink(viewModel: viewModel, router: router)
        }
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
