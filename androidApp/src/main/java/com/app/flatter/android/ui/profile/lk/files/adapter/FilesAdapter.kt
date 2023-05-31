package com.app.flatter.android.ui.profile.lk.files.adapter

import android.annotation.SuppressLint
import android.net.Uri
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.app.flatter.android.databinding.ItemFilesBinding
import com.app.flatter.android.ui.profile.lk.files.FileVo

class FilesAdapter(
    private val onItemClick: (Uri) -> Unit,
    private val onFullItemClick: (Uri) -> Unit,
) : RecyclerView.Adapter<FilesViewHolder>() {

    private var list: MutableList<FileVo> = mutableListOf()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): FilesViewHolder {
        val view = ItemFilesBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return FilesViewHolder(view, onItemClick, onFullItemClick)
    }

    override fun onBindViewHolder(holder: FilesViewHolder, position: Int) {
        holder.bind(list[position])
    }

    @SuppressLint("NotifyDataSetChanged")
    fun setItems(newList: MutableList<FileVo>) {
        list = newList
        notifyDataSetChanged()
    }

    @SuppressLint("NotifyDataSetChanged")
    fun addItem(uri: FileVo) {
        list.add(uri)
        notifyDataSetChanged()
    }

    override fun getItemCount() = list.size
}