import SwiftUI
import shared

struct ContentView: View {
    let presentationFactory: ProfileModulePresentationFactory

	var body: some View {
        RootView(presentationFactory: presentationFactory)
	}
}
