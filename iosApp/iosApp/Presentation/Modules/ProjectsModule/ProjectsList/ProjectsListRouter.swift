import Foundation
import SwiftUI

enum ProjectsListRoute: RouteType {
    case info(project: ProjectModel)
    case loading
}

final class ProjectsListRouter: Routing {
    @ViewBuilder func view(for route: ProjectsListRoute) -> some View {
        switch route {
            case let .info(project):
                let viewModel = ProjectInfoViewModelImpl(project: project)
                let router = ProjectInfoRouter()
                VStack {
                    ProjectInfoView(viewModel: viewModel, router: router)
                    AppNavigationLink(viewModel: viewModel, router: router)
                }
            case let .loading:
                LoaderView()
        }
    }
}
