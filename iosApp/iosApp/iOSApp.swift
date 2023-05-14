import SwiftUI
import shared

@main
struct iOSApp: App {
    init() {
        let projectsClient = ProjectsClientImpl()
        NetworkClientsProvider.shared.authClient = AuthClientImpl()
        NetworkClientsProvider.shared.newsClient = projectsClient
        NetworkClientsProvider.shared.projectsClient = projectsClient
        KoinFactoryKt.doInitKoin()
    }

	var body: some Scene {
		WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
		}
	}
}
