import SwiftUI

enum TabItem: View {
    case shows
    case topRated

    var body: some View {
        VStack {
            image
                .renderingMode(.original)
            text
        }
    }

    var image: Image {
        switch self {
        case .shows:
            return Image(systemName: "square.stack.fill")
        case .topRated:
            return Image(systemName: "heart.fill")
        }
    }

    var text: Text {
        switch self {
        case .shows:
            return Text("Shows")
        case .topRated:
            return Text("Top Rated")
        }
    }
}
