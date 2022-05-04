import UIKit

/// Allows easy setup by overriding 'setupLayout' and/or 'setupConstraints' methods. Additional methods: 'configureHierarchy' and 'configureViews'
class CustomView: UIView {

    override class var requiresConstraintBasedLayout: Bool {
        true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayoutAndConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupLayoutAndConstraints()
    }

    private func setupLayoutAndConstraints() {
        setupLayout()
        styleViews()
        setupConstraints()
    }

    // MARK: - Lifecycle
    /// Method for layouting views from code. The method does nothing as is,
    /// but it is called during the layout cycle has should be used for layouting
    /// your view from code. In short, override this method with your layout code.
    /// You can call super but it is optional.
    func setupLayout() {
        // Method is used for overriding
    }

    /// Style your view
    func styleViews() {

    }

    /// Create  any additional constraints for your cell
    func setupConstraints() {
        // Method is used for overriding
    }
}
