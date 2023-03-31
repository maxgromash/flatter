import Foundation
import SwiftUI

enum FlatsListRoute: RouteType {
    case flatInfo(flat: FlatModel)
}

final class FlatsListRouter: Routing {
    @ViewBuilder func view(for route: FlatsListRoute) -> some View {
        switch route {
            case .flatInfo(let flat):
                let viewModel = FlatInfoViewModelImpl(id: flat.id)
                let router = FlatInfoRouter()
                BackgroundContainer {
                    FlatInfoView(viewModel: viewModel, router: router)
                }
        }
    }
}
