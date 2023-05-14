package com.app.flatter.android.ui.flats.projects.adapter

import androidx.recyclerview.widget.RecyclerView
import com.app.flatter.android.databinding.ItemBuildingBinding
import com.app.flatter.businessModels.ProjectModel
import com.bumptech.glide.Glide

class BuildingsViewHolder(
    private val binding: ItemBuildingBinding,
    private val onItemClick: (ProjectModel) -> Unit
) : RecyclerView.ViewHolder(binding.root) {

    fun bind(vo: ProjectModel) {
        binding.rootCL.setOnClickListener { onItemClick.invoke(vo) }
        with(vo) {
            binding.addressMTV.text = vo.address.address
            binding.priceMTV.text = "от ${vo.minFlatPrice} млн. руб"
            binding.titleMTV.text = vo.title

            Glide.with(binding.root.context)
                .load(vo.imageURL)
                .centerCrop()
                .into(binding.imageSIV)
        }
    }
}