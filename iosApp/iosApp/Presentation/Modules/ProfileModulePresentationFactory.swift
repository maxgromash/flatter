import Foundation
import SwiftUI
import Combine
import shared

final class ProfileModulePresentationFactory {
    private let authClient = AuthClientImpl()
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
        let viewModel = ForgotPasswordViewModelImpl(store: authStore)
        let router = ForgetPasswordRouter()

        AppOverviewView(
            viewModel: viewModel,
            router: router
        ) {
            ForgotPasswordView(viewModel: viewModel, router: router)
        }
    }

    @ViewBuilder func profileModule() -> some View {
        let viewModel = ProfileViewModelImpl(
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
        let personalInfoChangesViewModel = PersonalInfoChangesViewModelImpl(store: authStore)
        let passwordChangesViewModel = PasswordChangesViewModelImpl(store: authStore)

        let compositeViewModel = CompositeViewModel(
            vm1: personalInfoChangesViewModel,
            vm2: passwordChangesViewModel
        )

        AppOverviewView(
            viewModel: compositeViewModel,
            router: router
        ) {
            BackgroundContainer {
                ProfileChangesView(
                    personalDataChangesView: PersonalInfoChangesView(
                        viewModel: personalInfoChangesViewModel,
                        router: router
                    ),
                    passwordChangesView: PasswordChangesView(
                        viewModel: passwordChangesViewModel,
                        router: router
                    )
                )
            }
        }
    }
}

private final class CompositeViewModel<Route: RouteType>: ViewModel{
    @Published var navigationRoute: Route? = nil

    @Published var overviewRoute: Route? = nil

    private var cancellable: AnyCancellable?

    init<
        VM1: ViewModel,
        VM2: ViewModel
    >(vm1: VM1, vm2: VM2) where VM1.Route == Route, VM2.Route == Route {
        let cancellable1 = vm1.objectWillChange.sink { [weak self, weak vm1] value in
            self?.overviewRoute = vm1?.overviewRoute
        }
        let cancellable2 = vm2.objectWillChange.sink { [weak self, weak vm2] value in
            self?.overviewRoute = vm2?.overviewRoute
        }

        cancellable = AnyCancellable {
            cancellable1.cancel()
            cancellable2.cancel()
        }
    }
}
