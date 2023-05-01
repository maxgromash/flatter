package com.app.flatter.services.network

import models.SignInRequest
import models.SignInResponse
import models.SignUpRequest
import models.SignUpResponse

interface AuthCallbackClient {
    fun sendHello(message: SignInRequest, callback: (SignInResponse?, Exception?) -> Unit)
}

