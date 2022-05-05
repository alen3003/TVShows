import Foundation
import RxSwift

final class LoginInteractor {
}

// MARK: - Extensions -

extension LoginInteractor: LoginInteractorInterface {
    // TODO: Implement Interactor methods
    func login(with email: String, _ password: String) -> Completable {
        .never()
    }

    func register(with email: String, _ password: String) -> Completable {
        .never()
    }
}
