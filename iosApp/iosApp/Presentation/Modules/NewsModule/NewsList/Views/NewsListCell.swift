import SwiftUI

struct NewsListCell: View {
    let news: NewsModel

    private let dateFormater: DateFormatter = {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .none
        formater.locale = .current

        return formater
    }()

    var body: some View {
        VStack {
            HStack {
                Image(
                    uiImage: news.image
                )
                .resizable()
                .scaledToFit()
                .cornerRadius(15)
                .frame(width: 120)
                VStack(alignment: .leading) {
                    Text(news.publishDate)
                        .font(.caption)
                        .padding(.bottom, 5)
                    Text(news.title)
                        .font(.caption)
                }
                Spacer()
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
        .background(.white)
        .cornerRadius(15)
    }
}

struct NewsListCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NewsListCell(
                news: [NewsModel].mock.first!
            )
        }
        .padding(16)
        .background(.black)
        .previewLayout(.sizeThatFits)
    }
}
