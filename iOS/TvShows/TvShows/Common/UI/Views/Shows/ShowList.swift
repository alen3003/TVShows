import SwiftUI

struct ShowList: View {

    @StateObject var appRouter = AppRouter()
    let shows: [ShowModel]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 5) {
                ForEach(shows) { show in
                    ShowCard(showModel: show)
                        .onTapGesture {
                            appRouter.selectedShow = show
                        }

                    NavigationLink(
                        tag: show,
                        selection: $appRouter.selectedShow,
                        destination: {
                            ShowDetailsView(viewModel: .init(showId: show.id), show: show)
                        },
                        label: { EmptyView() }
                    )
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
