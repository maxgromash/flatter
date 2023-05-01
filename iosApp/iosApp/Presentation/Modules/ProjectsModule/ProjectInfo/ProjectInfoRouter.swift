import Foundation
import SwiftUI

enum ProjectInfoRoute: RouteType {
    case flatsList
    case projectLiveStream
    case projectOnMap
}

final class ProjectInfoRouter: Routing {
    @ViewBuilder func view(for route: ProjectInfoRoute) -> some View {
        switch route {
            case .flatsList:
                let viewModel = FlatsListViewModelImpl()
                let router = FlatsListRouter()
                VStack {
                    FlatsListView(
                        viewModel: viewModel,
                        router: router,
                        title: "Выбор квартиры",
                        showFilters: true
                    )
                    AppNavigationLink(viewModel: viewModel, router: router)
                }
            case .projectLiveStream:
                let viewModel = ProjectLiveStreamViewModel()
                ProjectLiveStreamView(viewModel: viewModel)
            case .projectOnMap:
                EmptyView()
        }
    }
}
