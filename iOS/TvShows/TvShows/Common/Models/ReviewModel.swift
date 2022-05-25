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
