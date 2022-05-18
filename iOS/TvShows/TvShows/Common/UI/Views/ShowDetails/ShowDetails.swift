import SwiftUI

struct ShowDetails: View {

    let show: ShowModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ImageView(url: show.imageUrl, backgroundImage: .showBackground)
                    .scaledToFill()
                    .frame(height: 350)
                    .clipped()
                    .cornerRadius(10)

                Text(show.showDescription)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.black)

                Text("Reviews")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
            }
            .padding(20)
        }
    }

}

struct ShowDetails_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetails(show: ShowModel.testModel)
    }
}
