import Foundation

class AuthInterceptor: RequestInterceptorProtocol {

    private let userDefaults = UserDefaults.standard

    var interceptHeaders: [String: String] {
        guard
            let token = userDefaults.string(forKey: Constants.UserDefaults.token),
            let client = userDefaults.string(forKey: Constants.UserDefaults.client),
            let expiry = userDefaults.string(forKey: Constants.UserDefaults.expiry),
            let uid = userDefaults.string(forKey: Constants.UserDefaults.uid)
        else {
            return [:]
        }

        return [
            "access-token" : token,
            "uid" : uid,
            "client" : client,
            "expiry" : expiry
        ]
    }

}
