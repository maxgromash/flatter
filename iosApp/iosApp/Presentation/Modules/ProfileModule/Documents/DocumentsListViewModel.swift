import Foundation

protocol DocumentsListViewModel: ViewModel where Route == DocumentsListRoute {
    var documents: [DocumentModel] { get }

    func userDidTapDocumentCell(document: DocumentModel)
    func userDidSelectDocumentsToUpload(urls: [URL])
}

final class DocumentsListViewModelImpl: DocumentsListViewModel {
    @Published var navigationRoute: DocumentsListRoute? = nil

    @Published var documents: [DocumentModel] = []

    init() {
        loadFiles()
    }

    func userDidTapDocumentCell(document: DocumentModel) {
        navigationRoute = .document(url: document.path)
    }

    func userDidSelectDocumentsToUpload(urls: [URL]) {
        guard var url = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else { return }

        url = url.appendingPathComponent("FlatterDocuments", conformingTo: .folder)

        if false == FileManager.default.fileExists(atPath: url.relativePath) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch {
                return
            }
        }

        urls.forEach {
            let newFileName = $0.deletingPathExtension().lastPathComponent
            do {
                try FileManager.default.copyItem(
                    at: $0,
                    to: url.appendingPathComponent(newFileName, conformingTo: .pdf)
                )
            } catch {
                print(error)
            }
        }

        loadFiles()
    }

    private func loadFiles() {
        guard var url = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else { return }

        url = url.appendingPathComponent("FlatterDocuments", conformingTo: .folder)
        if false == FileManager.default.fileExists(atPath: url.relativePath) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch {
                return
            }
        }

        do {
            let documentUrls = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil).filter({ $0.pathExtension == "pdf" })
            self.documents = documentUrls.compactMap({ try? mapFileURL($0) })
        } catch {
            return
        }
    }

    private func mapFileURL(_ url: URL) throws -> DocumentModel? {
        let name = url.lastPathComponent
        let attributes = try FileManager.default.attributesOfItem(atPath: url.relativePath)
        guard let creationDate = attributes[.creationDate] as? Date else {
            return nil
        }

        return DocumentModel(
            name: name,
            path: url,
            creationDate: creationDate
        )
    }

    private func saveFile(url: URL) {

    }
}
