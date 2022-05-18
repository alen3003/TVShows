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
    func login(with email: String, _ password: String) -> Single<MemberModel> {
        userService
            .login(with: email, password)
            .map(\.user)
    }

    func register(with email: String, _ password: String) -> Single<MemberModel> {
        userService
            .register(with: email, password)
            .map(\.user)
    }
}
