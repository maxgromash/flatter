import Foundation
import SwiftUI

final class PresentationFactory {
    @ViewBuilder func makeAuthView() -> some View {
        let viewModel = AuthorizationViewModelImpl()
        let router = AuthorizationRouter(presentationFactory: self)

        AuthorizationView(viewModel: viewModel, router: router)
    }

    @ViewBuilder func makeRegistrationView() -> some View {
        let viewModel = RegistrationViewModelImpl()
        let router = RegistrationRouter()

        RegistrationView(viewModel: viewModel, router: router)
    }
}
