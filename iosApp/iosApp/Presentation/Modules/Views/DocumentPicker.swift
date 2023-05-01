import Foundation
import SwiftUI

struct DocumentPicker: UIViewControllerRepresentable {
    let userDidSelectFiles: ([URL]) -> Void

    func makeCoordinator() -> Coordinator {
        DocumentPicker.Coordinator(userDidSelectFiles: userDidSelectFiles)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
    }

    final class Coordinator: NSObject, UIDocumentPickerDelegate {
        let userDidSelectFiles: ([URL]) -> Void

        init(userDidSelectFiles: @escaping ([URL]) -> Void) {
            self.userDidSelectFiles = userDidSelectFiles
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            userDidSelectFiles(urls)
        }
    }
}
