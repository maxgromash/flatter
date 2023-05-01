package com.app.flatter.android.ui.flats.flatDetails.adapter

import androidx.recyclerview.widget.RecyclerView
import com.app.flatter.android.data.FlatPreviewVO
import com.app.flatter.android.databinding.ItemFlatDetailsBinding

class FlatDetailsViewHolder(
    private val binding: ItemFlatDetailsBinding
) : RecyclerView.ViewHolder(binding.root) {

    fun bind(vo: Int) {
        binding.root.setImageResource(vo)
    }
}