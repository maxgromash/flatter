package com.app.flatter.android.ui.flats.flatDetails.view

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.widget.SeekBar
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.core.content.ContextCompat
import androidx.core.view.setPadding
import com.app.flatter.android.R
import com.app.flatter.android.databinding.ViewMortgageCalcViewBinding
import com.app.flatter.android.util.formatBySpace
import com.app.flatter.android.util.toPx
import kotlin.math.pow
import kotlin.properties.Delegates

private const val RUB_SIGN = "₽"

class MortgageCalcView(
    context: Context,
    attributeSet: AttributeSet? = null
) : ConstraintLayout(context, attributeSet) {

    private val binding = ViewMortgageCalcViewBinding.inflate(LayoutInflater.from(context), this)
    private var annualInterest = 3.0
    private var numberOfPayments = 12
    private var principal by Delegates.notNull<Int>()
    private var flatPrice by Delegates.notNull<Int>()

    init {
        setPadding(16.toPx())
        background = ContextCompat.getDrawable(context, R.drawable.bg_rounded_20_white)
        setStartValues()
        setListeners()
    }

    fun bind(flatPrice: Int) {
        binding.contributionSeekBar.max = flatPrice
        binding.contributionSeekBar.min = (flatPrice * 0.15).toInt()
        binding.contributionSeekBar.progress = (flatPrice * 0.15).toInt()
        binding.contributionMin.text = (flatPrice * 0.15).toInt().formatBySpace()
        binding.contributionMax.text = flatPrice.formatBySpace()
        binding.contributionValue.text = (flatPrice * 0.15).toInt().formatBySpace() + " $RUB_SIGN"

        this.flatPrice = flatPrice
        principal = flatPrice - binding.contributionSeekBar.progress

        calculate()
    }

    private fun setStartValues() {
        binding.termSeekBar.min = 1
        binding.termSeekBar.max = 30
        binding.termSeekBar.progress = 1

        binding.rateSeekBar.min = 30
        binding.rateSeekBar.max = 200
        binding.rateSeekBar.progress = 30
    }

    private fun setListeners() {
        binding.termSeekBar.setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
            override fun onProgressChanged(seekBar: SeekBar?, progress: Int, fromUser: Boolean) {
                if (fromUser) {
                    numberOfPayments = progress * 12
                    binding.termValue.text = "$progress ${agePostfix(progress)}"
                    calculate()
                }
            }

            override fun onStartTrackingTouch(seekBar: SeekBar?) {}
            override fun onStopTrackingTouch(seekBar: SeekBar?) {}
        })


        binding.contributionSeekBar.setOnSeekBarChangeListener(object :
            SeekBar.OnSeekBarChangeListener {
            override fun onProgressChanged(seekBar: SeekBar?, progress: Int, fromUser: Boolean) {
                if (fromUser) {
                    binding.contributionValue.text = "${progress.formatBySpace()} $RUB_SIGN"
                    principal = flatPrice - progress
                    calculate()
                }
            }

            override fun onStartTrackingTouch(seekBar: SeekBar?) {}
            override fun onStopTrackingTouch(seekBar: SeekBar?) {}
        })

        binding.rateSeekBar.setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
            override fun onProgressChanged(seekBar: SeekBar?, progress: Int, fromUser: Boolean) {
                if (fromUser) {
                    val value = progress / 10.0
                    binding.rateValue.text = "$value %"
                    annualInterest = value
                    calculate()
                }
            }

            override fun onStartTrackingTouch(seekBar: SeekBar?) {}
            override fun onStopTrackingTouch(seekBar: SeekBar?) {}
        })
    }

    private fun agePostfix(term: Int): String {
        var old = ""
        val isExclusion = term % 100 in 11..14
        val ageLastNumber = term % 10

        old = if (ageLastNumber == 1) "год"
        else if (ageLastNumber == 0 || ageLastNumber in 5..9) "лет"
        else "года"
        if (isExclusion) old = "лет"

        return old
    }

    private fun calculate() {
        val monthlyInterest = annualInterest / 100 / 12
        val mathPower = (1 + monthlyInterest).pow(numberOfPayments.toDouble())
        val monthlyPayment = (principal * (monthlyInterest * mathPower / (mathPower - 1))).toInt()
        binding.totalValue.text = "${monthlyPayment.formatBySpace()} $RUB_SIGN"
    }
}