import SwiftUI

struct AchievementsView: View {
    @State var achievementList: [Activity] = []
    
    var body: some View {
        VStack {
            Text("Мои достижения")
                .font(.system(size: 25))
                .bold()
            
            ScrollView {
                ForEach(achievementList, id: \.self) { achievement in
                    ActivityCellView(activity: achievement)
                }
            }
        }.onAppear(perform: fetchAchievements)
    }
    
    private func fetchAchievements() {
        APIManger.shared.getAchievements { result in
            switch result {
            case .success(let achievements):
                achievementList = achievements
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView()
    }
}
