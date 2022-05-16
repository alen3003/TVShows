import SwiftUI

struct ShowDetailsView: View {

    let show: ShowModel

    var body: some View {
        ShowDetails(show: show)
            .navigationTitle(show.title)
    }

}

struct ShowDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetailsView(show: ShowService.getShows().first!)
    }
}
