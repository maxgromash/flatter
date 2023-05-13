import Foundation
import UIKit

struct NewsModel {
    let id: String
    let title: String
    let description: String
    let image: UIImage
    let publishDate: Date
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
                id: "1",
                title: "INGRAD обеспечил высокую строительную готовность ЖК «Миловидное»",
                description: .loremIpsum,
                image: ImagesProvider.newsImage(id: 1),
                publishDate: Date(timeIntervalSince1970: 1678958928)
            ),
            NewsModel(
                id: "2",
                title: "Группа «Самолет» и СберКорус впервые в России внедрили EDI-систему для обмена данными с поставщиками и подрядчиками",
                description: .loremIpsum,
                image: ImagesProvider.newsImage(id: 2),
                publishDate: Date(timeIntervalSince1970: 1679304528)
            ),
            NewsModel(
                id: "3",
                title: "Итальянский бренд керамики высоко оценил фасады ЖК RiverSky",
                description: .loremIpsum,
                image: ImagesProvider.newsImage(id: 3),
                publishDate: Date(timeIntervalSince1970: 1676280528)
            ),
            NewsModel(
                id: "4",
                title: "INGRAD приступил к заселению корпуса №22 ЖК «Новое Пушкино»",
                description: .loremIpsum,
                image: ImagesProvider.newsImage(id: 4),
                publishDate: Date(timeIntervalSince1970: 1674725328)
            ),
        ]
    }
}
