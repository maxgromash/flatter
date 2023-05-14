package com.app.flatter.android.viewModel

import androidx.lifecycle.LifecycleCoroutineScope
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.app.flatter.android.util.SingleLiveEvent
import com.app.flatter.businessModels.NewsModel
import com.app.flatter.presentation.news.NewsAction
import com.app.flatter.presentation.news.NewsSideEffect
import com.app.flatter.presentation.news.NewsState
import com.app.flatter.presentation.news.NewsStore
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch

class NewsViewModel : ViewModel() {

    private val store = NewsStore()
    private val newsLiveData = MutableLiveData<List<NewsModel>>()
    private val progressViewModel = SingleLiveEvent<Boolean>()
    private val showMessageViewModel = SingleLiveEvent<String>()

    init {
        observeState()
        getNews()
    }

    fun progressViewModel(): LiveData<Boolean> = progressViewModel
    fun showMessageViewModel(): LiveData<String> = showMessageViewModel
    fun newsLiveData(): LiveData<List<NewsModel>> = newsLiveData

    private fun getNews() {
        store.reduce(NewsAction.SyncNews)
    }

    fun getNewsById(id: Int): NewsModel? {
        return newsLiveData.value?.first { it.id == id }
    }

    fun launchWhenStartedCollectFlow(lifeCycleScope: LifecycleCoroutineScope) {
        lifeCycleScope.launchWhenStarted {
            store.observeState().collectLatest { state ->
                when (state) {
                    is NewsState.NewsList -> {
                        progressViewModel.value = false
                        newsLiveData.value = state.list
                    }

                    else -> {}
                }
            }
        }
    }

    private fun observeState() {
        viewModelScope.launch {
            store.observeSideEffects().collect { effect ->
                when (effect) {
                    is NewsSideEffect.ShowMessage -> {
                        progressViewModel.value = false
                        showMessageViewModel.value = effect.message
                    }

                    is NewsSideEffect.ShowProgress -> {
                        progressViewModel.value = true
                    }
                }
            }
        }
    }
}