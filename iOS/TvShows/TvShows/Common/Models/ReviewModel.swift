struct ReviewModel: Identifiable, Decodable {

    let id: String
    let comment: String?
    let rating: Int
    let showId: Int
    let user: MemberModel

}

struct ReviewWrapper: Decodable {

    let reviews: [ReviewModel]

}

extension ReviewModel {

    static var testModel: ReviewModel {
        let user = MemberModel(id: "8", email: "john7@example.com", imageUrl: nil)
        return ReviewModel(id: "9", comment: "This is a cool Tv Show", rating: 4, showId: 5, user: user)
    }

}
