import SwiftUI
import shared

class BaseViewModel<
    State,
    Action,
    Effect,
    Store: BaseStore<State, Action, Effect>
>: ObservableObject {
    private let store: Store

    private lazy var stateCollector: Observer = {
        let collector = Observer { [weak self] state in
            if let value = state as? State? {
                self?.didChangeState(value)
            }
        }
        return collector
    }()

    private lazy var effectCollector: Observer = {
        let collector = Observer { [weak self] effect in
            if let value = effect as? Effect? {
                self?.didRecieveEffect(value)
            }
        }
        return collector
    }()

    init(store: Store) {
        self.store = store
        store.observeState().collect(collector: stateCollector, completionHandler: { _ in })
        store.observeSideEffects().collect(collector: effectCollector, completionHandler: { _ in })
    }

    func didChangeState(_ state: State?) {  }

    func didRecieveEffect(_ effect: Effect?) {  }

    func reduce(action: Action) {
        store.reduce(action: action)
    }
}

typealias Collector = Kotlinx_coroutines_coreFlowCollector

class Observer: Collector {
    let callback:(Any?) -> Void

    init(callback: @escaping (Any?) -> Void) {
        self.callback = callback
    }

    func emit(value: Any?, completionHandler: @escaping (Error?) -> Void) {
        callback(value)
        completionHandler(nil)
    }
}
