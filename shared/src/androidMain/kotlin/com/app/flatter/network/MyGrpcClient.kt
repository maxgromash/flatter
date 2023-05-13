package com.app.flatter.network

import com.squareup.wire.GrpcClient
import okhttp3.OkHttpClient
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

internal class MyGrpcClient : KoinComponent {

    private val grpcOkhttpClient: OkHttpClient by inject()

    val grpcAuthClient = GrpcClient.Builder()
        .client(grpcOkhttpClient)
        .baseUrl("http://81.163.30.24:9000")
        .build()

    val grpcProjectsClient = GrpcClient.Builder()
        .client(grpcOkhttpClient)
        .baseUrl("http://81.163.30.24:9001")
        .build()
}