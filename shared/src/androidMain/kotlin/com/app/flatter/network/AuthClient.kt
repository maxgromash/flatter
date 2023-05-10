package com.app.flatter.network

import com.squareup.wire.GrpcClient
import models.*
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

class AuthClientImpl : KoinComponent, AuthClient {

    private val grpcClient: GrpcClient by inject()

    private val authClient = GrpcAuthServiceClient(grpcClient)

    override suspend fun signIn(data: SignInRequest): SignInResponse {
        return authClient.SignIn().execute(data)
    }

    override suspend fun signUp(data: SignUpRequest): SignUpResponse {
        return authClient.SignUp().execute(data)
    }

    override suspend fun restorePassword(data: RestorePasswordRequest): RestorePasswordResponse {
        return authClient.RestorePassword().execute(data)
    }
}