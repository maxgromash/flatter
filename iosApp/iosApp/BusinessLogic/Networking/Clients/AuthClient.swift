import Foundation
import shared

final class AuthClientImpl: BaseClient {
    private lazy var client = Models_AuthServiceNIOClient(
        channel: channel,
        defaultCallOptions: callOptions
    )

    init() {
        super.init(name: "AuthClient")
    }
}

extension AuthClientImpl: AuthClient {
    func signIn(
        data: SignInRequest,
        completionHandler: @escaping (SignInResponse?, Error?) -> Void
    ) {
        let request = Models_SignInRequest(data)
        let call = client.signIn(request)
        do {
            let message = try call.response.wait()
            let (wireMessage, _) = message.toWireMessage(adapter: SignInResponse.Companion.shared.ADAPTER)
            completionHandler(wireMessage, nil)
        } catch {
            completionHandler(nil, error)
        }
    }

    func signUp(
        data: SignUpRequest,
        completionHandler: @escaping (SignUpResponse?, Error?) -> Void
    ) {
        let request = Models_SignUpRequest(data)
        let call = client.signUp(request)

        do {
            let message = try call.response.wait()
            let (wireMessage, _) = message.toWireMessage(adapter: SignUpResponse.Companion.shared.ADAPTER)
            completionHandler(wireMessage, nil)
        } catch {
            completionHandler(nil, error)
        }
    }

    func restorePassword(
        data: RestorePasswordRequest,
        completionHandler: @escaping (RestorePasswordResponse?, Error?) -> Void
    ) {
        let request = Models_RestorePasswordRequest(data)
        let call = client.restorePassword(request)

        do {
            let message = try call.response.wait()
            let (wireMessage, _) = message.toWireMessage(adapter: RestorePasswordResponse.Companion.shared.ADAPTER)
            completionHandler(wireMessage, nil)
        } catch {
            completionHandler(nil, error)
        }
    }

    func changePhone(data: ChangePhoneRequest, completionHandler: @escaping (ChangePhoneResponse?, Error?) -> Void) {
        let request = Models_ChangePhoneRequest(data)
        let call = client.changePhone(request)

        do {
            let message = try call.response.wait()

            let (wireMessage, _) = message.toWireMessage(adapter: ChangePhoneResponse.Companion.shared.ADAPTER)
            completionHandler(wireMessage, nil)
        } catch {
            completionHandler(nil, error)
        }
    }

    func changePassword(data: ChangePasswordRequest, completionHandler: @escaping (ChangePasswordResponse?, Error?) -> Void) {
        let request = Models_ChangePasswordRequest(data)
        let call = client.changePassword(request)

        do {
            let message = try call.response.wait()

            let (wireMessage, _) = message.toWireMessage(adapter: ChangePasswordResponse.Companion.shared.ADAPTER)
            completionHandler(wireMessage, nil)
        } catch {
            completionHandler(nil, error)
        }
    }
}

private extension Models_SignInRequest {
    init(_ data: SignInRequest) {
        var this = Models_SignInRequest()
        this.email = data.email
        this.password = data.password
        self = this
    }
}

private extension Models_SignUpRequest {
    init(_ data: SignUpRequest) {
        var this = Models_SignUpRequest()
        this.email = data.email
        this.phone = data.phone
        this.name = data.name
        this.password = data.password
        this.passwordConfirm = data.password
        self = this
    }
}

private extension Models_RestorePasswordRequest {
    init(_ data: RestorePasswordRequest) {
        var this = Models_RestorePasswordRequest()
        this.email = data.email
        self = this
    }
}

private extension Models_RestorePasswordResponse {
    init(_ data: RestorePasswordResponse) {
        var this = Models_RestorePasswordResponse()
        this.status = data.status
        self = this
    }
}

private extension Models_ChangePasswordRequest {
    init(_ data: ChangePasswordRequest) {
        var this = Models_ChangePasswordRequest()
        this.password = data.password
        this.passwordConfirm = data.passwordConfirm
        this.token = data.token
        self = this
    }
}

private extension Models_ChangePasswordResponse {
    init(_ data: ChangePasswordResponse) {
        var this = Models_ChangePasswordResponse()
        this.status = data.status
        self = this
    }
}

private extension Models_ChangePhoneRequest {
    init(_ data: ChangePhoneRequest) {
        var this = Models_ChangePhoneRequest()
        this.token = data.token
        this.phone = data.phone
        self = this
    }
}

private extension Models_ChangePhoneResponse {
    init(_ data: ChangePhoneResponse) {
        var this = Models_ChangePhoneResponse()
        this.status = data.status
        self = this
    }
}
