import Combine

class ShowsViewModel: ObservableObject {

    private let showService = ShowService.shared

    private var disposables = Set<AnyCancellable>()

    @Published private(set) var shows: [ShowModel] = []
    @Published private(set) var error: Error?

    func fetchShows() {
        showService
            .fetchShows()
            .receiveOnMain()
            .map(\.shows)
            .asResult()
            .map { [unowned self] result in
                self.mapToModel(from: result)
            }
            .assign(to: &$shows)
    }

    private func mapToModel(from result: Result<[ShowModel], Error>) -> [ShowModel] {
        switch result {
        case .success(let shows):
            return shows
        case .failure(let error):
            self.error = error
            return []
        }
    }

}
