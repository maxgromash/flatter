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

