import Foundation
import SwiftUI

enum AuthorizationRoute: RouteType {
    case profile
    case registration
    case forgotPassword

    case loading
}

struct AuthorizationRouter: Routing {
    let presentationFactory: ProfileModulePresentationFactory

    @ViewBuilder func view(for route: AuthorizationRoute) -> some View {
        switch route {
        case .registration:
            presentationFactory.makeRegistrationView()
        case .forgotPassword:
            presentationFactory.makeForgotPasswordView()
        case .profile:
            presentationFactory.profileModule()
        case .loading:
            LoaderView()
        }
    }
}
