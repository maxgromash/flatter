import Foundation
import UIKit

protocol ProfileViewModel: ViewModel where Route == ProfileRoute {
    func userDidTapLogOutButton()
    func userDidTapFavouritesList()
    func userDidTapDocumentsList()
    func userDidTapProfileChangeButton()
    func userDidTapCallButton()
}

final class ProfileViewModelImpl: ProfileViewModel {
    @Published var navigationRoute: ProfileRoute? = nil

    let logOut: () -> Void

    init(logOut: @escaping () -> Void) {
        self.logOut = logOut
    }

    func userDidTapLogOutButton() {
        logOut()
    }

    func userDidTapFavouritesList() {
        navigationRoute = .favourites
    }

    func userDidTapDocumentsList() {
        navigationRoute = .documents
    }

    func userDidTapProfileChangeButton() {
        navigationRoute = .profileChanges
    }

    func userDidTapCallButton() {
        guard let url = URL(string: "tel://89634415933") else { return }
        UIApplication.shared.open(url)
    }
}
