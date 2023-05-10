package com.app.flatter.di

import com.app.flatter.network.HttpClient
import com.app.flatter.network.MyGrpcClient
import com.app.flatter.network.AuthClient
import com.squareup.wire.GrpcClient
import okhttp3.OkHttpClient
import org.koin.core.module.Module
import org.koin.dsl.bind
import org.koin.dsl.module

actual val platformModule: Module = module {
    single { HttpClient().grpcOkhttpClient } bind OkHttpClient::class
    single { MyGrpcClient().grpcClient } bind GrpcClient::class
    single { AuthClient() }
}