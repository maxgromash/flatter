import SwiftUI

struct AuthorizatoinMainActionButton: View {
    let text: String
    let action: () -> ()

    var disabled: Bool
    var body: some View {
        Button(
            action: action,
            label: {
                Text(text)
                    .foregroundColor(.white)
            }
        )
        .padding(.horizontal, 40)
        .padding(.vertical, 10)
        .background(disabled ? ColorsProvider.secondary : ColorsProvider.primary)
        .roundedBorder(.clear, cornerRadius: 15)
        .disabled(disabled)
    }
}

struct AuthorizatoinMainActionButton_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizatoinMainActionButton(
            text: "Preview",
            action: {},
            disabled: false
        )

        AuthorizatoinMainActionButton(
            text: "Preview",
            action: {},
            disabled: true
        )
    }
}
