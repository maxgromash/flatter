package com.app.flatter.android.ui.flats.projects

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.core.os.bundleOf
import androidx.core.view.isVisible
import androidx.fragment.app.Fragment
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.lifecycleScope
import androidx.lifecycle.repeatOnLifecycle
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.app.flatter.android.R
import com.app.flatter.android.databinding.FragmentBuildingsBinding
import com.app.flatter.android.ui.flats.projects.adapter.BuildingsAdapter
import com.app.flatter.android.ui.flats.projects.adapter.BuildingsDecoration
import com.app.flatter.android.viewModel.ProjectsViewModel
import kotlinx.coroutines.launch

internal class BuildingsFragment : Fragment() {

    private lateinit var viewModel: ProjectsViewModel
    private lateinit var binding: FragmentBuildingsBinding
    private val buildingAdapter = BuildingsAdapter {
        val bundle = bundleOf("id" to it.id)
        findNavController().navigate(R.id.action_buildingsFragment_to_projectInfoFragment, bundle)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        binding = FragmentBuildingsBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel = ViewModelProvider(requireActivity(), )[ProjectsViewModel::class.java]

        with(binding.list) {
            binding.list.adapter = buildingAdapter
            layoutManager = LinearLayoutManager(context, LinearLayoutManager.VERTICAL, false)
            addItemDecoration(BuildingsDecoration())
        }

        observeState()
    }


    private fun observeState() {

        viewModel.showMessageViewModel().observe(viewLifecycleOwner) { message ->
            Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
        }

        viewModel.progressViewModel().observe(viewLifecycleOwner) { isProgressVisible ->
            binding.loadingCPI.isVisible = isProgressVisible
            binding.list.isVisible = isProgressVisible.not()
        }

        viewModel.projectsLiveData().observe(viewLifecycleOwner) { news ->
            buildingAdapter.setItems(news)
        }

        lifecycleScope.launch {
            repeatOnLifecycle(Lifecycle.State.STARTED) {
                viewModel.launchWhenStartedCollectFlow(lifecycleScope)
            }
        }
    }
}