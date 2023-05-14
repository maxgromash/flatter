package com.app.flatter.businessModels

data class NewsModel(
    val id: Int,
    val title: String,
    val description: String,
    val publicationDate: String,
    val imageURL: String
)
