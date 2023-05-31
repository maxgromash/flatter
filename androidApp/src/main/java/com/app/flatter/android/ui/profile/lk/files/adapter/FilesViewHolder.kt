package com.app.flatter.android.ui.profile.lk.files.adapter

import android.net.Uri
import androidx.recyclerview.widget.RecyclerView
import com.app.flatter.android.databinding.ItemFilesBinding
import com.app.flatter.android.ui.profile.lk.files.FileVo

class FilesViewHolder(
    private val binding: ItemFilesBinding,
    private val onItemClick: (Uri) -> Unit,
    private val onFullItemClick: (Uri) -> Unit,
) : RecyclerView.ViewHolder(binding.root) {

    fun bind(vo: FileVo) {
        binding.documentName.text = vo.name
        binding.actionACIV.setOnClickListener { onItemClick.invoke(vo.uri) }
        //binding.root.setOnClickListener { onFullItemClick.invoke(vo.uri) }
    }
}