import SwiftUI

struct ShowDetails: View {

    let show: ShowModel
    let reviews: [ReviewModel]

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                content

                if reviews.isEmpty {
                    Text("No reviews yet.")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.gray)
                }

                Button("Write a Review") {
                }
                .frame(width: proxy.size.width - 40, height: 48)
                .background(Color(.backgroundViolet))
                .foregroundColor(.white)
                .cornerRadius(24)
            }
        }
    }

    @ViewBuilder
    var content: some View {
        LazyVStack(alignment: .leading, spacing: 20) {
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

            Text("\(show.reviewCount) REVIEWS, \(show.averageRating) AVERAGE")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(Color.gray)

            ForEach(reviews) { review in
                Review(review: review)
            }
        }
        .padding(20)
    }

}

struct ShowDetails_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetails(show: ShowModel.testModel, reviews: [.testModel, .testModel, .testModel])
    }
}
