import Foundation

protocol ProjectsListViewModel: ViewModel where Route == ProjectsListRoute {
    func onUserDidTapProjectCard(project: ProjectModel)
}

final class ProjectsListViewModelImpl: ProjectsListViewModel {
    @Published var navigationRoute: ProjectsListRoute? = nil

    func onUserDidTapProjectCard(project: ProjectModel) {
        navigationRoute = .info(project: project)
    }
}
