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

    func setupView() {
        let output = Login.ViewOutput(
            login: .just(()),
            register: .just(()),
            rememberMe: .just(false),
            email: .just(nil),
            password: .just(nil)
        )

        let input = presenter.configure(with: output)
        areButtonsEnabled(areEnabled: input.areButtonsAvailable)
    }

}

private extension LoginViewController {

    func areButtonsEnabled(areEnabled: Driver<Bool>) {

    }
}
