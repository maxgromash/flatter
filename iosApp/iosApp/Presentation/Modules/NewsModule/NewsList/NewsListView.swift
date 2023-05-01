import SwiftUI

struct NewsListView<
    VM: NewsListViewModel,
    Router: Routing
>: AppView where Router.Route == VM.Route  {
    var viewModel: VM
    var router: Router

    private let items = Array(0..<10)

    var body: some View {
        BackgroundContainer {
            ScrollView {
                ForEach(viewModel.news, id: \.id) { news in
                    NewsListCell(
                        news: news
                    )
                    .onTapGesture {
                        viewModel.userDidSelectNews(news: news)
                    }
                }
                .padding(.horizontal, 20)
            }
            .safeAreaInset(edge: .bottom) {
                EmptyView().frame(height: 20)
            }
        }
        .navigationTitle("Новости")
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewsListView(
                viewModel: NewsListViewModelMock(),
                router: EmptyViewRouterMock()
            )
        }
        .tint(.white)
    }

    private final class NewsListViewModelMock: NewsListViewModel {
        var navigationRoute: NewsListRoute? = nil

        let news: [NewsModel] = .mock

        func userDidSelectNews(news: NewsModel) {}
    }
}
