package com.app.flatter.database

interface AppDatabaseRepository {

    fun addFavouriteFlat(id: Int)

    fun removeFavouriteFlat(id: Int)

    fun getFavouriteFlats(): List<Int>

    fun deleteAllFavouriteFlats()
}