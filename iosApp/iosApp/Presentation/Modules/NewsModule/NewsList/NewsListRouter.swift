import Foundation
import SwiftUI

enum NewsListRoute: RouteType {
    case news(_ news: NewsModel)
    case loading
}

final class NewsListRouter: Routing {
    @ViewBuilder func view(for route: NewsListRoute) -> some View {
        switch route {
            case let .news(model):
                NewsInfoView(
                    title: model.title,
                    description: model.description,
                    date: model.publishDate,
                    image: model.image
                )
            case .loading:
                LoaderView()
        }
    }
}
