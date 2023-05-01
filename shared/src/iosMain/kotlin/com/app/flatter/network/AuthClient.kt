package com.app.flatter.network

import models.SignInRequest
import models.SignInResponse
import models.SignUpRequest
import models.SignUpResponse

actual class AuthClient {


/*    var callbackClientCalls: AuthCallbackClient? = null

   ("Not yet implemented")
    private suspend fun <In, Out> convertCallbackCallToSuspend(
        input: In,
        callbackClosure: ((In, ((Out?, Throwable?) -> Unit)) -> Unit),
    ): Out {
        return suspendCoroutine { continuation ->
            callbackClosure(input) { result, error ->
                when {
                    error != null -> {
                        continuation.resumeWith(Result.failure(error))
                    }
                    result != null -> {
                        continuation.resumeWith(Result.success(result))
                    }
                    else -> { //both values are null
                        continuation.resumeWith(Result.failure(IllegalStateException("Incorrect grpc call processing")))
                    }
                }
            }
        }
    }*/


    actual suspend fun signIn(data: SignInRequest): SignInResponse {
            /*return convertCallbackCallToSuspend(data, callbackClosure = { input, callback ->
            callbackClientCalls?.sendHello(input, callback)
        })*/
    }

    actual suspend fun signUp(data: SignUpRequest): SignUpResponse {
    }
}