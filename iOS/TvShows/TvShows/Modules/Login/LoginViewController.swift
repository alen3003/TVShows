import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: BaseViewController {

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
    func showTransient() {
        showTransientView()
    }

    func hideTransient() {
        hideTransientView()
    }
}

private extension LoginViewController {
    func setupView() {
        let output = Login.ViewOutput(
            login: loginView.loginButton.rx.tap.asSignal(),
            register: loginView.registerButton.rx.tap.asSignal(),
            rememberMe: .never(),
            email: loginView.emailTextField.rx.text.asDriver(),
            password: loginView.passwordTextField.rx.text.asDriver()
        )

        let input = presenter.configure(with: output)
        handle(areActionsAvailable: input.areButtonsAvailable)
    }

}

private extension LoginViewController {

    func handle(areActionsAvailable: Driver<Bool>) {
        areActionsAvailable
            .drive(loginView.loginButton.rx.isEnabled)
            .disposed(by: disposeBag)

        areActionsAvailable
            .drive(loginView.registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
