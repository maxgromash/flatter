package com.app.flatter.network

import models.SignInRequest
import models.SignInResponse
import models.SignUpRequest
import models.SignUpResponse

expect class AuthClient {

    suspend fun signIn(data: SignInRequest): SignInResponse

    suspend fun signUp(data: SignUpRequest): SignUpResponse
}