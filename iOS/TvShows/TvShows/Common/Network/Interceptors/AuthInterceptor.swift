import Foundation

class AuthInterceptor: RequestInterceptorProtocol {

    private let userDefaults = UserDefaults.standard

    private enum AuthHeaders {
        static let accessToken = "access-token"
        static let uid = "uid"
        static let client = "client"
        static let expiry = "expiry"
    }

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
            AuthHeaders.accessToken: token,
            AuthHeaders.uid: uid,
            AuthHeaders.client: client,
            AuthHeaders.expiry: expiry
        ]
    }

    func saveHeaders(from response: HTTPURLResponse?) {
        if
            let token = response?.allHeaderFields[AuthHeaders.accessToken],
            let expiry = response?.allHeaderFields[AuthHeaders.expiry],
            let client = response?.allHeaderFields[AuthHeaders.client],
            let uid = response?.allHeaderFields[AuthHeaders.uid]
        {
            userDefaults.set(token, forKey: Constants.UserDefaults.token)
            userDefaults.set(expiry, forKey: Constants.UserDefaults.expiry)
            userDefaults.set(client, forKey: Constants.UserDefaults.client)
            userDefaults.set(uid, forKey: Constants.UserDefaults.uid)
        }
    }

}

extension AuthInterceptor {

    static func deleteAuthHeaders() {
        UserDefaults.standard.removeObject(forKey: AuthHeaders.accessToken)
        UserDefaults.standard.removeObject(forKey: AuthHeaders.uid)
        UserDefaults.standard.removeObject(forKey: AuthHeaders.expiry)
        UserDefaults.standard.removeObject(forKey: AuthHeaders.client)
    }

}
