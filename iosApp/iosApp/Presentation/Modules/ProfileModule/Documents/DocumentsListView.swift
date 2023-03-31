import SwiftUI

struct DocumentsListView<
    VM: DocumentsListViewModel,
    Router: Routing
>: AppView where VM.Route == Router.Route {
    @ObservedObject var viewModel: VM
    var router: Router

    @State private var presentDocumentsPicker: Bool = false

    private let dateFormater: DateFormatter = {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .none
        formater.locale = .current

        return formater
    }()

    var body: some View {
        ScrollView {
            ForEach(viewModel.documents, id: \.name) { document in
                documentCell(document: document)
                    .onTapGesture { viewModel.userDidTapDocumentCell(document: document) }
            }
        }
        .padding(.horizontal, 15)
        .safeAreaInset(edge: .bottom) {
            EmptyView().frame(height: 20)
        }
        .navigationTitle("Мои документы")
        .sheet(isPresented: $presentDocumentsPicker) {
            DocumentPicker(
                userDidSelectFiles: viewModel.userDidSelectDocumentsToUpload(urls:)
            )
                .tint(ColorsProvider.primary)
        }
        .toolbar {
            Button("Загрузить") { presentDocumentsPicker = true }
        }
    }

    @ViewBuilder private func documentCell(document: DocumentModel) -> some View {
        HStack {
            ImagesProvider.pdfIcon
                .resizable()
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text(document.name)
                    .font(.body)
                    .foregroundColor(.black)
                Text(dateFormater.string(from: document.creationDate))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            if #available(iOS 16.0, *) {
                ShareLink(item: document.path) {
                    ImagesProvider.shareIcon
                        .tint(ColorsProvider.primary)
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(.white)
        .cornerRadius(10)
    }
}

struct DocumentsListView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsListView(
            viewModel: ViewModel(),
            router: EmptyViewRouterMock()
        )
    }

    private final class ViewModel: DocumentsListViewModel {
        var documents: [DocumentModel] = []

        var navigationRoute: DocumentsListRoute? = nil

        func userDidTapDocumentCell(document: DocumentModel) {}

        func userDidSelectDocumentsToUpload(urls: [URL]) {}
    }
}
