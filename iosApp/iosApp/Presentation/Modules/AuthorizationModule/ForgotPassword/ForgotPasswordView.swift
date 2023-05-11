import SwiftUI

struct ForgotPasswordView<
    Router: Routing,
    VM: ForgotPasswordViewModel
>: AppView where Router.Route == VM.Route {
    @ObservedObject var viewModel: VM
    let router: Router

    var body: some View {
        BackgroundContainer {
            VStack(alignment: .leading) {
                header
                descriptionText
                emailForm
            }
            .padding(.horizontal, 16)
            .alert(viewModel: viewModel)
        }
    }

    @ViewBuilder private var header: some View {
        Text("Восстановление пароля")
            .font(.largeTitle)
            .foregroundColor(.white)
    }

    @ViewBuilder private var descriptionText: some View {
        Text("Введите почту, которую указывали при регситрации. Мы отправим на почту ссылку для восстановления пароля.")
            .foregroundColor(.white)
            .font(.caption)
    }

    @ViewBuilder private var emailForm: some View {
        VStack(spacing: 20) {
            AuthorizationTextField(
                title: "Почта",
                text: $viewModel.emailInput
            )
            .required(validator: { _ in viewModel.emailValid } )
            AuthorizatoinMainActionButton(
                text: "Отправить письмо",
                action: viewModel.userDidTapSendButton,
                disabled: viewModel.emailValid == false
            )
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(
            viewModel: ViewModelMock(),
            router: EmptyViewRouterMock()
        )
    }

    private final class ViewModelMock: ForgotPasswordViewModel {
        var emailInput: String = ""

        var emailValid: Bool = false

        var navigationRoute: ForgotPasswordRoute? = nil

        func userDidTapSendButton() {}
    }
}
