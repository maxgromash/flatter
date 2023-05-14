import SwiftUI

struct FlatsListCard: View {
    var flat: FlatModel

    let onContentTap: () -> Void
    let onFavouritesTap: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            mainContent
                .onTapGesture(perform: onContentTap)
            favouriteButton
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(.white)
        .cornerRadius(10)
    }

    @ViewBuilder private var mainContent: some View {
        HStack(spacing: 20) {
            Image(uiImage: flat.images.first!)
                .resizable()
                .frame(width: 100)
                .scaledToFit()
            VStack(alignment: .leading) {
                Text("\(flat.price.formatedForPrice) ₽")
                    .font(.title2)
                    .foregroundColor(ColorsProvider.primary)
                Spacer()
                flatParams
                    .padding(.bottom, 5)
                detailedButton
            }
        }
    }

    @ViewBuilder private var flatParams: some View {
        HStack(spacing: 10) {
            HStack(spacing: 1) {
                ImagesProvider.areaIcon
                Text("\(String(format: "%.1f", flat.area)) м2")
                    .font(.caption)
            }
            Text("\(flat.floor) этаж")
                .font(.caption)
            Spacer()
        }
    }

    @ViewBuilder private var detailedButton: some View {
        HStack(alignment: .top) {
            Text("Подробнее")
            Spacer()
            ImagesProvider.rightArrow
        }
    }

    @ViewBuilder private var favouriteButton: some View {
        Button(
            action: { onFavouritesTap() },
            label: {
                favouriteIcon.foregroundColor(ColorsProvider.primary)
            }
        )
    }

    @ViewBuilder private var favouriteIcon: some View {
        flat.isFavourite ? ImagesProvider.favouritesFilledIcon : ImagesProvider.favouritesIcon
    }
}

private extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formatedForPrice: String { Formatter.withSeparator.string(for: self) ?? "" }
}

struct FlatsListCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FlatsListCard(
                flat: FlatModel(
                    id: 1,
                    price: 3_878_677,
                    rooms: 1,
                    number: 1,
                    area: 21.8,
                    floor: 13,
                    trimming: "Чистовая",
                    finishing: "4 кв. 2024",
                    images: [
                        ImagesProvider.flatLayout(id: 1),
                        ImagesProvider.floorLayout(id: 1)
                    ],
                    isFavourite: false
                ),
                onContentTap: {},
                onFavouritesTap: {}
            )
            .frame(height: 100)
        }
        .padding(10)
        .background(.black)
    }
}
