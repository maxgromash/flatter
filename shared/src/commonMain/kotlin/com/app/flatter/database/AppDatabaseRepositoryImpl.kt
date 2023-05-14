package com.app.flatter.database

import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import tables.AppDatabase

internal class AppDatabaseRepositoryImpl : KoinComponent, AppDatabaseRepository {
    private val databaseDriverFactory: DatabaseDriverFactory by inject()

    private val database: AppDatabase by lazy {
        AppDatabase(databaseDriverFactory.createDriver())
    }

    override fun addFavouriteFlat(id: Int) {
        database.favouriteFlatsTableQueries
            .insertFavouriteFlat(id.toLong())
    }

    override fun removeFavouriteFlat(id: Int) {
        database.favouriteFlatsTableQueries
            .deleteFavouriteFlat(id.toLong())
    }


    override fun getFavouriteFlats() = database.favouriteFlatsTableQueries
        .getAllFavouriteFlats()
        .executeAsList()
        .map { it.toInt() }

    override fun deleteAllFavouriteFlats() {
        database.favouriteFlatsTableQueries.deleteAllFavouriteFlats()
    }
}