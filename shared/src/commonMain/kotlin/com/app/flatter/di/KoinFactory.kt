package com.app.flatter.di

import co.touchlab.kermit.Logger
import co.touchlab.kermit.StaticConfig
import com.app.flatter.network.AuthClient
import com.app.flatter.network.NetworkClientsProvider
import com.app.flatter.network.NewsClient
import org.koin.core.context.startKoin
import org.koin.core.module.Module
import org.koin.dsl.KoinAppDeclaration
import org.koin.dsl.bind
import org.koin.dsl.module

fun initKoin(appDeclaration: KoinAppDeclaration = {}) =
    startKoin {
        appDeclaration()
        modules(platformModule, commonModule)
    }

fun initKoin() = initKoin {
    val log = Logger(config = StaticConfig(), tag = "KOIN_")
    log.d("initKoin ios")
}

val commonModule = module {
    single { NetworkClientsProvider.authClient } bind AuthClient::class
    single { NetworkClientsProvider.newsClient } bind NewsClient::class
}

expect val platformModule: Module