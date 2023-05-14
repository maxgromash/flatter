import Foundation
import UIKit
import shared

protocol ProfileViewModel: ViewModel where Route == ProfileRoute {
    var user: UserModel { get }

    func userDidTapLogOutButton()
    func userDidTapFavouritesList()
    func userDidTapDocumentsList()
    func userDidTapProfileChangeButton()
    func userDidTapCallButton()
}

final class ProfileViewModelImpl: AuthStoreViewModel, ProfileViewModel {
    @Published var navigationRoute: ProfileRoute? = nil

    @Published var user: UserModel

    init(user: UserModel, store: AuthStore) {
        self.user = user
        super.init(store: store)
    }
    
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

    override func didChangeState(_ state: AuthState?) {
        guard let state else { return }
        if let authState = state as? AuthStateAuthorized {
            self.user = .init(authState.model)
        }
    }
}
