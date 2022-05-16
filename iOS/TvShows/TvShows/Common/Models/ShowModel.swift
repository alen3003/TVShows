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
            image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-12-family-select-2021?wid=940&hei=1112&fmt=jpeg&qlt=90&.v=1617135051000",
            averageRating: 0,
            reviewNumber: 0
        )
    }

}
