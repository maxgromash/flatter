package com.app.flatter.android.ui.news.adapter

import androidx.recyclerview.widget.RecyclerView
import com.app.flatter.android.databinding.ItemNewsBinding
import com.app.flatter.businessModels.NewsModel
import com.bumptech.glide.Glide

class NewsViewHolder(
    private val binding: ItemNewsBinding,
    private val onItemClick: (NewsModel) -> Unit
) : RecyclerView.ViewHolder(binding.root) {

    fun bind(vo: NewsModel) {
        //binding.dateMTV.text = vo.publicationDate
        binding.titleMTV.text = vo.title

        Glide.with(binding.root.context)
            .load(vo.imageURL)
            .centerCrop()
            .into(binding.logoSIV)

        binding.rootCL.setOnClickListener { onItemClick.invoke(vo) }
    }
}