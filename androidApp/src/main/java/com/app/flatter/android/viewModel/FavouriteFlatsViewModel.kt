package com.app.flatter.android.viewModel

import androidx.lifecycle.LifecycleCoroutineScope
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.app.flatter.android.util.SingleLiveEvent
import com.app.flatter.businessModels.FlatModel
import com.app.flatter.presentation.favouriteFlats.FavouriteFlatsAction
import com.app.flatter.presentation.favouriteFlats.FavouriteFlatsSideEffect
import com.app.flatter.presentation.favouriteFlats.FavouriteFlatsState
import com.app.flatter.presentation.favouriteFlats.FavouriteFlatsStore
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch

class FavouriteFlatsViewModel : ViewModel() {

    private var store = FavouriteFlatsStore()
    private val progressViewModel = SingleLiveEvent<Boolean>()
    private val showMessageViewModel = SingleLiveEvent<String>()
    private val starredFlatsLiveData = MutableLiveData<List<FlatModel>>()

    fun progressViewModel(): LiveData<Boolean> = progressViewModel
    fun showMessageViewModel(): LiveData<String> = showMessageViewModel
    fun starredFlatsLiveData(): LiveData<List<FlatModel>> = starredFlatsLiveData

    init {
        observeState()
    }

    fun getFlatDetailsById(id: Int): FlatModel? {
        return starredFlatsLiveData.value?.find { it.id == id }
    }

    fun getFlats(){
        store.reduce(FavouriteFlatsAction.GetFavouriteFlats)
    }

    fun setStar(id: Int, isStar: Boolean) {
        if (isStar)
            store.reduce(FavouriteFlatsAction.AddFavouriteFlat(id))
        else
            store.reduce(FavouriteFlatsAction.RemoveFavouriteFlat(id))
        store.reduce(FavouriteFlatsAction.GetFavouriteFlats)
    }

    fun launchWhenStartedCollectFlow(lifeCycleScope: LifecycleCoroutineScope) {
        lifeCycleScope.launchWhenStarted {
            store.observeState().collectLatest { state ->
                when (state) {
                    is FavouriteFlatsState.FavouriteFlatsList -> {
                        progressViewModel.value = false
                        starredFlatsLiveData.value = state.list
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
                    is FavouriteFlatsSideEffect.ShowMessage -> {
                        progressViewModel.value = false
                        showMessageViewModel.value = effect.message
                    }

                    is FavouriteFlatsSideEffect.ShowProgress -> {
                        progressViewModel.value = true
                    }
                }
            }
        }
    }
}