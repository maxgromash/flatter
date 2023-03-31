import SwiftUI

struct NewsInfoView: View {
    let title: String
    let description: String
    let date: Date
    let image: UIImage?

    private let dateFormater: DateFormatter = {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .none
        formater.locale = .current

        return formater
    }()

    var body: some View {
        VStack {
            header
                .frame(height: 200)
            content
                .padding(.top, -30)
            Spacer()
        }
    }

    @ViewBuilder var header: some View {
        ZStack {
            Image(
                uiImage: image ?? ImagesProvider.newsImagePlaceholder
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
                titleText
                Spacer()
                newsPublishDate
            }
            .padding(.horizontal, 15)
            .padding(.top, 20)
            .padding(.bottom, 60)
        }
    }

    @ViewBuilder var content: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                }
                Text(description)
                    .font(.callout)
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
        }
        .background(.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }

    @ViewBuilder private var titleText: some View {
        Text(title)
            .font(.title)
            .foregroundColor(.white)
            .lineLimit(2)
    }

    @ViewBuilder private var newsPublishDate: some View {
        HStack {
            ImagesProvider.calendar
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
            Text(dateFormater.string(from: date))
                .foregroundColor(.white)
                .font(.subheadline)
        }
    }
}

struct NewsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NewsInfoView(
            title: "Example",
            description: .loremIpsum,
            date: .now,
            image: nil
        )
    }
}

