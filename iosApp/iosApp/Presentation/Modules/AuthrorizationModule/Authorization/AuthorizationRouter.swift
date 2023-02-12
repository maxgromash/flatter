import Foundation
import SwiftUI

enum AuthorizationRoute: RouteType {
    case registration
    case forgotPassword
}

struct AuthorizationRouter: Routing {
    let presentationFactory: PresentationFactory

    @ViewBuilder func view(for route: AuthorizationRoute) -> some View {
        switch route {
        case .registration:
            presentationFactory.makeRegistrationView()
        case .forgotPassword:
            EmptyView()
        }
    }
}
