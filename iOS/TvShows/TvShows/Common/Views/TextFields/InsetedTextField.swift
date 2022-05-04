import UIKit

class InsetedTextField: UITextField {

    var insets: UIEdgeInsets!

    convenience init(insets: UIEdgeInsets) {
        self.init()

        self.insets = insets
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)

        rect.origin.x += insets.left
        return rect
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)

        rect.origin.x -= insets.right
        return rect
    }

}
