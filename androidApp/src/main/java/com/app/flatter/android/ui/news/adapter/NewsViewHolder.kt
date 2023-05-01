package com.app.flatter.android.ui.news.adapter

import androidx.recyclerview.widget.RecyclerView
import com.app.flatter.android.databinding.ItemNewsBinding
import com.app.flatter.android.data.NewsVO
import com.bumptech.glide.Glide

class NewsViewHolder(
    private val binding: ItemNewsBinding,
    private val onItemClick: (NewsVO) -> Unit
) : RecyclerView.ViewHolder(binding.root) {

    fun bind(vo: NewsVO) {
        binding.dateMTV.text = vo.date
        binding.titleMTV.text = vo.title

        Glide.with(binding.root.context)
            .load(vo.imageLink)
            .centerCrop()
            .into(binding.logoSIV)

        binding.rootCL.setOnClickListener { onItemClick.invoke(vo) }
    }
}