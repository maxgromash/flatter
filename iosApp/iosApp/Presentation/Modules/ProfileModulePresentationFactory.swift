import Foundation
import SwiftUI
import Combine
import shared

final class ProfileModulePresentationFactory {
    private let authStore = AuthStore()
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
        let viewModel = ForgotPasswordViewModelImpl(store: authStore)
        let router = ForgetPasswordRouter()

        AppOverviewView(
            viewModel: viewModel,
            router: router
        ) {
            ForgotPasswordView(viewModel: viewModel, router: router)
        }
    }

    @ViewBuilder func profileModule(user: UserModel) -> some View {
        let viewModel = ProfileViewModelImpl(
            user: user,
            store: authStore
        )
        let router = ProfileRouter(factory: self)
        VStack {
            ProfileView(viewModel: viewModel, router: router)
            AppNavigationLink(viewModel: viewModel, router: router)
        }
    }

    @ViewBuilder func personalInfoChanges() -> some View {
        let router = ProfileChangesRouter()
        let viewModel = ProfileChangesViewModel(store: authStore)

        AppOverviewView(
            viewModel: viewModel,
            router: router
        ) {
            BackgroundContainer {
                ProfileChangesView(
                    viewModel: viewModel,
                    personalDataChangesView: PersonalInfoChangesView(
                        viewModel: viewModel,
                        router: router
                    ),
                    passwordChangesView: PasswordChangesView(
                        viewModel: viewModel,
                        router: router
                    )
                )
            }
        }
    }
}
