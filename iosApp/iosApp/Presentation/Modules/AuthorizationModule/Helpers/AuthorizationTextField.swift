import SwiftUI

struct AuthorizationTextField: View {
    typealias Validator = (String) -> Bool

    let title: String
    @Binding var text: String
    private var isSecure: Bool = false
    private var validator: Validator = { _ in true }

    init(
        title: String,
        text: Binding<String>
    ) {
        self.title = title
        self._text = text
    }

    var body: some View {
        textField
            .placeholder(title, when: text.isEmpty, color: .white.opacity(0.7))
            .padding(15)
            .foregroundColor(.white)
            .roundedBorder(ColorsProvider.primaryContainer, cornerRadius: 12)
            .overlay(alignment: .trailing) {
                requiredMark
            }
    }

    @inlinable func secure() -> Self {
        var this = self
        this.isSecure = true
        return this
    }

    @inlinable func required(validator: @escaping Validator) -> Self {
        var this = self
        this.validator = validator
        return this
    }

    @ViewBuilder private var textField: some View {
        if isSecure {
            SecureField("", text: $text)
        }
        else {
            TextField("", text: $text)
                .keyboardType(.emailAddress)
        }
    }

    @ViewBuilder private var requiredMark: some View {
        if false == validator(text) {
            HStack {
                Text("*")
                    .foregroundColor(.red)
            }
            .padding(.trailing, 10)
        }
        else {
            EmptyView()
        }
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
