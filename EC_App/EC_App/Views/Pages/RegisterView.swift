import SwiftUI
import Combine

struct RegisterView: View {
    @ObservedObject var registerManager: RegisterManger
    
    var body: some View {
        VStack {
            Text("Регистрация")
                .bold()
                .font(.system(size: 25))
            
            VStack(alignment: .leading) {
                Text("Имя")
                TextField("", text: $registerManager.firstName)
                    .textFieldStyle(.roundedBorder)
            }.padding()
            
            VStack(alignment: .leading) {
                Text("Фамилия")
                TextField("", text: $registerManager.lastName)
                    .textFieldStyle(.roundedBorder)
            }.padding()
            
            VStack(alignment: .leading) {
                Text("Ник")
                TextField("", text: $registerManager.username)
                    .textFieldStyle(.roundedBorder)
            }.padding()
            
            VStack(alignment: .leading) {
                Text("Email")
                TextField("", text: $registerManager.email)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
            }.padding()
            
            VStack(alignment: .leading) {
                Text("Пароль")
                SecureField("", text: $registerManager.password)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
            }.padding()
            
            Text("У меня есть аккаунт").overlay(Divider(), alignment: .bottom).onTapGesture {
                registerManager.registered = true
            }
            
            Button {
                registerManager.register()
            } label: {
                Text("Зарегистрироваться")
            }.buttonStyle(.bordered)

        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(registerManager: RegisterManger())
    }
}
