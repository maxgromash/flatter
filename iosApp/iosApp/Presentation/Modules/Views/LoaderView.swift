import SwiftUI

struct LoaderView: View {
    var body: some View {
        VStack {
            HStack { Spacer() }
            Spacer()
            ProgressView()
                .progressViewStyle(.circular)
                .padding(20)
                .background(.white)
                .cornerRadius(15)
                .tint(ColorsProvider.primary)
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .background(ColorsProvider.primaryContainer.opacity(0.4))
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LoaderView()
        }
        .background(.red)
    }
}
