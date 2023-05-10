import Foundation
import SwiftUI
import shared

protocol AuthorizationViewModel: ViewModel where Route == AuthorizationRoute {
    var emailInput: String { get set }
    var passwordInput: String { get set }

    var emailValid: Bool { get }
    var passwordValid: Bool { get }

    func userDidTapAuthorizationButton()
    func userDidTapRegistration()
    func userDidTapRestorePassword()
}

final class AuthorizationViewModelImpl: AuthStoreViewModel, AuthorizationViewModel {
    @Published var navigationRoute: AuthorizationRoute? = nil

    @Published var overviewRoute: AuthorizationRoute? = nil

    @Published var emailInput: String = ""
    @Published var passwordInput: String = ""

    override init(store: AuthStore) {
        super.init(store: store)

        reduce(action: AuthActionCheckToken())
    }

    var emailValid: Bool {
        EmailValidator.validate(email: emailInput)
    }

    var passwordValid: Bool {
        PasswordValidator.validate(password: passwordInput)
    }

    func userDidTapAuthorizationButton() {
        reduce(action: AuthActionSignIn(email: emailInput, password: passwordInput))
    }

    func userDidTapRegistration() {
        navigationRoute = .registration
    }

    func userDidTapRestorePassword() {
        navigationRoute = .forgotPassword
    }

    func reset() {
        navigationRoute = nil
        overviewRoute = nil
        emailInput = ""
        passwordInput = ""
    }

    override func didChangeState(_ state: AuthState?) {
        guard let state else { return }

        switch state {
            case is AuthStateSuccess:
                overviewRoute = nil
                navigationRoute = .profile
            case is AuthStateNone:
                overviewRoute = nil
                navigationRoute = nil
            default: return
        }
    }

    override func didRecieveEffect(_ effect: AuthSideEffect?) {
//        guard let effect else {
//            overviewRoute = nil
//            return
//        }
//        switch effect {
//            case is AuthSideEffectShowProgress:
//                overviewRoute = .loading
//            default: overviewRoute = nil
//        }
    }
}
