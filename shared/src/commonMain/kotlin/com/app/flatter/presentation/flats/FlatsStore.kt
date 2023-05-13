package com.app.flatter.presentation.flats

import com.app.flatter.mapper.FlatMapper
import com.app.flatter.network.FlatsClient
import com.app.flatter.presentation.BaseStore
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import models.GetFlatsRequest

import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

class FlatsStore : BaseStore<FlatsState, FlatsStateAction, FlatsStateSideEffect>(), KoinComponent {
    override val stateFlow = MutableStateFlow<FlatsState>(FlatsState.None)
    override val sideEffectsFlow = MutableSharedFlow<FlatsStateSideEffect>()

    private val client: FlatsClient by inject()
    private val mapper: FlatMapper by inject()

    override suspend fun reduce(action: FlatsStateAction, initialState: FlatsState) {
        coroutineScope {
            when (action) {
                is FlatsStateAction.GetFlats -> processGetFlats(action)
            }
        }
    }

    private suspend fun processGetFlats(action: FlatsStateAction.GetFlats) {
        sendEffect { FlatsStateSideEffect.ShowProgress }
        runCatching {
            client.loadFlats(GetFlatsRequest(action.projectID))
        }.onSuccess {
            val mappedFlats = it.flats.map(mapper)
            updateState { FlatsState.FlatsList(mappedFlats) }
        }.onFailure {
            sideEffectsFlow.emit(FlatsStateSideEffect.ShowMessage("Проверьте соединение с сетью!"))
        }
    }
}