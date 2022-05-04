import UIKit

extension UIImage {

    convenience init(with bundleImage: BundleImage) {
        self.init(named: bundleImage.rawValue)!
    }

    convenience init?(with bundleImage: BundleImage?) {
        guard let name = bundleImage?.rawValue else { return nil }

        self.init(named: name)
    }

}
