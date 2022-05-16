struct ShowModel: Identifiable, Decodable, Hashable {

    let id: String
    let title: String
    let showDescription: String
    let image: String
    let averageRating: Int
    let reviewNumber: Int

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case showDescription = "description"
        case image = "image_url"
        case averageRating = "average_rating"
        case reviewNumber = "no_of_reviews"
    }

}

struct ShowWrapper: Decodable {

    let shows: [ShowModel]

}
