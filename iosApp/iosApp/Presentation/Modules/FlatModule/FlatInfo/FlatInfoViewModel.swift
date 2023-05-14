import Foundation
import shared

protocol FlatInfoViewModel: ViewModel where Route == FlatInfoRoute {
    var flat: FlatModel { get }

    func userDidTapFavouriteButton()
}

final class FlatInfoViewModelImpl: FavouritesStoreViewModel, FlatInfoViewModel {
    @Published var navigationRoute: FlatInfoRoute? = nil

    @Published var flat: FlatModel
    @Published var alertText: String?

    init(flat: FlatModel) {
        self.flat = flat
        super.init(store: .shared)
    }
    

    func userDidTapFavouriteButton() {
        flat.isFavourite.toggle()
        if flat.isFavourite {
            reduce(action: FavouriteFlatsActionAddFavouriteFlat(id: flat.id))
        }
        else {
            reduce(action: FavouriteFlatsActionRemoveFavouriteFlat(id: flat.id))
        }
    }

    override func didReceiveEffect(_ effect: FavouriteFlatsSideEffect?) {
        guard let effect else { return }

        if let message = effect as? FavouriteFlatsSideEffectShowMessage {
            alertText = message.message
        }
        else if effect is FavouriteFlatsSideEffectShowProgress {
            overviewRoute = .loading
        }
    }
}
