package com.app.flatter.android.ui.flats.flatDetails.adapter

import androidx.recyclerview.widget.RecyclerView
import com.app.flatter.android.databinding.ItemFlatDetailsBinding
import com.bumptech.glide.Glide

class FlatDetailsViewHolder(
    private val binding: ItemFlatDetailsBinding
) : RecyclerView.ViewHolder(binding.root) {

    fun bind(vo: String) {
        Glide.with(binding.root.context)
            .load(vo)
            .centerCrop()
            .into(binding.root)

    }
}