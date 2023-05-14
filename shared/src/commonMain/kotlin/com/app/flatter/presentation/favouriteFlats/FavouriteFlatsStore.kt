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
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

class FavouriteFlatsStore : BaseStore<FavouriteFlatsState, FavouriteFlatsAction, FavouriteFlatsSideEffect>(), KoinComponent {

    override val stateFlow = MutableStateFlow<FavouriteFlatsState>(FavouriteFlatsState.None)
    override val sideEffectsFlow = MutableSharedFlow<FavouriteFlatsSideEffect>()

    private val appDatabaseRepository: AppDatabaseRepository by inject()
    private val client: FavouriteFlatsClient by inject()
    private val mapper: FlatMapper by inject()
    private val tokenStore = SharedSettingsHelper(EncryptedSettingsHolder().encryptedSettings)

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
            appDatabaseRepository.addFavouriteFlat(action.id)
            //TODO client...
        }.onSuccess {
            sendEffect { FavouriteFlatsSideEffect.ShowMessage("Добавлено в избранное!") }
        }.onFailure {
            sendEffect { FavouriteFlatsSideEffect.ShowMessage("Проверьте соединение с сетью!") }
        }
    }

    private suspend fun processRemoveFavouriteFlat(action: FavouriteFlatsAction.RemoveFavouriteFlat) {
        runCatching {
            appDatabaseRepository.removeFavouriteFlat(action.id)
            //TODO client...
        }.onSuccess {

        }.onFailure {
            sendEffect { FavouriteFlatsSideEffect.ShowMessage("Проверьте соединение с сетью!") }
        }
    }

    private suspend fun processGetFavouriteFlats() {
        runCatching {
            val cachedFavourites = appDatabaseRepository.getFavouriteFlats()
            // Если база не пустая - синкаем с сервом при запросе избранных
            if (cachedFavourites.isNotEmpty()) {
                //TODO client.setFavouriteFlats()
                appDatabaseRepository.deleteAllFavouriteFlats()
            }

            //TODO client.getFavouriteFlats(action) . получаем избранные с серва
        }.onSuccess {
            //TODO stateFlow.emit(FavouriteFlatsState.FavouriteFlatsList())
        }.onFailure {
            updateState { FavouriteFlatsState.None }
            sendEffect { FavouriteFlatsSideEffect.ShowMessage("Проверьте соединение с сетью!") }
        }
    }
}