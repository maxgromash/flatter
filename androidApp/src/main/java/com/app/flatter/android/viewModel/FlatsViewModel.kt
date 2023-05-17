package com.app.flatter.android.viewModel

import androidx.lifecycle.LifecycleCoroutineScope
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.app.flatter.android.data.RangeFilterVO
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

    private var flatsStore = FlatsStore(projectID)
    private var favouriteFlatsStore = FavouriteFlatsStore()
    private val progressViewModel = SingleLiveEvent<Boolean>()
    private val showMessageViewModel = SingleLiveEvent<String>()
    private val flatsLiveData = MutableLiveData<List<FlatModel>>()
    private val originalFlatsList = mutableListOf<FlatModel>()

    init {
        observeState()
    }

    fun progressViewModel(): LiveData<Boolean> = progressViewModel
    fun showMessageViewModel(): LiveData<String> = showMessageViewModel
    fun flatsLiveData(): LiveData<List<FlatModel>> = flatsLiveData

    init {
        flatsStore.reduce(FlatsAction.GetFlats)
    }

    fun getFlatDetailsById(id: Int): FlatModel? {
        return flatsLiveData.value?.find { it.id == id }
    }

    fun setStar(id: Int, isStar: Boolean) {
        favouriteFlatsStore.reduce(if (isStar) FavouriteFlatsAction.AddFavouriteFlat(id) else FavouriteFlatsAction.RemoveFavouriteFlat(id))
        flatsStore.reduce(FlatsAction.GetFlats)
    }

    fun setSquareFilter(min: Int, max: Int) {
        squareFilter = min to max
        flatsLiveData.value = originalFlatsList.filter()
    }

    fun setRoomsFilter(set: Set<Int>) {
        roomsFilter = set
        flatsLiveData.value = originalFlatsList.filter()
    }

    fun setFloorFilter(min: Int, max: Int) {
        floorFilter = min to max
        flatsLiveData.value = originalFlatsList.filter()
    }

    fun setPriceFilter(min: Int, max: Int) {
        priceFilter = min to max
        flatsLiveData.value = originalFlatsList.filter()
    }

    private var squareFilter: Pair<Int, Int>? = null

    private var roomsFilter: Set<Int>? = null

    private var floorFilter: Pair<Int, Int>? = null

    private var priceFilter: Pair<Int, Int>? = null

    private fun List<FlatModel>.filter() =
        filter { flat -> squareFilter?.let { filter -> flat.area >= filter.first && flat.area <= filter.second } ?: true }
            .filter { flat -> roomsFilter?.contains(flat.rooms) ?: true }
            .filter { flat -> floorFilter?.let { filter -> flat.floor >= filter.first && flat.floor <= filter.second } ?: true }
            .filter { flat -> priceFilter?.let { filter -> flat.price >= filter.first && flat.price <= filter.second } ?: true }

    fun clearFilters() {
        squareFilter = null
        roomsFilter = null
        floorFilter = null
        priceFilter = null
        flatsLiveData.value = originalFlatsList
    }

    fun launchWhenStartedCollectFlow(lifeCycleScope: LifecycleCoroutineScope) {
        lifeCycleScope.launchWhenStarted {
            flatsStore.observeState().collectLatest { state ->
                when (state) {
                    is FlatsState.FlatsList -> {
                        progressViewModel.value = false
                        originalFlatsList.clear()
                        originalFlatsList.addAll(state.list)
                        flatsLiveData.value = originalFlatsList
                    }

                    else -> {}
                }
            }
        }
    }

    fun getFilters() = listOf(
        RangeFilterVO(
            "Минимальная площадь",
            "Максимальная площадь",
            "м2",
            15,
            200,
            RangeFilterVO.FilterType.SQUARE
        ),
        RangeFilterVO(
            "Минимальный этаж",
            "Максимальный этаж",
            "этаж",
            1,
            30,
            RangeFilterVO.FilterType.FLOOR
        ),
        RangeFilterVO(
            "Минимальная стоимость",
            "Максимальная стоимость",
            "₽",
            8_000_000,
            30_000_000,
            RangeFilterVO.FilterType.PRICE
        )
    )

    private fun observeState() {
        viewModelScope.launch {
            flatsStore.observeSideEffects().collect { effect ->
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