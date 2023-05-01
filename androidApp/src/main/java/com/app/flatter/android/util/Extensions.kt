package com.app.flatter.android.util

import android.content.res.Resources
import android.util.TypedValue
import java.text.DecimalFormatSymbols

fun Int.toPxF(): Float =
    TypedValue.applyDimension(
        TypedValue.COMPLEX_UNIT_DIP,
        this.toFloat(),
        Resources.getSystem().displayMetrics
    )

fun Int.toPx(): Int =
    toPxF().toInt()

fun Int.formatBySpace(): String {
    var x = this
    var res = ""
    do {
        res = "${x % 1000}${if (res == "") res else " $res"}"
        x /= 1000
    } while (x > 0);

    return res
}