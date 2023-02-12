import Foundation
import SwiftUI

protocol AppView: View {
    associatedtype VM: ViewModel
    associatedtype Router: Routing where Router.Route == VM.Route

    var viewModel: VM { get }
    var router: Router { get }
}
