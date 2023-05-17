package com.app.flatter.android.ui.flats.flatSearchResult

import android.content.Intent
import android.graphics.drawable.Drawable
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.core.content.ContextCompat
import androidx.core.os.bundleOf
import androidx.core.view.isVisible
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.lifecycleScope
import androidx.lifecycle.repeatOnLifecycle
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.app.flatter.android.R
import com.app.flatter.android.databinding.FragmentFlatsSearchResultBinding
import com.app.flatter.android.ui.flats.flatSearchResult.adapter.FlatPreviewAdapter
import com.app.flatter.android.ui.flats.flatSearchResult.adapter.FlatPreviewDecoration
import com.app.flatter.android.viewModel.FlatsViewModel
import com.app.flatter.android.viewModel.FlatsViewModelFactory
import kotlinx.coroutines.launch

class FlatsSearchResult : Fragment() {

    private lateinit var viewModel: FlatsViewModel
    private lateinit var binding: FragmentFlatsSearchResultBinding
    private lateinit var defaultBg: Drawable
    private lateinit var selectedBg: Drawable
    private val adapterSearch = FlatPreviewAdapter(
        onItemClick = {
            val bundle = bundleOf("id" to it.id)
            findNavController().navigate(R.id.action_flatsSearchResult_to_flatDetailsFragment, bundle)
        },
        onStarClick = { id, isStar -> viewModel.setStar(id, isStar) }
    )

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        Intent.ACTION_GET_CONTENT
        binding = FragmentFlatsSearchResultBinding.inflate(inflater)
        val id = requireArguments().getInt("id")
        viewModel = ViewModelProvider(requireActivity(), FlatsViewModelFactory(id))[FlatsViewModel::class.java]
        defaultBg = ContextCompat.getDrawable(requireContext(), R.drawable.bg_rounded_20_white)!!
        selectedBg = ContextCompat.getDrawable(requireContext(), R.drawable.bg_rounded_20_primary)!!
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupUI()
        setupFilters()
        observeState()
    }

    override fun onDestroy() {
        super.onDestroy()
        viewModel.clearFilters()
    }

    private fun setupUI() {
        binding.searchResultRV.apply {
            adapter = adapterSearch
            layoutManager = LinearLayoutManager(context, LinearLayoutManager.VERTICAL, false)
            addItemDecoration(FlatPreviewDecoration())
        }

        binding.toolbar.subtitle = "Назад"
        binding.toolbar.setNavigationOnClickListener {
            findNavController().popBackStack()
        }
    }

    private fun setupFilters() {
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

        val filters = viewModel.getFilters()

        binding.squareFilter.bind(filters[0]) { min, max ->
            viewModel.setSquareFilter(min, max)
        }

        binding.floorFilter.bind(filters[1]) { min, max ->
            viewModel.setFloorFilter(min, max)
        }

        binding.priceFilter.bind(filters[2]) { min, max ->
            viewModel.setPriceFilter(min, max)
        }
    }

    private fun observeState() {

        viewModel.showMessageViewModel().observe(viewLifecycleOwner) { message ->
            Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
        }

        viewModel.progressViewModel().observe(viewLifecycleOwner) { isProgressVisible ->
            binding.loadingCPI.isVisible = isProgressVisible
            binding.searchResultRV.isVisible = isProgressVisible.not()
        }

        viewModel.flatsLiveData().observe(viewLifecycleOwner) { flats ->
            adapterSearch.setItems(flats)
        }

        lifecycleScope.launch {
            repeatOnLifecycle(Lifecycle.State.STARTED) {
                viewModel.launchWhenStartedCollectFlow(lifecycleScope)
            }
        }
    }
}