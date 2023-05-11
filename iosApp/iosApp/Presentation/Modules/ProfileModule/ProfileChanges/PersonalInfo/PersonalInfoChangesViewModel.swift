import Foundation
import shared

protocol PersonalInfoChangesViewModel: ViewModel where Route == ProfileChangesRoute {
    var phoneNumberInput: String { get set }

    var confirmButtonEnabled: Bool { get }

    func userDidTapSavePhoneButton()
}
