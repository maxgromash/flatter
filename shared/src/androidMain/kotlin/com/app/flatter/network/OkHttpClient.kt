package com.app.flatter.network

import okhttp3.OkHttpClient

internal class HttpClient {

    val grpcOkhttpClient = OkHttpClient().newBuilder()
        .protocols(listOf(okhttp3.Protocol.H2_PRIOR_KNOWLEDGE))
        .build()
}