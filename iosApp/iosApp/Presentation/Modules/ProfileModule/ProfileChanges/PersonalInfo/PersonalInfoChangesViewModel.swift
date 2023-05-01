import Foundation

protocol PersonalInfoChangesViewModel: ViewModel where Route == ProfileChangesRoute {
    var phoneNumberInput: String { get set }

    var confirmButtonEnabled: Bool { get }

    func userDidTapSaveButton()
}

final class PersonalInfoChangesViewModelImpl: PersonalInfoChangesViewModel {
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
        overviewRoute = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.overviewRoute = nil
            self?.showAlert = true
        }
    }
}
