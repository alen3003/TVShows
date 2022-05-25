struct ShowModel: Identifiable, Decodable, Hashable, Equatable {

    let id: String
    let title: String
    let showDescription: String
    let imageUrl: String
    let averageRating: Int
    let reviewCount: Int

    static func == (lhs: ShowModel, rhs: ShowModel) -> Bool {
        lhs.id == rhs.id
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case showDescription = "description"
        case imageUrl
        case averageRating
        case reviewCount = "noOfReviews"
    }

}

struct ShowWrapper: Decodable {

    let shows: [ShowModel]
    let meta: MetaModel?

}
