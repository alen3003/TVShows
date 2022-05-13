import Combine

typealias SingleCombine<Output, Failure: Error> = AnyPublisher<Output, Failure>

extension SingleCombine {

    static func from(
        _ outerPromise: @escaping ((Result<Output, Failure>) -> Void) -> Void
    ) -> SingleCombine<Output, Failure> {
        Deferred<Future<Output, Failure>> {
            Future<Output, Failure> { promise in
                outerPromise(promise)
            }
        }.eraseToAnyPublisher()
    }

    static func error(error: Failure) -> SingleCombine<Output, Failure> {
        Deferred<Fail<Output, Failure>> {
            Fail<Output, Failure>(error: error)
        }.eraseToAnyPublisher()
    }

    static func just(output: Output) -> SingleCombine<Output, Failure> {
        Deferred<AnyPublisher<Output, Failure>> {
            Just(output).setFailureType(to: Failure.self).eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }

    static func never() -> SingleCombine<Output, Failure> {
        Deferred<Empty<Output, Failure>> {
            Empty<Output, Failure>(completeImmediately: false)
        }.eraseToAnyPublisher()
    }

}

extension Publisher {

    func asSingle() -> SingleCombine<Output, Failure> {
        prefix(1)
            .eraseToAnyPublisher()
    }

}
