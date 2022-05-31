import XCTest
import SnapshotTesting
import SwiftUI
@testable import TvShows

class ReviewListTests: XCTestCase {

    var pallete: some View {
        ScrollView {
            LazyVStack {
                ForEach(0...10, id: \.self) { id in
                    let text = String(repeating: "Hello there", count: id)
                    let member = MemberModel(id: "\(id)", email: text, imageUrl: "")
                    let reviewModel = ReviewModel(id: "\(id)", comment: text, rating: id % 5, showId: id, user: member)
                    Review(review: reviewModel)
                }
            }
        }
    }

    func testReviewList() throws {
        assertSnapshot(matching: pallete, as: .image(layout: .device(config: .iPhone12)))
    }

}
