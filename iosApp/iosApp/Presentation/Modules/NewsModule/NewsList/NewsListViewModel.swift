import Foundation
import shared

protocol NewsListViewModel: ViewModel where Route == NewsListRoute {
    var news: [NewsModel] { get }

    func userDidSelectNews(news: NewsModel)
}

final class NewsListViewModelImpl: NewsStoreViewModel, NewsListViewModel {
    @Published var navigationRoute: NewsListRoute? = nil
    @Published var overviewRoute: NewsListRoute? = nil
    @Published var alertText: String? = nil

    var news: [NewsModel] = []

    override init(store: NewsStore) {
        super.init(store: store)
        reduce(action: NewsActionSyncNews())
    }

    private let imageLoader = ImageLoader.shared

    func userDidSelectNews(news: NewsModel) {
        navigationRoute = .news(news)
    }

    override func didChangeState(_ state: NewsState?) {
        guard let state else { return }
        switch state {
            case is NewsStateNewsList:
                guard let newsList = state as? NewsStateNewsList else { return }
                updateNews(newsList: newsList)
            case is NewsStateNone:
                news = []
            default: return
        }
    }

    override func didReceiveEffect(_ effect: NewsSideEffect?) {
        guard let effect else { return }

        switch effect {
            case is NewsSideEffectShowProgress:
                overviewRoute = .loading
            case is NewsSideEffectShowMessage:
                let showMessage = effect as! NewsSideEffectShowMessage
                overviewRoute = nil
                alertText = showMessage.message
            default: return
        }
    }

    private func updateNews(newsList: NewsStateNewsList) {
        Task {
            let mappedNews = try? await newsList.list
                .concurrentMap(mapNews(news:))
                .compactMap({ $0 })
            Task { @MainActor in
                self.overviewRoute = nil
                self.news = mappedNews ?? []
            }
        }
    }

    private func mapNews(news: shared.NewsModel) async -> NewsModel? {
        guard
            let imageUrl = URL(string: news.imageURL),
            let image = try? await imageLoader.loadImage(url: imageUrl)
        else { return nil }
        return NewsModel(
            id: news.id,
            title: news.title,
            description: news.description_,
            image: image,
            publishDate: Date(timeIntervalSince1970: TimeInterval(news.publicationDate.epochSeconds))
        )
    }
}
