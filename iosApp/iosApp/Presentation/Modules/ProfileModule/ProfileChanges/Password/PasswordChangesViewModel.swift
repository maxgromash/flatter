import Foundation

protocol PasswordChangesViewModel: ViewModel where Route == ProfileChangesRoute {
    var passwordInput: String { get set }
    var passwordAgainInput: String { get set }

    var passwordValid: Bool { get }
    var passswordAgainValid: Bool { get }

    var saveButtonEnabled: Bool { get }

    func userDidTapSaveButton()
}

final class PasswordChangesViewModelImpl: PasswordChangesViewModel {
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
        overviewRoute = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            self?.overviewRoute = nil
            self?.showAlert = true
        }
    }
}
