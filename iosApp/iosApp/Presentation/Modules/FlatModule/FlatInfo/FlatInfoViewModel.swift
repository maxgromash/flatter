import Foundation

protocol FlatInfoViewModel: ViewModel where Route == FlatInfoRoute {
    var flat: FlatModel { get }

    func userDidTapFavouriteButton()
}

final class FlatInfoViewModelImpl: FlatInfoViewModel {
    @Published var navigationRoute: FlatInfoRoute? = nil

    @Published var flat: FlatModel

    init(flat: FlatModel) {
        self.flat = flat
    }

    func userDidTapFavouriteButton() {
//        flatsProvider.updateFlatIsFavourite(flat: flat)
    }
}
