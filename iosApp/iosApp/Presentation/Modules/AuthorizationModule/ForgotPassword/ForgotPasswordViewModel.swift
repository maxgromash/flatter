import Foundation

protocol ForgotPasswordViewModel: ViewModel where Route == ForgotPasswordRoute {
    var emailInput: String { get set }
    var emailValid: Bool { get }

    func userDidTapSendButton()
}

final class ForgotPasswordViewModelImpl: ForgotPasswordViewModel {
    @Published var navigationRoute: ForgotPasswordRoute? = nil
    @Published var showAlert: Bool = false

    @Published var emailInput: String = ""

    var emailValid: Bool {
        EmailValidator.validate(email: emailInput)
    }

    func userDidTapSendButton() {
        showAlert = true
    }
}

