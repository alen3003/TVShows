import SwiftUI

struct Review: View {

    let review: ReviewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .center, spacing: 16) {
                ImageView(url: review.user.imageUrl, backgroundImage: .userFilled)
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 10) {
                    Text(review.user.email)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color.gray)
                    Stars(rate: review.rating)
                }
            }

            VStack(alignment: .leading, spacing: 14) {
                Text(review.comment ?? "")
                    .font(.system(size: 17, weight: .regular))

                Divider()
                    .background(Color.gray)
                    .frame(height: 1)
            }
        }
    }

}

struct Review_Previews: PreviewProvider {
    static var previews: some View {
        Review(review: .testModel)
    }
}
