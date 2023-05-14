package com.app.flatter.android.viewModel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.app.flatter.businessModels.FlatModel
import com.app.flatter.presentation.flats.FlatsStateAction
import com.app.flatter.presentation.flats.FlatsStore

class FlatsViewModel(projectID: Int) : ViewModel() {

    private var store = FlatsStore(projectID)
    private val mutableFlatsList: MutableList<FlatModel> = mutableListOf()
    private val mutableStarredList: MutableList<FlatModel> = mutableListOf()

    private val flatsLiveData = MutableLiveData<List<FlatModel>>()
    private val starredFlatsLiveData = MutableLiveData<List<FlatModel>>()

    fun starredFlatsLiveData(): LiveData<List<FlatModel>> = starredFlatsLiveData
    fun flatsLiveData(): LiveData<List<FlatModel>> = flatsLiveData

    init {
        store.reduce(FlatsStateAction.GetFlats)
    }

    fun getFlatDetailsById(id: Int): FlatModel? {
        return mutableFlatsList.find { it.id == id }
    }

    fun setStar(id: Int) {
        val ind = mutableFlatsList.indexOfFirst { it.id == id }
        val item = mutableFlatsList[ind]
        mutableFlatsList[ind] = mutableFlatsList[ind].copy(isFavourite = item.isFavourite.not())
        if (item.isFavourite.not()) {
            mutableStarredList.add(item.copy(isFavourite = true))
        } else {
            mutableStarredList.remove(item.copy(isFavourite = true))
        }
        flatsLiveData.value = mutableFlatsList.filter()
        starredFlatsLiveData.value = mutableStarredList
    }

    fun setSquareFilter(min: Int, max: Int) {
        squareFilter = min to max
        flatsLiveData.value = mutableFlatsList.filter()
    }

    fun setRoomsFilter(set: Set<Int>) {
        roomsFilter = set
        flatsLiveData.value = mutableFlatsList.filter()
    }

    fun setFloorFilter(min: Int, max: Int) {
        floorFilter = min to max
        flatsLiveData.value = mutableFlatsList.filter()
    }

    fun setPriceFilter(min: Int, max: Int) {
        priceFilter = min to max
        flatsLiveData.value = mutableFlatsList.filter()
    }

    private var squareFilter: Pair<Int, Int>? = null

    private var roomsFilter: Set<Int>? = null

    private var floorFilter: Pair<Int, Int>? = null

    private var priceFilter: Pair<Int, Int>? = null

    private fun MutableList<FlatModel>.filter(): List<FlatModel> {
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
        flatsLiveData.value = mutableFlatsList
    }

    /* private fun ohMyMockFlats() = mutableListOf(
         FlatPreviewVO(
             1,
             listOf(R.drawable.flat_layout_1, R.drawable.floor_layout_1, R.drawable.gen_plan),
             "13 878 677 ₽",
             13_878_677,
             21.8,
             "21.8 м2",
             13,
             "13 этаж",
             1,
             "Чистовая",
             "4 кв. 2024",
             134
         ),
         FlatPreviewVO(
             2,
             listOf(R.drawable.flat_layout_2, R.drawable.floor_layout_2, R.drawable.gen_plan),
             "15 014 010 ₽",
             15_014_010,
             33.0,
             "33 м2",
             1,
             "1 этаж",
             2,
             "Чистовая",
             "4 кв. 2024",
             13
         ),
         FlatPreviewVO(
             3,
             listOf(R.drawable.flat_layout_3, R.drawable.floor_layout_3, R.drawable.gen_plan),
             "27 391 422 ₽",
             27_391_422,
             51.0,
             "51 м2",
             8,
             "8 этаж",
             3,
             "Чистовая",
             "4 кв. 2024",
             323
         ),
         FlatPreviewVO(
             4,
             listOf(R.drawable.flat_layout_4, R.drawable.floor_layout_4, R.drawable.gen_plan),
             "29 442 263 ₽",
             29_442_263,
             69.5,
             "69.5 м2",
             5,
             "5 этаж",
             4,
             "Чистовая",
             "4 кв. 2024",
             55
         )
     )*/
}