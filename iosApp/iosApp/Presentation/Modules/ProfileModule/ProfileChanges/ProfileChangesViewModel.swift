import Foundation
import shared

final class ProfileChangesViewModel: AuthStoreViewModel {
    @Published var navigationRoute: ProfileChangesRoute? = nil
    @Published var overviewRoute: ProfileChangesRoute? = nil
    @Published var alertText: String? = nil

    @Published var passwordInput: String = ""
    @Published var passwordAgainInput: String = ""

    @Published private var phoneNumber: String = ""

    override func didReceiveEffect(_ effect: AuthSideEffect?) {
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

extension ProfileChangesViewModel: PasswordChangesViewModel {
    var passwordValid: Bool {
        PasswordValidator.validate(password: passwordInput)
    }
    var passswordAgainValid: Bool {
        passwordInput == passwordAgainInput && passwordValid
    }

    var saveButtonEnabled: Bool {
        passswordAgainValid
    }

    func userDidTapSavePasswordButton() {
        reduce(
            action: AuthActionChangePassword(
                password: passwordInput,
                passwordConfirm: passwordAgainInput
            )
        )
    }
}

extension ProfileChangesViewModel: PersonalInfoChangesViewModel {
    var phoneNumberInput: String {
        get { PhoneNumberFormatter.format(phoneNumber: phoneNumber) }
        set { phoneNumber = newValue }
    }

    var confirmButtonEnabled: Bool {
        PhoneNumberValidator.validate(phoneNumber: phoneNumber)
    }

    func userDidTapSavePhoneButton() {
        reduce(action: AuthActionChangePhone(phone: phoneNumber))
    }
}
