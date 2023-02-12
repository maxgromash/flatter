import Foundation

protocol RegistrationViewModel: ViewModel where Route == RegistrationRoute {}

final class RegistrationViewModelImpl: RegistrationViewModel {
    var navigationRoute: RegistrationRoute? = nil
}
