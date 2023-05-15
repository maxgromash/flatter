package com.app.flatter.android.ui.flats.flatDetails.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.app.flatter.android.databinding.ItemFlatDetailsBinding

class FlatDetailsAdapter: RecyclerView.Adapter<FlatDetailsViewHolder>() {

    private var list: List<String> = listOf()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): FlatDetailsViewHolder {
        val view = ItemFlatDetailsBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return FlatDetailsViewHolder(view)
    }

    override fun onBindViewHolder(holder: FlatDetailsViewHolder, position: Int) {
        holder.bind(list[position])
    }

    @SuppressLint("NotifyDataSetChanged")
    fun setItems(newList: List<String>) {
        list = newList
        notifyDataSetChanged()
    }

    override fun getItemCount() = list.size
}