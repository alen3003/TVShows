import Kingfisher
import SwiftUI

struct ImageView: View {

    let url: String?
    var backgroundImage: BundleImage

    var body: some View {
        KFImage(URL(string: url ?? ""))
            .placeholder {
                Image(with: backgroundImage)
                    .resizable()
            }
            .resizable()
    }

}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: "", backgroundImage: .userFilled)
    }
}
