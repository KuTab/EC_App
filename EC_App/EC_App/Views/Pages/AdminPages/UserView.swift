import SwiftUI

struct UserView: View {
    @Binding var user: User
    @State var isEditing: Bool = false
    @Binding var refetch: Bool
    @State var mediaLink: String
    var body: some View {
        VStack {
            ZStack {
                Text("Профиль")
                    .bold()
                    .font(.system(size: 25))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Button {
                    isEditing.toggle()
                } label: {
                    Image(systemName: "pencil")
                }.frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                
            }
            if(isEditing) {
                TextField("", text: $user.firstName)
                    .frame(alignment: .leading)
                    .padding()
                TextField("", text: $user.lastName)
                    .frame(alignment: .leading)
                    .padding()
                TextField("", text: $user.email)
                    .frame(alignment: .leading)
                    .padding()
                TextField("", text: $user.username)
                    .frame(alignment: .leading)
                    .padding()
                TextField("", text: $mediaLink)
                    .frame(alignment: .leading)
                    .padding()
            } else {
                Text(user.firstName)
                    .frame(alignment: .leading)
                Text(user.lastName)
                    .frame(alignment: .leading)
                Text(user.email)
                    .frame(alignment: .leading)
                Text(user.username)
                    .frame(alignment: .leading)
                Text(mediaLink)
                    .frame(alignment: .leading)
            }
            
            Button {
                if isEditing {
                    saveChanges()
                }
                isEditing.toggle()
            } label: {
                Text(isEditing ? "Сохранить" : "Редактировать")
                
            }.padding()
                .buttonStyle(.bordered)
        }
    }
    
    private func saveChanges() {
        let user = RedactedUser(firstName: user.firstName, lastName: user.lastName, username: user.username, mediaLink: mediaLink)
        APIManger.shared.updateUserRequest(user: user, email: self.user.email) { result in
            switch result {
            case .success(_):
                print("updated user")
                refetch = true
            case .failure(let error):
                print(error)
            }
        }
    }
}

