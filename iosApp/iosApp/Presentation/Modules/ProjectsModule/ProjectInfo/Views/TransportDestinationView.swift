import SwiftUI

struct TransportDestinationView: View {
    let color: Color
    let name: String
    let time: Int

    var body: some View {
        HStack(alignment: .center) {
            Circle()
                .frame(width: 15, height: 15)
                .foregroundColor(color)
            Text(name)
                .allowsTightening(false)
            Line()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                           .frame(height: 1)
            ImagesProvider.walkingPerson
            Text("\(time) мин.")
        }
        .padding(.vertical, 10)
    }
}

private struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct TransportDestinationView_Previews: PreviewProvider {
    static var previews: some View {
        TransportDestinationView(
            color: .purple,
            name: "м. Китай-город",
            time: 5
        )
        .previewLayout(.sizeThatFits)
    }
}
