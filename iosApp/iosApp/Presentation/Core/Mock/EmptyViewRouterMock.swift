import Foundation
import SwiftUI

#if DEBUG
final class EmptyViewRouterMock<T: RouteType>: Routing {
    @ViewBuilder func view(for route: T) -> some View {
        EmptyView()
    }
}
#endif
