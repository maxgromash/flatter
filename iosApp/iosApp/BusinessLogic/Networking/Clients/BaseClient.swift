import Foundation
import Logging
import GRPC
import NIOHPACK

class BaseClient {
    var channel: GRPCChannel {
        GRPCChannelProvider.shared.channel
    }

    private lazy var logger: Logger = makeLogger()

    var callOptions: CallOptions {
        CallOptions(
            customMetadata: HPACKHeaders([]),
            logger: logger
        )
    }

    private func makeLogger() -> Logger {
        var logger = Logger(
            label: "\(type(of: self))",
            factory: StreamLogHandler.standardOutput(label:)
        )
        logger.logLevel = .debug

        return logger
    }
}
