package com.app.flatter.businessModels

import kotlinx.datetime.Instant

data class NewsModel(
    val id: Int,
    val title: String,
    val description: String,
    val publicationDate: String,
    val imageURL: String
)
