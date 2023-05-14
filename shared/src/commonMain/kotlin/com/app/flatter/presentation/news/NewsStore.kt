package com.app.flatter.presentation.news

import com.app.flatter.businessModels.NewsModel
import com.app.flatter.mapper.NewsMapper
import com.app.flatter.network.NewsClient
import com.app.flatter.presentation.BaseStore
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.datetime.Instant
import kotlinx.datetime.toLocalDate
import models.GetNewsResponse
import models.News

import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

class NewsStore: BaseStore<NewsState, NewsAction, NewsSideEffect>(), KoinComponent {
    override val stateFlow = MutableStateFlow<NewsState>(NewsState.None)
    override val sideEffectsFlow = MutableSharedFlow<NewsSideEffect>()

    private val client: NewsClient by inject()
    private val mapper: NewsMapper by inject()

    override suspend fun reduce(action: NewsAction, initialState: NewsState) {
        coroutineScope {
            when (action) {
                is NewsAction.SyncNews -> processNewsSync()
            }
        }
    }

    private suspend fun processNewsSync() {
        sendEffect { NewsSideEffect.ShowProgress }
        runCatching {
            client.loadNews()
        }
            .onSuccess { response ->
                val mapped = mapper.invoke(response.news)
                updateState { NewsState.NewsList(mapped) }
            }
            .onFailure {
                sendEffect { NewsSideEffect.ShowMessage(message = "Не удалось загрузить новости") }
            }
    }
}