package com.app.flatter.android.data

import java.io.Serializable

data class NewsVO(
    val date: String,
    val title: String,
    val imageLink: String? = null
): Serializable