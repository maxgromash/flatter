package com.app.flatter.android.data

data class RangeFilterVO(
    val titleStart: String,
    val titleEnd: String,
    val appendValue: String,
    val minValue: Int,
    val maxValue: Int,
    val type: FilterType
) {
    enum class FilterType {
        SQUARE, FLOOR, PRICE
    }
}