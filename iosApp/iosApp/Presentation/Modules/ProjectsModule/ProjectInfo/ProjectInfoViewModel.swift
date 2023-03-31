import Foundation

protocol ProjectInfoViewModel: ViewModel where Route == ProjectInfoRoute {
    var project: ProjectModel { get }

    func onUserDidTapSelectFlatButton()
}

final class ProjectInfoViewModelImpl: ProjectInfoViewModel {
    @Published var navigationRoute: ProjectInfoRoute? = nil

    let project: ProjectModel

    init(project: ProjectModel) {
        self.project = project
    }

    func onUserDidTapSelectFlatButton() {
        navigationRoute = .flatsList
    }
}
