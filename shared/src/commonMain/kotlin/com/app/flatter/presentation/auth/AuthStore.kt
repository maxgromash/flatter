package com.app.flatter.presentation.auth

import com.app.flatter.businessModels.UserModel
import com.app.flatter.mapper.UserMapper
import com.app.flatter.presentation.BaseStore
import com.app.flatter.security.EncryptedSettingsHolder
import com.app.flatter.security.SharedSettingsHelper
import com.app.flatter.network.AuthClient
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.*
import models.*
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

class AuthStore : BaseStore<AuthState, AuthAction, AuthSideEffect>(), KoinComponent {

    override val stateFlow: MutableStateFlow<AuthState> = MutableStateFlow(AuthState.None)
    override val sideEffectsFlow: MutableSharedFlow<AuthSideEffect> = MutableSharedFlow()

    private val client: AuthClient by inject()
    private val tokenStore = SharedSettingsHelper(EncryptedSettingsHolder().encryptedSettings)

    private val userMapper: UserMapper by inject()

    override suspend fun reduce(action: AuthAction, initialState: AuthState) {
        coroutineScope {
            when (action) {
                is AuthAction.SignIn -> processSignInAction(action)
                is AuthAction.SingUp -> processSingUpAction(action)
                is AuthAction.LogOut -> processLogOutAction()
                is AuthAction.ChangePhone -> processChangePhone(action)
                is AuthAction.ChangePassword -> processChangePassword(action)
                is AuthAction.CheckToken -> processCheckTokenAction()
                is AuthAction.RestorePassword -> processRestorePasswordAction(action)
            }
        }
    }

    private suspend fun processCheckTokenAction() {
        tokenStore.token?.let { token ->
            sendEffect { AuthSideEffect.ShowProgress }
            runCatching { processUserInfoSync(token) }
                .onSuccess { user ->
                    updateState { AuthState.Authorized(model = user) }
                }
                .onFailure {
                    sendEffect {
                        AuthSideEffect.ShowMessage(
                            "Не удалось получить информацию о пользователе! Проверьте введенные данные и попробуйте снова"
                        )
                    }
                }
        } ?: run {
            updateState { AuthState.None }
        }
    }

    private suspend fun processLogOutAction() {
        tokenStore.token = null
        updateState { AuthState.None }
    }

    private suspend fun processSignInAction(action: AuthAction.SignIn) {
        try {
            sendEffect { AuthSideEffect.ShowProgress }
            val result = client.signIn(SignInRequest(email = action.email, password = action.password))
            tokenStore.token = result.token
            val user = processUserInfoSync(token = result.token)
            updateState { AuthState.Authorized(model = user) }
        } catch (ex: Throwable) {
            sendEffect { AuthSideEffect.ShowMessage("Ошибка! Проверьте введённые данные и подключение к сети.") }
        }
    }

    private suspend fun processSingUpAction(action: AuthAction.SingUp) {
        try {
            sendEffect { AuthSideEffect.ShowProgress }
            client.signUp(
                SignUpRequest(
                    name = action.name,
                    phone = action.phone,
                    email = action.email,
                    password = action.password,
                    passwordConfirm = action.passwordConfirm
                )
            )
            sendEffect { AuthSideEffect.ShowMessage("Активируйте аккаунт по ссылке в письме") }
        } catch (ex: Throwable) {
            sendEffect { AuthSideEffect.ShowMessage("Ошибка! Проверьте введённые данные и подключение к сети.") }
        }
    }

    private suspend fun processChangePhone(action: AuthAction.ChangePhone) {
        tokenStore.token?.let { token ->
            sendEffect { AuthSideEffect.ShowProgress }
            runCatching {
                client.changePhone(
                    ChangePhoneRequest(token = token, phone = action.phone)
                )
            }
                .onSuccess {
                    when (val currentState = stateFlow.value) {
                        is AuthState.Authorized -> updateStateWithNewPhone(currentState = currentState, newPhone = action.phone)
                        is AuthState.None -> processLogOutAction()
                    }
                    sendEffect { AuthSideEffect.ShowMessage("Номер телефона успешно обновлен") }
                }
                .onFailure {
                    sendEffect { AuthSideEffect.ShowMessage("Ошибка! Не удалось обновить номер телефона") }
                }
        } ?: run {
            updateState { AuthState.None }
        }
    }

    private suspend fun processChangePassword(action: AuthAction.ChangePassword) {
        tokenStore.token?.let { token ->
            sendEffect { AuthSideEffect.ShowProgress }
            runCatching {
                client.changePassword(
                    ChangePasswordRequest(
                        token = token,
                        password = action.password,
                        passwordConfirm = action.passwordConfirm
                    )
                )
            }
                .onSuccess {
                    sendEffect { AuthSideEffect.ShowMessage("Пароль успешно обновлен") }
                }
                .onFailure {
                    sendEffect { AuthSideEffect.ShowMessage("Ошибка! Не удалось обновить пароль") }
                }
        } ?: run {
            updateState { AuthState.None }
        }
    }

    private suspend fun processRestorePasswordAction(action: AuthAction.RestorePassword) {
        try {
            sendEffect { AuthSideEffect.ShowProgress }
            client.restorePassword(RestorePasswordRequest(email = action.email))
            sendEffect { AuthSideEffect.ShowMessage("Письмо с восстановлением пароля отправлено на почту") }
        } catch (ex: Throwable) {
            sendEffect { AuthSideEffect.ShowMessage("Ошибка! Проверьте введённые данные и подключение к сети.") }
        }
    }

    private suspend fun processUserInfoSync(token: String): UserModel {
        val response = client.userInfo(GetUserInfoRequest(token = token))
        return userMapper.invoke(response)
    }

    private suspend fun updateStateWithNewPhone(currentState: AuthState.Authorized, newPhone: String) {
        val user = UserModel(
            name = currentState.model.name,
            phoneNumber = newPhone,
            email = currentState.model.email
        )
        updateState { AuthState.Authorized(model = user) }
    }
}