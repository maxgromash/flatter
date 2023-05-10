import Foundation
import shared

protocol PersonalInfoChangesViewModel: ViewModel where Route == ProfileChangesRoute {
    var phoneNumberInput: String { get set }

    var confirmButtonEnabled: Bool { get }

    func userDidTapSaveButton()
}

final class PersonalInfoChangesViewModelImpl: AuthStoreViewModel, PersonalInfoChangesViewModel {
    @Published var navigationRoute: ProfileChangesRoute? = nil
    @Published var overviewRoute: ProfileChangesRoute? = nil
    @Published var showAlert: Bool = false

    var phoneNumberInput: String {
        get { PhoneNumberFormatter.format(phoneNumber: phoneNumber) }
        set { phoneNumber = newValue }
    }

    var confirmButtonEnabled: Bool {
        PhoneNumberValidator.validate(phoneNumber: phoneNumber)
    }

    @Published private var phoneNumber: String = ""

    func userDidTapSaveButton() {
        reduce(action: AuthActionChangePhone(phone: phoneNumber))
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
