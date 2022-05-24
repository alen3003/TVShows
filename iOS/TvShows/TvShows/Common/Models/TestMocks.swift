extension MemberModel {

    static var testModel: MemberModel {
        MemberModel(id: "", email: "sebalj.alen@gmail.com", imageUrl: "")
    }

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

extension ReviewModel {

    static var testModel: ReviewModel {
        let user = MemberModel(id: "8", email: "john7@example.com", imageUrl: nil)
        return ReviewModel(id: "9", comment: "This is a cool Tv Show", rating: 4, showId: 5, user: user)
    }

}
