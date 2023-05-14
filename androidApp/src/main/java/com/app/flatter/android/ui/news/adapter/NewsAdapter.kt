package com.app.flatter.android.ui.news.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.app.flatter.android.databinding.ItemNewsBinding
import com.app.flatter.businessModels.NewsModel

class NewsAdapter(
    private val onItemClick: (NewsModel) -> Unit
) : RecyclerView.Adapter<NewsViewHolder>() {

    private var list: List<NewsModel> = listOf()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): NewsViewHolder {
        val view = ItemNewsBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return NewsViewHolder(view, onItemClick)
    }

    override fun onBindViewHolder(holder: NewsViewHolder, position: Int) {
        holder.bind(list[position])
    }

    @SuppressLint("NotifyDataSetChanged")
    fun setItems(newList: List<NewsModel>) {
        list = newList
        notifyDataSetChanged()
    }

    override fun getItemCount() = list.size
}