import Foundation
import SwiftUI

enum DocumentsListRoute: RouteType {
    case document(url: URL)
}

final class DocumentsListRouter: Routing {
    @ViewBuilder func view(for route: DocumentsListRoute) -> some View {
        switch route {
            case let .document(url):
                try? PDFKitRepresentedView(url: url)
                    .tint(ColorsProvider.primary)
                    .navigationTitle("Документ")
        }
    }
}
