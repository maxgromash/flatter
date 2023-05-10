import Foundation
import SwiftUI

enum ForgotPasswordRoute: RouteType {
    case loading
}

final class ForgetPasswordRouter: Routing {
    @ViewBuilder func view(for route: ForgotPasswordRoute) -> some View {
        switch route {
            case .loading: LoaderView()
        }
    }
}
