import SwiftUI

struct ProfileView: View {
    @State var user: User = User(firstName: "", lastName: "", username: "", email: "", password: "")
    @State var mediaLink: String = ""
    @State var isEditing: Bool = false
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
        }.onAppear(perform: getInfo)
    }
    
    private func getInfo() {
        APIManger.shared.getMeRequest { result in
            switch result {
            case .success(let user):
                self.user = user
                self.mediaLink = user.mediaLink ?? "Media Link"
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func saveChanges() {
        let user = RedactedUser(firstName: user.firstName, lastName: user.lastName, username: user.username, mediaLink: mediaLink)
        APIManger.shared.updateMe(user: user) { result in
            switch result {
            case .success(_):
                print("updated me")
            case .failure(let error):
                print(error)
            }
        }
    }
}
