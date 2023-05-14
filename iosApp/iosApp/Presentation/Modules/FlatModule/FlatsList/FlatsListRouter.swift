import Foundation
import SwiftUI

enum FlatsListRoute: RouteType {
    case flatInfo(flat: FlatModel)
    case loading
}

final class FlatsListRouter: Routing {
    @ViewBuilder func view(for route: FlatsListRoute) -> some View {
        switch route {
            case .flatInfo(let flat):
                let viewModel = FlatInfoViewModelImpl(flat: flat)
                let router = FlatInfoRouter()
                BackgroundContainer {
                    FlatInfoView(viewModel: viewModel, router: router)
                }
            case .loading:
                LoaderView()
        }
    }
}
