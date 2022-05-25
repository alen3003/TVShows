class PaginatedResult {

    // Tells if all items have been loaded
    var shouldFetchNextPage: Bool

    // Tracks last page loaded. Used to load next page (current + 1)
    var currentPage: Int

    // Limit of items per page
    let itemsPerPage: Int

    init(startingPage: Int, itemsPerPage: Int) {
        self.shouldFetchNextPage = false
        self.currentPage = startingPage
        self.itemsPerPage = itemsPerPage
    }

    func increaseCurrentPage() {
        currentPage += 1
    }

    func setShouldFetchNextPage(_ value: Bool) {
        shouldFetchNextPage = value
    }

}
