import SwiftUI

struct SettingsView: View {

    let member = MemberModel(id: "", email: "sebalj.alen@gmail.com", imageUrl: "")

    var body: some View {
        Settings(member: member)
    }

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
