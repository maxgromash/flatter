package com.app.flatter.android.data

import android.os.Parcelable
import kotlinx.parcelize.Parcelize

@Parcelize
data class ProjectVO(
    val id: Int,
    val imageLink: String,
    val address: String,
    val title: String,
    val pricesFrom: String? = null,
    val description: String,
    val cord: Pair<Double, Double>,
    val metroSteps: List<MetroStep>
): Parcelable