package com.app.flatter.android.ui.flats.flatSearchResult.adapter

import android.graphics.Rect
import android.view.View
import androidx.recyclerview.widget.RecyclerView
import com.app.flatter.android.util.toPx

class FlatPreviewDecoration : RecyclerView.ItemDecoration() {

    private val offset = 16.toPx()

    override fun getItemOffsets(
        outRect: Rect,
        view: View,
        parent: RecyclerView,
        state: RecyclerView.State
    ) {
        val position = parent.getChildAdapterPosition(view)
        if (position == RecyclerView.NO_POSITION) return
        if (position == 0)
            outRect.set(offset, offset, offset, offset)
        else
            outRect.set(offset, 0, offset, offset)

    }
}