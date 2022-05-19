import SwiftUI

struct ShowDetailsView: View {

    let show: ShowModel

    var body: some View {
        ShowDetails(show: show)
            .navigationBarTitle(show.title, displayMode: .automatic)
    }

}

struct ShowDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetailsView(show: ShowModel.testModel)
    }
}
