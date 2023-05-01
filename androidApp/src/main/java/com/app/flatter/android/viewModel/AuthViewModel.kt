package com.app.flatter.android.viewModel

import androidx.lifecycle.LifecycleCoroutineScope
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.app.flatter.android.util.SingleLiveEvent
import com.app.flatter.presentation.auth.AuthAction
import com.app.flatter.presentation.auth.AuthSideEffect
import com.app.flatter.presentation.auth.AuthStore
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch

class AuthViewModel : ViewModel() {

    private val store = AuthStore()
    private val signInStateViewModel = MutableLiveData<AuthState>()
    private val progressViewModel = SingleLiveEvent<Boolean>()
    private val showMessageViewModel = SingleLiveEvent<String>()

    init {
        observeState()
        checkToken()
    }

    fun signInStateViewModel(): LiveData<AuthState> = signInStateViewModel
    fun progressViewModel(): LiveData<Boolean> = progressViewModel
    fun showMessageViewModel(): LiveData<String> = showMessageViewModel

    fun signUp(phone: String, email: String, name: String, password: String, passwordConfirm: String) {
        store.reduce(
            AuthAction.SingUp(
                phone = phone.trim(),
                email = email.trim(),
                name = name.trim(),
                password = password.trim(),
                passwordConfirm = passwordConfirm.trim()
            )
        )
    }

    fun logOut() {
        store.reduce(AuthAction.LogOut)
    }

    fun signIn(login: String, password: String) {
        store.reduce(AuthAction.SignIn(login.trim(), password.trim()))
    }

    fun checkToken() {
        store.reduce(AuthAction.CheckToken)
    }

    fun launchWhenStartedCollectFlow(lifeCycleScope: LifecycleCoroutineScope) {
        lifeCycleScope.launchWhenStarted {
            store.observeState().collectLatest { state ->
                when (state) {
                    is com.app.flatter.presentation.auth.AuthState.Success -> {
                        progressViewModel.value = false
                        signInStateViewModel.value = AuthState.Success
                    }

                    is com.app.flatter.presentation.auth.AuthState.None -> {
                        progressViewModel.value = false
                        signInStateViewModel.value = AuthState.None
                    }
                }
            }
        }
    }

    private fun observeState() {
        viewModelScope.launch {

            store.observeSideEffects().collect { effect ->
                when (effect) {
                    is AuthSideEffect.ShowMessage -> {
                        progressViewModel.value = false
                        showMessageViewModel.value = effect.message
                    }

                    is AuthSideEffect.ShowProgress -> {
                        progressViewModel.value = true
                    }
                }
            }
        }
    }


    sealed interface AuthState {
        object Success : AuthState
        object None : AuthState
    }
}