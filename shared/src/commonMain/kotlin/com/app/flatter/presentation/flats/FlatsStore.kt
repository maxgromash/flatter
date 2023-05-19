package com.app.flatter.presentation.flats

import com.app.flatter.database.AppDatabaseRepository
import com.app.flatter.mapper.FlatMapper
import com.app.flatter.network.FlatsClient
import com.app.flatter.presentation.BaseStore
import com.app.flatter.security.EncryptedSettingsHolder
import com.app.flatter.security.SharedSettingsHelper
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import models.GetFlatsRequest
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

class FlatsStore(private val projectID: Int) : BaseStore<FlatsState, FlatsAction, FlatsSideEffect>(), KoinComponent {
    override val stateFlow = MutableStateFlow<FlatsState>(FlatsState.None)
    override val sideEffectsFlow = MutableSharedFlow<FlatsSideEffect>()

    private val client: FlatsClient by inject()
    private val mapper: FlatMapper by inject()
    private val appDatabaseRepository: AppDatabaseRepository by inject()
    private val tokenStore = SharedSettingsHelper(EncryptedSettingsHolder().encryptedSettings)

    override suspend fun reduce(action: FlatsAction, initialState: FlatsState) {
        coroutineScope {
            when (action) {
                is FlatsAction.GetFlats -> processGetFlats()
            }
        }
    }

    private suspend fun processGetFlats() {
        sendEffect { FlatsSideEffect.ShowProgress }
        runCatching {
            client.loadFlats(GetFlatsRequest(projectID, tokenStore.token))
        }.onSuccess {
            val mappedFlats = it.flats.map(mapper)
            val favouriteFlatsIds = appDatabaseRepository.getFavouriteFlats()
            favouriteFlatsIds.forEach { favouriteId ->
                val flat = mappedFlats.first { flat -> flat.id == favouriteId }
                flat.isFavourite = true
            }
            updateState { FlatsState.FlatsList(mappedFlats) }
        }.onFailure {
            sendEffect { FlatsSideEffect.ShowMessage("Проверьте соединение с сетью!") }
        }
    }
}