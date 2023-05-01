package com.app.flatter.android.ui.flats.projects.adapter

import androidx.recyclerview.widget.RecyclerView
import com.app.flatter.android.databinding.ItemBuildingBinding
import com.app.flatter.android.data.ProjectVO
import com.bumptech.glide.Glide

class BuildingsViewHolder(
    private val binding: ItemBuildingBinding,
    private val onItemClick: (ProjectVO) -> Unit
) : RecyclerView.ViewHolder(binding.root) {

    fun bind(vo: ProjectVO) {
        binding.rootCL.setOnClickListener { onItemClick.invoke(vo) }
        with(vo) {
            binding.addressMTV.text = address
            binding.priceMTV.text = pricesFrom
            binding.titleMTV.text = title

            Glide.with(binding.root.context)
                .load(vo.imageLink)
                .centerCrop()
                .into(binding.imageSIV)
        }
    }
}