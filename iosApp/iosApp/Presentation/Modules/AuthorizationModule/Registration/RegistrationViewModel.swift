import Foundation
import shared

protocol RegistrationViewModel: ViewModel where Route == RegistrationRoute {
    var nameInput: String { get set }
    var emailInput: String { get set }
    var phoneNumberInput: String { get set }

    var passwordInput: String { get set }
    var passwordAgainInput: String { get set }

    var nameValid: Bool { get }
    var emailValid: Bool { get }
    var passwordValid: Bool { get }
    var passswordAgainValid: Bool { get }

    func userDidTapRegistrationButton()
}

final class RegistrationViewModelImpl: AuthStoreViewModel, RegistrationViewModel {
    @Published var navigationRoute: RegistrationRoute? = nil
    @Published var overviewRoute: RegistrationRoute? = nil
    @Published var alertText: String? = nil

    @Published var nameInput: String = ""
    @Published var emailInput: String = ""
    var phoneNumberInput: String {
        get { PhoneNumberFormatter.format(phoneNumber: _phoneNumber) }
        set { _phoneNumber = newValue }
    }
    @Published var passwordInput: String = ""
    @Published var passwordAgainInput: String = ""

    @Published private var _phoneNumber: String = ""

    var nameValid: Bool {
        nameInput.count >= 2
    }
    var emailValid: Bool {
        EmailValidator.validate(email: emailInput)
    }
    var passwordValid: Bool {
        PasswordValidator.validate(password: passwordInput)
    }
    var passswordAgainValid: Bool {
        PasswordValidator.validate(password: passwordAgainInput) && passwordAgainInput == passwordInput
    }

    func userDidTapRegistrationButton() {
        reduce(
            action: AuthActionSingUp(
                phone: phoneNumberInput,
                email: emailInput,
                name: nameInput,
                password: passwordInput,
                passwordConfirm: passwordAgainInput
            )
        )
    }

    override func didReceiveEffect(_ effect: AuthSideEffect?) {
        guard let effect else { return }

        switch effect {
            case is AuthSideEffectShowProgress:
                overviewRoute = .loading
            case is AuthSideEffectShowMessage:
                overviewRoute = nil
                guard let showMessage = effect as? AuthSideEffectShowMessage else { return }
                alertText = showMessage.message
            default: return
        }
    }
}
