package com.app.flatter.network

import models.*


interface FavouriteFlatsClient {
    suspend fun getFavourites(data: GetFavouritesRequest): GetFavouritesResponse
    suspend fun addFavourites(data: AddFavouritesRequest): AddFavouritesResponse

    suspend fun removeFavourites(data: RemoveFavouritesRequest): RemoveFavouritesResponse
}