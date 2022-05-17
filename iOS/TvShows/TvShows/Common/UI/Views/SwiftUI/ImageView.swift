import Kingfisher
import SwiftUI

struct ImageView: View {

    let url: String?
    let backgroundImage: BundleImage?

    var body: some View {
        KFImage(URL(string: url ?? ""))
            .placeholder { Image(with: backgroundImage) }
            .resizable()
    }

}

struct ImageView_Previews: PreviewProvider {

    static var previews: some View {
        ImageView(url: "", backgroundImage: .showBackground)
    }

}
