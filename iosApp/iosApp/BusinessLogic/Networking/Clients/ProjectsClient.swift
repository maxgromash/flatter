import Foundation
import shared

final class ProjectsClientImpl: BaseClient {
    private lazy var client = Models_ProjectServiceNIOClient(
        channel: GRPCChannelProvider.shared.projectsChannel,
        defaultCallOptions: callOptions
    )
}

extension ProjectsClientImpl: NewsClient {
    func loadNews(completionHandler: @escaping (GetNewsResponse?, Error?) -> Void) {
        let call = client.getNews(.init())
        do {
            let message = try call.response.wait()
            let (wireMessage, _) = message.toWireMessage(adapter: GetNewsResponse.Companion.shared.ADAPTER)
            completionHandler(wireMessage, nil)
        } catch {
            completionHandler(nil, error)
        }
    }
}

extension ProjectsClientImpl: ProjectsClient {
    func loadProjects(completionHandler: @escaping (GetProjectsResponse?, Error?) -> Void) {
        let call = client.getProjects(.init())
        do {
            let message = try call.response.wait()
            let (wireMessage, _) = message.toWireMessage(adapter: GetProjectsResponse.Companion.shared.ADAPTER)
            completionHandler(wireMessage, nil)
        } catch {
            completionHandler(nil, error)
        }
    }
}

