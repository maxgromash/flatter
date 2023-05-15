package com.app.flatter.android.ui.flats.projectDetails

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout.LayoutParams
import androidx.core.content.ContextCompat
import androidx.core.os.bundleOf
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import com.app.flatter.android.R
import com.app.flatter.android.databinding.FragmentProjectInfoBinding
import com.app.flatter.android.util.toPx
import com.app.flatter.android.viewModel.ProjectsViewModel
import com.app.flatter.businessModels.ProjectModel
import com.bumptech.glide.Glide
import com.yandex.mapkit.Animation
import com.yandex.mapkit.MapKitFactory
import com.yandex.mapkit.geometry.Point
import com.yandex.mapkit.map.CameraPosition
import com.yandex.runtime.ui_view.ViewProvider

class ProjectInfoFragment : Fragment() {

    private lateinit var binding: FragmentProjectInfoBinding
    private lateinit var viewModel: ProjectsViewModel

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        viewModel = ViewModelProvider(requireActivity())[ProjectsViewModel::class.java]
        binding = FragmentProjectInfoBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        setupUI()
    }

    private fun setupUI() {
        with(binding.toolBarTB) {
            setSubtitleTextColor(ContextCompat.getColor(requireContext(), R.color.md_theme_light_onPrimary))
            setNavigationIcon(R.drawable.ic_round_arrow_back_24_white)
            subtitle = "Назад"
            setNavigationOnClickListener { findNavController().popBackStack() }
        }

        val id = arguments?.getInt("id")
        val item = viewModel.getProjectById(id!!)

        binding.descriptionMTV.text = item.description
        binding.titleMTV.text = item.title


        item.nearestTransport.forEach { binding.metro.addView(getMetroStepView(it)) }
        binding.addressMTV.text = item.address.address

        Glide.with(binding.root.context)
            .load(item.imageURL)
            .centerCrop()
            .into(binding.imageAPIV)

        binding.clickZoneV.setOnClickListener {
            findNavController().navigate(R.id.action_projectInfoFragment_to_flatsSearchResult, bundleOf("id" to id))
        }

        setupMap(item.address.coordinates)
    }

    private fun setupMap(cord: ProjectModel.Address.Coordinates) {
        val placeMark = View(requireContext()).apply {
            background = ContextCompat.getDrawable(requireContext(), R.drawable.ic_baseline_place_24)
        }

        val point = Point(cord.latitude, cord.longitude)
        binding.mapView.map.mapObjects.addPlacemark(point, ViewProvider(placeMark))
        binding.mapView.map.move(
            CameraPosition(point, 13.0f, 0.0f, 0.0f),
            Animation(Animation.Type.SMOOTH, 0f),
            null
        )
    }

    override fun onStart() {
        super.onStart()
        MapKitFactory.getInstance().onStart()
        binding.mapView.onStart()
    }

    override fun onStop() {
        binding.mapView.onStop()
        MapKitFactory.getInstance().onStop()
        super.onStop()
    }

    private fun getMetroStepView(item: ProjectModel.NearestTransport) = MetroStepView(requireContext()).apply {
        layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT).apply {
            topMargin = 16.toPx()
        }
        bind(item)
    }
}