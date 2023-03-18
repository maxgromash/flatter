import Foundation

protocol AuthorizationViewModel: ViewModel where Route == AuthorizationRoute {
    var emailInput: String { get set }
    var passwordInput: String { get set }

    func userDidTapRegistration()
}

final class AuthorizationViewModelImpl: AuthorizationViewModel {
    @Published var navigationRoute: AuthorizationRoute? = nil

    @Published var emailInput: String = ""
    @Published var passwordInput: String = ""

    func userDidTapRegistration() {
        navigationRoute = .registration
    }
}
