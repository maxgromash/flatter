//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: auth.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `Models_AuthServiceClient`, then call methods of this protocol to make API calls.
internal protocol Models_AuthServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Models_AuthServiceClientInterceptorFactoryProtocol? { get }

  func signUp(
    _ request: Models_SignUpRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Models_SignUpRequest, Models_SignUpResponse>

  func signIn(
    _ request: Models_SignInRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Models_SignInRequest, Models_SignInResponse>

  func restorePassword(
    _ request: Models_RestorePasswordRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Models_RestorePasswordRequest, Models_RestorePasswordResponse>

  func changePassword(
    _ request: Models_ChangePasswordRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Models_ChangePasswordRequest, Models_ChangePasswordResponse>

  func changePhone(
    _ request: Models_ChangePhoneRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Models_ChangePhoneRequest, Models_ChangePhoneResponse>

  func getUserInfo(
    _ request: Models_GetUserInfoRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Models_GetUserInfoRequest, Models_GetUserInfoResponse>
}

extension Models_AuthServiceClientProtocol {
  internal var serviceName: String {
    return "models.AuthService"
  }

  /// Unary call to SignUp
  ///
  /// - Parameters:
  ///   - request: Request to send to SignUp.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func signUp(
    _ request: Models_SignUpRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Models_SignUpRequest, Models_SignUpResponse> {
    return self.makeUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.signUp.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSignUpInterceptors() ?? []
    )
  }

  /// Unary call to SignIn
  ///
  /// - Parameters:
  ///   - request: Request to send to SignIn.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func signIn(
    _ request: Models_SignInRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Models_SignInRequest, Models_SignInResponse> {
    return self.makeUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.signIn.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSignInInterceptors() ?? []
    )
  }

  /// Unary call to RestorePassword
  ///
  /// - Parameters:
  ///   - request: Request to send to RestorePassword.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func restorePassword(
    _ request: Models_RestorePasswordRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Models_RestorePasswordRequest, Models_RestorePasswordResponse> {
    return self.makeUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.restorePassword.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRestorePasswordInterceptors() ?? []
    )
  }

  /// Unary call to ChangePassword
  ///
  /// - Parameters:
  ///   - request: Request to send to ChangePassword.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func changePassword(
    _ request: Models_ChangePasswordRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Models_ChangePasswordRequest, Models_ChangePasswordResponse> {
    return self.makeUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.changePassword.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeChangePasswordInterceptors() ?? []
    )
  }

  /// Unary call to ChangePhone
  ///
  /// - Parameters:
  ///   - request: Request to send to ChangePhone.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func changePhone(
    _ request: Models_ChangePhoneRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Models_ChangePhoneRequest, Models_ChangePhoneResponse> {
    return self.makeUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.changePhone.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeChangePhoneInterceptors() ?? []
    )
  }

  /// Unary call to GetUserInfo
  ///
  /// - Parameters:
  ///   - request: Request to send to GetUserInfo.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getUserInfo(
    _ request: Models_GetUserInfoRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Models_GetUserInfoRequest, Models_GetUserInfoResponse> {
    return self.makeUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.getUserInfo.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetUserInfoInterceptors() ?? []
    )
  }
}

#if compiler(>=5.6)
@available(*, deprecated)
extension Models_AuthServiceClient: @unchecked Sendable {}
#endif // compiler(>=5.6)

@available(*, deprecated, renamed: "Models_AuthServiceNIOClient")
internal final class Models_AuthServiceClient: Models_AuthServiceClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: Models_AuthServiceClientInterceptorFactoryProtocol?
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  internal var interceptors: Models_AuthServiceClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the models.AuthService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Models_AuthServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

internal struct Models_AuthServiceNIOClient: Models_AuthServiceClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Models_AuthServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the models.AuthService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Models_AuthServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

