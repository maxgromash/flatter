import SwiftUI

struct ProfileChangesView<
    PersonalDataChangesView: View,
    PasswordChangesView: View
>: View {
    @ObservedObject var viewModel: ProfileChangesViewModel
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
        .alert(viewModel: viewModel)
    }
}
