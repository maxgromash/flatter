package com.app.flatter.network

import com.squareup.wire.GrpcClient
import models.GetFlatsRequest
import models.GetFlatsResponse
import models.GrpcProjectServiceClient
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import org.koin.core.parameter.parametersOf

class FlatsClientImpl : FlatsClient, KoinComponent {

    private val grpcClient: GrpcClient by inject { parametersOf(false) }

    private val client by lazy { GrpcProjectServiceClient(grpcClient) }

    override suspend fun loadFlats(data: GetFlatsRequest): GetFlatsResponse {
        return client.GetFlats().execute(data)
    }
}