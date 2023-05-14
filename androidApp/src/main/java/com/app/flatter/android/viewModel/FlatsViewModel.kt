package com.app.flatter.android.viewModel

import androidx.lifecycle.LifecycleCoroutineScope
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.app.flatter.android.util.SingleLiveEvent
import com.app.flatter.businessModels.FlatModel
import com.app.flatter.presentation.favouriteFlats.FavouriteFlatsAction
import com.app.flatter.presentation.favouriteFlats.FavouriteFlatsStore
import com.app.flatter.presentation.flats.FlatsAction
import com.app.flatter.presentation.flats.FlatsSideEffect
import com.app.flatter.presentation.flats.FlatsState
import com.app.flatter.presentation.flats.FlatsStore
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch

class FlatsViewModel(projectID: Int) : ViewModel() {

    private var store = FlatsStore(projectID)
    private var favouritesStore = FavouriteFlatsStore()
    private val progressViewModel = SingleLiveEvent<Boolean>()
    private val showMessageViewModel = SingleLiveEvent<String>()
    private val flatsLiveData = MutableLiveData<List<FlatModel>>()
    private val starredFlatsLiveData = MutableLiveData<List<FlatModel>>()

    init {
        observeState()
    }

    fun progressViewModel(): LiveData<Boolean> = progressViewModel
    fun showMessageViewModel(): LiveData<String> = showMessageViewModel
    fun starredFlatsLiveData(): LiveData<List<FlatModel>> = starredFlatsLiveData
    fun flatsLiveData(): LiveData<List<FlatModel>> = flatsLiveData

    init {
        store.reduce(FlatsAction.GetFlats)
    }

    fun getFlatDetailsById(id: Int): FlatModel? {
        return flatsLiveData.value?.find { it.id == id }
    }

    fun setStar(id: Int) {
        favouritesStore.reduce(FavouriteFlatsAction.AddFavouriteFlat(id))



        /*val ind = flatsLiveData.value!!.indexOfFirst { it.id == id }
        val item = flatsLiveData.value[ind]
        mutableFlatsList[ind] = mutableFlatsList[ind].copy(isFavourite = item.isFavourite.not())
        if (item.isFavourite.not()) {
            mutableStarredList.add(item.copy(isFavourite = true))
        } else {
            mutableStarredList.remove(item.copy(isFavourite = true))
        }
        flatsLiveData.value = mutableFlatsList.filter()
        starredFlatsLiveData.value = mutableStarredList*/
    }

    fun setSquareFilter(min: Int, max: Int) {
        squareFilter = min to max
        flatsLiveData.value = flatsLiveData.value?.filter()
    }

    fun setRoomsFilter(set: Set<Int>) {
        roomsFilter = set
        flatsLiveData.value = flatsLiveData.value?.filter()
    }

    fun setFloorFilter(min: Int, max: Int) {
        floorFilter = min to max
        flatsLiveData.value = flatsLiveData.value?.filter()
    }

    fun setPriceFilter(min: Int, max: Int) {
        priceFilter = min to max
        flatsLiveData.value = flatsLiveData.value?.filter()
    }

    private var squareFilter: Pair<Int, Int>? = null

    private var roomsFilter: Set<Int>? = null

    private var floorFilter: Pair<Int, Int>? = null

    private var priceFilter: Pair<Int, Int>? = null

    private fun List<FlatModel>.filter(): List<FlatModel> {
        return filter {
            if (squareFilter != null)
                it.area >= squareFilter!!.first && it.area <= squareFilter!!.second
            else
                true
        }
            .filter {
                if (roomsFilter != null)
                    roomsFilter!!.contains(it.rooms)
                else
                    true
            }
            .filter {
                if (floorFilter != null)
                    it.floor >= floorFilter!!.first && it.floor <= floorFilter!!.second
                else true
            }.filter {
                if (priceFilter != null) it.price >= priceFilter!!.first && it.price <= priceFilter!!.second
                else true
            }
    }

    fun clearFilters() {
        squareFilter = null
        roomsFilter = null
        floorFilter = null
        priceFilter = null
        //flatsLiveData.value = mutableFlatsList
    }

    fun launchWhenStartedCollectFlow(lifeCycleScope: LifecycleCoroutineScope) {
        lifeCycleScope.launchWhenStarted {
            store.observeState().collectLatest { state ->
                when (state) {
                    is FlatsState.FlatsList -> {
                        progressViewModel.value = false
                        flatsLiveData.value = state.list
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
                    is FlatsSideEffect.ShowMessage -> {
                        progressViewModel.value = false
                        showMessageViewModel.value = effect.message
                    }

                    is FlatsSideEffect.ShowProgress -> {
                        progressViewModel.value = true
                    }
                }
            }
        }
    }
}