import SwiftUI

struct ProjectLiveStreamView: View {
    let streams: ProjectModel.Stream
    @ObservedObject var viewModel:  ProjectLiveStreamViewModel
    var body: some View {
        LiveStreamView(
            url: URL(string: "rtmp://81.163.30.24:1935/hls")!,
            streams: streams
        )
        .navigationTitle("Прямая трансляция")
    }
}
