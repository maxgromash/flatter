package com.app.flatter.android.ui.flats.flatSearchResult.adapter

import androidx.recyclerview.widget.RecyclerView
import com.app.flatter.android.R
import com.app.flatter.android.databinding.ItemSearchResultBinding
import com.app.flatter.android.data.FlatPreviewVO

class FlatPreviewViewHolder(
    private val binding: ItemSearchResultBinding,
    private val onItemClick: (FlatPreviewVO) -> Unit,
    private val onStarClick: (Int) -> Unit
) : RecyclerView.ViewHolder(binding.root) {

    fun bind(vo: FlatPreviewVO) {
        binding.rootCL.setOnClickListener { onItemClick.invoke(vo) }

        binding.priceMTV.text = vo.priceString
        binding.flatLayoutACIV.setImageResource(vo.layout.first())
        binding.squareTitleMTV.text = vo.squareString
        binding.floorMTV.text = vo.floorString
        if (vo.isStarred)
            binding.starACIV.setImageResource(R.drawable.ic_baseline_star_24)
        else
            binding.starACIV.setImageResource(R.drawable.ic_baseline_star_border_24)
        binding.starACIV.setOnClickListener {
            onStarClick.invoke(vo.id)
        }
    }
}