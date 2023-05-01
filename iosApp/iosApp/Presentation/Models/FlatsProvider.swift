import Foundation

final class FlatsProvider {
    typealias Listener = ([FlatModel]) -> Void

    static let shared = FlatsProvider()

    var flats: [FlatModel] = .mock

    private var listeners: [Listener] = []

    func updateFlatIsFavourite(flat: FlatModel) {
        var newFlats = flats
        for (idx, existedFlat) in newFlats.enumerated() {
            if existedFlat.id == flat.id {
                newFlats[idx].isFavourite = !newFlats[idx].isFavourite
            }
        }

        flats = newFlats
        listeners.forEach({ $0(flats) })
    }

    func addListener(_ listener: @escaping Listener) {
        listeners.append(listener)
    }
}

protocol FlatsProviderListener {
    func onFlatsChange()
}
