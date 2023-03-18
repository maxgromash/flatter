import Foundation
import SwiftUI

final class ProfileModulePresentationFactory {
    @ViewBuilder func makeAuthView() -> some View {
        let viewModel = AuthorizationViewModelImpl()
        let router = AuthorizationRouter(presentationFactory: self)

        VStack {
            AuthorizationView(viewModel: viewModel, router: router)
            AppNavigationLink(viewModel: viewModel, router: router)
        }
    }

    @ViewBuilder func makeRegistrationView() -> some View {
        let viewModel = RegistrationViewModelImpl()
        let router = RegistrationRouter()

        RegistrationView(viewModel: viewModel, router: router)
    }
}
