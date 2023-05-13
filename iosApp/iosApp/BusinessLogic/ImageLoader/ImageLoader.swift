import Foundation
import UIKit

final class ImageLoader {
    static let shared = ImageLoader()

    private let urlSession = URLSession(configuration: .default)

    func loadImage(url: URL) async throws -> UIImage {
        let request = URLRequest(url: url)
        let (data, _) = try await urlSession.data(for: request)
        guard let image = UIImage(data: data) else {
            throw ImageLoadingErrors.uiImageConvertError
        }

        return image
    }

    enum ImageLoadingErrors: Error {
        case uiImageConvertError
    }
}
