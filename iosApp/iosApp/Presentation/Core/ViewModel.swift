import Foundation
import SwiftUI

protocol ViewModel: ObservableObject {
    associatedtype Route: RouteType

    var navigationRoute: Route? { get set }
    var overviewRoute: Route? { get set }
    var showAlert: Bool { get set }
}

extension ViewModel {
    var overviewRoute: Route? {
        get { nil }
        set { }
    }

    var showAlert: Bool {
        get { false }
        set {}
    }
}
