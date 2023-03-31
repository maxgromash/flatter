import SwiftUI

struct ProjectsListCard: View {
    let project: ProjectModel

    var body: some View {
        VStack(spacing: 1) {
            Image(uiImage: project.image)
                .resizable()
                .frame(height: 200)
                .scaledToFill()
                .cornerRadius(10)
            projectDescription

            Divider()
                .padding(.vertical, 10)
            priceBlock
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(.white)
        .cornerRadius(10)
    }

    @ViewBuilder private var projectDescription: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                }
                Text(project.title)
                    .foregroundColor(.black)
                    .font(.title)
                Text(project.address.address)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .padding(.horizontal, 3)
            .background(.white)
            ImagesProvider.rightArrow
        }
    }

    @ViewBuilder private var priceBlock: some View {
        HStack {
            Text("Цены")
            Spacer()
            Text("от \(String(format: "%.1f", project.minFlatPrice)) млн. руб.")
        }
    }
}

struct ProjectsListCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ProjectsListCard(
                project: .init(
                    title: "Демонстрационный",
                    image: ImagesProvider.firstDubrovskiy,
                    address: .init(
                        address: "г. Москва, ул. Демонстрационная",
                        coordinates: .init(latitude: 1, longitude: 1)
                    ),
                    minFlatPrice: 1,
                    nearestTransports: []
                )
            )
            .frame(maxWidth: 400)
        }
        .padding(10)
        .background(.black)
        .previewLayout(.sizeThatFits)
    }
}
