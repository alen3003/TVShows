import Foundation
import RxSwift

final class LoginInteractor {

    let userService: UserService

    init(userService: UserService = .shared) {
        self.userService = userService
    }

}

// MARK: - Extensions -

extension LoginInteractor: LoginInteractorInterface {
    func login(with email: String, _ password: String) -> Single<Member> {
        userService
            .login(with: email, password)
            .map { $0.user }
    }

    func register(with email: String, _ password: String) -> Single<Member> {
        userService
            .register(with: email, password)
            .map { $0.user }
    }
}
