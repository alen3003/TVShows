import UIKit

public extension UIEdgeInsets {

    static func insets(
        top: CGFloat = .zero,
        left: CGFloat = .zero,
        bottom: CGFloat = .zero,
        right: CGFloat = .zero
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    static func insets(all: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: all, left: all, bottom: all, right: all)
    }

}
