import Foundation
import SwiftUI

enum ForgotPasswordRoute: RouteType {}

final class ForgetPasswordRouter: Routing {
    @ViewBuilder func view(for route: ForgotPasswordRoute) -> some View {
        EmptyView()
    }
}
