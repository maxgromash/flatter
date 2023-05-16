package com.app.flatter.network

import models.*

interface AuthClient {
    suspend fun signIn(data: SignInRequest): SignInResponse

    suspend fun signUp(data: SignUpRequest): SignUpResponse

    suspend fun restorePassword(data: RestorePasswordRequest): RestorePasswordResponse

    suspend fun changePassword(data: ChangePasswordRequest): ChangePasswordResponse

    suspend fun changePhone(data: ChangePhoneRequest): ChangePhoneResponse

    suspend fun userInfo(data: GetUserInfoRequest): GetUserInfoResponse

    suspend fun refreshToken(data: RefreshTokenRequest): RefreshTokenResponse

    suspend fun logout(data: LogoutRequest): LogoutResponse
}