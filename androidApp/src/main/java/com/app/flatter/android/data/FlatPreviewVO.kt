package com.app.flatter.android.data

import android.os.Parcelable
import androidx.annotation.DrawableRes
import kotlinx.parcelize.Parcelize

@Parcelize
data class FlatPreviewVO(
    val id: Int,
    @DrawableRes
    val layout: List<Int>,
    val priceString: String,
    val price: Int,
    val square: Double,
    val squareString: String,
    val floor: Int,
    val floorString: String,
    // количество квартир
    val roomsCount: Int,
    // Отделка
    val typeOfFinish: String,
    // Сдача
    val surrender: String,
    // Номер квартиры
    val roomNumber: Int,
    var isStarred: Boolean = false
): Parcelable