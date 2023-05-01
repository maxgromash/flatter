import Foundation
import SwiftUI
import Combine

enum ProfileRoute: RouteType {
    case favourites
    case documents
    case profileChanges
}

final class ProfileRouter: Routing {
    @ViewBuilder func view(for route: ProfileRoute) -> some View {
        switch route {
            case .favourites:
                let viewModel = FlistListViewModelFavouritesOnly()
                let router = FlatsListRouter()

                VStack {
                    FlatsListView(
                        viewModel: viewModel,
                        router: router,
                        title: "Избранное",
                        showFilters: false
                    )
                    AppNavigationLink(viewModel: viewModel, router: router)
                }
            case .profileChanges:
                let router = ProfileChangesRouter()
                let personalInfoChangesViewModel = PersonalInfoChangesViewModelImpl()
                let passwordChangesViewModel = PasswordChangesViewModelImpl()

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
                            personalDataChangesView: AppAlertView(
                                viewModel: personalInfoChangesViewModel,
                                router: router,
                                title: "Успешно!",
                                message: "Ваши данные сохранены"
                            ) {
                                PersonalInfoChangesView(
                                    viewModel: personalInfoChangesViewModel,
                                    router: router
                                )
                            },
                            passwordChangesView: AppAlertView(
                                viewModel: passwordChangesViewModel,
                                router: router,
                                title: "Успешно!",
                                message: "Пароль обновлен"
                            ) {
                                PasswordChangesView(
                                    viewModel: passwordChangesViewModel,
                                    router: router
                                )
                            }
                        )
                    }
                }
            case .documents:
                let router = DocumentsListRouter()
                let viewModel = DocumentsListViewModelImpl()
                BackgroundContainer {
                    VStack {
                        DocumentsListView(viewModel: viewModel, router: router)
                        AppNavigationLink(viewModel: viewModel, router: router)
                    }
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
