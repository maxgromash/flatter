package com.app.flatter.businessModels

data class FlatModel(
    val id: Int,
    val price: Double,
    val rooms: Int,
    val number: Int,
    val area: Int,
    val floor: Int,
    val trimming: String,
    val finishing: String,
    val images: List<String>,
    val isFavourite: Boolean
)