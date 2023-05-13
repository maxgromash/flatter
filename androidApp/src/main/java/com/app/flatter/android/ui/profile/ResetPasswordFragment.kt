package com.app.flatter.android.ui.profile

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import com.app.flatter.android.R
import com.app.flatter.android.databinding.FragmentResetPasswordBinding
import com.app.flatter.android.util.hideKeyboard
import com.app.flatter.android.viewModel.AuthViewModel


class ResetPasswordFragment : Fragment() {

    private lateinit var binding: FragmentResetPasswordBinding
    private lateinit var viewModel: AuthViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentResetPasswordBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel = ViewModelProvider(requireActivity())[AuthViewModel::class.java]

        binding.toolBarTB.setNavigationIcon(R.drawable.ic_round_arrow_back_24_white)
        binding.toolBarTB.subtitle = "Назад"
        binding.toolBarTB.setNavigationOnClickListener {
            findNavController().popBackStack()
        }

        binding.button.setOnClickListener {
            viewModel.restorePassword(binding.emailTIET.text.toString())
            hideKeyboard()
        }

        observeState()
    }

    private fun observeState() {

        viewModel.showMessageViewModel().observe(viewLifecycleOwner) { message ->
            Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
        }

        viewModel.progressViewModel().observe(viewLifecycleOwner) { isProgressVisible ->
            if (isProgressVisible) {
                binding.loadingProgressCPI.visibility = View.VISIBLE
                binding.button.text = ""
            } else {
                binding.loadingProgressCPI.visibility = View.GONE
                binding.button.text = "Восстановить"
            }

        }
    }
}