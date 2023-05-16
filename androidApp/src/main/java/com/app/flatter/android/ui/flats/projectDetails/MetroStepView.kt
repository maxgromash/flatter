package com.app.flatter.android.ui.flats.projectDetails

import android.content.Context
import android.graphics.drawable.GradientDrawable
import android.util.AttributeSet
import android.view.LayoutInflater
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.core.content.ContextCompat
import com.app.flatter.android.R
import com.app.flatter.android.databinding.ViewMetroStepBinding
import com.app.flatter.businessModels.ProjectModel

class MetroStepView(context: Context, attr: AttributeSet? = null) : ConstraintLayout(context, attr) {

    private val binding = ViewMetroStepBinding.inflate(LayoutInflater.from(context), this)

    fun bind(item: ProjectModel.NearestTransport) {
        //TODO починить цвет
        binding.metroColorACIV.background = getMetroBackground(R.color.green)
        binding.titleMTV.text = item.name
        binding.timeMTV.text = item.time.toString() + " мин"
    }

    private fun getMetroBackground(colorX: Int): GradientDrawable = GradientDrawable().apply {
        shape = GradientDrawable.OVAL
        color = ContextCompat.getColorStateList(context, colorX)
    }
}