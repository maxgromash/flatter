package com.app.flatter.android.data

data class ProfileActionVO(
    val icon: Int,
    val title: String,
    val isArrowVisible: Boolean,
    val onClickCallback: (() -> Unit)? = null
)