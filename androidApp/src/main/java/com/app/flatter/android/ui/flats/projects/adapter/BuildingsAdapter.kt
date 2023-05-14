package com.app.flatter.android.ui.flats.projects.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.app.flatter.android.databinding.ItemBuildingBinding
import com.app.flatter.businessModels.ProjectModel

class BuildingsAdapter(
    private val onItemClick: (ProjectModel) -> Unit
) : RecyclerView.Adapter<BuildingsViewHolder>() {

    private var list: List<ProjectModel> = listOf()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): BuildingsViewHolder {
        val view = ItemBuildingBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return BuildingsViewHolder(view, onItemClick)
    }

    override fun onBindViewHolder(holder: BuildingsViewHolder, position: Int) {
        holder.bind(list[position])
    }

    @SuppressLint("NotifyDataSetChanged")
    fun setItems(newList: List<ProjectModel>) {
        list = newList
        notifyDataSetChanged()
    }

    override fun getItemCount() = list.size
}