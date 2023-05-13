import Foundation
import shared

final class NewsClientImpl: BaseClient {
    
}

extension NewsClientImpl: NewsClient {
    func loadNews(completionHandler: @escaping (Error?) -> Void) {}
}
