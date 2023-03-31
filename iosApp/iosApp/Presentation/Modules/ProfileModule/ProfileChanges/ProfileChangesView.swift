import SwiftUI

struct ProfileChangesView<
    PersonalDataChangesView: View,
    PasswordChangesView: View
>: View {
    let personalDataChangesView: PersonalDataChangesView
    let passwordChangesView: PasswordChangesView

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                personalDataChangesView
                passwordChangesView
            }
        }
        .navigationTitle("Изменение данных")
        .padding(.horizontal, 15)
        .safeAreaInset(edge: .bottom) {
            EmptyView().frame(height: 20)
        }
    }
}

struct ProfileChangesView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileChangesView(
            personalDataChangesView: EmptyView(),
            passwordChangesView: EmptyView()
        )
    }
}
