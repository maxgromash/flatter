package com.app.flatter.network

interface NewsClient {
    suspend fun loadNews()
}