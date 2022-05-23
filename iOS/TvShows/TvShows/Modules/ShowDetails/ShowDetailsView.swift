import SwiftUI

struct ShowDetailsView: View {

    @ObservedObject var viewModel: ShowDetailsViewModel
    let show: ShowModel

    var body: some View {
        switch viewModel.result {
        case .success(let reviews):
            ShowDetails(show: show, reviews: reviews)
                .navigationBarTitle(show.title, displayMode: .automatic)
        case .failure:
            Text("Something went wrong. Try again later")
        }
    }

}

struct ShowDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ShowDetailsViewModel(showId: "")
        ShowDetailsView(viewModel: viewModel, show: ShowModel.testModel)
    }
}
