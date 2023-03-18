import Foundation
import SwiftUI

struct RootView: View {
    let presentationFactory: ProfileModulePresentationFactory

    init(presentationFactory: ProfileModulePresentationFactory) {
        self.presentationFactory = presentationFactory

        UITabBar.appearance().backgroundColor = UIColor(ColorsProvider.primaryContainer)
    }

    var body: some View {
        TabView {
            Text("Проекты")
                .tabItem {
                    TabItemView(
                        text: "Проекты",
                        icon: ImagesProvider.buildingTabIcon
                    )
                }
            Text("Новости")
                .tabItem {
                    TabItemView(
                        text: "Новости",
                        icon: ImagesProvider.newsTabIcon
                    )
                }
            NavigationView {
                presentationFactory.makeAuthView()
            }
            .tabItem {
                TabItemView(
                    text: "Профиль",
                    icon: ImagesProvider.profileTabIcon
                )
            }
        }
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
