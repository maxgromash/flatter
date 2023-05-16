package com.app.flatter.presentation.favouriteFlats

import com.app.flatter.database.AppDatabaseRepository
import com.app.flatter.mapper.FlatMapper
import com.app.flatter.network.FavouriteFlatsClient
import com.app.flatter.presentation.BaseStore
import com.app.flatter.security.EncryptedSettingsHolder
import com.app.flatter.security.SharedSettingsHelper
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import models.AddFavouritesRequest
import models.GetFavouritesRequest
import models.RemoveFavouritesRequest
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

class FavouriteFlatsStore : BaseStore<FavouriteFlatsState, FavouriteFlatsAction, FavouriteFlatsSideEffect>(), KoinComponent {

    override val stateFlow = MutableStateFlow<FavouriteFlatsState>(FavouriteFlatsState.None)
    override val sideEffectsFlow = MutableSharedFlow<FavouriteFlatsSideEffect>()

    private val appDatabaseRepository: AppDatabaseRepository by inject()
    private val client: FavouriteFlatsClient by inject()
    private val mapper: FlatMapper by inject()
    private val tokenStore: SharedSettingsHelper by inject()

    override suspend fun reduce(action: FavouriteFlatsAction, initialState: FavouriteFlatsState) {
        coroutineScope {
            when (action) {
                is FavouriteFlatsAction.AddFavouriteFlat -> processAddFavouriteFlat(action)
                is FavouriteFlatsAction.RemoveFavouriteFlat -> processRemoveFavouriteFlat(action)
                is FavouriteFlatsAction.GetFavouriteFlats -> processGetFavouriteFlats()
            }
        }
    }

    private suspend fun processAddFavouriteFlat(action: FavouriteFlatsAction.AddFavouriteFlat) {
        runCatching {
            tokenStore.token?.let { token ->
                client.addFavourites(
                    data = AddFavouritesRequest(
                        token = token,
                        ids = listOf(action.id)
                    )
                )
            } ?: run {
                appDatabaseRepository.addFavouriteFlat(action.id)
            }
        }.onSuccess {
            sendEffect { FavouriteFlatsSideEffect.ShowMessage("Добавлено в избранное!") }
        }.onFailure {
            appDatabaseRepository.addFavouriteFlat(action.id)
            sendEffect { FavouriteFlatsSideEffect.ShowMessage("Проверьте соединение с сетью!") }
        }
    }

    private suspend fun processRemoveFavouriteFlat(action: FavouriteFlatsAction.RemoveFavouriteFlat) {
        runCatching {
            appDatabaseRepository.removeFavouriteFlat(action.id)
            tokenStore.token?.let { token ->
                client.removeFavourites(
                    RemoveFavouritesRequest(
                        token = token,
                        id = action.id
                    )
                )
            }
        }.onSuccess {
            val stateFlats = stateFlow.value as? FavouriteFlatsState.FavouriteFlatsList
            stateFlats?.let {
                val filtered = stateFlats.list.filter { it.id != action.id }
                updateState { FavouriteFlatsState.FavouriteFlatsList(list = filtered) }
            } ?: run { updateState { FavouriteFlatsState.None } }
        }.onFailure {
            sendEffect { FavouriteFlatsSideEffect.ShowMessage("Проверьте соединение с сетью!") }
        }
    }

    private suspend fun processGetFavouriteFlats() {
        runCatching {
            val cachedFavourites = appDatabaseRepository.getFavouriteFlats()
            // Если база не пустая - синкаем с сервом при запросе избранных
            tokenStore.token?.let { token ->
                if (cachedFavourites.isNotEmpty()) {
                    client.addFavourites(
                        AddFavouritesRequest(
                            token = token,
                            ids = cachedFavourites
                        )
                    )
                    appDatabaseRepository.deleteAllFavouriteFlats()
                }
                client.getFavourites(
                    GetFavouritesRequest(
                        token = token
                    )
                )
            }
        }.onSuccess { response ->
            response?.let {
                val flats = it.flats.map(mapper)
                updateState { FavouriteFlatsState.FavouriteFlatsList(flats) }
            } ?: run {
                updateState { FavouriteFlatsState.None }
            }
        }.onFailure {
            updateState { FavouriteFlatsState.None }
            sendEffect { FavouriteFlatsSideEffect.ShowMessage("Проверьте соединение с сетью!") }
        }
    }
}