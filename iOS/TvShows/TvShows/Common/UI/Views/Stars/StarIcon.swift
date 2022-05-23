import SwiftUI

enum StarIcon: View {

    case normal
    case filled

    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .foregroundColor(Color(.backgroundViolet))
            .frame(maxWidth: 22, maxHeight: 22)
    }

    var image: Image {
        switch self {
        case .normal:
            return Image(systemName:"star")
        case .filled:
            return Image(systemName:"star.fill")
        }
    }

}
