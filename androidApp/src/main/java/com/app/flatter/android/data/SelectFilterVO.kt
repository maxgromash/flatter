package com.app.flatter.android.data

data class SelectFilterVO(
    val list: List<FilterItem>
) {
    data class FilterItem(
        val value: Int,
        val sign: String
    )
}