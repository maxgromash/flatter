package com.app.flatter.presentation.news

import com.app.flatter.businessModels.NewsModel
import com.app.flatter.presentation.auth.AuthSideEffect

sealed interface NewsState {
    data class NewsList(
        val list: List<NewsModel>
    ) : NewsState
    object None: NewsState
}

sealed interface NewsAction {
    object SyncNews: NewsAction
}

sealed interface NewsSideEffect {
    object ShowProgress: NewsSideEffect

    data class ShowMessage(val message: String) : NewsSideEffect
}