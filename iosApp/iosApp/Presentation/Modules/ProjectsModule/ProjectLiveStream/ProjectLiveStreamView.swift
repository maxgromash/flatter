import SwiftUI

struct ProjectLiveStreamView: View {
    @ObservedObject var viewModel:  ProjectLiveStreamViewModel
    var body: some View {
        LiveStreamView(
            url: URL(string: "rtmp://45.8.250.161:1935/hls")!,
            streamName: "stream_480p1128kbs"
        )
        .navigationTitle("Прямая трансляция")
    }
}
