import UIKit

extension BaseWireframe: Progressable {

    private var hudParentView: UIView {
        return viewController.view
    }

    // MARK: - Public methods -

    // MARK: - Show/hide

    func showLoading() {
        showLoading(blocking: true)
    }

    func hideLoading() {
        hideLoading(blocking: true)
    }

    // MARK: - Show/hide with blocking state

    func showLoading(blocking: Bool) {
        hideTransientViewIfExists()

        let transientView = TransientView()
        hudParentView.addSubview(transientView)
        transientView.pinToSuperview()
        transientView.isUserInteractionEnabled = blocking
        transientView.startAnimating()
    }

    func hideLoading(blocking: Bool) {
        hideTransientViewIfExists()
    }

    // MARK: - Failure handling

    func showFailure(with error: Error) {
        showFailure(with: nil, message: error.localizedDescription)
    }

    func showFailure(with title: String?, message: String?) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .cancel))
        viewController.present(alertView, animated: true)
    }

    // MARK: - Private methods

    private func hideTransientViewIfExists() {
        hudParentView
            .subviews
            .filter { $0 is TransientView }
            .forEach { $0.removeFromSuperview() }
    }
}
