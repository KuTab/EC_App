import SwiftUI

struct AdminPannelView: View {
    var body: some View {
        TabView {
            SessionCreationView()
                .tabItem {
                    Image(systemName: "car.fill")
                    Text("Смены")
                }
            ActivityCreationView()
                .tabItem {
                    Image(systemName: "checkmark.seal.fill")
                    Text("Задания")
                }
            ActivityResponseView()
                .tabItem {
                    Image(systemName: "archivebox.fill")
                    Text("Ответы")
                }
            SessionResponseView()
                .tabItem {
                    Image(systemName: "book.closed.fill")
                    Text("Бронь")
                }
            UsersView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Люди")
                }
            NewsAdditionView()
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("Новости")
                }
        }
    }
}

struct AdminPannelView_Previews: PreviewProvider {
    static var previews: some View {
        AdminPannelView()
    }
}
