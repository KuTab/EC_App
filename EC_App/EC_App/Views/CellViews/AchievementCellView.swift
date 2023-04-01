import SwiftUI

struct AchievementCellView: View {
    @State var achievement: Achievement
    
    var body: some View {
            ListView(viewModel: achievement.toListViewModel())
    }
}

struct AchievementCellView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementCellView(achievement: testAchievement)
    }
}
