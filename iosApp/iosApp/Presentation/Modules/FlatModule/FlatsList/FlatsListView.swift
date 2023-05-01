import SwiftUI

struct FlatsListView<
    VM: FlatsListViewModel,
    Router: Routing
>: AppView where VM.Route == Router.Route {
    @ObservedObject var viewModel: VM
    let router: Router

    let title: String
    let showFilters: Bool

    @State private var activeFilter: Filter? = nil
    @State private var minAreSize: Float = 30
    @State private var maxAreaSize: Float = 100

    @State private var minFloor: Float = 1
    @State private var maxFloor: Float = 30

    @State private var selectedRooms: Set<Int> = [0, 1, 2, 3, 4]

    private enum Filter {
        case price
        case area
        case rooms
        case floor
    }

    var body: some View {
        BackgroundContainer {
                ScrollView {
                    VStack(spacing: 15) {
                        if showFilters {
                            filters
                            if let activeFilter {
                                filterView(filter: activeFilter)
                            }
                        }
                        flatsList
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    EmptyView()
                        .frame(height: 20)
                }
            .padding(.horizontal, 15)
        }
        .navigationTitle(title)
    }

    @ViewBuilder private var flatsList: some View {
        VStack(alignment: .leading) {
            if viewModel.flats.isEmpty {
                Text("Список квартир пуст")
                    .foregroundColor(.white)
                    .bold()
            }
            else {
                Text("Доступные квартиры")
                    .font(.title2)
                    .foregroundColor(.white)
                ForEach(viewModel.flats, id: \.id) { flat in
                    FlatsListCard(
                        flat: flat,
                        onContentTap: {
                            viewModel.onUserDidSelectFlat(flat: flat)
                        },
                        onFavouritesTap: {
                            viewModel.userDidChangeFavourite(flat: flat)
                        }
                    )
                    .frame(height: 100)
                    .padding(.bottom, flat.id == viewModel.flats.last?.id ? 0 : 10)
                }
            }
        }
    }

    @ViewBuilder private var filters: some View {
        VStack(alignment: .leading) {
            Text("Фильтры")
                .font(.title2)
                .foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    filterItem(
                        text: "Стоимость",
                        associated: .price
                    )
                    filterItem(
                        text: "Площадь",
                        associated: .area
                    )
                    filterItem(
                        text: "Комнаты",
                        associated: .rooms
                    )
                    filterItem(
                        text: "Этаж",
                        associated: .floor
                    )
                    Spacer()
                }
            }
        }
    }

    @ViewBuilder private func filterItem(
        text: String,
        associated filter: Filter
    ) -> some View {
        VStack {
            Text(text)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(activeFilter == filter ? ColorsProvider.primaryContainer : .white)
        .cornerRadius(10)
        .onTapGesture {
            if activeFilter == nil || activeFilter != filter {
                activeFilter = filter
            }
            else {
                activeFilter = nil
            }
        }
    }

    @ViewBuilder private func filterView(filter: Filter) -> some View {
        VStack {
            switch filter {
                case .price:
                    priceFilter
                case .floor:
                    floorFilter
                case .area:
                    areaFilter
                case .rooms:
                    roomsFilter
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(.white)
        .cornerRadius(10)
    }

    @ViewBuilder private var priceFilter: some View {
        VStack {
            priceSliderView(
                text: "Минимальная стоимость",
                value: $viewModel.filter.price.minPriceValue,
                caption: "₽",
                step: 100_000,
                range: viewModel.filter.price.minPrice...viewModel.filter.price.maxPrice
            )
            Divider()
            priceSliderView(
                text: "Максимальная стоимость",
                value: $viewModel.filter.price.maxPriceValue,
                caption: "₽",
                step: 100_000,
                range: viewModel.filter.price.minPrice...viewModel.filter.price.maxPrice
            )
        }
    }

    @ViewBuilder private var areaFilter: some View {
        VStack {
            sliderView(
                text: "Минимальная площадь",
                value: $viewModel.filter.area.minArea,
                caption: "м2",
                range: Filters.AreaFilter.min...Filters.AreaFilter.max
            )
            Divider()
            sliderView(
                text: "Максимальная площадь",
                value: $viewModel.filter.area.maxArea,
                caption: "м2",
                range: Filters.AreaFilter.min...Filters.AreaFilter.max
            )
        }
    }

    @ViewBuilder private var floorFilter: some View {
        VStack {
            sliderView(
                text: "Минимальный этаж",
                value: $viewModel.filter.floor.minFloor,
                caption: "этаж",
                range: Filters.FloorFilter.min...Filters.FloorFilter.max
            )
            Divider()
            sliderView(
                text: "Максимальный этаж",
                value: $viewModel.filter.floor.maxFloor,
                caption: "этаж",
                range: Filters.FloorFilter.min...Filters.FloorFilter.max
            )
        }
    }

    @ViewBuilder private var roomsFilter: some View {
        HStack(spacing: 15) {
            Spacer()
            roomFilterItem(count: 0)
            roomFilterItem(count: 1)
            roomFilterItem(count: 2)
            roomFilterItem(count: 3)
            roomFilterItem(count: 4)
            Spacer()
        }
    }

    @ViewBuilder private func roomFilterItem(count: Int) -> some View {
        var text = "\(count)"
        if count == 0 {
            text = "Студия"
        }
        if count == 4 {
            text = "4+"
        }

        return Text(text)
            .padding(10)
            .background(
                viewModel.filter.rooms.contains(count) ? ColorsProvider.primaryContainer : .white
            )
            .cornerRadius(10)
            .onTapGesture {
                if viewModel.filter.rooms.contains(count) {
                    viewModel.filter.rooms.remove(count)
                }
                else {
                    viewModel.filter.rooms.insert(count)
                }
            }
    }

    @ViewBuilder private func sliderView(
        text: String,
        value: Binding<Float>,
        caption: String,
        range: ClosedRange<Float>
    ) -> some View {
        VStack {
            HStack {
                Text(text)
                Spacer()
                Text("\(Int(value.wrappedValue)) \(caption)")
            }
            Slider(
                value: value,
                in: range,
                step: 1,
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

    @ViewBuilder private func priceSliderView(
        text: String,
        value: Binding<Float>,
        caption: String,
        step: Float = 1,
        range: ClosedRange<Float>
    ) -> some View {
        let labelText: (Float) -> String = { value in
            "\(Int(value).formatedForPrice)"
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
                        .font(.caption)
                },
                maximumValueLabel: {
                    Text(labelText(range.upperBound))
                        .font(.caption)
                }
            )
            .tint(ColorsProvider.primary)
        }
    }
}

struct FlatsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FlatsListView(
                viewModel: ViewModelMock(),
                router: EmptyViewRouterMock(),
                title: "Квартиры",
                showFilters: true
            )
        }
    }

    private final class ViewModelMock: FlatsListViewModel {
        var filter = Filters(price: .init(minPrice: 0, maxPrice: 0))

        var flats: [FlatModel] = [
            FlatModel(
                price: 3_878_677,
                rooms: 1,
                number: 1,
                area: 21.8,
                floor: 13,
                finishing: "4 кв. 2024",
                images: [
                    ImagesProvider.flatLayout(id: 1),
                    ImagesProvider.floorLayout(id: 1)
                ],
                isFavourite: false
            )
        ]

        var navigationRoute: FlatsListRoute? = nil

        func onUserDidSelectFlat(flat: FlatModel) {}
        
        func userDidChangeFavourite(flat: FlatModel) {}
    }
}
