package com.app.flatter.presentation.auth

sealed interface AuthState {
    object None : AuthState
    object Success : AuthState
}

sealed interface AuthAction {

    data class SignIn(
        val email: String,
        val password: String
    ) : AuthAction

    data class SingUp(
        val phone: String,
        val email: String,
        val name: String,
        val password: String,
        val passwordConfirm: String
    ) : AuthAction

    data class RestorePassword(
        val email: String
    ) : AuthAction

    data class ChangePassword(
        val password: String,
        var passwordConfirm: String
    ) : AuthAction

    data class ChangePhone(
        val phone: String
    ) : AuthAction

    object LogOut: AuthAction

    object CheckToken : AuthAction
}

sealed interface AuthSideEffect{
    data class ShowMessage(val message: String) : AuthSideEffect
    object ShowProgress : AuthSideEffect
}