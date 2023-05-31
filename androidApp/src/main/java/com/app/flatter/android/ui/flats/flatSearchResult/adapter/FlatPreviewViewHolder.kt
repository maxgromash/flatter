package com.app.flatter.android.ui.flats.flatSearchResult.adapter

import androidx.recyclerview.widget.RecyclerView
import com.app.flatter.android.R
import com.app.flatter.android.databinding.ItemSearchResultBinding
import com.app.flatter.android.util.formatBySpace
import com.app.flatter.businessModels.FlatModel
import com.bumptech.glide.Glide

class FlatPreviewViewHolder(
    private val binding: ItemSearchResultBinding,
    private val onItemClick: (FlatModel) -> Unit,
    private val onStarClick: (Int, Boolean) -> Unit
) : RecyclerView.ViewHolder(binding.root) {

    fun bind(vo: FlatModel) {
        binding.rootCL.setOnClickListener { onItemClick.invoke(vo) }

        Glide.with(binding.root.context)
            .load(vo.images.first())
            .centerInside()
            .into(binding.flatLayoutACIV)

        binding.priceMTV.text = "${vo.price.formatBySpace()} ₽"
        binding.squareTitleMTV.text = "${vo.area} м2"
        binding.floorMTV.text = "${vo.floor} этаж"
        binding.starACIV.setImageResource(if (vo.isFavourite) R.drawable.ic_baseline_star_24 else R.drawable.ic_baseline_star_border_24)
        binding.starACIV.setOnClickListener {
            onStarClick.invoke(vo.id, vo.isFavourite.not())
        }
    }
}