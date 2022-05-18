import SwiftUI

struct ShowsView: View {

    @StateObject var appRouter = AppRouter()
    @StateObject private var showsViewModel = ShowsViewModel()

    var body: some View {
        switch showsViewModel.result {
        case .success(let shows):
            ShowList(shows: shows)
                .navigationTitle("Shows")
                .toolbar {
                    Image(with: .user)
                }
                .environmentObject(appRouter)
        case .failure:
            Text("Something went wrong. Try again later")
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
