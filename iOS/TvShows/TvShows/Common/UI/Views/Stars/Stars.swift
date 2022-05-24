import SwiftUI

struct Stars: View {

    let rate: Int

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            ForEach(0..<rate, id: \.self) { _ in
                StarIcon.filled
            }
            ForEach(rate..<5, id: \.self) { _ in
                StarIcon.normal
            }
        }
    }

}

struct Stars_Previews: PreviewProvider {
    static var previews: some View {
        Stars(rate: 3)
    }
}
