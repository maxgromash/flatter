package com.app.flatter.presentation.auth

import com.app.flatter.dispatchers.ioDispatcher
import com.app.flatter.presentation.BaseStore
import com.app.flatter.security.EncryptedSettingsHolder
import com.app.flatter.security.SharedSettingsHelper
import com.app.flatter.network.AuthClient
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.*
import models.SignInRequest
import models.SignUpRequest
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

class AuthStore(private val client: AuthClient) : BaseStore<AuthState, AuthAction, AuthSideEffect>(), KoinComponent {

    override val stateFlow: MutableStateFlow<AuthState> = MutableStateFlow(AuthState.None)
    override val sideEffectsFlow: MutableSharedFlow<AuthSideEffect> = MutableSharedFlow()

    private val tokenStore = SharedSettingsHelper(EncryptedSettingsHolder().encryptedSettings)

    override suspend fun reduce(action: AuthAction, initialState: AuthState) {
        coroutineScope {
            when (action) {
                is AuthAction.SignIn -> processSignInAction(action)
                is AuthAction.SingUp -> processSingUpAction(action)
                is AuthAction.LogOut -> {
                    tokenStore.token = null
                    updateState { AuthState.None }
                }

                is AuthAction.CheckToken -> {
                    if (tokenStore.token != null) {
                        updateState { AuthState.Success }
                    }
                    else {
                        updateState { AuthState.None }
                    }
                }
            }
        }
    }

    private suspend fun processSignInAction(action: AuthAction.SignIn) {
        try {
            sideEffectsFlow.emit(AuthSideEffect.ShowProgress)
            val result =
                client.signIn(SignInRequest(email = action.email, password = action.password))
            tokenStore.token = result.token
            updateState { AuthState.Success }
        } catch (ex: Throwable) {
            sideEffectsFlow.emit(AuthSideEffect.ShowMessage("Ошибка! Проверьте подключение к сети."))
        }
    }

    private suspend fun processSingUpAction(action: AuthAction.SingUp) {
        try {
            sideEffectsFlow.emit(AuthSideEffect.ShowProgress)
            client.signUp(
                SignUpRequest(
                    name = action.name,
                    phone = action.phone,
                    email = action.email,
                    password = action.password,
                    passwordConfirm = action.passwordConfirm
                )
            )
            sideEffectsFlow.emit(AuthSideEffect.ShowMessage("Активируйте аккаунт по ссылке в письме"))
        } catch (ex: Throwable) {
            sideEffectsFlow.emit(AuthSideEffect.ShowMessage("Ошибка! Проверьте введённые данные и подключение к сети."))
        }
    }
}