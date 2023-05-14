import Foundation
import SwiftUI
import Combine

enum ProfileRoute: RouteType {
    case favourites
    case documents
    case profileChanges
}

final class ProfileRouter: Routing {
    let factory: ProfileModulePresentationFactory

    init(factory: ProfileModulePresentationFactory) {
        self.factory = factory
    }

    @ViewBuilder func view(for route: ProfileRoute) -> some View {
        switch route {
            case .favourites:
                let viewModel = FlistListViewModelFavouritesOnly()
                let router = FlatsListRouter()

                AppOverviewView(
                    viewModel: viewModel,
                    router: router
                ) {
                    VStack {
                        FlatsListView(
                            viewModel: viewModel,
                            router: router,
                            title: "Избранное",
                            showFilters: false
                        )
                        AppNavigationLink(viewModel: viewModel, router: router)
                    }
                }
            case .profileChanges:
                factory.personalInfoChanges()
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
