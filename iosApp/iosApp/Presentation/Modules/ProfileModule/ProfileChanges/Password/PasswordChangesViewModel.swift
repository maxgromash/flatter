import Foundation
import shared

protocol PasswordChangesViewModel: ViewModel where Route == ProfileChangesRoute {
    var passwordInput: String { get set }
    var passwordAgainInput: String { get set }

    var passwordValid: Bool { get }
    var passswordAgainValid: Bool { get }

    var saveButtonEnabled: Bool { get }

    func userDidTapSaveButton()
}

final class PasswordChangesViewModelImpl: AuthStoreViewModel, PasswordChangesViewModel {
    @Published var navigationRoute: ProfileChangesRoute? = nil
    @Published var overviewRoute: ProfileChangesRoute? = nil
    @Published var showAlert: Bool = false

    @Published var passwordInput: String = ""
    @Published var passwordAgainInput: String = ""

    var passwordValid: Bool {
        PasswordValidator.validate(password: passwordInput)
    }
    var passswordAgainValid: Bool {
        passwordInput == passwordAgainInput && passwordValid
    }

    var saveButtonEnabled: Bool {
        passswordAgainValid
    }

    func userDidTapSaveButton() {
        reduce(
            action: AuthActionChangePassword(
                password: passwordInput,
                passwordConfirm: passwordAgainInput
            )
        )
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
