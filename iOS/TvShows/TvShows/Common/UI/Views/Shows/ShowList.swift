import SwiftUI

struct ShowList: View {

    let shows: [ShowModel]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 5) {
                ForEach(shows) { show in
                    ShowCard(showModel: show)
                }
            }
        }
    }

}

struct ShowList_Previews: PreviewProvider {
    static var previews: some View {
        ShowList(shows: [ShowModel.testModel])
    }
}
