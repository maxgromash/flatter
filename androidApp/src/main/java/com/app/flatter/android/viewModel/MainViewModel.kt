package com.app.flatter.android.viewModel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.app.flatter.android.R
import com.app.flatter.android.data.FlatPreviewVO
import com.app.flatter.android.data.MetroStep
import com.app.flatter.android.data.ProfileVO
import com.app.flatter.android.data.ProjectVO
import com.app.flatter.presentation.auth.AuthAction
import com.app.flatter.presentation.auth.AuthStore

class MainViewModel : ViewModel() {

    val profile = ProfileVO("Максим", "+7 (922) 704 58 75")
    private var authStore = AuthStore()
    private val mutableFlatsList: MutableList<FlatPreviewVO> = ohMyMockFlats()
    private val mutableStarredList: MutableList<FlatPreviewVO> = mutableListOf()

    private val flatsLiveData = MutableLiveData<List<FlatPreviewVO>>()
    private val starredFlatsLiveData = MutableLiveData<List<FlatPreviewVO>>()
    private val projectsLiveData = MutableLiveData<List<ProjectVO>>()

    fun starredFlatsLiveData(): LiveData<List<FlatPreviewVO>> = starredFlatsLiveData
    fun projectsLiveData(): LiveData<List<ProjectVO>> = projectsLiveData
    fun flatsLiveData(): LiveData<List<FlatPreviewVO>> = flatsLiveData

    init {
        flatsLiveData.value = mutableFlatsList.filter()
        projectsLiveData.value = ohMyMockProjects()
    }

    fun getFlatDetailsById(id: Int): FlatPreviewVO? {
        return mutableFlatsList.find { it.id == id }
    }

    fun getProjectById(id: Int): ProjectVO? {
        return projectsLiveData.value?.find { it.id == id }
    }

    fun setStar(id: Int) {
        val ind = mutableFlatsList.indexOfFirst { it.id == id }
        val item = mutableFlatsList[ind]
        mutableFlatsList[ind] = mutableFlatsList[ind].copy(isStarred = item.isStarred.not())
        if (item.isStarred.not()) {
            mutableStarredList.add(item.copy(isStarred = true))
        } else {
            mutableStarredList.remove(item.copy(isStarred = true))
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

    private fun MutableList<FlatPreviewVO>.filter(): List<FlatPreviewVO> {
        return filter {
            if (squareFilter != null)
                it.square >= squareFilter!!.first && it.square <= squareFilter!!.second
            else
                true
        }
            .filter {
                if (roomsFilter != null)
                    roomsFilter!!.contains(it.roomsCount)
                else
                    true
            }
            .filter {
                if (floorFilter != null)
                    it.floor >= floorFilter!!.first && it.floor <= floorFilter!!.second
                else true
            }.filter {
                if (priceFilter != null)
                    it.price >= priceFilter!!.first && it.price <= priceFilter!!.second
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


    private fun ohMyMockProjects() = listOf(
        ProjectVO(
            1,
            "https://raw.githubusercontent.com/maxgromash/flatter/5897a80fdc883ca9fbbf715da8d2afb3cedd5e4b/iosApp/iosApp/Resources/Assets.xcassets/project_icon.imageset/%D0%9E%D1%81%D1%82%D1%80%D0%BE%D0%B2-1.jpg",
            "Москва, ул. 1-й Дубровский проезд, 78/14с12",
            "Первый Дубровский",
            "от 11,8 млн. руб.",
            "Lorem Ipsum - это текст-рыба, часто используемый в печати и вэб-дизайне. Lorem Ipsum является стандартной рыбой для текстов на латинице с начала XVI века. В то время некий безымянный печатник создал большую коллекцию размеров и форм шрифтов, используя Lorem Ipsum для распечатки образцов. Lorem Ipsum не только успешно пережил без заметных изменений пять веков, но и перешагнул в электронный дизайн. Его популяризации в новое время послужили публикация листов Letraset с образцами Lorem Ipsum в 60-х годах и, в более недавнее время, программы электронной вёрстки типа Aldus PageMaker, в шаблонах которых используется Lorem Ipsum.\n",
            55.724282 to 37.684901,
            listOf(
                MetroStep(
                    "Волгоградский проспект",
                    "2 мин",
                    R.color.md_theme_dark_errorContainer
                )
            )
        ),
        ProjectVO(
            2,
            "https://raw.githubusercontent.com/maxgromash/flatter/5897a80fdc883ca9fbbf715da8d2afb3cedd5e4b/iosApp/iosApp/Resources/Assets.xcassets/symbol_project.imageset/symbol.jpg",
            "Москва, ул. Золоторожский Вал, 11с2",
            "Символ",
            "от 9,5 млн. руб.",
            "Lorem Ipsum - это текст-рыба, часто используемый в печати и вэб-дизайне. Lorem Ipsum является стандартной рыбой для текстов на латинице с начала XVI века. В то время некий безымянный печатник создал большую коллекцию размеров и форм шрифтов, используя Lorem Ipsum для распечатки образцов. Lorem Ipsum не только успешно пережил без заметных изменений пять веков, но и перешагнул в электронный дизайн. Его популяризации в новое время послужили публикация листов Letraset с образцами Lorem Ipsum в 60-х годах и, в более недавнее время, программы электронной вёрстки типа Aldus PageMaker, в шаблонах которых используется Lorem Ipsum.",
            55.748808 to 37.692687,
            listOf(
                MetroStep(
                    "м. Римская",
                    "8 мин",
                    R.color.green
                ),
                MetroStep(
                    "м. Авиамоторная",
                    "12 мин",
                    R.color.yellow
                )
            )
        )
    )

    private fun ohMyMockFlats() = mutableListOf(
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
    )
}