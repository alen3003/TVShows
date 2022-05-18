import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let navigationController = UINavigationController()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        guard let window = window else { return false }

        if shouldShowHome {
            let viewController = UIHostingController(rootView: ShowsView())
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.setViewControllers([viewController], animated: false)
        } else {
            let viewController = LoginWireframe().viewController
            navigationController.setViewControllers([viewController], animated: false)
        }

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return true
    }

}

private extension AppDelegate {

    var shouldShowHome: Bool {
        UserDefaults.standard.string(forKey: Constants.UserDefaults.token) != nil
    }

}
