package com.app.flatter.android.ui.flats.projectDetails

import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import androidx.core.content.ContextCompat
import androidx.core.view.marginBottom
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import com.app.flatter.android.R
import com.app.flatter.android.databinding.FragmentProjectInfoBinding
import com.app.flatter.android.data.MetroStep
import com.app.flatter.android.util.toPx
import com.app.flatter.android.viewModel.MainViewModel
import com.bumptech.glide.Glide
import com.yandex.mapkit.Animation
import com.yandex.mapkit.MapKitFactory
import com.yandex.mapkit.geometry.Point
import com.yandex.mapkit.map.CameraPosition
import com.yandex.runtime.image.ImageProvider
import com.yandex.runtime.ui_view.ViewProvider

class ProjectInfoFragment : Fragment() {

    private lateinit var binding: FragmentProjectInfoBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentProjectInfoBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        with(binding) {

            //Toolbar
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
            val model = ViewModelProvider(requireActivity())[MainViewModel::class.java]
            val item = model.getProjectById(id!!)

            item?.let {
                binding.descriptionMTV.text = item.description
                binding.titleMTV.text = item.title
                item.metroSteps.forEach { binding.metro.addView(getMetroStepView(it)) }
                binding.addressMTV.text = item.address

                val placeMark = View(requireContext()).apply {
                    background =
                        ContextCompat.getDrawable(requireContext(), R.drawable.ic_baseline_place_24)
                }

                mapView.map.mapObjects.addPlacemark(
                    Point(item.cord.first, item.cord.second),
                    ViewProvider(placeMark)
                )
                mapView.map.move(
                    CameraPosition(Point(item.cord.first, item.cord.second), 13.0f, 0.0f, 0.0f),
                    Animation(Animation.Type.SMOOTH, 0f),
                    null
                )

                Glide.with(binding.root.context)
                    .load(item.imageLink)
                    .centerCrop()
                    .into(binding.imageAPIV)

            }

            clickZoneV.setOnClickListener {
                findNavController().navigate(R.id.action_projectInfoFragment_to_flatsSearchResult)
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

    private fun getMetroStepView(item: MetroStep) = MetroStepView(requireContext()).apply {
        layoutParams = LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT,
            LinearLayout.LayoutParams.WRAP_CONTENT
        ).apply {
            topMargin = 16.toPx()
        }
        bind(item)
    }
}