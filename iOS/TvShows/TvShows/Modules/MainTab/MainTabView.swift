import SwiftUI

struct MainTabView: View {

    @State var title = ShowsType.shows.title
    @StateObject var appRouter = AppRouter()

    var body: some View {
        TabView(selection: $title) {
            ShowsView(showsViewModel: .init(type: .shows))
                .tabItem {
                    TabItem.shows
                }
                .tag(ShowsType.shows.title)
            ShowsView(showsViewModel: .init(type: .topRated))
                .tabItem {
                    TabItem.topRated
                }
                .tag(ShowsType.topRated.title)
        }
        .navigationTitle(title)
        .toolbar {
            Image(with: .user)
                .onTapGesture {
                    appRouter.selectedSettings = true
                }
        }
    }

}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
