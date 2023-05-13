import SwiftUI
import shared

@main
struct iOSApp: App {
    init() {
        NetworkClientsProvider.shared.authClient = AuthClientImpl()
        KoinFactoryKt.doInitKoin()
    }

	var body: some Scene {
		WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
		}
	}
}
