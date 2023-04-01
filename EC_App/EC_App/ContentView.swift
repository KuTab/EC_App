import SwiftUI

struct ContentView: View {
    @StateObject var manager = RegisterManger.shared
    var body: some View {
        if manager.loggedIn && manager.isAdmin {
            AdminPannelView()
        } else if manager.loggedIn && !manager.isAdmin {
            ClientPannelView()
        } else if manager.registered {
            LoginView(registerManager: manager)
        } else {
            RegisterView(registerManager: manager)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
