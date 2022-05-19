enum ShowsType {

    case shows
    case topRated

    var title: String {
        switch self {
        case .shows:
            return "Shows"
        case .topRated:
            return "Top rated"
        }
    }

}
