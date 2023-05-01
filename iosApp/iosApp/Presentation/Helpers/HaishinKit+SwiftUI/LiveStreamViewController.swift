import Foundation
import AVFoundation
import CoreMedia
import HaishinKit
import SwiftUI

struct LiveStreamView: UIViewControllerRepresentable {
    let url: URL
    let streamName: String

    func makeUIViewController(context: Context) -> LiveStreamViewController {
        LiveStreamViewController(url: url, streamName: streamName)
    }

    func updateUIViewController(_ uiViewController: LiveStreamViewController, context: Context) {}
}

final class LiveStreamViewController: UIViewController {
    private let connection = RTMPConnection()
    private let stream: RTMPStream

    private let url: URL
    private let streamName: String

    private var retryCount = 0

    private var currentBitrate = Constants.maxBitrate

    private var bitrateRetryCounter = 0

    init(url: URL, streamName: String) {
        self.stream = .init(connection: connection)
        self.url = url
        self.streamName = streamName
        super.init(nibName: nil, bundle: nil)

        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = PiPHKView()
        view.attachStream(stream)
        self.view = view
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = false
        restoreConnection()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        UIApplication.shared.isIdleTimerDisabled = true
        DispatchQueue.global(qos: .background).async { [connection] in
            connection.close()
        }
    }

    private func setUp() {
        connection.addEventListener(.rtmpStatus, selector: #selector(rtmpStatusHandler), observer: self)
        connection.addEventListener(.ioError, selector: #selector(rtmpErrorHandler), observer: self)
        stream.videoSettings[.bitrate] = currentBitrate
        stream.delegate = self

        stream.videoSettings[.maxKeyFrameIntervalDuration] = 1.0
        stream.videoSettings[.scalingMode] = ScalingMode.cropSourceToCleanAperture
    }

    @objc
    private func rtmpStatusHandler(_ notification: Notification) {
        let e = Event.from(notification)
        guard let data = e.data as? ASObject, let code = data["code"] as? String else {
            return
        }
        switch code {
        case RTMPConnection.Code.connectSuccess.rawValue:
            play()
        case RTMPConnection.Code.connectFailed.rawValue:
            restoreConnection()
        default:
            break
        }
    }

    @objc
    private func rtmpErrorHandler(_ notification: Notification) {
        restoreConnection()
    }

    private func play() {
        stream.play(streamName)
        stream.receiveVideo = true
    }

    private func restoreConnection() {
        guard false == self.connection.connected else { return }
        connection.connect(url.absoluteString)
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.restoreConnection()
        }
    }
}

extension LiveStreamViewController: RTMPStreamDelegate {
    func rtmpStream(_ stream: RTMPStream, publishInsufficientBWOccured connection: RTMPConnection) {
        let newBitrate = max(UInt(Double(currentBitrate) * Constants.bitrateDown), Constants.minBitrate)
        self.stream.videoSettings[.bitrate] = newBitrate
    }

    func rtmpStream(_ stream: RTMPStream, publishSufficientBWOccured connection: RTMPConnection) {
        guard currentBitrate <= Constants.maxBitrate else {
            return
        }
        guard self.bitrateRetryCounter >= Constants.retrySecBeforeUpBitrate else {
            self.bitrateRetryCounter += 1
            return
        }

        self.bitrateRetryCounter = 0
        let newBitrate = min(Constants.maxBitrate, UInt(Double(currentBitrate) * Constants.bitrateUp))
        if newBitrate == currentBitrate { return }

        self.stream.videoSettings[.bitrate] = newBitrate
    }

    func rtmpStream(_ stream: RTMPStream, updatedStats connection: RTMPConnection) {}

    func rtmpStream(_ stream: RTMPStream, didOutput audio: AVAudioBuffer, presentationTimeStamp: CMTime) {}

    func rtmpStream(_ stream: RTMPStream, didOutput video: CMSampleBuffer) {}

    func rtmpStream(_ stream: RTMPStream, sessionWasInterrupted session: AVCaptureSession, reason: AVCaptureSession.InterruptionReason) {}

    func rtmpStream(_ stream: RTMPStream, sessionInterruptionEnded session: AVCaptureSession, reason: AVCaptureSession.InterruptionReason) {}

    func rtmpStream(_ stream: RTMPStream, videoCodecErrorOccurred error: VideoCodec.Error) {}

    func rtmpStreamDidClear(_ stream: RTMPStream) {}
}

private struct Constants {
    static let minBitrate: UInt = 15
    static let maxBitrate: UInt = 60
    static let bitrateDown: Double = 0.75
    static let bitrateUp: Double = 1.15
    static let retrySecBeforeUpBitrate = 20
}
