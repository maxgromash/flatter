package com.app.flatter.android.ui.profile.lk

import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import com.app.flatter.android.R
import com.app.flatter.android.data.ProfileActionVO
import com.app.flatter.android.databinding.FragmentProfileBinding
import com.app.flatter.android.util.toPx
import com.app.flatter.android.viewModel.AuthViewModel
import com.google.android.material.textview.MaterialTextView

class ProfileFragment : Fragment() {

    private lateinit var viewModel: AuthViewModel
    private lateinit var binding: FragmentProfileBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        viewModel = ViewModelProvider(requireActivity())[AuthViewModel::class.java]
        binding = FragmentProfileBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val actions = getActions()
        actions.forEach {
            binding.actionList.addView(getNewActionView(it))
        }
        binding.actionList.addView(createLogOutTextView())
    }

    private fun getNewActionView(item: ProfileActionVO) =
        ProfileActionView(requireContext()).apply {
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            )

            bind(item, item.onClickCallback)
        }

    private fun createLogOutTextView() = MaterialTextView(requireContext()).apply {
        layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.WRAP_CONTENT).apply {
            gravity = Gravity.CENTER_HORIZONTAL
            topMargin = 16.toPx()
        }
        setTextColor(ContextCompat.getColor(context, R.color.md_theme_light_primary))
        textSize = 8.toPx().toFloat()
        text = "Выйти"
        isFocusable = true
        isClickable = true
        setPadding(16.toPx(), 4.toPx(), 16.toPx(), 4.toPx())
        background = ContextCompat.getDrawable(context, R.drawable.ripple_effect_no_bg)
        setOnClickListener {
            viewModel.logOut()
            findNavController().navigate(R.id.action_profileFragment_to_loginFragment)
        }
    }

    private fun getActions() = listOf(
        ProfileActionVO(
            R.drawable.ic_baseline_star_border_24,
            "Избранное",
            true
        ) {
            findNavController().navigate(R.id.action_profileFragment_to_starFlatsFragment)
        },
        /*ProfileActionVO(
            R.drawable.ic_baseline_insert_drive_file_24,
            "Мои документы",
            true
        ),*/
        ProfileActionVO(
            R.drawable.ic_baseline_mode_edit_outline_24,
            "Изменить данные",
            true
        ) {
            findNavController().navigate(R.id.action_profileFragment_to_changePersonalDataFragment)
        },
        ProfileActionVO(
            R.drawable.ic_outline_phone_24,
            "Связаться с менеджером",
            false,
            onClickCallback = {
                if (ContextCompat.checkSelfPermission(
                        requireContext(),
                        android.Manifest.permission.CALL_PHONE
                    ) != PackageManager.PERMISSION_GRANTED
                ) {
                    ActivityCompat.requestPermissions(
                        requireActivity(),
                        arrayOf(android.Manifest.permission.CALL_PHONE),
                        123
                    )
                } else {
                    val intent = Intent(Intent.ACTION_CALL, Uri.parse("tel:" + "89227045875"))
                    startActivity(intent)
                }
            }
        )
    )
}