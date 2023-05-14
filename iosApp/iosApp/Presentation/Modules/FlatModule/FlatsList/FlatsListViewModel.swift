import Foundation
import shared

protocol FlatsListViewModel: ViewModel where Route == FlatsListRoute {
    var flats: [FlatModel] { get }

    var filter: Filters? { get set }

    func onUserDidSelectFlat(flat: FlatModel)
    func userDidChangeFavourite(flat: FlatModel, isFavourite: Bool)
}

struct Filters {

    struct AreaFilter {
        let minArea: Float
        let maxArea: Float

        var minAreaValue: Float
        var maxAreaValue: Float

        init(minArea: Float, maxArea: Float) {
            let _maxArea = maxArea == minArea ? maxArea + 10 : maxArea
            self.minArea = minArea
            self.maxArea = _maxArea
            self.minAreaValue = minArea
            self.maxAreaValue = _maxArea
        }
    }

    struct FloorFilter {
        let minFloor: Float
        let maxFloor: Float

        var minFloorValue: Float
        var maxFloorValue: Float

        init(minFloor: Float, maxFloor: Float) {
            let _maxFloor = maxFloor == minFloor ? maxFloor + 1 : maxFloor
            self.minFloor = minFloor
            self.maxFloor = _maxFloor
            self.minFloorValue = minFloor
            self.maxFloorValue = _maxFloor
        }
    }

    struct PriceFilter {
        var minPrice: Float
        var maxPrice: Float

        var minPriceValue: Float
        var maxPriceValue: Float

        init(minPrice: Float, maxPrice: Float) {
            let _maxPrice = maxPrice == minPrice ? maxPrice + 1_000_000 : maxPrice
            self.minPrice = minPrice
            self.maxPrice = _maxPrice
            self.minPriceValue = minPrice
            self.maxPriceValue = _maxPrice
        }
    }

    var area: AreaFilter
    var floor: FloorFilter
    var price: PriceFilter
    var rooms: Set<Int> = [0, 1, 2, 3, 4]
}

final class FlatsListViewModelImpl: FlatsViewModel, FlatsListViewModel {
    @Published var flats: [FlatModel] = []

    @Published var navigationRoute: FlatsListRoute? = nil {
        didSet {
            if navigationRoute == nil {
                reduce(action: FlatsActionGetFlats())
            }
        }
    }
    @Published var overviewRoute: FlatsListRoute? = nil
    @Published var alertText: String? = nil

    @Published var filter: Filters? {
        didSet {
            updateFlats()
        }
    }

    private let favouritesStore: FavouriteFlatsStore = .shared

    private var actualFlats: [FlatModel] = []

    private let flatsProvider = FlatsProvider.shared

    private let imageLoader = ImageLoader.shared

    override init(store: FlatsStore) {
        super.init(store: store)
        reduce(action: FlatsActionGetFlats())
    }

    func onUserDidSelectFlat(flat: FlatModel) {
        navigationRoute = .flatInfo(flat: flat)
    }

    func userDidChangeFavourite(flat: FlatModel, isFavourite: Bool) {
        if isFavourite {
            favouritesStore.reduce(
                action: FavouriteFlatsActionAddFavouriteFlat(id: flat.id)
            )
        }
        else {
            favouritesStore.reduce(
                action: FavouriteFlatsActionRemoveFavouriteFlat(id: flat.id)
            )
        }
    }

    override func didReceiveEffect(_ effect: FlatsSideEffect?) {
        guard let effect else { return }
        switch effect {
            case is FlatsSideEffectShowProgress:
                overviewRoute = .loading
            case is FlatsSideEffectShowMessage:
                guard let message = effect as? FlatsSideEffectShowMessage else { return }
                alertText = message.message
            default: return
        }
    }

    override func didChangeState(_ state: FlatsState?) {
        guard let state else { return }
        switch state {
            case is FlatsStateFlatsList:
                guard let list = state as? FlatsStateFlatsList else { return }
                mapState(list)
            case is FlatsStateNone:
                filter = nil
                flats = []
            default: return
        }
    }

    private func updateFlats() {
        guard let filter else { return }
        var flats = actualFlats.filter {
            $0.area >= filter.area.minAreaValue && $0.area <= filter.area.maxAreaValue
            && $0.floor >= Int(filter.floor.minFloorValue) && $0.floor <= Int(filter.floor.maxFloorValue)
            && Float($0.price) >= filter.price.minPriceValue && Float($0.price) <= filter.price.maxPriceValue
        }

        flats = flats.filter {
            filter.rooms.contains($0.rooms) || filter.rooms.contains(4) && $0.rooms >= 4
        }

        self.flats = flats
    }

    private func mapState(_ state: FlatsStateFlatsList) {
        Task {
            let mapped = try? await state.list.concurrentMap(map(_:))
            updateFlats(mapped ?? [])
        }
    }

