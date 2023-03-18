import SwiftUI

struct AuthorizationTextField: View {
    let title: String
    @Binding var text: String
    let isSecure: Bool

    init(
        title: String,
        text: Binding<String>,
        isSecure: Bool = false
    ) {
        self.title = title
        self._text = text
        self.isSecure = isSecure
    }

    @ViewBuilder private var textField: some View {
        if isSecure {
            SecureField("", text: $text)
        }
        else {
            TextField("", text: $text)
        }
    }

    var body: some View {
        textField
            .placeholder(title, when: text.isEmpty, color: .white.opacity(0.7))
            .padding(15)
            .foregroundColor(.white)
            .roundedBorder(ColorsProvider.primaryContainer, cornerRadius: 12)
    }
}

struct AuthorizationTextField_Previews: PreviewProvider {
    @State static var text: String = "Test"

    static var previews: some View {
        Group {
            AuthorizationTextField(
                title: "Preview",
                text: .init(
                    get: { "Test" },
                    set: { _ in }
                )
            )
                .previewLayout(.sizeThatFits)
                .previewDisplayName("With input")

            AuthorizationTextField(
                title: "Preview",
                text: .init(
                    get: { "" },
                    set: { _ in }
                )
            )
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Without input")
        }
        .padding(.horizontal, 15)
        .background(.gray)
    }
}
