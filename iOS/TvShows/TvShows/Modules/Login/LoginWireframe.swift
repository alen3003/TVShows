import UIKit
import RxSwift
import RxCocoa
import SwiftUI

final class LoginWireframe: BaseWireframe<LoginViewController> {

    // MARK: - Private properties -

    // MARK: - Module setup -

    init() {
        let moduleViewController = LoginViewController()
        super.init(viewController: moduleViewController)

        let interactor = LoginInteractor()
        let presenter = LoginPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension LoginWireframe: LoginWireframeInterface {
    func navigateToHome() {
        let showListView = ShowsView()
        let viewController = UIHostingController(rootView: showListView)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setViewControllers([viewController], animated: true)
    }
}
