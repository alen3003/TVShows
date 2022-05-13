import Kingfisher
import SwiftUI

struct ImageView: View {

    let url: URL?
    let backgroundImage: BundleImage?

    var body: some View {
        KFImage(url)
            .placeholder { Image(with: backgroundImage) }
            .resizable()
    }

}

struct ImageView_Previews: PreviewProvider {

    static var previews: some View {
        ImageView(url: URL(string: ""), backgroundImage: .showBackground)
    }

}
