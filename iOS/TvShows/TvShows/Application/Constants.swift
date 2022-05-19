import Foundation

enum Constants {

    enum NetworkConstants {

        static let base = "https://tv-shows.infinum.academy"
        static let login = "/users/sign_in"
        static let register = "/users"
        static let shows = "/shows"
        static let topRated = "/shows/top_rated"

    }

    enum UserDefaults {
        static let remember = "rememberUser"
        static let token = "token"
        static let expiry = "expiry"
        static let client = "client"
        static let uid = "uid"
    }

}
