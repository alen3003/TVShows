import SwiftUI

struct Settings: View {

    let member: MemberModel

    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text(member.email)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.black)

            userProfileView

            Button("Logout") {
                AppModule.shared.popToRoot()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(Color(.backgroundViolet))
            .foregroundColor(.white)
            .cornerRadius(24)

            Spacer()
        }
        .padding()
    }

    @ViewBuilder
    var userProfileView: some View {
        HStack(alignment: .center) {
            ImageView(url: member.imageUrl, backgroundImage: .userFilled)
                .frame(width: 100, height: 100)
            Button("Change Profile Photo") {
            }
            .foregroundColor(Color(.backgroundViolet))
        }
    }

}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(member: .testModel)
    }
}
