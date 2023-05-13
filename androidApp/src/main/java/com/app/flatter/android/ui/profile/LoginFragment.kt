package com.app.flatter.android.ui.profile

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.lifecycleScope
import androidx.lifecycle.repeatOnLifecycle
import androidx.navigation.NavController
import androidx.navigation.fragment.findNavController
import com.app.flatter.android.R
import com.app.flatter.android.databinding.FragmentLoginBinding
import com.app.flatter.android.util.hideKeyboard
import com.app.flatter.android.viewModel.AuthViewModel
import kotlinx.coroutines.launch
import org.koin.core.component.KoinComponent

class LoginFragment : Fragment(), KoinComponent {

    private lateinit var binding: FragmentLoginBinding
    private lateinit var viewModel: AuthViewModel

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        binding = FragmentLoginBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel = ViewModelProvider(requireActivity())[AuthViewModel::class.java]

        binding.signInMB.setOnClickListener {
            viewModel.signIn(binding.loginTIET.text.toString(), binding.passwordTIET.text.toString())
            hideKeyboard()
        }

        observeState()
        setNavigationListeners()
    }

    private fun observeState() {

        viewModel.showMessageViewModel().observe(viewLifecycleOwner) { message ->
            Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
        }

        viewModel.progressViewModel().observe(viewLifecycleOwner) { isProgressVisible ->
            if (isProgressVisible) {
                binding.loadingCPI.visibility = View.VISIBLE
                binding.signInMB.text = ""
            } else {
                binding.loadingCPI.visibility = View.GONE
                binding.signInMB.text = "Войти"
            }

        }
        viewModel.signInStateViewModel().observe(viewLifecycleOwner) { state ->
            when (state) {
                is AuthViewModel.AuthState.Success -> {
                    findNavControllerSafely(R.id.loginFragment)?.navigate(R.id.action_loginFragment_to_profileFragment)
                }

                else -> {}
            }
        }

        lifecycleScope.launch {
            repeatOnLifecycle(Lifecycle.State.STARTED) {
                viewModel.launchWhenStartedCollectFlow(lifecycleScope)
            }
        }
    }

    private fun setNavigationListeners() {
        binding.registrationLink.setOnClickListener { findNavController().navigate(R.id.action_loginFragment_to_registrationFragment) }
        binding.restPasswordLink.setOnClickListener { findNavController().navigate(R.id.action_loginFragment_to_resetPasswordFragment) }
    }

    private fun findNavControllerSafely(id: Int): NavController? {
        return if (findNavController().currentDestination?.id == id) {
            findNavController()
        } else {
            null
        }
    }
}