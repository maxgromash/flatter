import Foundation
import SwiftUI

struct RegistrationView<
    Router: Routing,
    VM: RegistrationViewModel
>: AppView where Router.Route == RegistrationRoute  {
    var viewModel: VM

    var router: Router

    var body: some View {
        Text("reg")
    }
}
