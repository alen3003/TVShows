struct MetaModel: Decodable {

    struct Pagination: Decodable {

        let count: Int
        let page: Int
        let items: Int
        let pages: Int

    }

    let pagination: Pagination

}
