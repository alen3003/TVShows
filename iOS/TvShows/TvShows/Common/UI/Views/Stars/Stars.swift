import SwiftUI

struct Stars: View {

    let rate: Int

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            ForEach(0..<rate, id: \.self) { _ in
                Image(systemName:"star.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color(.backgroundViolet))
                    .frame(maxWidth: 22, maxHeight: 22)
            }
            ForEach(rate..<5, id: \.self) { _ in
                Image(systemName:"star")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color(.backgroundViolet))
                    .frame(maxWidth: 22, maxHeight: 22)
            }
        }
    }

}

struct Stars_Previews: PreviewProvider {
    static var previews: some View {
        Stars(rate: 3)
    }
}
