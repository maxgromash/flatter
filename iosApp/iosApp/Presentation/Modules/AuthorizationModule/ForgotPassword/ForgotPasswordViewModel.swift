import Foundation
import shared

protocol ForgotPasswordViewModel: ViewModel where Route == ForgotPasswordRoute {
    var emailInput: String { get set }
    var emailValid: Bool { get }

    func userDidTapSendButton()
}

final class ForgotPasswordViewModelImpl: AuthStoreViewModel, ForgotPasswordViewModel {
    @Published var navigationRoute: ForgotPasswordRoute? = nil
    @Published var showAlert: Bool = false

    @Published var emailInput: String = ""

    var emailValid: Bool {
        EmailValidator.validate(email: emailInput)
    }

    func userDidTapSendButton() {
        reduce(action: AuthActionRestorePassword(email: emailInput))
    }

    override func didRecieveEffect(_ effect: AuthSideEffect?) {
        guard let effect else { return }
        switch effect {
            case is AuthSideEffectShowProgress:
                overviewRoute = .loading
            default: overviewRoute = nil
        }
    }
}

