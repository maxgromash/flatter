import Foundation
import SwiftUI

protocol RouteType: Hashable, CaseIterable {}

protocol Routing {
    associatedtype Route: RouteType
    associatedtype Body: View

    @ViewBuilder func view(for route: Route) -> Self.Body
}
