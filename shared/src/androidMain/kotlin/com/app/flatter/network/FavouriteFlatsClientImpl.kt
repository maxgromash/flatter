package com.app.flatter.network

import com.squareup.wire.GrpcClient
import models.AddFavouritesRequest
import models.AddFavouritesResponse
import models.GetFavouritesRequest
import models.GetFavouritesResponse
import models.GrpcProjectServiceClient
import models.RemoveFavouritesRequest
import models.RemoveFavouritesResponse
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import org.koin.core.parameter.parametersOf

class FavouriteFlatsClientImpl : FavouriteFlatsClient, KoinComponent {

    private val grpcClient: GrpcClient by inject { parametersOf(false) }

    private val client by lazy { GrpcProjectServiceClient(grpcClient) }

    override suspend fun getFavourites(data: GetFavouritesRequest): GetFavouritesResponse {
        return client.GetFavourites().execute(data)
    }

    override suspend fun addFavourites(data: AddFavouritesRequest): AddFavouritesResponse {
        return client.AddFavourites().execute(data)
    }

    override suspend fun removeFavourites(data: RemoveFavouritesRequest): RemoveFavouritesResponse {
        return client.RemoveFavourites().execute(data)
    }
}