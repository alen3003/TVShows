import UIKit

extension UIStackView {

    func setCustomSpacing(_ spacing: CGFloat, after arrangedSubviews: UIView...) {
        arrangedSubviews.forEach {
            setCustomSpacing(spacing, after: $0)
        }
    }

    func setDefaultMargins() {
        let margin: CGFloat = 20
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: margin, bottom: 0, trailing: margin)
    }

}
