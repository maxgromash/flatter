package com.app.flatter.android.ui.profile

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
import com.app.flatter.android.databinding.FragmentFlatsSearchResultBinding
import com.app.flatter.android.databinding.FragmentStarFlatsBinding
import com.app.flatter.android.ui.flats.flatSearchResult.adapter.FlatPreviewAdapter
import com.app.flatter.android.ui.flats.flatSearchResult.adapter.FlatPreviewDecoration
import com.app.flatter.android.viewModel.MainViewModel

class StarFlatsFragment : Fragment() {

    private lateinit var viewModel: MainViewModel
    private lateinit var binding: FragmentStarFlatsBinding
    private val starredAdapter = FlatPreviewAdapter(
        onItemClick = {
            val bundle = bundleOf("id" to it.id)
            findNavController().navigate(
                R.id.action_starFlatsFragment_to_flatDetailsFragment,
                bundle
            )
        },
        onStarClick = { viewModel.setStar(it) }
    )

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        viewModel = ViewModelProvider(requireActivity())[MainViewModel::class.java]
        binding = FragmentStarFlatsBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        binding.toolBarTB.setSubtitleTextColor(
            ContextCompat.getColor(
                requireContext(),
                R.color.md_theme_light_onPrimary
            )
        )
        binding.toolBarTB.subtitle = "Назад"
        binding.toolBarTB.setNavigationOnClickListener {
            findNavController().popBackStack()
        }

        binding.listRV.apply {
            adapter = starredAdapter
            layoutManager = LinearLayoutManager(requireContext(), LinearLayoutManager.VERTICAL, false)
            addItemDecoration(FlatPreviewDecoration())
        }

        viewModel.starredFlatsLiveData().observe(viewLifecycleOwner) {
            starredAdapter.setItems(it)
            binding.noStars.isVisible = it.isEmpty()
        }
    }
}