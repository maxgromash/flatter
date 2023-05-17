import Foundation

protocol ProjectInfoViewModel: ViewModel where Route == ProjectInfoRoute {
    var project: ProjectModel { get }

    func onUserDidTapSelectFlatButton()
    func onUserDidTapLiveStreamButton()
}

final class ProjectInfoViewModelImpl: ProjectInfoViewModel {
    @Published var navigationRoute: ProjectInfoRoute? = nil

    let project: ProjectModel

    init(project: ProjectModel) {
        self.project = project
    }

    func onUserDidTapSelectFlatButton() {
        navigationRoute = .flatsList(projectId: project.id)
    }

    func onUserDidTapLiveStreamButton() {
        navigationRoute = .projectLiveStream(streams: project.stream)
    }
}
