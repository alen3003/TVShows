import UIKit

class TransientView: CustomView {

    let spinnerSize = CGSize(width: 100, height: 100)

    var spinnerView: SpinnerView!

    override func setupLayout() {
        spinnerView = SpinnerView()
        addSubview(spinnerView)
    }

    override func styleViews() {
        backgroundColor = UIColor.neutral1000.withAlphaComponent(0.2)
    }

    override func setupConstraints() {
        spinnerView.centerToSuperview()
        spinnerView.pin(to: spinnerSize)
    }

    func startAnimating() {
        spinnerView.startAnimating()
    }

    func stopAnimating() {
        spinnerView.stopAnimating()
    }

}