#if compiler(>=5.6)
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Models_AuthServiceAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Models_AuthServiceClientInterceptorFactoryProtocol? { get }

  func makeSignUpCall(
    _ request: Models_SignUpRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Models_SignUpRequest, Models_SignUpResponse>

  func makeSignInCall(
    _ request: Models_SignInRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Models_SignInRequest, Models_SignInResponse>

  func makeRestorePasswordCall(
    _ request: Models_RestorePasswordRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Models_RestorePasswordRequest, Models_RestorePasswordResponse>

  func makeChangePasswordCall(
    _ request: Models_ChangePasswordRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Models_ChangePasswordRequest, Models_ChangePasswordResponse>

  func makeChangePhoneCall(
    _ request: Models_ChangePhoneRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Models_ChangePhoneRequest, Models_ChangePhoneResponse>

  func makeGetUserInfoCall(
    _ request: Models_GetUserInfoRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Models_GetUserInfoRequest, Models_GetUserInfoResponse>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Models_AuthServiceAsyncClientProtocol {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Models_AuthServiceClientMetadata.serviceDescriptor
  }

  internal var interceptors: Models_AuthServiceClientInterceptorFactoryProtocol? {
    return nil
  }

  internal func makeSignUpCall(
    _ request: Models_SignUpRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Models_SignUpRequest, Models_SignUpResponse> {
    return self.makeAsyncUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.signUp.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSignUpInterceptors() ?? []
    )
  }

  internal func makeSignInCall(
    _ request: Models_SignInRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Models_SignInRequest, Models_SignInResponse> {
    return self.makeAsyncUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.signIn.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSignInInterceptors() ?? []
    )
  }

  internal func makeRestorePasswordCall(
    _ request: Models_RestorePasswordRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Models_RestorePasswordRequest, Models_RestorePasswordResponse> {
    return self.makeAsyncUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.restorePassword.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRestorePasswordInterceptors() ?? []
    )
  }

  internal func makeChangePasswordCall(
    _ request: Models_ChangePasswordRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Models_ChangePasswordRequest, Models_ChangePasswordResponse> {
    return self.makeAsyncUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.changePassword.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeChangePasswordInterceptors() ?? []
    )
  }

  internal func makeChangePhoneCall(
    _ request: Models_ChangePhoneRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Models_ChangePhoneRequest, Models_ChangePhoneResponse> {
    return self.makeAsyncUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.changePhone.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeChangePhoneInterceptors() ?? []
    )
  }

  internal func makeGetUserInfoCall(
    _ request: Models_GetUserInfoRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Models_GetUserInfoRequest, Models_GetUserInfoResponse> {
    return self.makeAsyncUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.getUserInfo.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetUserInfoInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Models_AuthServiceAsyncClientProtocol {
  internal func signUp(
    _ request: Models_SignUpRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Models_SignUpResponse {
    return try await self.performAsyncUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.signUp.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSignUpInterceptors() ?? []
    )
  }

  internal func signIn(
    _ request: Models_SignInRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Models_SignInResponse {
    return try await self.performAsyncUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.signIn.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSignInInterceptors() ?? []
    )
  }

  internal func restorePassword(
    _ request: Models_RestorePasswordRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Models_RestorePasswordResponse {
    return try await self.performAsyncUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.restorePassword.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRestorePasswordInterceptors() ?? []
    )
  }

  internal func changePassword(
    _ request: Models_ChangePasswordRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Models_ChangePasswordResponse {
    return try await self.performAsyncUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.changePassword.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeChangePasswordInterceptors() ?? []
    )
  }

  internal func changePhone(
    _ request: Models_ChangePhoneRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Models_ChangePhoneResponse {
    return try await self.performAsyncUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.changePhone.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeChangePhoneInterceptors() ?? []
    )
  }

  internal func getUserInfo(
    _ request: Models_GetUserInfoRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Models_GetUserInfoResponse {
    return try await self.performAsyncUnaryCall(
      path: Models_AuthServiceClientMetadata.Methods.getUserInfo.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetUserInfoInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal struct Models_AuthServiceAsyncClient: Models_AuthServiceAsyncClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Models_AuthServiceClientInterceptorFactoryProtocol?

  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Models_AuthServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

#endif // compiler(>=5.6)

internal protocol Models_AuthServiceClientInterceptorFactoryProtocol: GRPCSendable {

  /// - Returns: Interceptors to use when invoking 'signUp'.
  func makeSignUpInterceptors() -> [ClientInterceptor<Models_SignUpRequest, Models_SignUpResponse>]

  /// - Returns: Interceptors to use when invoking 'signIn'.
  func makeSignInInterceptors() -> [ClientInterceptor<Models_SignInRequest, Models_SignInResponse>]

  /// - Returns: Interceptors to use when invoking 'restorePassword'.
  func makeRestorePasswordInterceptors() -> [ClientInterceptor<Models_RestorePasswordRequest, Models_RestorePasswordResponse>]

  /// - Returns: Interceptors to use when invoking 'changePassword'.
  func makeChangePasswordInterceptors() -> [ClientInterceptor<Models_ChangePasswordRequest, Models_ChangePasswordResponse>]

  /// - Returns: Interceptors to use when invoking 'changePhone'.
  func makeChangePhoneInterceptors() -> [ClientInterceptor<Models_ChangePhoneRequest, Models_ChangePhoneResponse>]

  /// - Returns: Interceptors to use when invoking 'getUserInfo'.
  func makeGetUserInfoInterceptors() -> [ClientInterceptor<Models_GetUserInfoRequest, Models_GetUserInfoResponse>]
}

internal enum Models_AuthServiceClientMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "AuthService",
    fullName: "models.AuthService",
    methods: [
      Models_AuthServiceClientMetadata.Methods.signUp,
      Models_AuthServiceClientMetadata.Methods.signIn,
      Models_AuthServiceClientMetadata.Methods.restorePassword,
      Models_AuthServiceClientMetadata.Methods.changePassword,
      Models_AuthServiceClientMetadata.Methods.changePhone,
      Models_AuthServiceClientMetadata.Methods.getUserInfo,
    ]
  )

  internal enum Methods {
    internal static let signUp = GRPCMethodDescriptor(
      name: "SignUp",
      path: "/models.AuthService/SignUp",
      type: GRPCCallType.unary
    )

    internal static let signIn = GRPCMethodDescriptor(
      name: "SignIn",
      path: "/models.AuthService/SignIn",
      type: GRPCCallType.unary
    )

    internal static let restorePassword = GRPCMethodDescriptor(
      name: "RestorePassword",
      path: "/models.AuthService/RestorePassword",
      type: GRPCCallType.unary
    )

    internal static let changePassword = GRPCMethodDescriptor(
      name: "ChangePassword",
      path: "/models.AuthService/ChangePassword",
      type: GRPCCallType.unary
    )

    internal static let changePhone = GRPCMethodDescriptor(
      name: "ChangePhone",
      path: "/models.AuthService/ChangePhone",
      type: GRPCCallType.unary
    )

    internal static let getUserInfo = GRPCMethodDescriptor(
      name: "GetUserInfo",
      path: "/models.AuthService/GetUserInfo",
      type: GRPCCallType.unary
    )
  }
}

