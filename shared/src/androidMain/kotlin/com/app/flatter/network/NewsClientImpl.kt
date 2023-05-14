package com.app.flatter.network

import com.squareup.wire.GrpcClient
import models.GetNewsResponse
import models.GrpcProjectServiceClient
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import org.koin.core.parameter.parametersOf

class NewsClientImpl : NewsClient, KoinComponent {

    private val grpcClient: GrpcClient by inject { parametersOf(false) }

    private val client by lazy { GrpcProjectServiceClient(grpcClient) }

    override suspend fun loadNews(): GetNewsResponse {
        return client.GetNews().execute(Unit)
    }
}