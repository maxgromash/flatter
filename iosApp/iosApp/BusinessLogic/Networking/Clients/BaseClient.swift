import Foundation
import Logging
import GRPC
import NIOHPACK

class BaseClient {
    var channel: GRPCChannel {
        GRPCChannelProvider.shared.channel
    }

    private let name: String

    private lazy var logger: Logger = makeLogger()

    init(name: String) {
        self.name = name
    }

    var callOptions: CallOptions {
        CallOptions(
            customMetadata: HPACKHeaders([]),
            logger: logger
        )
    }

    private func makeLogger() -> Logger {
        var logger = Logger(
            label: name,
            factory: StreamLogHandler.standardOutput(label:)
        )
        logger.logLevel = .debug

        return logger
    }
}
