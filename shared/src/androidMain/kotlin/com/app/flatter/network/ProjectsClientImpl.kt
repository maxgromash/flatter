package com.app.flatter.network

import com.squareup.wire.GrpcClient
import models.GetProjectsResponse
import models.GrpcProjectServiceClient
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import org.koin.core.parameter.parametersOf

class ProjectsClientImpl : ProjectsClient, KoinComponent {

    private val grpcClient: GrpcClient by inject { parametersOf(false) }

    private val client by lazy { GrpcProjectServiceClient(grpcClient) }

    override suspend fun loadProjects(): GetProjectsResponse {
        return client.GetProjects().execute(Unit)
    }
}