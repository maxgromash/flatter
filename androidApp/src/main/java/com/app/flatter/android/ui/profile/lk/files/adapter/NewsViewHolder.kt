package com.app.flatter.android.ui.profile.lk.files.adapter

import android.annotation.SuppressLint
import android.database.Cursor
import android.net.Uri
import android.provider.OpenableColumns
import androidx.recyclerview.widget.RecyclerView
import com.app.flatter.android.databinding.ItemFilesBinding

class FilesViewHolder(
    private val binding: ItemFilesBinding,
    private val onItemClick: (Uri) -> Unit
) : RecyclerView.ViewHolder(binding.root) {

    fun bind(vo: Uri) {
        val name = getNameFromURI(vo)
        binding.documentName.text = name
        binding.actionACIV.setOnClickListener { onItemClick.invoke(vo) }
    }

    @SuppressLint("Range")
    fun getNameFromURI(uri: Uri): String? {
        val c: Cursor? = binding.root.context.contentResolver.query(uri, null, null, null, null)
        c?.moveToFirst()
        return c?.getString(c.getColumnIndex(OpenableColumns.DISPLAY_NAME))
    }

}