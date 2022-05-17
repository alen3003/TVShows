import SwiftUI

struct ShowCard: View {

   let showModel: ShowModel

    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 24) {
                ImageView(url: showModel.image, backgroundImage: .showBackground)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(4)
                Text(showModel.title)
                    .foregroundColor(.black)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 115)
            .padding([.leading, .trailing], 16)

            Divider()
                .background(Color.gray)
                .padding(.leading, 18)
                .frame(height: 1)
        }
    }
}

struct ShowCard_Previews: PreviewProvider {
    static var previews: some View {
        ShowCard(showModel: ShowModel.testModel)
    }
}
