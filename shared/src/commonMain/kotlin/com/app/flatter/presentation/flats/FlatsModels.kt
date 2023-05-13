package com.app.flatter.presentation.flats

import com.app.flatter.businessModels.FlatModel

sealed interface FlatsState {
    data class FlatsList(
        val list: List<FlatModel>
    ) : FlatsState

    object None : FlatsState
}

sealed interface FlatsStateAction {
    data class GetFlats(val projectID: Int) : FlatsStateAction
}

sealed interface FlatsStateSideEffect {
    object ShowProgress : FlatsStateSideEffect

    data class ShowMessage(val message: String) : FlatsStateSideEffect
}