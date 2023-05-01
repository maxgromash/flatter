import Foundation
import SwiftUI

protocol AuthorizationViewModel: ViewModel where Route == AuthorizationRoute {
    var emailInput: String { get set }
    var passwordInput: String { get set }

    var emailValid: Bool { get }
    var passwordValid: Bool { get }

    func userDidTapAuthorizationButton()
    func userDidTapRegistration()
    func userDidTapRestorePassword()
}

final class AuthorizationViewModelImpl: AuthorizationViewModel {
    @Published var navigationRoute: AuthorizationRoute? = nil

    @Published var overviewRoute: AuthorizationRoute? = nil

    @Published var emailInput: String = ""
    @Published var passwordInput: String = ""

    var emailValid: Bool {
        EmailValidator.validate(email: emailInput)
    }

    var passwordValid: Bool {
        PasswordValidator.validate(password: passwordInput)
    }


    func userDidTapAuthorizationButton() {
        overviewRoute = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.overviewRoute = nil
            self?.navigationRoute = .profile
        }
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
}
