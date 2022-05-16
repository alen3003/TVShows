struct MemberModel: Decodable {

    let id: String
    let email: String
    let imageUrl: String?

}

struct MemberWrapper: Decodable {

    let user: MemberModel

}
