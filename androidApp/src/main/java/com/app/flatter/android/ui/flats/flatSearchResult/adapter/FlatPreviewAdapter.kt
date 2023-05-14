package com.app.flatter.android.ui.flats.flatSearchResult.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.app.flatter.android.databinding.ItemSearchResultBinding
import com.app.flatter.businessModels.FlatModel

class FlatPreviewAdapter(
    private val onItemClick: (FlatModel) -> Unit,
    private val onStarClick: (Int) -> Unit
) : RecyclerView.Adapter<FlatPreviewViewHolder>() {

    private var list: List<FlatModel> = listOf()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): FlatPreviewViewHolder {
        val view = ItemSearchResultBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return FlatPreviewViewHolder(view, onItemClick, onStarClick)
    }

    override fun onBindViewHolder(holder: FlatPreviewViewHolder, position: Int) {
        holder.bind(list[position])
    }

    @SuppressLint("NotifyDataSetChanged")
    fun setItems(newList: List<FlatModel>) {
        list = newList
        notifyDataSetChanged()
    }

    override fun getItemCount() = list.size
}