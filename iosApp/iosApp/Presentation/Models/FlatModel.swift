import Foundation
import UIKit

struct FlatModel {
    let id: Int32
    let price: Double
    let rooms: Int
    let number: Int
    let area: Float
    let floor: Int
    let trimming: String
    let finishing: String

    let images: [UIImage]

    var isFavourite: Bool
}

extension FlatModel: Equatable {
    static func == (lhs: FlatModel, rhs: FlatModel) -> Bool {
        lhs.id == rhs.id
    }
}

extension FlatModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(isFavourite)
    }
}

extension Array where Element == FlatModel {
    static var mock: [FlatModel] {
        [
            FlatModel(
                id: 1,
                price: 13_878_677,
                rooms: 1,
                number: 134,
                area: 21.8,
                floor: 13,
                trimming: "Чистовая",
                finishing: "4 кв. 2024",
                images: [
                    ImagesProvider.flatLayout(id: 1),
                    ImagesProvider.floorLayout(id: 1),
                    ImagesProvider.generalPlan
                ],
                isFavourite: false
            ),
            FlatModel(
                id: 2,
                price: 15_014_010,
                rooms: 2,
                number: 13,
                area: 33,
                floor: 1,
                trimming: "Чистовая",
                finishing: "4 кв. 2024",
                images: [
                    ImagesProvider.flatLayout(id: 2),
                    ImagesProvider.floorLayout(id: 2),
                    ImagesProvider.generalPlan
                ],
                isFavourite: false
            ),
            FlatModel(
                id: 3,
                price: 27_391_422,
                rooms: 3,
                number: 86,
                area: 51,
                floor: 8,
                trimming: "Чистовая",
                finishing: "4 кв. 2024",
                images: [
                    ImagesProvider.flatLayout(id: 3),
                    ImagesProvider.floorLayout(id: 3),
                    ImagesProvider.generalPlan
                ],
                isFavourite: false
            ),
            FlatModel(
                id: 4,
                price: 29_442_263,
                rooms: 4,
                number: 55,
                area: 69.5,
                floor: 5,
                trimming: "Чистовая",
                finishing: "4 кв. 2024",
                images: [
                    ImagesProvider.flatLayout(id: 4),
                    ImagesProvider.floorLayout(id: 4),
                    ImagesProvider.generalPlan
                ],
                isFavourite: false
            ),
        ]
    }
}
