import UIKit

class BaseButton: UIButton {

    override var isEnabled: Bool {
        didSet {
            isUserInteractionEnabled = isEnabled
            alpha = isEnabled ? 1 : 0.3
        }
    }

}
