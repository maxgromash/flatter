import Foundation
import UIKit
import shared

protocol ProjectsListViewModel: ViewModel where Route == ProjectsListRoute {
    var projects: [ProjectModel] { get }
    func onUserDidTapProjectCard(project: ProjectModel)
}

final class ProjectsListViewModelImpl: ProjectsViewModel, ProjectsListViewModel {
    @Published var navigationRoute: ProjectsListRoute? = nil
    @Published var overviewRoute: ProjectsListRoute? = nil
    @Published var alertText: String? = nil

    @Published var projects: [ProjectModel] = []

    private let imageLoader = ImageLoader.shared

    override init(store: ProjectsStore) {
        super.init(store: store)
        reduce(action: ProjectsActionSyncProjects())
    }

    func onUserDidTapProjectCard(project: ProjectModel) {
        navigationRoute = .info(project: project)
    }

    override func didChangeState(_ state: ProjectsState?) {
        guard let state else { return }
        switch state {
            case is ProjectsStateProjectsList:
                guard let models = state as? ProjectsStateProjectsList else { return }
                mapProjectsModels(models.list)
            case is ProjectsStateNone:
                projects = []
            default: return
        }

    }

    override func didReceiveEffect(_ effect: ProjectsSideEffect?) {
        guard let effect else { return }

        switch effect {
            case is ProjectsSideEffectShowProgress:
                overviewRoute = .loading
            case is ProjectsSideEffectShowMessage:
                let showMessage = effect as! ProjectsSideEffectShowMessage
                overviewRoute = nil
                alertText = showMessage.message
            default: return
        }
    }

    private func mapProjectsModels(_ models: [shared.ProjectModel]) {
        Task {
            let models = try? await models.concurrentMap(mapProjectModel(_:)).compactMap({ $0 })
            Task { @MainActor in
                self.projects = models ?? []
                overviewRoute = nil
            }
        }
    }

    private func mapProjectModel(_ model: shared.ProjectModel) async -> ProjectModel? {
        var image: UIImage? = nil
        if let imageURL = URL(string: model.imageURL) {
            image = try? await imageLoader.loadImage(url: imageURL)
        }

        return ProjectModel(
            id: model.id,
            title: model.title,
            description: model.description_,
            image: image ?? ImagesProvider.newsImagePlaceholder,
            address: mapAddress(model.address),
            minFlatPrice: Float(model.minFlatPrice),
            nearestTransports: mapTransports(model.nearestTransport),
            stream: .init(
                high: model.streamResolution.high,
                standard: model.streamResolution.standard,
                low: model.streamResolution.low
            )
        )
    }

    private func mapAddress(_ address: shared.ProjectModel.Address) -> ProjectModel.Address {
        .init(
            address: address.address,
            coordinates: .init(
                latitude: address.coordinates.latitude,
                longitude: address.coordinates.longitude
            )
        )
    }

    private func mapTransports(
        _ transports: [shared.ProjectModel.NearestTransport]
    ) -> [ProjectModel.NearestTransport] {
        let mapped: [ProjectModel.NearestTransport] = transports
            .compactMap({ (dto: shared.ProjectModel.NearestTransport) -> ProjectModel.NearestTransport? in
            guard let color = UIColor(hexString: dto.color) else { return nil }
            return ProjectModel.NearestTransport(
                name: dto.name,
                color: color.color,
                time: Int(dto.time)
            )
        })

        return mapped
    }
}
