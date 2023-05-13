import SwiftUI
import shared

@main
struct iOSApp: App {
    init() {
        NetworkClientsProvider.shared.authClient = AuthClientImpl()
        NetworkClientsProvider.shared.newsClient = NewsClientImpl()
        NetworkClientsProvider.shared.projectsClient = ProjectsClientImpl()
        KoinFactoryKt.doInitKoin()
    }

	var body: some Scene {
		WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
		}
	}
}
