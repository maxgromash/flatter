package com.app.flatter.android.ui.flats.flatSearchResult

import android.graphics.drawable.Drawable
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.core.os.bundleOf
import androidx.core.view.isVisible
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.app.flatter.android.R
import com.app.flatter.android.data.RangeFilterVO
import com.app.flatter.android.databinding.FragmentFlatsSearchResultBinding
import com.app.flatter.android.ui.flats.flatSearchResult.adapter.FlatPreviewAdapter
import com.app.flatter.android.ui.flats.flatSearchResult.adapter.FlatPreviewDecoration
import com.app.flatter.android.viewModel.MainViewModel

class FlatsSearchResult : Fragment() {

    private lateinit var viewModel: MainViewModel
    private lateinit var binding: FragmentFlatsSearchResultBinding
    private lateinit var defaultBg: Drawable
    private lateinit var selectedBg: Drawable
    private val adapterSearch = FlatPreviewAdapter(
        onItemClick = {
            val bundle = bundleOf("id" to it.id)
            findNavController().navigate(
                R.id.action_flatsSearchResult_to_flatDetailsFragment,
                bundle
            )
        },
        onStarClick = { viewModel.setStar(it) }
    )

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentFlatsSearchResultBinding.inflate(inflater)
        viewModel = ViewModelProvider(requireActivity())[MainViewModel::class.java]
        defaultBg = ContextCompat.getDrawable(requireContext(), R.drawable.bg_rounded_20_white)!!
        selectedBg = ContextCompat.getDrawable(requireContext(), R.drawable.bg_rounded_20_primary)!!
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding.searchResultRV.apply {
            adapter = adapterSearch
            layoutManager = LinearLayoutManager(context, LinearLayoutManager.VERTICAL, false)
            addItemDecoration(FlatPreviewDecoration())
        }

        binding.toolbar.subtitle = "Назад"
        binding.toolbar.setNavigationOnClickListener {
            findNavController().popBackStack()
        }

        binding.squareFilterTitle.setOnClickListener {
            val bg = if (binding.squareFilter.isVisible) defaultBg else selectedBg
            it.background = bg
            binding.floorFilterTitle.background = defaultBg
            binding.priceFilterTitle.background = defaultBg
            binding.squareFilter.isVisible = !binding.squareFilter.isVisible
            binding.floorFilter.isVisible = false
            binding.priceFilter.isVisible = false
        }

        binding.floorFilterTitle.setOnClickListener {
            val bg = if (binding.floorFilter.isVisible) defaultBg else selectedBg
            it.background = bg
            binding.squareFilterTitle.background = defaultBg
            binding.priceFilterTitle.background = defaultBg
            binding.floorFilter.isVisible = !binding.floorFilter.isVisible
            binding.squareFilter.isVisible = false
            binding.priceFilter.isVisible = false
        }

        binding.priceFilterTitle.setOnClickListener {
            val bg = if (binding.priceFilter.isVisible) defaultBg else selectedBg
            it.background = bg
            binding.squareFilterTitle.background = defaultBg
            binding.floorFilterTitle.background = defaultBg
            binding.priceFilter.isVisible = !binding.priceFilter.isVisible
            binding.squareFilter.isVisible = false
            binding.floorFilter.isVisible = false
        }

        binding.squareFilter.bind(getFilters()[0]) { min, max ->
            viewModel.setSquareFilter(min, max)
        }

        binding.floorFilter.bind(getFilters()[1]) { min, max ->
            viewModel.setFloorFilter(min, max)
        }

        binding.priceFilter.bind(getFilters()[2]) { min, max ->
            viewModel.setPriceFilter(min, max)
        }

        viewModel.flatsLiveData().observe(viewLifecycleOwner) {
            adapterSearch.setItems(it)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        viewModel.clearFilters()
    }

    private fun getFilters() = listOf(
        RangeFilterVO(
            "Минимальная площадь",
            "Максимальная площадь",
            "м2",
            10,
            150,
            RangeFilterVO.FilterType.SQUARE
        ),
        RangeFilterVO(
            "Минимальный этаж",
            "Максимальный этаж",
            "этаж",
            1,
            30,
            RangeFilterVO.FilterType.FLOOR
        ),
        RangeFilterVO(
            "Минимальная стоимость",
            "Максимальная стоимость",
            "₽",
            13_878_677,
            29_442_263,
            RangeFilterVO.FilterType.PRICE
        )
    )
}