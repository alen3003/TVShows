import Foundation
import RxSwift

final class LoginInteractor {
}

// MARK: - Extensions -

extension LoginInteractor: LoginInteractorInterface {
    func login(with email: String, _ password: String) -> Completable {
        .empty()
    }

    func register(with email: String, _ password: String) -> Completable {
        .empty()
    }
}
