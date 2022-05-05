import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: LoginPresenterInterface!

    // MARK: - Private properties -
    private let loginView = LoginView()
    private let disposeBag = DisposeBag()

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func loadView() {
        view = loginView
    }

}

// MARK: - Extensions -

extension LoginViewController: LoginViewInterface {
}

private extension LoginViewController {
    // TODO: Implement setupView method for LoginViewController
    func setupView() {
        let output = Login.ViewOutput(
            login: .never(),
            register: .never(),
            rememberMe: .never(),
            email: .never(),
            password: .never()
        )

        let input = presenter.configure(with: output)
        areButtonsEnabled(areEnabled: input.areButtonsAvailable)
    }

}

private extension LoginViewController {

    func areButtonsEnabled(areEnabled: Driver<Bool>) {
    }
}
