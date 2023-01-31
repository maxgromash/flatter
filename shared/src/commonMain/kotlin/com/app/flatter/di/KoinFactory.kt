package com.app.flatter.di

import co.touchlab.kermit.Logger
import co.touchlab.kermit.StaticConfig
import com.app.flatter.database.AppDatabaseRepository
import com.app.flatter.database.AppDatabaseRepositoryImpl
import org.koin.core.context.startKoin
import org.koin.core.module.Module
import org.koin.dsl.KoinAppDeclaration
import org.koin.dsl.bind
import org.koin.dsl.module

// How to use https://github.com/zazzazeHSE/CookerMobile/blob/dev/shared/src/commonMain/kotlin/on/the/stove/di/KoinFactory.kt

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
}

expect val platformModule: Module