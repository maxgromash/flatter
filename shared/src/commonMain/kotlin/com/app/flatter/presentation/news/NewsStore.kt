package com.app.flatter.presentation.news

import com.app.flatter.businessModels.NewsModel
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
                updateState { NewsState.NewsList(response.toNewsList()) }
            }
            .onFailure {
                sendEffect { NewsSideEffect.ShowMessage(message = "Не удалось загрузить новости") }
            }
    }

    private fun GetNewsResponse.toNewsList(): List<NewsModel> {
        return this.news.map { it.toModel() }
    }

    private fun News.toModel(): NewsModel {
        return NewsModel(
            id = this.id,
            title = this.title,
            description = this.description,
            publicationDate = this.date,
            imageURL = this.images.first()
        )
    }
}