import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = createInitialWindow()

        return true
    }

    func createInitialWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = LoginWireframe().viewController
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
        return window
    }

}
