import Foundation

protocol FlatsListViewModel: ViewModel where Route == FlatsListRoute {
    var flats: [FlatModel] { get }

    var filter: Filters { get set }

    func onUserDidSelectFlat(flat: FlatModel)
    func userDidChangeFavourite(flat: FlatModel)
}

struct Filters {

    struct AreaFilter {
        static let min: Float = 10
        static let max: Float = 150
        var minArea: Float = Self.min
        var maxArea: Float = Self.max
    }

    struct FloorFilter {
        static let min: Float = 1
        static let max: Float = 20
        var minFloor: Float = Self.min
        var maxFloor: Float = Self.max
    }

    struct PriceFilter {
        let minPrice: Float
        let maxPrice: Float

        var minPriceValue: Float
        var maxPriceValue: Float

        init(minPrice: Float, maxPrice: Float) {
            self.minPrice = minPrice
            self.maxPrice = maxPrice
            self.minPriceValue = minPrice
            self.maxPriceValue = maxPrice
        }
    }

    var area = AreaFilter()
    var floor = FloorFilter()
    var price: PriceFilter
    var rooms: Set<Int> = [0, 1, 2, 3, 4]
}

final class FlatsListViewModelImpl: FlatsListViewModel {
    @Published var flats: [FlatModel]

    @Published var navigationRoute: FlatsListRoute? = nil

    @Published var filter: Filters {
        didSet {
            updateFlats()
        }
    }

    private let flatsProvider = FlatsProvider.shared

    init() {
        let flats = FlatsProvider.shared.flats
        filter = .init(
            price: .init(
                minPrice: Float(flats.min(by: { flat1, flat2 in
                    flat1.price < flat2.price
                })?.price ?? 0),
                maxPrice: Float(flats.max(by: { flat1, flat2 in
                    flat1.price < flat2.price
                })?.price ?? 0)
            )
        )

        self.flats = flats

        flatsProvider.addListener { [weak self] flats in
            self?.updateFlats()
        }
    }

    func onUserDidSelectFlat(flat: FlatModel) {
        navigationRoute = .flatInfo(flat: flat)
    }

    func userDidChangeFavourite(flat: FlatModel) {
        flatsProvider.updateFlatIsFavourite(flat: flat)
    }

    private func updateFlats() {
        var flats = flatsProvider.flats.filter {
            $0.area >= filter.area.minArea && $0.area <= filter.area.maxArea
            && $0.floor >= Int(filter.floor.minFloor) && $0.floor <= Int(filter.floor.maxFloor)
            && Float($0.price) >= filter.price.minPriceValue && Float($0.price) <= filter.price.maxPriceValue
        }

        flats = flats.filter {
            filter.rooms.contains($0.rooms) || filter.rooms.contains(4) && $0.rooms >= 4
        }

        self.flats = flats
    }
}

final class FlistListViewModelFavouritesOnly: FlatsListViewModel {
    var filter = Filters(price: .init(minPrice: 0, maxPrice: 0))

    @Published var flats: [FlatModel] = FlatsProvider.shared.flats

    @Published var navigationRoute: FlatsListRoute? = nil

    init() {
        flatsProvider.addListener { [weak self] flats in
            self?.filterFlats()
        }
        filterFlats()
    }

    private let flatsProvider = FlatsProvider.shared

    func onUserDidSelectFlat(flat: FlatModel) {
        navigationRoute = .flatInfo(flat: flat)
    }

    func userDidChangeFavourite(flat: FlatModel) {
        flatsProvider.updateFlatIsFavourite(flat: flat)
    }

    private func filterFlats() {
        flats = flatsProvider.flats.filter({ $0.isFavourite })
    }
}
