import SwiftUI

struct ShowsView: View {

    @StateObject private var showsViewModel = ShowsViewModel()

    var body: some View {
        ShowList(shows: showsViewModel.shows)
            .navigationTitle("Shows")
            .toolbar {
                Image(with: .user)
            }
            .onAppear {
                showsViewModel.fetchShows()
            }
    }

}

struct ShowsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ShowsView()
        }
    }
}
