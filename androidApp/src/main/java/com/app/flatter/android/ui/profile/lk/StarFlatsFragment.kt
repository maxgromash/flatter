package com.app.flatter.android.ui.profile.lk

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
import com.app.flatter.android.databinding.FragmentStarFlatsBinding
import com.app.flatter.android.ui.flats.flatSearchResult.adapter.FlatPreviewAdapter
import com.app.flatter.android.ui.flats.flatSearchResult.adapter.FlatPreviewDecoration
import com.app.flatter.android.viewModel.FavouriteFlatsViewModel
import kotlinx.coroutines.launch

class StarFlatsFragment : Fragment() {

    private lateinit var viewModel: FavouriteFlatsViewModel
    private lateinit var binding: FragmentStarFlatsBinding
    private val starredAdapter = FlatPreviewAdapter(
        onItemClick = {
            val bundle = bundleOf("id" to it.id)
            findNavController().navigate(R.id.action_starFlatsFragment_to_flatDetailsFragment, bundle)
        },
        onStarClick = { id, isStar -> viewModel.setStar(id, isStar) }
    )

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        viewModel = ViewModelProvider(requireActivity())[FavouriteFlatsViewModel::class.java]
        binding = FragmentStarFlatsBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupUI()
        observeState()
    }

    private fun setupUI() {
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
    }

    private fun observeState() {

        viewModel.starredFlatsLiveData().observe(viewLifecycleOwner) {
            starredAdapter.setItems(it)
            binding.noStars.isVisible = it.isEmpty()
        }


        viewModel.showMessageViewModel().observe(viewLifecycleOwner) { message ->
            Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
        }

        viewModel.progressViewModel().observe(viewLifecycleOwner) { isProgressVisible ->
            if (isProgressVisible) {
                binding.loadingCPI.visibility = View.VISIBLE
            } else {
                binding.loadingCPI.visibility = View.GONE
            }
        }

        lifecycleScope.launch {
            repeatOnLifecycle(Lifecycle.State.STARTED) {
                viewModel.launchWhenStartedCollectFlow(lifecycleScope)
            }
        }
    }
}