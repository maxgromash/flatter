package com.app.flatter.android.data

import java.io.Serializable

data class MetroStep(
    val name: String,
    val time: String,
    val metroLineColor: Int
): Serializable
