import Foundation
import shared

protocol PasswordChangesViewModel: ViewModel where Route == ProfileChangesRoute {
    var passwordInput: String { get set }
    var passwordAgainInput: String { get set }

    var passwordValid: Bool { get }
    var passswordAgainValid: Bool { get }

    var saveButtonEnabled: Bool { get }

    func userDidTapSavePasswordButton()
}
