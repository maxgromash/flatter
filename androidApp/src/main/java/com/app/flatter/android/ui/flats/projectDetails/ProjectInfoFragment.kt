package com.app.flatter.android.ui.flats.projectDetails

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
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
        binding = FragmentProjectInfoBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        with(binding) {

            toolBarTB.setSubtitleTextColor(
                ContextCompat.getColor(
                    requireContext(),
                    R.color.md_theme_light_onPrimary
                )
            )
            toolBarTB.setNavigationIcon(R.drawable.ic_round_arrow_back_24_white);
            toolBarTB.subtitle = "Назад"
            toolBarTB.setNavigationOnClickListener {
                findNavController().popBackStack()
            }

            val id = arguments?.getInt("id")
            viewModel = ViewModelProvider(requireActivity())[ProjectsViewModel::class.java]
            val item = viewModel.getProjectById(id!!)

            item?.let {
                binding.descriptionMTV.text = item.description
                binding.titleMTV.text = item.title


                item.nearestTransport.forEach { binding.metro.addView(getMetroStepView(it)) }
                binding.addressMTV.text = item.address.address

                val placeMark = View(requireContext()).apply {
                    background =
                        ContextCompat.getDrawable(requireContext(), R.drawable.ic_baseline_place_24)
                }

                val point = Point(item.address.coordinates.latitude, item.address.coordinates.longitude)
                mapView.map.mapObjects.addPlacemark(point, ViewProvider(placeMark))
                mapView.map.move(
                    CameraPosition(point, 13.0f, 0.0f, 0.0f),
                    Animation(Animation.Type.SMOOTH, 0f),
                    null
                )

                Glide.with(binding.root.context)
                    .load(item.imageURL)
                    .centerCrop()
                    .into(binding.imageAPIV)
            }

            clickZoneV.setOnClickListener {
                findNavController().navigate(R.id.action_projectInfoFragment_to_flatsSearchResult, bundleOf("id" to id))
            }
        }
    }


    override fun onStart() {
        super.onStart()
        MapKitFactory.getInstance().onStart();
        binding.mapView.onStart();
    }

    override fun onStop() {
        binding.mapView.onStop();
        MapKitFactory.getInstance().onStop();
        super.onStop()
    }

    private fun getMetroStepView(item: ProjectModel.NearestTransport) = MetroStepView(requireContext()).apply {
        layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT).apply {
            topMargin = 16.toPx()
        }
        bind(item)
    }
}