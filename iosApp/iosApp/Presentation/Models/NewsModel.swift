import Foundation
import UIKit

struct NewsModel {
    let id: Int32
    let title: String
    let description: String
    let image: UIImage
    let publishDate: String
}

extension NewsModel: Equatable {
    static func == (lhs: NewsModel, rhs: NewsModel) -> Bool {
        lhs.id == rhs.id
    }
}

extension NewsModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Array where Element == NewsModel {
    static var mock: [NewsModel] {
        [
            NewsModel(
                id: 1,
                title: "INGRAD обеспечил высокую строительную готовность ЖК «Миловидное»",
                description: .loremIpsum,
                image: ImagesProvider.newsImage(id: 1),
                publishDate: "2011"
            ),
            NewsModel(
                id: 2,
                title: "Группа «Самолет» и СберКорус впервые в России внедрили EDI-систему для обмена данными с поставщиками и подрядчиками",
                description: .loremIpsum,
                image: ImagesProvider.newsImage(id: 2),
                publishDate: "2011"
            ),
            NewsModel(
                id: 3,
                title: "Итальянский бренд керамики высоко оценил фасады ЖК RiverSky",
                description: .loremIpsum,
                image: ImagesProvider.newsImage(id: 3),
                publishDate: "2011"
            ),
            NewsModel(
                id: 4,
                title: "INGRAD приступил к заселению корпуса №22 ЖК «Новое Пушкино»",
                description: .loremIpsum,
                image: ImagesProvider.newsImage(id: 4),
                publishDate: "2011"
            ),
        ]
    }
}
