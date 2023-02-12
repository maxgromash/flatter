import SwiftUI
import shared

struct ContentView: View {
    let presentationFactory: PresentationFactory

	var body: some View {
        NavigationView {
            presentationFactory.makeAuthView()
        }
	}
}
