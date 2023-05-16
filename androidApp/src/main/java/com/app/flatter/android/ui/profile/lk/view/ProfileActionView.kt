package com.app.flatter.android.ui.profile.lk.view

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.core.content.ContextCompat
import com.app.flatter.android.R
import com.app.flatter.android.data.ProfileActionVO
import com.app.flatter.android.databinding.ViewProfileActionBinding
import com.app.flatter.android.util.toPx

class ProfileActionView(
    context: Context
) : ConstraintLayout(context) {

    private val binding = ViewProfileActionBinding.inflate(LayoutInflater.from(context), this)

    init {
        setPadding(0, 16.toPx(), 0, 0)
    }

    fun bind(item: ProfileActionVO, onClickAction: (() -> Unit)? = null) {
        binding.icon.setImageResource(item.icon)
        binding.title.text = item.title
        if (item.isArrowVisible) {
            binding.iconGo.visibility = View.VISIBLE
        } else {
            binding.iconGo.visibility = View.INVISIBLE
        }
        binding.root.background = ContextCompat.getDrawable(context, R.drawable.ripple_effect)
        binding.root.isClickable = true
        binding.root.isFocusable = true
        binding.root.setOnClickListener {
            onClickAction?.invoke()
        }
    }
}