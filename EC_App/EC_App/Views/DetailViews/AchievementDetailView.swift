import SwiftUI

struct AchievementDetailView: View {
    var achievement: Achievement
    var body: some View {
        Text(achievement.name)
    }
}

struct AchievementDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementDetailView(achievement: testAchievement)
    }
}
