import Foundation
import SwiftUI

enum ProfileChangesRoute: RouteType {
    case loading
}

final class ProfileChangesRouter: Routing {
    @ViewBuilder func view(for route: ProfileChangesRoute) -> some View {
        switch route {
            case .loading:
                LoaderView()
        }
    }
}
