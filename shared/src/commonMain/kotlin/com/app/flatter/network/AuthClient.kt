package com.app.flatter.network

import models.SignInRequest
import models.SignInResponse
import models.SignUpRequest
import models.SignUpResponse

interface AuthClient {
    suspend fun signIn(data: SignInRequest): SignInResponse

    suspend fun signUp(data: SignUpRequest): SignUpResponse

    suspend fun restorePassword
}