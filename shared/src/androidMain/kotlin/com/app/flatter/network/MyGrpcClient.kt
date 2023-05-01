package com.app.flatter.network

import com.squareup.wire.GrpcClient
import okhttp3.OkHttpClient
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

internal class MyGrpcClient : KoinComponent {

    private val grpcOkhttpClient: OkHttpClient by inject()

    val grpcClient = GrpcClient.Builder()
        .client(grpcOkhttpClient)
        .baseUrl("http://45.8.250.161:8000")
        .build()
}