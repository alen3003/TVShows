import Foundation
import RxSwift
import RxCocoa

final class LoginPresenter {

    // MARK: - Private properties -

    private unowned let view: LoginViewInterface
    private let interactor: LoginInteractorInterface
    private let wireframe: LoginWireframeInterface

    // MARK: - Lifecycle -

    init(
        view: LoginViewInterface,
        interactor: LoginInteractorInterface,
        wireframe: LoginWireframeInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension LoginPresenter: LoginPresenterInterface {

    func configure(with output: Login.ViewOutput) -> Login.ViewInput {
        let areButtonsAvailable = onButtonsAvailable(email: output.email, password: output.password)

        return Login.ViewInput(areButtonsAvailable: areButtonsAvailable)
    }
}

extension LoginPresenter {
    // TODO: Implement onButtonsAvailable
    func onButtonsAvailable(email: Driver<String?>, password: Driver<String?>) -> Driver<Bool> {
        .never()
    }
}
