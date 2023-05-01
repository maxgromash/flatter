package com.app.flatter.network

import com.squareup.wire.GrpcClient
import models.GrpcAuthServiceClient
import models.SignInRequest
import models.SignInResponse
import models.SignUpRequest
import models.SignUpResponse
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

actual class AuthClient : KoinComponent {

    private val grpcClient: GrpcClient by inject()

    private val authClient = GrpcAuthServiceClient(grpcClient)

    actual suspend fun signIn(data: SignInRequest): SignInResponse {
        return authClient.SignIn().execute(data)
    }

    actual suspend fun signUp(data: SignUpRequest): SignUpResponse {
        return authClient.SignUp().execute(data)
    }
}