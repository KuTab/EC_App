import SwiftUI

struct LoginView: View {
    @ObservedObject var registerManager: RegisterManger
    var body: some View {
        VStack {
            Text("Вход")
                .bold()
                .font(.system(size: 25))
            
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
            
            Text("У меня нет аккаунта").overlay(Divider(), alignment: .bottom)
                .onTapGesture {
                    registerManager.registered = false
                }
            Button {
                registerManager.login()
            } label: {
                Text("Войти")
            }.buttonStyle(.bordered)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(registerManager: RegisterManger())
    }
}
