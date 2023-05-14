import Foundation
import GRPC
import Logging

final class GRPCChannelProvider {
    static let shared = GRPCChannelProvider()

    private(set) lazy var authChannel: GRPCChannel = makeAuthChannel()
    private(set) lazy var projectsChannel: GRPCChannel = makeProjectsProjectsChannel()


    private func makeAuthChannel() -> GRPCChannel {
        var logger = Logger(
            label: "gRPC_auth",
            factory: StreamLogHandler.standardOutput(label:)
        )
        logger.logLevel = .debug
        let eventGroup = PlatformSupport.makeEventLoopGroup(loopCount: 4, logger: logger)
        return ClientConnection
            .insecure(group: eventGroup)
            .withBackgroundActivityLogger(logger)
            .withConnectionIdleTimeout(.seconds(10))
            .connect(host: "81.163.30.24", port: 9000)
    }

    private func makeProjectsProjectsChannel() -> GRPCChannel {
        var logger = Logger(
            label: "gRPC_projects",
            factory: StreamLogHandler.standardOutput(label:)
        )
        logger.logLevel = .debug
        let eventGroup = PlatformSupport.makeEventLoopGroup(loopCount: 4, logger: logger)
        return ClientConnection
            .insecure(group: eventGroup)
            .withBackgroundActivityLogger(logger)
            .withConnectionIdleTimeout(.seconds(10))
            .connect(host: "81.163.30.24", port: 9001)
    }
}
