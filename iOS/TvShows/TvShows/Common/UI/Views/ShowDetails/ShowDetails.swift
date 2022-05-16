import SwiftUI

struct ShowDetails: View {

    let show: ShowModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ImageView(url: URL(string: show.image), backgroundImage: .showBackground)
                    .scaledToFill()
                    .padding(20)
                    .frame(height: 350)
                    .cornerRadius(10)
                    .clipped()

                Text(show.showDescription)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.black)
                    .padding([.leading, .trailing], 20)

                Text("Reviews")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .padding([.leading, .trailing], 20)
            }
        }
    }

}

struct ShowDetails_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetails(show: ShowService.getShows().first!)
    }
}
