import Foundation

struct MemberModel: Decodable {

    let id: String
    let email: String
    let imageUrl: String?

}

struct MemberWrapper: Decodable {

    let user: MemberModel

}

extension MemberModel {

    static func getMe() -> MemberModel? {
        guard
            let id = UserDefaults.standard.string(forKey: Constants.UserDefaults.client),
            let email = UserDefaults.standard.string(forKey: Constants.UserDefaults.uid)
        else {
            return nil
        }

        return MemberModel(id: id, email: email, imageUrl: "")
    }

}
