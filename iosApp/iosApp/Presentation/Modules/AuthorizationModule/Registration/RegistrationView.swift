import Foundation
import SwiftUI

struct RegistrationView<
    Router: Routing,
    VM: RegistrationViewModel
>: AppView where Router.Route == RegistrationRoute  {
    @ObservedObject var viewModel: VM

    var router: Router

    var body: some View {
        BackgroundContainer {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 20) {
                    header
                    registrationForm
                }
                registrationButton
                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }

    @ViewBuilder private var registrationForm: some View {
        VStack(alignment: .leading, spacing: 15) {
            personalDataSection
            authorizationDataSection
        }
    }

    @ViewBuilder private var personalDataSection: some View {
        VStack(alignment: .leading) {
            formGroupHeader(text: "Личные данные")
            AuthorizationTextField(
                title: "Имя",
                text: $viewModel.nameInput
            )
            .required(validator: { $0.isEmpty == false })
            AuthorizationTextField(
                title: "Номер телефона",
                text: $viewModel.phoneNumberInput
            )
        }
    }

    @ViewBuilder private var authorizationDataSection: some View {
        VStack(alignment: .leading) {
            formGroupHeader(text: "Авторизационные данные")
            AuthorizationTextField(
                title: "Почта",
                text: $viewModel.emailInput
            )
            .required(validator: { _ in viewModel.emailValid })
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
        }
    }

    @ViewBuilder private var header: some View {
        Text("Регистрация")
            .font(.largeTitle)
            .foregroundColor(.white)
    }

    @ViewBuilder private var registrationButton: some View {
        AuthorizatoinMainActionButton(
            text: "Зарегистрироваться",
            action: viewModel.userDidTapRegistrationButton,
            disabled: (viewModel.nameValid && viewModel.emailValid && viewModel.passwordValid && viewModel.passswordAgainValid) == false
        )
    }

    @ViewBuilder private func formGroupHeader(text: String) -> some View {
        Text(text)
            .font(.subheadline)
            .foregroundColor(.white)
    }
}

struct RegistrationView_Preview: PreviewProvider {
    static var previews: some View {
        RegistrationView(
            viewModel: ViewModelMock(),
            router: EmptyViewRouterMock()
        )
    }

    private final class ViewModelMock: RegistrationViewModel {
        var nameInput: String = ""

        var nameValid: Bool = false

        var emailInput: String = ""

        var phoneNumberInput: String = ""

        var passwordInput: String = ""

        var passwordAgainInput: String = ""

        var emailValid: Bool = false

        var passwordValid: Bool = false

        var passswordAgainValid: Bool = false

        var navigationRoute: RegistrationRoute? = nil

        func userDidTapRegistrationButton() {}
    }
}
