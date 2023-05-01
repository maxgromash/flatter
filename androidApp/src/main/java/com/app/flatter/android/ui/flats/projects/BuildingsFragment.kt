package com.app.flatter.android.ui.flats.projects

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.Navigation
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.app.flatter.android.R
import com.app.flatter.android.databinding.FragmentBuildingsBinding
import com.app.flatter.android.data.ProjectVO
import com.app.flatter.android.ui.flats.projects.adapter.BuildingsAdapter
import com.app.flatter.android.ui.flats.projects.adapter.BuildingsDecoration
import com.app.flatter.android.viewModel.MainViewModel

internal class BuildingsFragment : Fragment() {

    private lateinit var binding: FragmentBuildingsBinding
    private val buildingAdapter = BuildingsAdapter {
        val bundle = bundleOf("id" to it.id)
        //Navigation.createNavigateOnClickListener(R.id.action_buildingsFragment_to_projectInfoFragment, bundle)
        findNavController().navigate(R.id.action_buildingsFragment_to_projectInfoFragment, bundle)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentBuildingsBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        with(binding.list) {
            binding.list.adapter = buildingAdapter
            layoutManager = LinearLayoutManager(context, LinearLayoutManager.VERTICAL, false)
            addItemDecoration(BuildingsDecoration())
        }

        val model = ViewModelProvider(requireActivity())[MainViewModel::class.java]

        model.projectsLiveData().observe(viewLifecycleOwner) {
            buildingAdapter.setItems(it)
        }
    }
}