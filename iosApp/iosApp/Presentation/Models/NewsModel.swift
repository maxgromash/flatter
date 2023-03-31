import Foundation
import UIKit

struct NewsModel {
    let id = UUID()
    let title: String
    let description: String = .loremIpsum
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
                title: "INGRAD обеспечил высокую строительную готовность ЖК «Миловидное»",
                image: ImagesProvider.newsImage(id: 1),
                publishDate: Date(timeIntervalSince1970: 1678958928)
            ),
            NewsModel(
                title: "Группа «Самолет» и СберКорус впервые в России внедрили EDI-систему для обмена данными с поставщиками и подрядчиками",
                image: ImagesProvider.newsImage(id: 2),
                publishDate: Date(timeIntervalSince1970: 1679304528)
            ),
            NewsModel(
                title: "Итальянский бренд керамики высоко оценил фасады ЖК RiverSky",
                image: ImagesProvider.newsImage(id: 3),
                publishDate: Date(timeIntervalSince1970: 1676280528)
            ),
            NewsModel(
                title: "INGRAD приступил к заселению корпуса №22 ЖК «Новое Пушкино»",
                image: ImagesProvider.newsImage(id: 4),
                publishDate: Date(timeIntervalSince1970: 1674725328)
            ),
        ]
    }
}
