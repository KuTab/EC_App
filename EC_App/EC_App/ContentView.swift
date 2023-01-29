//
//  ContentView.swift
//  EC_App
//
//  Created by Egor Dadugin on 29.01.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                SessionHistoryView()
            }
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
