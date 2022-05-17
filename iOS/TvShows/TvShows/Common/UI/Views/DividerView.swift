import UIKit

class DividerView: CustomView {

    enum DividerAxis {
        case vertical
        case horizontal
    }

    let axis: DividerAxis
    let thickness: CGFloat
    let color: UIColor

    init(
        axis: DividerAxis = .horizontal,
        thickness: CGFloat = 1.0,
        color: UIColor = .white
    ) {
        self.axis = axis
        self.thickness = thickness
        self.color = color
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupLayout() {
    }

    override func styleViews() {
        backgroundColor = color
    }

    override func setupConstraints() {
        switch axis {
        case .vertical:
            widthAnchor.constraint(equalToConstant: thickness).isActive = true
        case .horizontal:
            heightAnchor.constraint(equalToConstant: thickness).isActive = true
        }
    }

}
