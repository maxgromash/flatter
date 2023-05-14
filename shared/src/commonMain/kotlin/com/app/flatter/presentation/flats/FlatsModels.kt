package com.app.flatter.presentation.flats

import com.app.flatter.businessModels.FlatModel

sealed interface FlatsState {
    data class FlatsList(
        val list: List<FlatModel>
    ) : FlatsState

    object None : FlatsState
}

sealed interface FlatsAction {
    object GetFlats : FlatsAction
}

sealed interface FlatsSideEffect {
    object ShowProgress : FlatsSideEffect

    data class ShowMessage(val message: String) : FlatsSideEffect
}