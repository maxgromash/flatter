package com.app.flatter.presentation.news

import com.app.flatter.businessModels.NewsModel
import com.app.flatter.network.NewsClient
import com.app.flatter.presentation.BaseStore
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.datetime.Instant

import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

class NewsStore: BaseStore<NewsState, NewsAction, NewsSideEffect>(), KoinComponent {
    override val stateFlow = MutableStateFlow<NewsState>(NewsState.None)
    override val sideEffectsFlow = MutableSharedFlow<NewsSideEffect>()

    private val client: NewsClient by inject()

    override suspend fun reduce(action: NewsAction, initialState: NewsState) {
        coroutineScope {
            when (action) {
                is NewsAction.SyncNews -> processNewsSync()
            }
        }
    }

    private suspend fun processNewsSync() {
        sendEffect { NewsSideEffect.ShowProgress }
        delay(1000)
        updateState {
            NewsState.NewsList(
                list = listOf(
                    NewsModel(
                        id = "1",
                        title = "Пример",
                        description = "Пример описания",
                        publicationDate = Instant.parse("2010-06-01T22:19:44.475Z"),
                        imageURL = "https://domavlad.ru/wp-content/uploads/2023/01/osnovnye-plyusy-karkasnogo-kottedzha-i-osobennosti-ego-stroitelstva-1.jpg"
                    )
                )
            )
        }
    }
}