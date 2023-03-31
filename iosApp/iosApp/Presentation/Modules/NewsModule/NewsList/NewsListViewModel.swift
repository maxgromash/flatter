import Foundation

protocol NewsListViewModel: ViewModel where Route == NewsListRoute {
    var news: [NewsModel] { get }

    func userDidSelectNews(news: NewsModel)
}

final class NewsListViewModelImpl: NewsListViewModel {
    @Published var navigationRoute: NewsListRoute? = nil

    let news: [NewsModel] = .mock

    func userDidSelectNews(news: NewsModel) {
        navigationRoute = .news(news)
    }
}
