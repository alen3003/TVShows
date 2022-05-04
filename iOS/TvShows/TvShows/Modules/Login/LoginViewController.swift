import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: LoginPresenterInterface!

    // MARK: - Private properties -

    private let disposeBag = DisposeBag()

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func loadView() {
        view = LoginView()
    }

}

// MARK: - Extensions -

extension LoginViewController: LoginViewInterface {
}

private extension LoginViewController {

    func setupView() {
        let output = Login.ViewOutput()

        _ = presenter.configure(with: output)
    }

}
