import UIKit
import RxSwift
import RxCocoa

protocol LoginWireframeInterface: WireframeInterface, Progressable {
    func navigateToHome()
}

protocol LoginViewInterface: ViewInterface {
}

protocol LoginPresenterInterface: PresenterInterface {
    func configure(with output: Login.ViewOutput) -> Login.ViewInput
}

protocol LoginInteractorInterface: InteractorInterface {
    func login(with email: String, _ password: String) -> Single<Member>
    func register(with email: String, _ password: String) -> Single<Member>
}

enum Login {
    struct ViewOutput {
        let login: Signal<Void>
        let register: Signal<Void>
        let rememberMe: Driver<Bool>
        let email: Driver<String?>
        let password: Driver<String?>
    }

    struct ViewInput {
        let areButtonsAvailable: Driver<Bool>
    }
}
