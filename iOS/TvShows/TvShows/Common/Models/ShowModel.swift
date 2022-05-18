struct ShowModel: Identifiable, Decodable, Hashable {

    let id: String
    let title: String
    let showDescription: String
    let imageUrl: String
    let averageRating: Int
    let reviewCount: Int

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

}

extension ShowModel {

    static var testModel: ShowModel {
        ShowModel(
            id: "",
            title: "The Office",
            showDescription: """
                The Office is an American mockumentary sitcom television series that depicts the everyday work lives of
                office employees in the Scranton, Pennsylvania, branch of the fictional Dunder Mifflin Paper Company.
                It aired on NBC from March 24, 2005, to May 16, 2013, lasting a total of nine seasons.
            """,
            imageUrl: "",
            averageRating: 0,
            reviewCount: 0
        )
    }

}
