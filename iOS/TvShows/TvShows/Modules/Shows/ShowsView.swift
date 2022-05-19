import SwiftUI

struct ShowsView: View {

    @StateObject var showsViewModel: ShowsViewModel

    var body: some View {
        switch showsViewModel.result {
        case .success(let shows):
            ShowList(shows: shows)
        case .failure:
            Text("Something went wrong. Try again later")
        }
    }

}

struct ShowsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ShowsView(showsViewModel: .init(type: .shows))
        }
    }
}
