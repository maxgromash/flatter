import Foundation
import SwiftUI

enum RegistrationRoute: RouteType {
    case loading
}

struct RegistrationRouter: Routing {
    let presentationFactory: ProfileModulePresentationFactory

    @ViewBuilder func view(for route: RegistrationRoute) -> some View {
        switch route {
            case .loading:
                LoaderView()
        }
    }
}
