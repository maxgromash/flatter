import Foundation
import shared

protocol ForgotPasswordViewModel: ViewModel where Route == ForgotPasswordRoute {
    var emailInput: String { get set }
    var emailValid: Bool { get }

    func userDidTapSendButton()
}

final class ForgotPasswordViewModelImpl: AuthStoreViewModel, ForgotPasswordViewModel {
    @Published var navigationRoute: ForgotPasswordRoute? = nil
    @Published var overviewRoute: ForgotPasswordRoute? = nil
    @Published var alertText: String? = nil

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
            case is AuthSideEffectShowMessage:
                overviewRoute = nil
                guard let showMessage = effect as? AuthSideEffectShowMessage else { return }
                alertText = showMessage.message
            default: overviewRoute = nil
        }
    }
}

