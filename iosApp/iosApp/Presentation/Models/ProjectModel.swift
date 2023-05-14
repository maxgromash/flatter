import Foundation
import SwiftUI
import CoreLocation

struct ProjectModel {
    struct Address {
        let address: String
        let coordinates: CLLocationCoordinate2D
    }

    struct NearestTransport {
        let name: String
        let color: Color
        let time: Int
    }

    let id: Int32
    let title: String
    let description: String
    let image: UIImage
    let address: Address
    let minFlatPrice: Float
    let nearestTransports: [NearestTransport]
}

extension ProjectModel: Equatable {
    static func == (lhs: ProjectModel, rhs: ProjectModel) -> Bool {
        lhs.id == rhs.id
    }
}

extension ProjectModel: Hashable {
    func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
}

extension Array where Element == ProjectModel {
    static var mock: [ProjectModel] {
        [
            ProjectModel(
                id: 1,
                title: "Первый Дубровский",
                description: .loremIpsum,
                image: ImagesProvider.firstDubrovskiy,
                address: .init(
                    address: "Москва, ул. 1-й Дубровский проезд, 78/14с12",
                    coordinates: .init(
                        latitude: 55.724282, longitude: 37.684901
                    )
                ),
                minFlatPrice: 11.8,
                nearestTransports: [
                    .init(
                        name: "Волгоградский проспект",
                        color: ColorsProvider.metroPurpleLine.color,
                        time: 2
                    )
                ]
            ),
            ProjectModel(
                id: 2,
                title: "Символ",
                description: .loremIpsum,
                image: ImagesProvider.symbolProject,
                address: .init(
                    address: "Москва, ул. Золоторожский Вал, 11с2",
                    coordinates: .init(
                        latitude: 55.748808, longitude: 37.692687
                    )
                ),
                minFlatPrice: 9.5,
                nearestTransports: [
                    .init(
                        name: "Римская",
                        color: ColorsProvider.metroLightGreenLine.color,
                        time: 8
                    ),
                    .init(
                        name: "Авиамоторная",
                        color: ColorsProvider.metroYellowLine.color,
                        time: 12
                    ),
                ]
            ),
            
        ]
    }
}
