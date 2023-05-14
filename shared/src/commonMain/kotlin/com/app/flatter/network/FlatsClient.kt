package com.app.flatter.network

import models.GetFlatsRequest
import models.GetFlatsResponse

interface FlatsClient {
    suspend fun loadFlats(data: GetFlatsRequest): GetFlatsResponse
}