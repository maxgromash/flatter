import Foundation
import SwiftUI

enum AuthorizationRoute: RouteType {
    case profile(user: UserModel)
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
        case let .profile(user):
            presentationFactory.profileModule(user: user)
        case .loading:
            LoaderView()
        }
    }
}
