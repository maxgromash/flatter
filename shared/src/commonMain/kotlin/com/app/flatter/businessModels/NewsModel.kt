package com.app.flatter.businessModels

import kotlinx.datetime.Instant

data class NewsModel(
    val id: String,
    val title: String,
    val description: String,
    val publicationDate: Instant,
    val imageURL: String
)
