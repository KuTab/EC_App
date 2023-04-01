import SwiftUI

struct ClientPannelView: View {
    var body: some View {
        TabView {
            SessionHistoryView()
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("Мои смены")
                }
            AchievementsView()
                .tabItem {
                    Image(systemName: "trophy")
                    Text("Достижения")
                }
            ActivitiesView()
                .tabItem {
                    Image(systemName: "checkmark.seal.fill")
                    Text("Задания")
                }
            NearestSessionsView()
                .tabItem {
                    Image(systemName: "car.fill")
                    Text("Я еду")
                }
            NewsView()
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("Новости")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Профиль")
                }
        }
    }
}

struct ClientPannelView_Previews: PreviewProvider {
    static var previews: some View {
        ClientPannelView()
    }
}
