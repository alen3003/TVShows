import Combine

typealias CompletableCombine<Failure: Error> = AnyPublisher<Never, Failure>

extension CompletableCombine {

    static func from(_ action: @escaping () -> Void) -> CompletableCombine<Never> {
        Deferred<Empty<Never, Never>> {
            action()
            return Empty<Never, Never>()
        }.eraseToAnyPublisher()
    }

}

extension CompletableCombine {

    func run(in store: inout Set<AnyCancellable>) {
        sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &store)
    }

}

extension CompletableCombine where Output == Never {

    func sink(receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void) -> AnyCancellable {
        sink(receiveCompletion: receiveCompletion, receiveValue: { _ in })
    }

}

extension CompletableCombine where Failure == Never {

    static func empty() -> CompletableCombine<Never> {
        from { }
    }

    static func never() -> CompletableCombine<Never> {
        Deferred<Future<Never, Never>> {
            Future<Never, Never> { _ in }
        }.eraseToAnyPublisher()
    }

}

extension Publisher {

    func asCompletable() -> CompletableCombine<Failure> {
        ignoreOutput()
            .eraseToAnyPublisher()
    }

}
