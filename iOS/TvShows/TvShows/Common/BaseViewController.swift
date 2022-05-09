import UIKit

class BaseViewController: UIViewController {

    var transientView: TransientView!

    override func viewDidLoad() {
        super.viewDidLoad()

        buildTransientView()
    }

    private func buildTransientView() {
        transientView = TransientView()
        view.addSubview(transientView)

        transientView.isHidden = true
        transientView.pinToSuperview()
    }

    func showTransientView() {
        view.bringSubviewToFront(transientView)
        transientView.startAnimating()
        UIView.animate(
            withDuration: 0.4,
            animations: {
                self.transientView.isHidden = false
            }
        )
    }

    func hideTransientView() {
        transientView.stopAnimating()
        UIView.animate(
            withDuration: 0.4,
            animations: {
                self.transientView.isHidden = true
                self.view.sendSubviewToBack(self.transientView)
            }
        )
    }

}
