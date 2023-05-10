import Foundation
import SwiftUI
import shared

final class ProfileModulePresentationFactory {
    private let authStore = AuthStore(client: AuthClientImpl())
    private lazy var authorizationViewModel = AuthorizationViewModelImpl(store: authStore)

    @ViewBuilder func makeAuthView() -> some View {
        let router = AuthorizationRouter(presentationFactory: self)

        AppOverviewView(
            viewModel: authorizationViewModel,
            router: router
        ) {
            VStack {
                AuthorizationView(viewModel: authorizationViewModel, router: router)
                AppNavigationLink(viewModel: authorizationViewModel, router: router)
            }
        }
    }

    @ViewBuilder func makeRegistrationView() -> some View {
        let viewModel = RegistrationViewModelImpl(store: authStore)
        let router = RegistrationRouter(presentationFactory: self)

        AppOverviewView(viewModel: viewModel, router: router) {
            VStack {
                RegistrationView(viewModel: viewModel, router: router)
                AppNavigationLink(viewModel: viewModel, router: router)
            }
        }
    }

    @ViewBuilder func makeForgotPasswordView() -> some View {
        let viewModel = ForgotPasswordViewModelImpl()
        let router = ForgetPasswordRouter()

        AppAlertView(
            viewModel: viewModel,
            router: router,
            title: "Письмо отправленно на почту",
            message: ""
        ) {
            ForgotPasswordView(viewModel: viewModel, router: router)
        }

    }

    @ViewBuilder func profileModule() -> some View {
        let viewModel = ProfileViewModelImpl(
            logOut: { [weak self] in
                self?.authorizationViewModel.reset()
            }
        )
        let router = ProfileRouter()
        VStack {
            ProfileView(viewModel: viewModel, router: router)
            AppNavigationLink(viewModel: viewModel, router: router)
        }
    }
}
