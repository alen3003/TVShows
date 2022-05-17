import SwiftUI

extension Image {

    init?(with bundleImage: BundleImage?) {
        guard let bundleImage = bundleImage else { return nil }

        self.init(bundleImage.rawValue)
    }

}
