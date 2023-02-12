import Foundation

protocol AuthorizationViewModel: ViewModel where Route == AuthorizationRoute {
    func userDidTapRegistration()
}

final class AuthorizationViewModelImpl: AuthorizationViewModel {
    @Published var navigationRoute: AuthorizationRoute? = nil
    @Published var overviewRoute: AuthorizationRoute? = nil

    func userDidTapRegistration() {
        overviewRoute = .registration
    }
}
