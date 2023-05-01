package com.app.flatter.android.ui.flats.flatSearchResult.view

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.widget.FrameLayout
import android.widget.LinearLayout
import com.app.flatter.android.data.SelectFilterVO
import com.app.flatter.android.databinding.ViewSelectFilterBinding
import com.app.flatter.android.util.toPx
import com.google.android.material.textview.MaterialTextView

class SelectFilterView(
    context: Context,
    attrs: AttributeSet? = null
) : FrameLayout(context, attrs) {

    private val binding = ViewSelectFilterBinding.inflate(LayoutInflater.from(context), this)
    private val set = mutableSetOf<Int>()
    var isSelect: Boolean = false

    init {

    }

    fun bind(item: SelectFilterVO) {


    }

    private fun getNewFilter(item: SelectFilterVO.FilterItem) = MaterialTextView(context).apply {
        layoutParams = LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT,
            LinearLayout.LayoutParams.WRAP_CONTENT
        ).apply {
            leftMargin = 16.toPx()
        }

        text = item.sign
        set.add(item.value)
        setOnClickListener {
            if (isSelect) {

            }
            isSelect = !isSelect
        }
    }
}