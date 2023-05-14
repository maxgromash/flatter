package com.app.flatter.network

import models.GetNewsResponse

interface NewsClient {
    suspend fun loadNews(): GetNewsResponse
}