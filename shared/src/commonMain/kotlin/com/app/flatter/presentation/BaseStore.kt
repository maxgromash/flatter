package com.app.flatter.presentation

import co.touchlab.kermit.Logger
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import org.koin.core.component.KoinComponent
import com.app.flatter.dispatchers.*
import kotlinx.coroutines.Job

abstract class BaseStore<State, Action, Effect> : KoinComponent {

    protected abstract val stateFlow: MutableStateFlow<State>
    protected abstract val sideEffectsFlow: MutableSharedFlow<Effect>
    private val scope: CoroutineScope = CoroutineScope(uiDispatcher + SupervisorJob())
    var reduceJob: Job? = null

    protected suspend fun updateState(reduceState: (state: State) -> State) {
        val state = reduceState(stateFlow.value)
        Logger.d("[STORE]: ${this::class.simpleName} update state ${state!!::class.simpleName}")
        scope.launch(uiDispatcher) { stateFlow.emit(state) }
    }

    protected suspend fun sendEffect(sendEffect: () -> Effect) {
        val effect = sendEffect()
        Logger.d("[STORE]: ${this::class.simpleName} send effect ${effect!!::class.simpleName}")
        scope.launch(uiDispatcher) { sideEffectsFlow.emit(effect) }
    }

    protected abstract suspend fun reduce(action: Action, initialState: State)

    fun reduce(action: Action) {
        Logger.d("[STORE]: ${this::class.simpleName} reduce action ${action!!::class.qualifiedName}")
        reduceJob = scope.launch(ioDispatcher) {
            reduce(action, stateFlow.value)
        }
    }

    fun observeState(): StateFlow<State> = stateFlow

    fun observeSideEffects(): Flow<Effect> = sideEffectsFlow
}