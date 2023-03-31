import SwiftUI
import MapKit

struct ProjectInfoView<
    VM: ProjectInfoViewModel,
    Router: Routing
>: AppView where VM.Route == Router.Route {
    let viewModel: VM
    let router: Router

    @State private var fullDescription = false

    private var projectLocation: MKCoordinateRegion {
        .init(
            center: viewModel.project.address.coordinates,
            span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    }

    var body: some View {
        VStack {
            header
                .frame(height: 150)
            content
                .padding(.top, -30)
            Spacer()
        }
    }

    @ViewBuilder private var header: some View {
        ZStack {
            Image(
                uiImage: viewModel.project.image
            )
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.top)
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.top)
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                }
                projectTitle
                Spacer()
                addressText
                Spacer()
            }
            .padding(.horizontal, 15)
            .padding(.top, 20)
            .padding(.bottom, 60)
        }
    }

    @ViewBuilder private var projectTitle: some View {
        Text(viewModel.project.title)
            .font(.title)
            .foregroundColor(.white)
    }

    @ViewBuilder private var addressText: some View {
        Text(viewModel.project.address.address)
            .font(.caption)
            .foregroundColor(.white)
    }

    @ViewBuilder private var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Spacer()
                }
                flattersNavigationLink
                Divider()
                projectDescription
                Divider()
                projectLocationView
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
        }
        .background(.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }

    @ViewBuilder private var projectDescription: some View {
        VStack(alignment: .leading) {
            Text("Описание проекта")
                .font(.title2)
            Text(viewModel.project.description)
                .font(.callout)
                .foregroundColor(.black)
                .lineLimit(fullDescription ? nil : 5)
            Button(
                fullDescription ? "Скрыть" : "Подробнее",
                action: {
                    withAnimation { fullDescription.toggle() }
                }
            )
            .foregroundColor(ColorsProvider.primary)
        }
    }

    @ViewBuilder private var flattersNavigationLink: some View {
        Button(
            action: viewModel.onUserDidTapSelectFlatButton,
            label: {
                HStack {
                    Text("Смотреть квартиры")
                        .font(.title2)
                        .foregroundColor(.black)
                    Spacer()
                    ImagesProvider.rightArrow
                        .tint(.black)
                }
            }
        )
    }

    @ViewBuilder private var projectLocationView: some View {
        VStack(spacing: 10) {
            Map(
                coordinateRegion: .constant(projectLocation),
                annotationItems: [
                    MapAnnotation(coordinates: viewModel.project.address.coordinates)
                ]) { coord in
                    MapMarker(coordinate: coord.coordinates)
                }
                .frame(height: 150)
                .cornerRadius(15)
                .disabled(true)
            ForEach(viewModel.project.nearestTransports, id: \.name) { nearestTransport in
                TransportDestinationView(
                    color: nearestTransport.color,
                    name: nearestTransport.name,
                    time: nearestTransport.time
                )
            }
        }
    }
}

private struct MapAnnotation: Identifiable {
    let id = UUID()
    let coordinates: CLLocationCoordinate2D
}

struct ProjectInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProjectInfoView(
                viewModel: ViewModelMock(),
                router: EmptyViewRouterMock()
            )
        }
    }

    private final class ViewModelMock: ProjectInfoViewModel {
        let project: ProjectModel = .init(
            title: "Демонстрационный",
            image: ImagesProvider.firstDubrovskiy,
            address: .init(
                address: "г. Москва, ул. Демонстрационная",
                coordinates: .init(latitude: 1, longitude: 1)
            ),
            minFlatPrice: 1,
            nearestTransports: []
        )

        var navigationRoute: ProjectInfoRoute? = nil

        func onUserDidTapSelectFlatButton() {}
    }
}
