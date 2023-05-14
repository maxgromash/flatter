package com.app.flatter.presentation.favouriteFlats

import com.app.flatter.businessModels.FlatModel

sealed interface FavouriteFlatsState {
    data class FavouriteFlatsList(
        val list: List<FlatModel>
    ) : FavouriteFlatsState

    object None : FavouriteFlatsState
}

sealed interface FavouriteFlatsAction {
    data class AddFavouriteFlat(val id: Int) : FavouriteFlatsAction
    data class RemoveFavouriteFlat(val id: Int) : FavouriteFlatsAction
    object GetFavouriteFlats: FavouriteFlatsAction
}

sealed interface FavouriteFlatsSideEffect {
    object ShowProgress : FavouriteFlatsSideEffect

    data class ShowMessage(val message: String) : FavouriteFlatsSideEffect
}