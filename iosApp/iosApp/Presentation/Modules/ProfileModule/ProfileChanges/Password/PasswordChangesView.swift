import SwiftUI

struct PasswordChangesView<
    VM: PasswordChangesViewModel,
    Router: Routing
>: AppView where VM.Route == Router.Route {
    @ObservedObject var viewModel: VM
    var router: Router

    var body: some View {
        VStack {
            HStack {
                title
                Spacer()
            }
            AuthorizationTextField(
                title: "Пароль",
                text: $viewModel.passwordInput
            )
            .secure()
            .required(validator: { _ in viewModel.passwordValid })
            AuthorizationTextField(
                title: "Пароль еще раз",
                text: $viewModel.passwordAgainInput
            )
            .secure()
            .required(validator: { _ in viewModel.passswordAgainValid })
            AuthorizatoinMainActionButton(
                text: "Сохранить",
                action: viewModel.userDidTapSavePasswordButton,
                disabled: false == viewModel.saveButtonEnabled
            )
        }
    }

    @ViewBuilder private var title: some View {
        Text("Пароль")
            .font(.title2)
            .foregroundColor(.white)
    }
}

struct PasswordChangesView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordChangesView(
            viewModel: ViewModelMock(),
            router: EmptyViewRouterMock()
        )
        .background(.black)
    }

    private final class ViewModelMock: PasswordChangesViewModel {
        var passwordInput: String = ""

        var passwordAgainInput: String = ""

        var passwordValid: Bool = false

        var passswordAgainValid: Bool = false

        var saveButtonEnabled: Bool = false

        func userDidTapSavePasswordButton() {}

        var navigationRoute: ProfileChangesRoute? = nil
    }
}
