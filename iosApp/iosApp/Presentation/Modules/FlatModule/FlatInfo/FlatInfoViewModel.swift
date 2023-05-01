import Foundation

protocol FlatInfoViewModel: ViewModel where Route == FlatInfoRoute {
    var flat: FlatModel { get }

    func userDidTapFavouriteButton()
}

final class FlatInfoViewModelImpl: FlatInfoViewModel {
    @Published var navigationRoute: FlatInfoRoute? = nil

    @Published var flat: FlatModel

    private let flatsProvider = FlatsProvider.shared

    init(id: UUID) {
        guard let flat = flatsProvider.flats.first(where: { $0.id == id }) else {
            fatalError()
        }
        self.flat = flat

        flatsProvider.addListener { [weak self] flats in
            if
                let self,
                let updatedFlat = flats.first(where: { $0 == self.flat })
            {
                print(self.flat)
                print(updatedFlat)
                self.flat = updatedFlat
            }
        }
    }

    func userDidTapFavouriteButton() {
        flatsProvider.updateFlatIsFavourite(flat: flat)
    }
}
