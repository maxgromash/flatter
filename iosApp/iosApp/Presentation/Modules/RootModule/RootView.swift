import Foundation
import SwiftUI

struct RootView: View {
    init() {
        self.presentationFactory = .init()
        setupAppearance()
    }

    let presentationFactory: ProfileModulePresentationFactory

    private func setupAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(ColorsProvider.primaryContainer)
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance

        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .init(ColorsProvider.primary)
        UINavigationBar.appearance().standardAppearance = appearance
    }

    var body: some View {
        TabView {
            NavigationView {
                let viewModel = ProjectsListViewModelImpl()
                let router = ProjectsListRouter()
                VStack {
                    ProjectsListView(viewModel: viewModel, router: router)
                    AppNavigationLink(viewModel: viewModel, router: router)
                }
            }
            .tint(.white)
            .tabItem {
                TabItemView(
                    text: "Проекты",
                    icon: ImagesProvider.buildingTabIcon
                )
            }
            NavigationView {
                let viewModel = NewsListViewModelImpl()
                let router = NewsListRouter()
                VStack {
                    NewsListView(
                        viewModel: viewModel,
                        router: router
                    )
                    AppNavigationLink(viewModel: viewModel, router: router)
                }
            }
            .tint(.white)
            .navigationViewStyle(.stack)
                .tabItem {
                    TabItemView(
                        text: "Новости",
                        icon: ImagesProvider.newsTabIcon
                    )
                }
            NavigationView {
                presentationFactory.makeAuthView()
            }
            .tint(.white)
            .tabItem {
                TabItemView(
                    text: "Профиль",
                    icon: ImagesProvider.profileTabIcon
                )
            }
        }
        .tint(ColorsProvider.primary)
    }
}

private struct TabItemView: View {
    let text: String
    let icon: Image

    var body: some View {
        VStack {
            icon
            Text(text)
        }
    }
}
