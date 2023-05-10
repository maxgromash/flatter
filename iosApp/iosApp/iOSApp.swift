import SwiftUI
import shared

@main
struct iOSApp: App {
    init() {
        KoinFactoryKt.doInitKoin()
    }

	var body: some Scene {
		WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
		}
	}
}
