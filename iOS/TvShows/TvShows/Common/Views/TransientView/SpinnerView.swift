import UIKit

class SpinnerView: CustomView {

    private let rotationAnimationKey = "rotationAnimation"
    private let rotationZKey = "transform.rotation.z"

    private var imageView: UIImageView!

    override func setupLayout() {
        imageView = UIImageView()
        addSubview(imageView)
    }

    override func styleViews() {
        imageView.image = UIImage(with: .spinner)
        imageView.contentMode = .scaleAspectFit
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    override func setupConstraints() {

    }

    func startAnimating() {
        isHidden = false
        rotate()
    }

    func stopAnimating() {
        isHidden = true
        removeRotation()
    }

    private func rotate() {
        let rotation = CABasicAnimation(keyPath: rotationZKey)
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1.0
        rotation.isCumulative = true
        rotation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        rotation.repeatCount = Float.greatestFiniteMagnitude
        imageView.layer.add(rotation, forKey: rotationAnimationKey)
    }

    private func removeRotation() {
        imageView.layer.removeAnimation(forKey: rotationAnimationKey)
    }

}
