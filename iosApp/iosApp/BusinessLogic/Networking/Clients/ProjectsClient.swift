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

extension ProjectsClientImpl: FavouriteFlatsClient {
    func addFavourites(data: AddFavouritesRequest, completionHandler: @escaping (AddFavouritesResponse?, Error?) -> Void) {
        let request = Models_AddFavouritesRequest(data)
        let call = client.addFavourites(request)
        do {
            let message = try call.response.wait()
            let (wireMessage, _) = message.toWireMessage(adapter: AddFavouritesResponse.Companion.shared.ADAPTER)
            completionHandler(wireMessage, nil)
        } catch {
            completionHandler(nil, error)
        }
    }

    func getFavourites(data: GetFavouritesRequest, completionHandler: @escaping (GetFavouritesResponse?, Error?) -> Void) {
        let request = Models_GetFavouritesRequest(data)
        let call = client.getFavourites(request)
        do {
            let message = try call.response.wait()
            let (wireMessage, _) = message.toWireMessage(adapter: GetFavouritesResponse.Companion.shared.ADAPTER)
            completionHandler(wireMessage, nil)
        } catch {
            completionHandler(nil, error)
        }
    }

    func removeFavourites(data: RemoveFavouritesRequest, completionHandler: @escaping (RemoveFavouritesResponse?, Error?) -> Void) {
        let request = Models_RemoveFavouritesRequest(data)
        let call = client.removeFavourites(request)
        do {
            let message = try call.response.wait()
            let (wireMessage, _) = message.toWireMessage(adapter: RemoveFavouritesResponse.Companion.shared.ADAPTER)
            completionHandler(wireMessage, nil)
        } catch {
            completionHandler(nil, error)
        }
    }

}

extension ProjectsClientImpl: FlatsClient {
    func loadFlats(data: GetFlatsRequest, completionHandler: @escaping (GetFlatsResponse?, Error?) -> Void) {
        let request = Models_GetFlatsRequest(data)
        let call = client.getFlats(request)
        do {
            let message = try call.response.wait()
            let (wireMessage, _) = message.toWireMessage(adapter: GetFlatsResponse.Companion.shared.ADAPTER)
            completionHandler(wireMessage, nil)
        } catch {
            completionHandler(nil, error)
        }
    }
}

private extension Models_GetFlatsRequest {
    init(_ data: GetFlatsRequest) {
        var this = Models_GetFlatsRequest()
        this.projectID = data.projectID
        self = this
    }
}

extension Models_GetFavouritesRequest {
    init(_ data: GetFavouritesRequest) {
        var this = Models_GetFavouritesRequest()
        this.token = data.token
        self = this
    }
}

extension Models_AddFavouritesRequest {
    init(_ data: AddFavouritesRequest) {
        var this = Models_AddFavouritesRequest()
        this.token = data.token
        this.ids = data.ids.map(\.int32Value)
        self = this
    }
}

extension Models_RemoveFavouritesRequest {
    init(_ data: RemoveFavouritesRequest) {
        var this = Models_RemoveFavouritesRequest()
        this.token = data.token
        this.id = data.id
        self = this
    }
}
