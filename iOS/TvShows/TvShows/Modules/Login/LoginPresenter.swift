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
        return Login.ViewInput()
    }

}
