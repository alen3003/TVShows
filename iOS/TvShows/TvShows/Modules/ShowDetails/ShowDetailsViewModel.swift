import Combine

class ShowDetailsViewModel: ObservableObject {

    private let showService = ShowService.shared
    
    @Published private(set) var result: Result<[ReviewModel], Error> = .success([])

    init(showId: String) {
        fetchShowReviews(showId: showId)
    }

    private func fetchShowReviews(showId: String) {
        showService
            .fetchReviews(showId: showId)
            .receiveOnMain()
            .map(\.reviews)
            .map { [unowned self] reviews in
                self.removeEmpty(from: reviews)
            }
            .asResult()
            .assign(to: &$result)
    }

    private func removeEmpty(from reviews: [ReviewModel]) -> [ReviewModel] {
        reviews
            .filter { !($0.comment?.isEmpty ?? true) }
    }

}
