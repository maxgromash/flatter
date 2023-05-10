import Foundation
import UIKit
import shared

protocol ProfileViewModel: ViewModel where Route == ProfileRoute {
    func userDidTapLogOutButton()
    func userDidTapFavouritesList()
    func userDidTapDocumentsList()
    func userDidTapProfileChangeButton()
    func userDidTapCallButton()
}

final class ProfileViewModelImpl: AuthStoreViewModel, ProfileViewModel {
    @Published var navigationRoute: ProfileRoute? = nil
    
    func userDidTapLogOutButton() {
        reduce(action: AuthActionLogOut())
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
