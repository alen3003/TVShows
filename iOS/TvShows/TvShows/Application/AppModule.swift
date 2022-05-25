import SwiftUI
import UIKit

class AppModule {

    static let shared = AppModule()

    private let navigationController = UINavigationController()

    private init() {
        navigationController.navigationBar.prefersLargeTitles = true
    }

    func start(in window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        startApp()
    }

    func eraseAndPopToRoot() {
        removeUserDefaultsData()
        startApp()
    }

}

private extension AppModule {

    var shouldShowHome: Bool {
        UserDefaults.standard.string(forKey: Constants.UserDefaults.token) != nil
    }

    private func startApp() {
        if shouldShowHome {
            let mainTab = MainTabView()
            let viewController = UIHostingController(rootView: mainTab)
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.setViewControllers([viewController], animated: true)
        } else {
            let viewController = LoginWireframe().viewController
            navigationController.setViewControllers([viewController], animated: true)
        }
    }

    private func removeUserDefaultsData() {
        UserDefaults.standard.set(nil, forKey: Constants.UserDefaults.token)
        UserDefaults.standard.set(nil, forKey: Constants.UserDefaults.expiry)
        UserDefaults.standard.set(nil, forKey: Constants.UserDefaults.client)
        UserDefaults.standard.set(nil, forKey: Constants.UserDefaults.uid)
    }

}
