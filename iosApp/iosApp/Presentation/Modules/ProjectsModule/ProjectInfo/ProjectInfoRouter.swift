import Foundation
import SwiftUI
import shared

enum ProjectInfoRoute: RouteType {
    case flatsList(projectId: Int32)
    case projectLiveStream(streams: ProjectModel.Stream)
    case projectOnMap
}

final class ProjectInfoRouter: Routing {
    @ViewBuilder func view(for route: ProjectInfoRoute) -> some View {
        switch route {
            case let .flatsList(projectId):
                let viewModel = FlatsListViewModelImpl(
                    store: FlatsStore(projectID: projectId)
                )
                let router = FlatsListRouter()
                AppOverviewView(
                    viewModel: viewModel,
                    router: router
                ) {
                    VStack {
                        FlatsListView(
                            viewModel: viewModel,
                            router: router,
                            title: "Выбор квартиры",
                            showFilters: true
                        )
                        AppNavigationLink(viewModel: viewModel, router: router)
                    }
                }
            case let .projectLiveStream(streams):
                let viewModel = ProjectLiveStreamViewModel()
                ProjectLiveStreamView(
                    streams: streams,
                    viewModel: viewModel
                )
            case .projectOnMap:
                EmptyView()
        }
    }
}
