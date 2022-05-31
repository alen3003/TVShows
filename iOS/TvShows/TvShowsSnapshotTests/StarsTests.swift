import XCTest
import SnapshotTesting
import SwiftUI
@testable import TvShows

class StarsTests: XCTestCase {

    var pallete: some View {
        VStack(spacing: 8) {
            ForEach(0...5, id: \.self) { rate in
                Stars(rate: rate)
            }
        }
    }

    func testStars() throws {
        assertSnapshot(matching: pallete, as: .image(layout: .device(config: .iPhone12)))
    }

}
