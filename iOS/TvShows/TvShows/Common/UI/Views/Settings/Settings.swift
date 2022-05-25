import SwiftUI

struct Settings: View {

    @Environment(\.presentationMode) var presentationMode
    let member = MemberModel.getMe()

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("My Account")
                .foregroundColor(.black)
                .font(.system(size: 17, weight: .semibold))
                .frame(maxWidth: .infinity, maxHeight: 50)

            VStack(alignment: .leading, spacing: 25) {
                Text(member.email)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.black)

                userProfileView

                Button(
                    action: {
                        presentationMode.wrappedValue.dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            AppModule.shared.eraseAndPopToRoot()
                        }
                    },
                    label: {
                        Text("Logout")
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(Color(.backgroundViolet))
                            .foregroundColor(.white)
                            .cornerRadius(24)
                    }
                )

                Spacer()
            }
            .padding()
        }
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
        Settings()
    }
}
