package com.app.flatter.di

import co.touchlab.kermit.Logger
import co.touchlab.kermit.StaticConfig
import com.app.flatter.database.AppDatabaseRepository
import com.app.flatter.database.AppDatabaseRepositoryImpl
import com.app.flatter.mapper.FlatMapper
import com.app.flatter.mapper.NewsMapper
import com.app.flatter.mapper.ProjectsMapper
import com.app.flatter.mapper.UserMapper
import com.app.flatter.network.AuthClient
import com.app.flatter.network.FavouriteFlatsClient
import com.app.flatter.network.FlatsClient
import com.app.flatter.network.NetworkClientsProvider
import com.app.flatter.network.NewsClient
import com.app.flatter.network.ProjectsClient
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
    single { AppDatabaseRepositoryImpl() } bind AppDatabaseRepository::class
    single { NetworkClientsProvider.authClient } bind AuthClient::class
    single { NetworkClientsProvider.newsClient } bind NewsClient::class
    single { NetworkClientsProvider.projectsClient } bind ProjectsClient::class
    single { NetworkClientsProvider.flatsClient } bind FlatsClient::class
    single { NetworkClientsProvider.favouriteFlatsClient } bind FavouriteFlatsClient::class
    single { FlatMapper() }
    single { ProjectsMapper() }
    single { NewsMapper() }
    single { UserMapper() }
}

expect val platformModule: Module