    private func updateFlats(_ flats: [FlatModel]) {
        guard false == flats.isEmpty else {
            return updateState(flats: flats, filter: nil)
        }
        var newFilter = makeFilters(flats: flats)
        if let oldFilter = self.filter {
            newFilter.floor.minFloorValue = oldFilter.floor.minFloorValue
            newFilter.floor.maxFloorValue = oldFilter.floor.maxFloorValue

            newFilter.area.minAreaValue = oldFilter.area.minAreaValue
            newFilter.area.maxAreaValue = oldFilter.area.maxAreaValue

            newFilter.price.minPriceValue = oldFilter.price.minPriceValue
            newFilter.price.maxPriceValue = oldFilter.price.maxPriceValue
        }

        updateState(flats: flats, filter: newFilter)
    }

    private func updateState(
        flats: [FlatModel],
        filter: Filters?
    ) {
        Task { @MainActor in
            self.actualFlats = flats
            self.filter = filter
            overviewRoute = nil
        }
    }

    private func makeFilters(flats: [FlatModel]) -> Filters {
        let area = Filters.AreaFilter(
            minArea: flats.min(by: { flat1, flat2 in
                flat1.area < flat2.area
            })?.area ?? 0,
            maxArea: flats.max(by: { flat1, flat2 in
                flat1.area < flat2.area
            })?.area ?? 0
        )
        let floor = Filters.FloorFilter(
            minFloor: Float(flats.min(by: { flat1, flat2 in
                flat1.floor < flat2.floor
            })?.floor ?? 0),
            maxFloor: Float(flats.max(by: { flat1, flat2 in
                flat1.floor < flat2.floor
            })?.floor ?? 0)
        )
        let price = Filters.PriceFilter(
            minPrice: Float(flats.min(by: { flat1, flat2 in
                flat1.price < flat2.price
            })?.price ?? 0),
            maxPrice: Float(flats.max(by: { flat1, flat2 in
                flat1.price < flat2.price
            })?.price ?? 0)
        )
        return Filters(
            area: area,
            floor: floor,
            price: price
        )
    }

    private func map(_ data: shared.FlatModel) async -> FlatModel {
        let imageURLs = data.images.compactMap(URL.init(string:))
        let loadedImages = try? await imageURLs
            .concurrentMap(imageLoader.loadImage(url:))
            .compactMap({ $0 })
        var images = loadedImages ?? []
        images = images.isEmpty ? [ImagesProvider.newsImagePlaceholder] : images
        return FlatModel(
            id: data.id,
            price: data.price,
            rooms: Int(data.rooms),
            number: Int(data.number),
            area: Float(data.area),
            floor: Int(data.floor),
            trimming: data.trimming,
            finishing: data.finishing,
            images: images,
            isFavourite: data.isFavourite
        )
    }
}

final class FlistListViewModelFavouritesOnly: FavouritesStoreViewModel, FlatsListViewModel {
    var filter: Filters? = nil

    @Published var flats: [FlatModel] = FlatsProvider.shared.flats

    @Published var navigationRoute: FlatsListRoute? = nil {
        didSet {
            if navigationRoute == nil {
                reduce(action: FavouriteFlatsActionGetFavouriteFlats())
            }
        }
    }
    @Published var overviewRoute: FlatsListRoute? = nil
    @Published var alertText: String? = nil

    private let imageLoader = ImageLoader.shared

    init() {
        super.init(store: .shared)
        reduce(action: FavouriteFlatsActionGetFavouriteFlats())
    }

    func onUserDidSelectFlat(flat: FlatModel) {
        navigationRoute = .flatInfo(flat: flat)
    }

    func userDidChangeFavourite(flat: FlatModel, isFavourite: Bool) {
        if isFavourite {
            reduce(
                action: FavouriteFlatsActionAddFavouriteFlat(id: flat.id)
            )
        }
        else {
            reduce(
                action: FavouriteFlatsActionRemoveFavouriteFlat(id: flat.id)
            )
        }
    }

    override func didChangeState(_ state: FavouriteFlatsState?) {
        guard let state else { return }
        if let list = state as? FavouriteFlatsStateFavouriteFlatsList {
            updateFlats(list)
        }
        else {
            flats = []
            overviewRoute = nil
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

    private func updateFlats(_ state: FavouriteFlatsStateFavouriteFlatsList) {
        Task {
            let mapped = try? await state.list.concurrentMap(map(_:))
            Task { @MainActor in
                self.flats = mapped ?? []
                overviewRoute = nil
            }
        }
    }

    private func map(_ data: shared.FlatModel) async -> FlatModel {
        let imageURLs = data.images.compactMap(URL.init(string:))
        let loadedImages = try? await imageURLs
            .concurrentMap(imageLoader.loadImage(url:))
            .compactMap({ $0 })
        var images = loadedImages ?? []
        images = images.isEmpty ? [ImagesProvider.newsImagePlaceholder] : images
        return FlatModel(
            id: data.id,
            price: data.price,
            rooms: Int(data.rooms),
            number: Int(data.number),
            area: Float(data.area),
            floor: Int(data.floor),
            trimming: data.trimming,
            finishing: data.finishing,
            images: images,
            isFavourite: data.isFavourite
        )
    }
}
