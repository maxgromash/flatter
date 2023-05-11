import SwiftUI

struct PersonalInfoChangesView<
    VM: PersonalInfoChangesViewModel,
    Router: Routing
>: AppView where VM.Route == Router.Route {
    @ObservedObject var viewModel: VM
    var router: Router

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                title
                Spacer()
            }
            AuthorizationTextField(
                title: "Номер телефона",
                text: $viewModel.phoneNumberInput
            )
            AuthorizatoinMainActionButton(
                text: "Сохранить",
                action: viewModel.userDidTapSavePhoneButton,
                disabled: false == viewModel.confirmButtonEnabled
            )
        }
    }

    @ViewBuilder private var title: some View {
        Text("Персональные данные")
            .font(.title2)
            .foregroundColor(.white)
    }
}

struct PersonalInfoChangesView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInfoChangesView(
            viewModel: ViewModelMock(),
            router: EmptyViewRouterMock()
        )
        .background(.black)
    }

    private final class ViewModelMock: PersonalInfoChangesViewModel {
        var phoneNumberInput: String = ""

        var confirmButtonEnabled: Bool = false

        var navigationRoute: ProfileChangesRoute? = nil

        func userDidTapSavePhoneButton() {}
    }
}
