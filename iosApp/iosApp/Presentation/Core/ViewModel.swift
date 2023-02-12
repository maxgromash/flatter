import Foundation
import SwiftUI

protocol ViewModel: ObservableObject {
    associatedtype Route: RouteType

    var navigationRoute: Route? { get set }
    var overviewRoute: Route? { get set }
}

extension ViewModel {
    var overviewRoute: Route? {
        get { nil }
        set { }
    }
}
