package com.app.flatter.android.ui.flats.flatSearchResult.view

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.widget.SeekBar
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.core.content.ContextCompat
import androidx.core.view.setPadding
import com.app.flatter.android.R
import com.app.flatter.android.data.RangeFilterVO
import com.app.flatter.android.databinding.ViewSquareFilterBinding
import com.app.flatter.android.util.formatBySpace
import com.app.flatter.android.util.toPx

class RangeFilterView @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0,
) : ConstraintLayout(context, attrs, defStyleAttr) {

    private val binding = ViewSquareFilterBinding.inflate(LayoutInflater.from(context), this)
    private var cachedMinValue = 0
    private var cachedMaxValue = Int.MAX_VALUE
    private var isBinded = false

    init {
        background = ContextCompat.getDrawable(context, R.drawable.bg_rounded_20_white)
        setPadding(16.toPx())
    }

    fun bind(item: RangeFilterVO, callBack: (Int, Int) -> Unit) {
        if (isBinded) return
        isBinded = true
        binding.title.text = item.titleStart
        binding.title2.text = item.titleEnd
        binding.start.text = item.minValue.formatBySpace()
        binding.start2.text = item.minValue.formatBySpace()
        binding.end.text = item.maxValue.formatBySpace()
        binding.end2.text = item.maxValue.formatBySpace()

        if (item.maxValue != binding.seekBar.max) {
            binding.seekBar.max = item.maxValue
            binding.seekBar2.max = item.maxValue
        }

        if (item.minValue != binding.seekBar.min) {
            binding.seekBar.min = item.minValue
            binding.seekBar2.min = item.minValue
        }

        if (cachedMinValue < item.minValue) {
            cachedMinValue = item.minValue
            binding.seekBar.progress = item.minValue
        } else {
            binding.seekBar.progress = cachedMinValue
        }
        if (cachedMaxValue > item.maxValue) {
            cachedMaxValue = item.maxValue
            binding.seekBar2.progress = item.maxValue
        } else {
            binding.seekBar2.progress = cachedMaxValue
        }

        binding.squire.text = "${cachedMinValue.formatBySpace()} ${item.appendValue}"
        binding.squire2.text = "${cachedMaxValue.formatBySpace()} ${item.appendValue}"

        binding.seekBar.setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
            override fun onProgressChanged(seekBar: SeekBar?, progress: Int, fromUser: Boolean) {
                if (fromUser) {
                    val x = progress
                    cachedMinValue = progress
                    binding.squire.text = "${cachedMinValue.formatBySpace()} ${item.appendValue}"
                    callBack.invoke(cachedMinValue, cachedMaxValue)
                }
            }

            override fun onStartTrackingTouch(seekBar: SeekBar?) {}

            override fun onStopTrackingTouch(seekBar: SeekBar?) {}

        })

        binding.seekBar2.setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
            override fun onProgressChanged(seekBar: SeekBar?, progress: Int, fromUser: Boolean) {
                if (fromUser) {
                    cachedMaxValue = progress
                    binding.squire2.text = "${cachedMaxValue.formatBySpace()} ${item.appendValue}"
                    callBack.invoke(cachedMinValue, cachedMaxValue)
                }
            }

            override fun onStartTrackingTouch(seekBar: SeekBar?) {}

            override fun onStopTrackingTouch(seekBar: SeekBar?) {}
        })
    }
}