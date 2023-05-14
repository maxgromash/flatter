import SwiftUI

struct FlatInfoView<
    VM: FlatInfoViewModel,
    Router: Routing
>: AppView where VM.Route == Router.Route {
    @ObservedObject var viewModel: VM
    let router: Router

    @State private var creditMonths: Float = 12
    @State private var initialPayment: Float = 2_000_000
    @State private var interestRate: Float = 5

    private var monthlyPayment: Float {
        let fullPrice = Float(viewModel.flat.price) - initialPayment
        let percent = interestRate / 100 / 12

        return fullPrice * (
            percent + (
                percent / (pow(1 + percent, creditMonths) - 1)
            )
        )
    }

    init(viewModel: VM, router: Router) {
        self.viewModel = viewModel
        self.router = router

        UIPageControl.appearance()
            .currentPageIndicatorTintColor = ColorsProvider.primary.uiColor
        UIPageControl.appearance().pageIndicatorTintColor = ColorsProvider.onPrimaryContainer.uiColor
        UIPageControl.appearance().tintColor = ColorsProvider.primary.uiColor
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                imagesSlider
                    .frame(height: 200)
                    .padding(.bottom, 20)
                flatDescriptionBlock
                creditCalculationBlock
                callToManagerButton
            }
            .padding(.horizontal, 15)
        }
        .navigationTitle("Квартира")
        .safeAreaInset(edge: .bottom) {
            EmptyView().frame(height: 20)
        }
        .alert(viewModel: viewModel)
    }

    @ViewBuilder private var imagesSlider: some View {
        TabView {
            ForEach(
                viewModel.flat.images,
                id: \.self
            ) { image in
                Image(uiImage: image)
                   .resizable()
                   .scaledToFit()
                   .cornerRadius(15)
           }
        }
        .tint(ColorsProvider.primary)
        .tabViewStyle(PageTabViewStyle())
    }

    @ViewBuilder private var flatDescriptionBlock: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                blockDescriptionTitle(text: "О квартире")
                Spacer()
                favouriteButton
            }
            flatParamsDescription
            Divider()
            flatInhouseDescription
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(.white)
        .cornerRadius(15)
    }

    @ViewBuilder private func blockDescriptionTitle(text: String) -> some View {
        Text(text)
            .font(.title2)
            .padding(.leading, 10)
            .foregroundColor(ColorsProvider.primary)
    }

    @ViewBuilder private var flatParamsDescription: some View {
        HStack {
            Group {
                Spacer()
                VStack {
                    Text("\(viewModel.flat.number)")
                        .foregroundColor(ColorsProvider.primary)
                    Text("№ квартиры")
                        .font(.caption)
                }
                Spacer()
            }
            Group {
                Spacer()
                VStack {
                    Text("\(viewModel.flat.floor)")
                        .foregroundColor(ColorsProvider.primary)
                    Text("этаж")
                        .font(.caption)
                }
                Spacer()
            }
            Spacer()
            VStack {
                Text("\(String(format: "%.1f", viewModel.flat.area)) м2")
                    .foregroundColor(ColorsProvider.primary)
                ImagesProvider.areaIcon
            }
            Spacer()
        }
    }

    @ViewBuilder private var flatInhouseDescription: some View {
        VStack(spacing: 15) {
            flatHorizontalDescription(
                title: "Стоимость",
                text: "\(viewModel.flat.price.formatedForPrice) ₽"
            )
            flatHorizontalDescription(
                title: "Комнат",
                text: "\(viewModel.flat.rooms)"
            )
            flatHorizontalDescription(
                title: "Отделка",
                text: "\(viewModel.flat.trimming)"
            )
            flatHorizontalDescription(
                title: "Сдача",
                text: "\(viewModel.flat.finishing)"
            )
        }
        .padding(.horizontal, 15)
    }

    @ViewBuilder private func flatHorizontalDescription(title: String, text: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(text)
                .bold()
                .foregroundColor(ColorsProvider.primary)
        }
    }

    @ViewBuilder private var creditCalculationBlock: some View {
        VStack(alignment: .leading, spacing: 30) {
            blockDescriptionTitle(text: "Рассчет ипотеки")
            creditCalculationSliders
            calculatedMonthlyPayment
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(.white)
        .cornerRadius(15)
    }

    @ViewBuilder private var creditCalculationSliders: some View {
        VStack(spacing: 15) {
            sliderIntView(
                text: "Срок ипотеки",
                value: $creditMonths,
                caption: "месяцев",
                range: 12...360
            )
            sliderIntView(
                text: "Взнос",
                value: $initialPayment,
                caption: "₽",
                step: 100000,
                range: 2_000_000...Float(viewModel.flat.price)
            )
            sliderFloatView(
                text: "Ставка",
                value: $interestRate,
                caption: "%",
                step: 0.1,
                range: 5...20
            )
        }
    }

    @ViewBuilder private var calculatedMonthlyPayment: some View {
        HStack {
            Text("Ежемесячный платеж")
            Spacer()
            Text("\(monthlyPayment.formatedForPrice)₽")
                .foregroundColor(ColorsProvider.primary)
        }
    }

    @ViewBuilder private var callToManagerButton: some View {
        Button(
            action: {},
            label: {
                HStack {
                    Spacer()
                    Text("Забронировать квартиру")
                        .font(.title3)
                        .foregroundColor(ColorsProvider.primary)
                    Spacer()
                }
            }
        )
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(.white)
        .cornerRadius(15)
    }

    @ViewBuilder private func sliderIntView(
        text: String,
        value: Binding<Float>,
        caption: String,
        step: Float = 1,
        range: ClosedRange<Float>,
        priceFormated: Bool = false
    ) -> some View {
        let labelText: (Float) -> String = { value in
            if priceFormated {
                return "\(Int(value).formatedForPrice)"
            }
            else {
                return "\(Int(value))"
            }
        }
        VStack {
            HStack {
                Text(text)
                Spacer()
                Text("\(labelText(value.wrappedValue)) \(caption)")
            }
            Slider(
                value: value,
                in: range,
                step: step,
                label: { EmptyView() },
                minimumValueLabel: {
                    Text(labelText(range.lowerBound))
                },
                maximumValueLabel: {
                    Text(labelText(range.upperBound))
                }
            )
            .tint(ColorsProvider.primary)
        }
    }

    @ViewBuilder private func sliderFloatView(
        text: String,
        value: Binding<Float>,
        caption: String,
        step: Float = 1,
        range: ClosedRange<Float>
    ) -> some View {
        VStack {
            HStack {
                Text(text)
                Spacer()
                Text("\(String(format: "%.1f", value.wrappedValue)) \(caption)")
            }
            Slider(
                value: value,
                in: range,
                step: step,
                label: { EmptyView() },
                minimumValueLabel: {
                    Text("\(Int(range.lowerBound))")
                },
                maximumValueLabel: {
                    Text("\(Int(range.upperBound))")
                }
            )
            .tint(ColorsProvider.primary)
        }
    }

    @ViewBuilder private var favouriteButton: some View {
        Button(
            action: { viewModel.userDidTapFavouriteButton() },
            label: {
                favouriteIcon
                    .foregroundColor(ColorsProvider.primary)
            }
        )
    }

    @ViewBuilder private var favouriteIcon: some View {
        viewModel.flat.isFavourite ? ImagesProvider.favouritesFilledIcon : ImagesProvider.favouritesIcon
    }
}
