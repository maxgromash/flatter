package com.app.flatter.database

import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import tables.AppDatabase

internal class AppDatabaseRepositoryImpl : KoinComponent, AppDatabaseRepository {
    private val databaseDriverFactory: DatabaseDriverFactory by inject()

    private val database: AppDatabase by lazy {
        AppDatabase(databaseDriverFactory.createDriver())
    }
}