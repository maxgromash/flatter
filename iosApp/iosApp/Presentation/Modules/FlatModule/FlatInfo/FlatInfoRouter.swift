import Foundation
import SwiftUI

enum FlatInfoRoute: RouteType {
    case loading
}

final class FlatInfoRouter: Routing {
    @ViewBuilder func view(for route: FlatInfoRoute) -> some View {
        switch route {
            case .loading:
                LoaderView()
        }
    }
}
