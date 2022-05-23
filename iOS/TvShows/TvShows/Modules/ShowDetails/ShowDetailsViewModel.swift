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
            .map(\.withoutEmpty)
            .asResult()
            .assign(to: &$result)
    }

}

extension Array where Element == ReviewModel {

    var withoutEmpty: [ReviewModel] {
        self
            .filter { !($0.comment?.isEmpty ?? true) }
    }

}
